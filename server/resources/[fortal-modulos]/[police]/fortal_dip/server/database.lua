-- ===== FUNÇÕES DE BANCO DE DADOS =====

-- Incluir arquivo de utilitários
local Utils = module("fortal_dip", "server/utils")

-- Função para converter data MySQL para formato ISO
function MySQLDateToISO(mysqlDate)
    if not mysqlDate or mysqlDate == "" then
        return os.date('%Y-%m-%dT00:00:00Z', os.time())
    end
    
    if type(mysqlDate) == "number" then
        local seconds = mysqlDate / 1000
        local dateTable = os.date('*t', seconds)
        
        local result = string.format('%04d-%02d-%02dT00:00:00', dateTable.year, dateTable.month, dateTable.day)
        return result
    end
    
    if type(mysqlDate) == "string" then
        local year, month, day = mysqlDate:match("(%d+)-(%d+)-(%d+)")
        
        if year and month and day then
            local timestamp = os.time({
                year = tonumber(year),
                month = tonumber(month),
                day = tonumber(day),
                hour = 0,
                min = 0,
                sec = 0
            })
            local result = os.date('%Y-%m-%dT00:00:00', timestamp)
            return result
        end
    end
    
    return os.date('%Y-%m-%dT00:00:00', os.time())
end

-- Função para obter data atual no formato correto
function GetCurrentDate()
    local currentTime = os.time()
    local dateTable = os.date('*t', currentTime)
    return string.format('%04d-%02d-%02d', dateTable.year, dateTable.month, dateTable.day)
end

-- Função para converter timestamp para formato ISO
function TimestampToISO(timestamp)
    return os.date('%Y-%m-%dT00:00:00', timestamp)
end



-- Função para obter rank do jogador
function GetPlayerRank(user_id)
    local query = [[
        SELECT rank FROM ftdip_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]
    
    local result = exports.oxmysql:executeSync(query, {user_id})
  
    if result and result[1] then
        local rank = result[1].rank
        return rank
    end
    
    return nil
end

-- Função para atualizar estatísticas simplificadas
function UpdateStats(date, type, count)
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local dateString = date
    if type(date) == 'number' then
        dateString = os.date('%Y-%m-%d', date / 1000)
    end
    
    local query = [[
        INSERT INTO ftdip_stats (date, type, count)
        VALUES (?, ?, ?)
        ON DUPLICATE KEY UPDATE
        count = VALUES(count),
        updated_at = CURRENT_TIMESTAMP
    ]]
    
    exports.oxmysql:execute(query, {dateString, type, count}, function(result)
        if result then
            -- Sucesso
        else
            -- Erro
        end
    end)
end

-- Função para calcular e atualizar todas as estatísticas do dia
function UpdateDailyStats(date)
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local seizedItemsQuery = "SELECT COUNT(*) as count FROM ftdip_history WHERE type = 'Item' AND DATE(created_at) = ?"
    local seizedVehiclesQuery = "SELECT COUNT(*) as count FROM ftdip_history WHERE type = 'Veículo' AND DATE(created_at) = ?"
    local occurrencesQuery = "SELECT COUNT(*) as count FROM ftdip_bo WHERE DATE(created_at) = ?"
    local arrestsQuery = "SELECT COUNT(*) as count FROM ftdip_history WHERE type = 'Prisão' AND DATE(created_at) = ?"
    local finesQuery = "SELECT COUNT(*) as count FROM ftdip_history WHERE type = 'Multa' AND DATE(created_at) = ?"
    
    local completedQueries = 0
    local totalQueries = 5
    
    local function checkCompletion()
        completedQueries = completedQueries + 1
        if completedQueries >= totalQueries then
            -- Todas as queries foram completadas
        end
    end
    
    -- Itens apreendidos
    exports.oxmysql:execute(seizedItemsQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'seized_items', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- Veículos apreendidos
    exports.oxmysql:execute(seizedVehiclesQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'seized_vehicles', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- B.O.s registrados
    exports.oxmysql:execute(occurrencesQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'occurrences', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- Prisões
    exports.oxmysql:execute(arrestsQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'arrests', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- Multas
    exports.oxmysql:execute(finesQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'fines', result[1].count or 0)
        end
        checkCompletion()
    end)
end

-- Função para salvar histórico do jogador
function SavePlayerHistory(playerId, type, description, amount, months, officerId, officerName)
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        INSERT INTO ftdip_history 
        (player_id, type, description, amount, months, officer_id, officer_name, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_DATE)
    ]]
    
    local params = {
        playerId,
        type,
        description,
        amount or 0,
        months or 0,
        officerId,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar estatísticas do dia
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
            -- Erro ao salvar histórico
        end
    end)
end

-- Função para verificar se um jogador está procurado
function CheckAndUpdateWantedStatus(userId, playerData, callback)
    if not userId or userId == 0 or not playerData then
        if callback then callback(playerData) end
        return
    end
    
    local data = Utils.functions.getUserIdentity(userId)
    if not data then
        if callback then callback(playerData) end
        return
    end
    
    local playerName = "Jogador " .. userId
    if data.name and data.name2 then
        playerName = data.name .. " " .. data.name2
    elseif data.name then
        playerName = data.name
    end
    
    local query = [[
        SELECT id, name, description, status
        FROM ftdip_wanted_users 
        WHERE name = ? AND status = 'Ativo'
        LIMIT 1
    ]]
    
    exports.oxmysql:execute(query, {playerName}, function(result)
        local isWanted = false
        if result and #result > 0 then
            isWanted = true
        end
        
        if playerData then
            playerData.wanted = isWanted and 'Sim' or 'Não'
        end
        
        if callback then callback(playerData) end
    end)
end

-- Função para buscar dados de um jogador específico
function GetPlayerSearchData(userId)
    if not userId or userId == 0 then
        return false
    end
    
    local data = Utils.functions.getUserIdentity(userId)
    
    if data then
        local name = "Jogador " .. userId
        
        if data.name and data.name2 then
            name = data.name .. " " .. data.name2
        elseif data.name then
            name = data.name
        end
        
        return {
            name = name,
            passport = tostring(userId),
            photo = nil,
            register = data.serial or tostring(userId),
            years = data.age or 25,
            wanted = 'Não',
            size = 'Não',
            history = {}
        }
    else
        return false
    end
end

-- Função para verificar se jogador pode acessar página
function CanAccessPage(user_id, page)
    -- Primeiro verificar se tem permissão de agente
    local hasPermission = Utils.functions.hasPermission(user_id, Config.DefaultPermission)
    
    -- Se tem permissão mas não está na tabela, permite acesso total
    if hasPermission then
        local rank = GetPlayerRank(user_id)
        
        -- Se não tem rank (não está na tabela), mas tem permissão, permite tudo
        if not rank then
            return true
        end
        
        -- Se tem rank, verificar restrições
        local rankConfig = Config.Hierarchy[rank]
        if not rankConfig then 
            return false 
        end
        
        if not rankConfig.restrictedPages or #rankConfig.restrictedPages == 0 then
            return true
        end
        
        for _, restrictedPage in ipairs(rankConfig.restrictedPages) do
            if restrictedPage == page then
                return false
            end
        end
        
        return true
    end
    
    return false
end

-- Função para verificar permissão de ação
function CanPerformAction(user_id, action)
    -- Primeiro verificar se tem permissão de agente
    local hasPermission = Utils.functions.hasPermission(user_id, Config.DefaultPermission)
    
    -- Se tem permissão mas não está na tabela, permite todas as ações
    if hasPermission then
        local rank = GetPlayerRank(user_id)
        
        -- Se não tem rank (não está na tabela), mas tem permissão, permite tudo
        if not rank then
            return true
        end
        
        -- Se tem rank, verificar permissões específicas
        local rankConfig = Config.Hierarchy[rank]
        if not rankConfig then return false end
        
        if not rankConfig.permissions then return false end
        
        return rankConfig.permissions[action] == true
    end
    
    return false
end

-- Função para verificar se tem permissão de agente do DIP
function HasDipPermission(user_id)
    if not user_id then return false end
    
    -- Verificar se tem permissão de agente
    if Utils.functions.hasPermission(user_id, Config.DefaultPermission) then
        return true
    end
    
    -- Verificar se está na tabela de membros
    local query = [[
        SELECT user_id FROM ftdip_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]
    
    local result = exports.oxmysql:executeSync(query, {user_id})
    if result and result[1] then
        return true
    end
    
    return false
end

 