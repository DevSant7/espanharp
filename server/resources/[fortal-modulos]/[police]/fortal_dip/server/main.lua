-- Incluir arquivo de utilitários
local Utils = module("fortal_dip", "server/utils")

-- Incluir arquivo de funções de banco de dados
local Database = module("fortal_dip", "server/database")

-- Função para buscar jogadores próximos
function GetNearbyPlayers(source, distance)
    local nearbyPlayers = {}
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    
    
    -- Usar GetPlayers() nativo
    local players = GetPlayers()
    
    for _, playerId in ipairs(players) do
        local targetSource = tonumber(playerId)
        if targetSource and targetSource ~= source then
            local targetPed = GetPlayerPed(targetSource)
            local targetCoords = GetEntityCoords(targetPed)
            
            -- Calcular distância
            local dist = #(playerCoords - targetCoords)
            
            
            if dist <= distance then
                local user_id = Utils.functions.getUserId(targetSource)
                if user_id then
                    local identity = Utils.functions.getUserIdentity(user_id)
                    local playerName = "Jogador " .. user_id
                    
                    if identity then
                        if identity.name and identity.name2 then
                            playerName = identity.name .. " " .. identity.name2
                        elseif identity.name then
                            playerName = identity.name
                        end
                    end
                    
                    
                    table.insert(nearbyPlayers, {
                        id = user_id,
                        name = playerName,
                        passport = tostring(user_id),
                        distance = dist
                    })
                else
                end
            end
        end
    end
    
    return nearbyPlayers
end


function GetAllOnlineUsers()
    local users = nil
    
    -- Método 1: vRP.getUsers()
    if vRP and vRP.getUsers then
        users = vRP.getUsers()
        
        if users and type(users) == 'table' then
            local count = 0
            for _ in pairs(users) do count = count + 1 end
            return users
        end
    end
    
    -- Método 2: Fallback usando GetPlayers() nativo
    local playerList = GetPlayers()
    users = {}
    
    for _, playerId in ipairs(playerList) do
        local source = tonumber(playerId)
        if source then
            local user_id = Utils.functions.getUserId(source)
            if user_id then
                users[user_id] = source
            end
        end
    end
    
    local count = 0
    for _ in pairs(users) do count = count + 1 end
    
    return users
end

-- Função para obter todos os jogadores (online e offline)
function GetAllPlayers()
    local players = {}
    
    -- Buscar jogadores online primeiro
    local users = GetAllOnlineUsers()
    
    if users then
        for user_id, source in pairs(users) do
            local identity = Utils.functions.getUserIdentity(user_id)
            local name = "Jogador " .. user_id
            
            
            if identity then
                if identity.name and identity.name2 then
                    name = identity.name .. " " .. identity.name2
                elseif identity.name then
                    name = identity.name
                end
            end
            
            table.insert(players, {
                name = name,
                passport = tostring(user_id),
                photo = nil,
                register = identity and identity.serial or tostring(user_id),
                years = (identity and identity.age) or 25,
                wanted = 'Não',
                size = 'Não',
                history = {},
                online = true
            })
        end
    end
    
    -- Buscar jogadores offline do banco de dados
    if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('SELECT DISTINCT player_id FROM ftdip_history', {}, function(results)
            if results and type(results) == 'table' and #results > 0 then
                for _, row in pairs(results) do
                    local user_id = row.player_id
                    
                    -- Verificar se o jogador já não está na lista (online)
                    local alreadyInList = false
                    for _, player in pairs(players) do
                        if tonumber(player.passport) == user_id then
                            alreadyInList = true
                            break
                        end
                    end
                    
                    if not alreadyInList then
                        local identity = Utils.functions.getUserIdentity(user_id)
                        local name = "Jogador " .. user_id
                        
                        if identity then
                            if identity.name and identity.name2 then
                                name = identity.name .. " " .. identity.name2
                            elseif identity.name then
                                name = identity.name
                            end
                        end
                        
                        table.insert(players, {
                            name = name,
                            passport = tostring(user_id),
                            photo = nil,
                            register = identity and identity.serial or tostring(user_id),
                            years = (identity and identity.age) or 25,
                            wanted = 'Não',
                            size = 'Não',
                            history = {},
                            online = false
                        })
                    end
                end
            end
            
        end)
    end
    
    return players
end

-- Função para obter nome do jogador
function GetPlayerName(user_id)
    local identity = Utils.functions.getUserIdentity(user_id)
    local name = "Jogador " .. user_id
    
    
    if identity then
        if identity.name and identity.name2 then
            name = identity.name .. " " .. identity.name2
        elseif identity.name then
            name = identity.name
        end
    end
    
    return name
end

-- Função para buscar e enviar membros atualizados
function SendUpdatedMembers()
    local membersQuery = [[
        SELECT user_id, name, charge, rank, join_date, status 
        FROM ftdip_members 
        WHERE status = 'Ativo' 
        ORDER BY rank ASC, join_date ASC
    ]]
    
    exports.oxmysql:execute(membersQuery, {}, function(results)
        local members = {}
        
        if results and type(results) == 'table' then
            for i, row in ipairs(results) do
                local rankInfo = Config.Hierarchy[row.rank] or {name = "Desconhecido", label = "Desconhecido"}
                
                local isOnline = false
                local targetSource = Utils.functions.getUserSource(row.user_id)
                if targetSource then
                    isOnline = true
                end
                
                local formattedDate = "N/A"
                if row.join_date then
                    if type(row.join_date) == 'number' then
                        local timestamp = row.join_date / 1000
                        local dateTable = os.date('*t', timestamp)
                        if dateTable then
                            formattedDate = string.format('%02d/%02d/%04d', dateTable.day, dateTable.month, dateTable.year)
                        end
                    else
                        local year, month, day = string.match(row.join_date, "(%d+)-(%d+)-(%d+)")
                        if year and month and day then
                            formattedDate = day .. "/" .. month .. "/" .. year
                        end
                    end
                end
                
                local memberData = {
                    id = row.user_id,
                    name = row.name,
                    charge = row.charge,
                    rank = row.rank,
                    rankName = rankInfo.name,
                    rankLabel = rankInfo.label,
                    date = formattedDate,
                    status = isOnline
                }
                
                table.insert(members, memberData)
            end
        end
        
        -- Enviar dados atualizados para todos os clientes
        TriggerClientEvent('fortal_dip:receiveData:getMembers', -1, members)
    end)
end

-- Event para buscar dados específicos de um jogador por ID
RegisterNetEvent('fortal_dip:getPlayerData')
AddEventHandler('fortal_dip:getPlayerData', function(playerId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getPlayerData', source, {})
        return 
    end
    
    local targetId = tonumber(playerId)
    if not targetId then
        TriggerClientEvent('fortal_dip:receiveData:getPlayerData', source, {})
        return
    end
    
    -- Usar a função GetPlayerSearchData para buscar dados básicos
    local playerData = GetPlayerSearchData(targetId)
    
    if not playerData then
        TriggerClientEvent('fortal_dip:receiveData:getPlayerData', source, {})
        return
    end
    
    -- Verificar e atualizar status de procurado
    CheckAndUpdateWantedStatus(targetId, playerData, function(updatedPlayerData)
        
        -- Buscar histórico do banco de dados se existir
        if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('SELECT * FROM ftdip_history WHERE player_id = ? ORDER BY created_at DESC LIMIT 20', {targetId}, function(results)
            if results and type(results) == 'table' and #results > 0 then
                for _, row in pairs(results) do
                    -- Converter data MySQL para formato DD/MM/YYYY
                    local dateStr = ""
                    local createdAtStr = tostring(row.created_at)
                    
                    if createdAtStr and createdAtStr ~= "" then
                        -- Verificar se é timestamp (número grande)
                        local timestamp = tonumber(createdAtStr)
                        if timestamp and timestamp > 1000000000000 then
                            -- É timestamp em milissegundos, converter para data
                            local seconds = timestamp / 1000
                            local dateTable = os.date("*t", seconds)
                            dateStr = string.format("%02d/%02d/%04d", dateTable.day, dateTable.month, dateTable.year)
                        else
                            -- Tentar diferentes formatos de data string
                            local year, month, day
                            
                            -- Formato YYYY-MM-DD
                            year, month, day = createdAtStr:match("(%d+)-(%d+)-(%d+)")
                            if not year then
                                -- Formato YYYY/MM/DD
                                year, month, day = createdAtStr:match("(%d+)/(%d+)/(%d+)")
                            end
                            
                            if year and month and day then
                                dateStr = string.format("%02d/%02d/%04d", tonumber(day), tonumber(month), tonumber(year))
                            else
                            end
                        end
                    end
                    
                    -- Montar tempo/valor
                    local timeValue = ""
                    local amountNum = tonumber(row.amount or 0)
                    local formattedAmount
                    
                    -- Formatar o valor: sem .00 se for inteiro, com .xx se tiver centavos
                    if amountNum % 1 == 0 then -- Verifica se o número é inteiro
                        formattedAmount = tostring(math.floor(amountNum))
                    else
                        formattedAmount = string.format("%.2f", amountNum)
                    end
                    
                    if row.type == "Prisão" then
                        timeValue = tostring(row.months or 0) .. "/" .. formattedAmount
                    else
                        timeValue = formattedAmount
                    end
                    
                    table.insert(playerData.history, {
                        type = row.type or "Multa",
                        date = dateStr,
                        name = row.officer_name or "Agente",
                        id = row.officer_id or 0,
                        description = row.description or "Descrição não disponível",
                        time = timeValue
                    })
                end
            else
            end
            
            TriggerClientEvent('fortal_dip:receiveData:getPlayerData', source, updatedPlayerData)
        end)
    else
        -- Fallback se oxmysql não estiver disponível
        TriggerClientEvent('fortal_dip:receiveData:getPlayerData', source, updatedPlayerData)
    end
    end)
end)





-- Event para buscar jogadores
RegisterNetEvent('fortal_dip:getPlayers')
AddEventHandler('fortal_dip:getPlayers', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getPlayers', source, {})
        return 
    end
    
    local players = {}
    local foundCount = 0
    local consecutiveEmpty = 0
    local maxConsecutiveEmpty = 50 -- Para de buscar após 50 IDs consecutivos vazios
    
    
    -- Primeiro, coletar todos os jogadores
    local id = 1
    while consecutiveEmpty < maxConsecutiveEmpty do
        local playerData = GetPlayerSearchData(id)
        if playerData then
            table.insert(players, playerData)
            foundCount = foundCount + 1
            consecutiveEmpty = 0 -- Reset contador de vazios
        else
            consecutiveEmpty = consecutiveEmpty + 1
        end
        
        -- Log a cada 100 IDs para acompanhar o progresso
        if id % 100 == 0 then
        end
        
        id = id + 1
    end
    
    
    -- Se não há jogadores, enviar lista vazia
    if #players == 0 then
        TriggerClientEvent('fortal_dip:receiveData:getPlayers', source, players)
        return
    end
    
    -- Agora verificar status de procurado para todos os jogadores
    local playersToCheck = #players
    local playersChecked = 0
    
    
    for i, playerData in ipairs(players) do
        local playerId = tonumber(playerData.passport)
        CheckAndUpdateWantedStatus(playerId, playerData, function(updatedPlayerData)
            playersChecked = playersChecked + 1
            
            -- Se todos os jogadores foram verificados, enviar dados atualizados
            if playersChecked >= playersToCheck then
                TriggerClientEvent('fortal_dip:receiveData:getPlayers', source, players)
            end
        end)
    end
end)

-- Event para buscar avisos do banco de dados
RegisterNetEvent('fortal_dip:getWarns')
AddEventHandler('fortal_dip:getWarns', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getWarns', source, {})
        return 
    end
    
    local warns = {}
    
    -- Tentar buscar do banco de dados usando oxmysql
    if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('SELECT * FROM ftdip_warns ORDER BY id DESC LIMIT 50', {}, function(results)
            if results and type(results) == 'table' and #results > 0 then
                for _, row in pairs(results) do
                    -- Converter data MySQL DATE para formato ISO
                    local isoDate = MySQLDateToISO(row.created_at)
                    
                    
                    table.insert(warns, {
                        id = tostring(row.id),
                        title = row.title or "Título não disponível",
                        description = row.description or "Descrição não disponível",
                        author = row.author_name or "Autor desconhecido",
                        createdAt = isoDate
                    })
                end
            else
                -- Se não há avisos no banco, retornar array vazio
                warns = {}
            end
            
            TriggerClientEvent('fortal_dip:receiveData:getWarns', source, warns)
        end)
    else
        -- Fallback se oxmysql não estiver disponível
        TriggerClientEvent('fortal_dip:receiveData:getWarns', source, {})
    end
end)

-- Event para criar aviso no banco de dados
RegisterNetEvent('fortal_dip:createAnnounce')
AddEventHandler('fortal_dip:createAnnounce', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:createAnnounce', source, {})
        return 
    end
    
    if not data or not data.title or not data.message then
        TriggerClientEvent('fortal_dip:receiveData:createAnnounce', source, {})
        return
    end
    
    local playerName = GetPlayerName(user_id)
    
    -- Tentar inserir no banco de dados
    if GetResourceState('oxmysql') == 'started' then
        -- Inserir apenas com data atual (sem hora)
        -- Forçar timezone local para evitar problemas de UTC
        local currentDate = GetCurrentDate()
        local insertQuery = "INSERT INTO ftdip_warns (title, description, author_id, author_name, created_at) VALUES (?, ?, ?, ?, ?)"
        local insertParams = {data.title, data.message, user_id, playerName, currentDate}
        
        
        exports.oxmysql:execute(insertQuery, insertParams, function(result)
            local newWarn = {
                id = tostring((result and result.insertId) or math.random(1000, 9999)),
                title = data.title,
                description = data.message,
                author = playerName,
                createdAt = TimestampToISO(os.time())
            }
            
            
            -- Enviar o novo aviso para quem criou
            TriggerClientEvent('fortal_dip:receiveData:createAnnounce', source, newWarn)
            
            -- Buscar todos os avisos atualizados e enviar para todos os jogadores online
            exports.oxmysql:execute('SELECT * FROM ftdip_warns ORDER BY created_at DESC LIMIT 50', {}, function(allWarns)
                local updatedWarns = {}
                
                if allWarns and type(allWarns) == 'table' and #allWarns > 0 then
                    for _, row in pairs(allWarns) do
                        local isoDate = MySQLDateToISO(row.created_at)
                        table.insert(updatedWarns, {
                            id = tostring(row.id),
                            title = row.title or "Título não disponível",
                            description = row.description or "Descrição não disponível",
                            author = row.author_name or "Autor desconhecido",
                            createdAt = isoDate
                        })
                    end
                end
                
                
                -- Obter usuários online com método robusto
                local users = GetAllOnlineUsers()
                
                if users and type(users) == 'table' then
                    local sentCount = 0
                    for target_id, target_source in pairs(users) do
                        if target_source and tonumber(target_source) then
                            TriggerClientEvent('updateWarns', tonumber(target_source), updatedWarns)
                            sentCount = sentCount + 1
                            
                            -- Notificar outros jogadores sobre o novo aviso (exceto quem criou)
                            if target_id ~= user_id then
                                TriggerClientEvent('newWarnNotification', tonumber(target_source), {
                                    title = data.title,
                                    author = playerName
                                })
                            end
                        else
                        end
                    end
                else
                    
                    -- Fallback: enviar apenas para quem criou o aviso
                    TriggerClientEvent('updateWarns', source, updatedWarns)
                end
            end)
        end)
    else
        -- Fallback se oxmysql não estiver disponível
        local newWarn = {
            id = tostring(math.random(1000, 9999)),
            title = data.title,
            description = data.message,
            author = playerName,
            createdAt = TimestampToISO(os.time())
        }
        
        TriggerClientEvent('fortal_dip:receiveData:createAnnounce', source, newWarn)
        
        -- Notificar todos os jogadores online
        local users = GetAllOnlineUsers()
        if users and type(users) == 'table' then
            for target_id, target_source in pairs(users) do
                if target_id ~= user_id and target_source then
                    TriggerClientEvent('newWarnNotification', tonumber(target_source), {
                        title = data.title,
                        author = playerName
                    })
                end
            end
        end
    end
end)

-- Event para buscar opções de prisão
RegisterNetEvent('fortal_dip:getOptions')
AddEventHandler('fortal_dip:getOptions', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getOptions', source, {suspect = {}, infractions = {}})
        return 
    end
    
    local suspects = {}
    local infractions = {}
    
    -- Buscar suspeitos (jogadores próximos)
    local nearbyPlayers = GetNearbyPlayers(source, 2.0) -- Aumentar distância para 2.0
    for _, player in pairs(nearbyPlayers) do
        table.insert(suspects, {
            id = tonumber(player.passport),
            name = player.name
        })
    end
    
    -- Buscar infrações da config de prisões
    if Config and Config.Prison then
        for _, fine in pairs(Config.Prison) do
            table.insert(infractions, {
                art = fine.art,
                description = fine.description .. ' (' .. fine.months .. ' meses e $' .. fine.price .. ')'
            })
        end
    else
        -- Infrações padrão se config não existir
        table.insert(infractions, {
            art = 101,
            description = 'Excesso de velocidade (2 meses e $500)'
        })
        table.insert(infractions, {
            art = 102,
            description = 'Direção perigosa (5 meses e $1000)'
        })
    end
    
    local options = {
        suspect = suspects,
        infractions = infractions
    }
    
    TriggerClientEvent('fortal_dip:receiveData:getOptions', source, options)
end)

-- Event para buscar opções de multas (sem prisão)
RegisterNetEvent('fortal_dip:getOptionsFine')
AddEventHandler('fortal_dip:getOptionsFine', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getOptions', source, {suspect = {}, infractions = {}})
        return 
    end
    
    local suspects = {}
    local infractions = {}
    
    -- Buscar suspeitos (jogadores próximos)
    local nearbyPlayers = GetNearbyPlayers(source, 2.0) -- Aumentar distância para 2.0
    for _, player in pairs(nearbyPlayers) do
        table.insert(suspects, {
            id = tonumber(player.passport),
            name = player.name
        })
    end
    
    -- Buscar infrações da nova config de multas
    if Config and Config.Fines then
        for _, fine in pairs(Config.Fines) do
            table.insert(infractions, {
                art = fine.art,
                description = fine.description .. ' ($' .. fine.price .. ')'
            })
        end
    else
        -- Infrações padrão se config não existir
        table.insert(infractions, {
            art = 301,
            description = 'Estacionamento irregular ($200)'
        })
        table.insert(infractions, {
            art = 302,
            description = 'Ultrapassagem proibida ($400)'
        })
        table.insert(infractions, {
            art = 303,
            description = 'Sinal vermelho ($300)'
        })
    end
    
    local options = {
        suspect = suspects,
        infractions = infractions
    }
    
    TriggerClientEvent('fortal_dip:receiveData:getOptions', source, options)
end)

-- Event para aplicar multa
RegisterNetEvent('fortal_dip:applyFine')
AddEventHandler('fortal_dip:applyFine', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    local targetId = tonumber(data.targetId)
    local fineId = tonumber(data.fineId)
    local description = data.description or ""
    
    if not targetId or not fineId then
        return
    end
    
    -- Buscar informações da multa
    local fineInfo = Config.Fines[fineId]
    if not fineInfo then
        return
    end
    
    -- Aplicar multa usando vRP
    Utils.functions.addFines(targetId, fineInfo.value)
    
    -- Salvar na tabela ftdip_fines
    local identity = Utils.functions.getUserIdentity(targetId)
    local targetName = "Jogador " .. targetId
    
    if identity then
        if identity.name and identity.name2 then
            targetName = identity.name .. " " .. identity.name2
        elseif identity.name then
            targetName = identity.name
        end
    end
    
    local query = [[
        INSERT INTO ftdip_fines (user_id, name, fine_value, fine_description, applied_by, applied_date) 
        VALUES (?, ?, ?, ?, ?, ?)
    ]]
    local params = {targetId, targetName, fineInfo.value, description, user_id, os.date('%Y-%m-%d %H:%M:%S')}
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            
            -- Salvar no histórico
            local historyQuery = [[
                INSERT INTO ftdip_history (user_id, action, description, officer_id, date) 
                VALUES (?, ?, ?, ?, ?)
            ]]
            local historyParams = {targetId, "Multa Aplicada", "Multa de $" .. fineInfo.value .. " - " .. fineInfo.description, user_id, os.date('%Y-%m-%d %H:%M:%S')}
            
            exports.oxmysql:execute(historyQuery, historyParams, function(historyResult)
                if historyResult then
                else
                end
            end)
            

            
            -- Atualizar estatísticas gerais
            local generalStatsQuery = [[
                INSERT INTO ftdip_stats (date, type, count) 
VALUES (?, 'fines', 1) 
ON DUPLICATE KEY UPDATE count = count + 1
            ]]
            local generalStatsParams = {os.date('%Y-%m-%d')}
            
            exports.oxmysql:execute(generalStatsQuery, generalStatsParams, function(generalStatsResult)
                if generalStatsResult then
                    
                    -- Atualizar estatísticas do oficial
                    local officerStatsQuery = [[
                        INSERT INTO ftdip_officer_stats (user_id, fines_applied, total_fines_value)
VALUES (?, 1, ?)
ON DUPLICATE KEY UPDATE
fines_applied = fines_applied + 1,
total_fines_value = total_fines_value + ?
                    ]]
                    
                    exports.oxmysql:execute(officerStatsQuery, {user_id, fineInfo.value, fineInfo.value}, function(officerStatsResult)
                        if officerStatsResult then
                        else
                        end
                    end)
                    
                    -- Notificar todos os clientes para atualizar estatísticas
                    TriggerClientEvent('updateStatistics', -1)
                else
                end
            end)
            
            -- Notificar jogadores
            TriggerClientEvent('Notify', source, 'sucesso', 'Multa aplicada com sucesso!')
            
            local targetSource = Utils.functions.getUserSource(targetId)
            if targetSource then
                TriggerClientEvent('Notify', targetSource, 'negado', 'Você recebeu uma multa de $' .. fineInfo.value)
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao aplicar multa!')
        end
    end)
end)


-- Event para confirmar prisão
RegisterNetEvent('fortal_dip:confirmPrison')
AddEventHandler('fortal_dip:confirmPrison', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    -- Processar prisão usando o sistema fortal_prisao
    if data and data.users and data.users.suspects and type(data.users.suspects) == "table" then
        for _, suspect in pairs(data.users.suspects) do
            local targetId = tonumber(suspect.id)
            local targetSource = Utils.functions.getUserSource(targetId)
            
            if targetSource then
                -- Calcular tempo total e multa total
                local totalMonths = 0
                local totalFine = 0
                local infractionsList = {}
                local prisonType = data.prisonType or "normal"
                
                -- Verificar se infractions existe e é uma tabela
                if data.users.infractions and type(data.users.infractions) == "table" then
                    for _, infraction in pairs(data.users.infractions) do
                        -- Buscar infração na config de prisões
                        if Config and Config.Prison then
                            for _, fine in pairs(Config.Prison) do
                                if fine.art == infraction.art then
                                    totalMonths = totalMonths + fine.months
                                    totalFine = totalFine + fine.price
                                    table.insert(infractionsList, fine.description)
                                    break
                                end
                            end
                        end
                    end
                end
                
                -- Se não há infrações, aplicar valores padrão
                if totalMonths == 0 then
                    totalMonths = 12
                    totalFine = 5000
                    table.insert(infractionsList, "Infração padrão")
                end
                
                -- Usar o sistema fortal_prisao para prender
                local description = data.description or table.concat(infractionsList, ", ")
                
                -- Chamar função do fortal_prisao usando o sistema de integração
                
                -- Chamar diretamente o evento do fortal_prisao
                TriggerEvent("fortal_prisao:imprisonFromPolice", targetId, prisonType, totalMonths, totalFine, description, source)
                
                local success = true -- Assumir sucesso se não houver erro
                local message = "Prisão aplicada com sucesso"
                
                if success then
                    -- Salvar histórico da prisão no banco de dados
                    if GetResourceState('oxmysql') == 'started' then
                        local officerName = GetPlayerName(user_id)
                        local targetName = GetPlayerName(targetId)
                        
                        -- Salvar na tabela ftdip_history
local historyQuery = "INSERT INTO ftdip_history (player_id, type, description, amount, months, officer_id, officer_name, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())"
                        local historyParams = {targetId, "Prisão", description, totalFine, totalMonths, user_id, officerName}
                        
                        exports.oxmysql:execute(historyQuery, historyParams, function(historyResult)
                            if historyResult then
                                
                                                    -- Atualizar estatísticas na tabela ftdip_stats
local today = os.date('%Y-%m-%d')
local statsQuery = "INSERT INTO ftdip_stats (date, type, count) VALUES (?, 'arrests', 1) ON DUPLICATE KEY UPDATE count = count + 1"
                    local statsParams = {today}
                    
                    exports.oxmysql:execute(statsQuery, statsParams, function(statsResult)
                                    if statsResult then
                                        
                                        -- Atualizar estatísticas do oficial
                                        local officerStatsQuery = [[
                                            INSERT INTO ftdip_officer_stats (user_id, arrests_made)
VALUES (?, 1)
ON DUPLICATE KEY UPDATE
arrests_made = arrests_made + 1
                                        ]]
                                        
                                        exports.oxmysql:execute(officerStatsQuery, {user_id}, function(officerStatsResult)
                                            if officerStatsResult then
                                            else
                                            end
                                        end)
                                        
                                        -- Notificar todos os clientes para atualizar estatísticas
                                        TriggerClientEvent('updateStatistics', -1)
                                    else
                                    end
                                end)
                            else
                            end
                        end)
                    end
                    
                    -- Notificar agente
                    TriggerClientEvent("Notify", source, "verde", "Prisão aplicada com sucesso!", 5000)
                    
                    -- O fortal_prisao vai cuidar do teleporte e interface
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Erro ao aplicar prisão: " .. message, 5000)
                end
                
                local targetName = GetPlayerName(targetId)
            end
        end
    end
end)

-- Event para confirmar multa
RegisterNetEvent('fortal_dip:confirmFine')
AddEventHandler('fortal_dip:confirmFine', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    local officerName = GetPlayerName(source)
    
    -- Processar multa
    if data and data.users and data.users.suspects and type(data.users.suspects) == "table" then
        for _, suspect in pairs(data.users.suspects) do
            local targetId = tonumber(suspect.id)
            local targetSource = Utils.functions.getUserSource(targetId)
            
            if targetSource then
                -- Calcular multa total
                local totalFine = 0
                local infractionsList = {}
                
                -- Verificar se infractions existe e é uma tabela
                if data.users.infractions and type(data.users.infractions) == "table" then
                    for _, infraction in pairs(data.users.infractions) do
                        -- Buscar infração na config de multas
                        if Config and Config.Fines then
                            for _, fine in pairs(Config.Fines) do
                                if fine.art == infraction.art then
                                    totalFine = totalFine + fine.price
                                    table.insert(infractionsList, fine.description)
                                    break
                                end
                            end
                        end
                    end
                end
                
                -- Se não há infrações, aplicar valor padrão
                if totalFine == 0 then
                    totalFine = 500
                    table.insert(infractionsList, "Multa padrão")
                end
                
                -- Aplicar multa
                if totalFine > 0 then
                    Utils.functions.tryPayment(targetId, totalFine)
                end
                
                -- Salvar histórico no banco de dados
                if GetResourceState('oxmysql') == 'started' then
                    local description = table.concat(infractionsList, ", ")
                    local insertQuery = "INSERT INTO ftdip_history (player_id, type, description, amount, months, officer_id, officer_name, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())"
                    local insertParams = {targetId, "Multa", description, totalFine, 0, user_id, officerName}
                    
                    exports.oxmysql:execute(insertQuery, insertParams, function(result)
                        if result then
                        else
                        end
                    end)
                    
                    -- Salvar na tabela ftdip_fines
local fineQuery = "INSERT INTO ftdip_fines (player_id, player_name, fine_type, description, amount, officer_id, officer_name, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())"
                    local fineParams = {targetId, GetPlayerName(targetSource), "Multa", description, totalFine, user_id, officerName}
                    
                    exports.oxmysql:execute(fineQuery, fineParams, function(result)
                        if result then
                        else
                        end
                    end)
                    
                    -- Atualizar estatísticas na tabela ftdip_stats
local today = os.date('%Y-%m-%d')
local statsQuery = "INSERT INTO ftdip_stats (date, type, count) VALUES (?, 'fines', 1) ON DUPLICATE KEY UPDATE count = count + 1"
                    local statsParams = {today}
                    
                    exports.oxmysql:execute(statsQuery, statsParams, function(result)
                        if result then
                        else
                        end
                    end)
                end
                
                -- Mostrar multa para o suspeito
                TriggerClientEvent('showFineAmount', targetSource, totalFine)
                
                local targetName = GetPlayerName(targetSource)
            end
        end
    end
end)

-- Event para buscar membros
RegisterNetEvent('fortal_dip:getMembers')
AddEventHandler('fortal_dip:getMembers', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getMembers', source, {})
        return 
    end
    
    -- Buscar membros da tabela ftdip_members
local query = [[
    SELECT user_id, name, charge, rank, join_date, status 
    FROM ftdip_members 
    WHERE status = 'Ativo' 
    ORDER BY rank ASC, join_date ASC
]]
    
    
    if not GetResourceState('oxmysql') == 'started' then
        TriggerClientEvent('fortal_dip:receiveData:getMembers', source, {})
        return
    end
    
    -- Primeiro, vamos verificar se há dados na tabela
    exports.oxmysql:execute('SELECT COUNT(*) as count FROM ftdip_members', {}, function(countResult)
        
        -- Agora executar a query principal
        exports.oxmysql:execute(query, {}, function(results)
            
            local members = {}
            
            if results and type(results) == 'table' then
                
                for i, row in ipairs(results) do
                    
                    local rankInfo = Config.Hierarchy[row.rank] or {name = "Desconhecido", label = "Desconhecido"}
                    
                    -- Verificar se o jogador está online
                    local isOnline = false
                    local targetSource = Utils.functions.getUserSource(row.user_id)
                    if targetSource then
                        isOnline = true
                    end
                    
                    -- Formatar data de forma segura
                    local formattedDate = "N/A"
                    
                    if row.join_date then
                        
                        -- Se for número (timestamp), converter
                        if type(row.join_date) == 'number' then
                            local timestamp = row.join_date / 1000 -- Converter de milissegundos para segundos
                            local dateTable = os.date('*t', timestamp)
                            if dateTable then
                                formattedDate = string.format('%02d/%02d/%04d', dateTable.day, dateTable.month, dateTable.year)
                            else
                            end
                        else
                            -- Se for string, tentar extrair com regex
                            local year, month, day = string.match(row.join_date, "(%d+)-(%d+)-(%d+)")
                            
                            if year and month and day then
                                formattedDate = day .. "/" .. month .. "/" .. year
                            else
                            end
                        end
                    else
                    end
                    
                    local memberData = {
                        id = row.user_id,
                        name = row.name,
                        charge = row.charge,
                        rank = row.rank,
                        rankName = rankInfo.name,
                        rankLabel = rankInfo.label,
                        date = formattedDate, -- Mudança aqui: usar 'date' em vez de 'joinDate'
                        status = isOnline
                    }
                    
                    table.insert(members, memberData)
                end
            else
            end
            
            TriggerClientEvent('fortal_dip:receiveData:getMembers', source, members)
        end)
    end)
end)

-- Event para adicionar membro
RegisterNetEvent('fortal_dip:addMember')
AddEventHandler('fortal_dip:addMember', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    local targetId = tonumber(data.id)
    local targetSource = Utils.functions.getUserSource(targetId)
    
    if targetSource then
        local officerName = GetPlayerName(user_id)
        local targetName = GetPlayerName(targetId)
    end
end)

-- Event para contratar membro
RegisterNetEvent('fortal_dip:hireMember')
AddEventHandler('fortal_dip:hireMember', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    local targetId = tonumber(data.id)
    local targetSource = Utils.functions.getUserSource(targetId)
    
    
    if not targetSource then
        TriggerClientEvent('Notify', source, 'negado', 'Jogador não está online!')
        return
    end
    
    -- Verificar se o jogador já está na tabela ftdip_members
    local query = [[
        SELECT user_id FROM ftdip_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]
    
    
    exports.oxmysql:execute(query, {targetId}, function(result)
        
        if result and #result > 0 then
            TriggerClientEvent('Notify', source, 'negado', 'Este jogador já é membro da corporação!')
            return
        end
        
        
        -- Se não está na tabela, pode contratar
        -- Fazer request para o jogador
        if Utils.functions.request(targetSource, "Deseja aceitar entrar na corporação DIP?") then
            
            -- Se aceitar, adicionar à tabela ftdip_members
            local identity = Utils.functions.getUserIdentity(targetId)
            local playerName = "Jogador " .. targetId
            
            if identity then
                if identity.name and identity.name2 then
                    playerName = identity.name .. " " .. identity.name2
                elseif identity.name then
                    playerName = identity.name
                end
            end
            
            
            local insertQuery = [[
                INSERT INTO ftdip_members (user_id, name, charge, rank, join_date, status) 
                VALUES (?, ?, ?, ?, ?, ?)
            ]]
            local currentDate = os.date('%Y-%m-%d') -- Usar formato de data
            local params = {targetId, playerName, "Estagiario", 8, currentDate, "Ativo"} -- Rank 15 = Soldado

            
            exports.oxmysql:execute(insertQuery, params, function(insertResult)

                if insertResult then
                    -- Definir permissão direto com rank específico
                    Utils.functions.setPermission(targetId, Config.DefaultPermission, 8) -- Rank 8 = Estagiário
                    
                    -- Forçar atualização das permissões do jogador contratado
                    local targetSource = Utils.functions.getUserSource(targetId)
                    if targetSource then
                        -- Notificar o jogador sobre a atualização de permissões
                        TriggerClientEvent('fortal_dip:updatePermissions', targetSource)
                        
                        -- Fechar o painel se estiver aberto
                        TriggerClientEvent('fortal_dip:closeNUI', targetSource)
                    end
                    
                    TriggerClientEvent('Notify', source, 'sucesso', 'Jogador contratado com sucesso!')
                    TriggerClientEvent('Notify', targetSource, 'sucesso', 'Você foi contratado como agente do DIP!')
                    
                    -- Buscar membros atualizados e enviar para todos
                    SendUpdatedMembers()
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Erro ao contratar jogador!')
                end
            end)
        else
            TriggerClientEvent('Notify', source, 'negado', 'Jogador recusou a contratação!')
        end
    end)
end)

-- Event para remover/demitir membro
RegisterNetEvent('fortal_dip:removePlayer')
AddEventHandler('fortal_dip:removePlayer', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    -- Verificar permissão para demitir
    local rank = GetPlayerRank(user_id)
    if not rank then
        return
    end
    
    local rankInfo = Config.Hierarchy[rank]
    if not rankInfo or not rankInfo.permissions or not rankInfo.permissions.canFire then
    
        TriggerClientEvent('Notify', source, 'negado', 'Você não tem permissão para demitir membros!')
        return
    end
    
    local targetId = tonumber(data.id)
    
    if not targetId then
        TriggerClientEvent('Notify', source, 'negado', 'ID do membro inválido!')
        return
    end
    
    
    -- Verificar se o membro existe na tabela
    local checkQuery = [[
        SELECT user_id, name, rank FROM ftdip_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]
    
    exports.oxmysql:execute(checkQuery, {targetId}, function(checkResult)
        if not checkResult or #checkResult == 0 then
            TriggerClientEvent('Notify', source, 'negado', 'Membro não encontrado!')
            return
        end
        
        local memberData = checkResult[1]
        
        -- Verificar se não está tentando demitir a si mesmo
        if targetId == user_id then
            TriggerClientEvent('Notify', source, 'negado', 'Você não pode demitir a si mesmo!')
            return
        end
        
        -- Verificar se não está tentando demitir alguém de patente superior
        local userRank = GetPlayerRank(user_id)
        if userRank >= memberData.rank then
            TriggerClientEvent('Notify', source, 'negado', 'Você não pode demitir alguém de patente superior ou igual!')
            return
        end
        
        -- Remover permissões de agente
        Utils.functions.removePermission(targetId, Config.DefaultPermission)
        Utils.functions.remPermission(targetId, "waitDip")
        
        -- Deletar membro da tabela
        local deleteQuery = [[
            DELETE FROM ftdip_members 
            WHERE user_id = ?
        ]]
        
        exports.oxmysql:execute(deleteQuery, {targetId}, function(deleteResult)
            if deleteResult then
                
                -- Notificar quem demitiu
                TriggerClientEvent('Notify', source, 'sucesso', 'Membro demitido com sucesso!')
                
                -- Notificar o membro demitido se estiver online
                local targetSource = Utils.functions.getUserSource(targetId)
                if targetSource then
                    TriggerClientEvent('Notify', targetSource, 'negado', 'Você foi demitido da corporação!')
                end
                
                -- Buscar membros atualizados e enviar para todos
                SendUpdatedMembers()
                
            else
                TriggerClientEvent('Notify', source, 'negado', 'Erro ao demitir membro!')
            end
        end)
    end)
end)

-- Event para promover membro
RegisterNetEvent('fortal_dip:promotePlayer')
AddEventHandler('fortal_dip:promotePlayer', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    

    
    if not user_id then 

        return 
    end
    
    -- Verificar permissão
    if not CanPerformAction(user_id, 'canPromote') then

        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para promover membros!", 5000)
        return
    end
    
    local targetId = tonumber(data.id)
    local currentRank = tonumber(data.rank)
    
    
    if not targetId or not currentRank then

        TriggerClientEvent('Notify', source, 'negado', 'Dados inválidos!')
        return
    end
    
    -- Verificar se pode ser promovido (não pode ser Secretário - rank 1)
    if currentRank <= 1 then
        TriggerClientEvent('Notify', source, 'negado', 'Este membro já está na patente máxima!')
        return
    end
    
    local newRank = currentRank - 1 -- Diminuir rank (1 = Secretário, 16 = Aluno)
    local rankInfo = Config.Hierarchy[newRank]
    
    
    if not rankInfo then
        TriggerClientEvent('Notify', source, 'negado', 'Patente inválida!')
        return
    end
    
    -- Atualizar rank na DB
    local query = [[
        UPDATE ftdip_members 
        SET rank = ?, charge = ? 
        WHERE user_id = ?
    ]]
    local params = {newRank, rankInfo.name, targetId}
    
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            

            Utils.functions.setPermission(targetId, Config.DefaultPermission, newRank)
            
            if true then
                -- Notificar o jogador promovido se estiver online
            local targetSource = Utils.functions.getUserSource(targetId)
            if targetSource then
                TriggerClientEvent('Notify', targetSource, 'sucesso', 'Você foi promovido para ' .. rankInfo.label .. '!')
                
                -- Forçar atualização das permissões do jogador promovido
                TriggerClientEvent('fortal_dip:updatePermissions', targetSource)
                
                -- Fechar o painel se estiver aberto
                TriggerClientEvent('fortal_dip:closeNUI', targetSource)
            end
            
                            -- Notificar o promotor
                TriggerClientEvent('Notify', source, 'sucesso', 'Membro promovido para ' .. rankInfo.label .. '!')
                
                -- Buscar membros atualizados e enviar para todos
                local membersQuery = [[
                    SELECT user_id, name, charge, rank, join_date, status 
                    FROM ftdip_members 
                    WHERE status = 'Ativo' 
                    ORDER BY rank ASC, join_date ASC
                ]]
                
                exports.oxmysql:execute(membersQuery, {}, function(results)
                    local members = {}
                    
                    if results and type(results) == 'table' then
                        for i, row in ipairs(results) do
                            local rankInfo = Config.Hierarchy[row.rank] or {name = "Desconhecido", label = "Desconhecido"}
                            
                            local isOnline = false
                            local targetSource = Utils.functions.getUserSource(row.user_id)
                            if targetSource then
                                isOnline = true
                            end
                            
                            local formattedDate = "N/A"
                            if row.join_date then
                                if type(row.join_date) == 'number' then
                                    local timestamp = row.join_date / 1000
                                    local dateTable = os.date('*t', timestamp)
                                    if dateTable then
                                        formattedDate = string.format('%02d/%02d/%04d', dateTable.day, dateTable.month, dateTable.year)
                                    end
                                else
                                    local year, month, day = string.match(row.join_date, "(%d+)-(%d+)-(%d+)")
                                    if year and month and day then
                                        formattedDate = day .. "/" .. month .. "/" .. year
                                    end
                                end
                            end
                            
                            local memberData = {
                                id = row.user_id,
                                name = row.name,
                                charge = row.charge,
                                rank = row.rank,
                                rankName = rankInfo.name,
                                rankLabel = rankInfo.label,
                                date = formattedDate,
                                status = isOnline
                            }
                            
                            table.insert(members, memberData)
                        end
                    end
                    
                    -- Enviar dados atualizados para todos os clientes
                    TriggerClientEvent('fortal_dip:receiveData:getMembers', -1, members)
                end)
            else
                TriggerClientEvent('Notify', source, 'negado', 'Erro ao atualizar permissões!')
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao promover membro!')
        end
    end)
end)

-- Event para rebaixar membro
RegisterNetEvent('fortal_dip:demotePlayer')
AddEventHandler('fortal_dip:demotePlayer', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    

    
    if not user_id then 

        return 
    end
    
    -- Verificar permissão
    if not CanPerformAction(user_id, 'canDemote') then

        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para rebaixar membros!", 5000)
        return
    end
    
    local targetId = tonumber(data.id)
    local currentRank = tonumber(data.rank)
    
    
    if not targetId or not currentRank then

        TriggerClientEvent('Notify', source, 'negado', 'Dados inválidos!')
        return
    end
    
    -- Verificar se pode ser rebaixado (não pode ser Aluno - rank 16)
    if currentRank >= 16 then
        TriggerClientEvent('Notify', source, 'negado', 'Este membro já está na patente mínima!')
        return
    end
    
    local newRank = currentRank + 1 -- Aumentar rank (1 = Secretário, 16 = Aluno)
    local rankInfo = Config.Hierarchy[newRank]
    
    
    if not rankInfo then
        TriggerClientEvent('Notify', source, 'negado', 'Patente inválida!')
        return
    end
    
    -- Atualizar rank na DB
    local query = [[
        UPDATE ftdip_members 
        SET rank = ?, charge = ? 
        WHERE user_id = ?
    ]]
    local params = {newRank, rankInfo.name, targetId}
    
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            
            -- Remover permissão antiga e definir nova permissão
            Utils.functions.setPermission(targetId, Config.DefaultPermission, newRank)
            
            if true then
                -- Notificar o jogador rebaixado se estiver online
            local targetSource = Utils.functions.getUserSource(targetId)
            if targetSource then
                TriggerClientEvent('Notify', targetSource, 'negado', 'Você foi rebaixado para ' .. rankInfo.label .. '!')
                
                -- Forçar atualização das permissões do jogador rebaixado
                TriggerClientEvent('fortal_dip:updatePermissions', targetSource)
                
                -- Fechar o painel se estiver aberto
                TriggerClientEvent('fortal_dip:closeNUI', targetSource)
            end
            
                            -- Notificar o rebaixador
                TriggerClientEvent('Notify', source, 'sucesso', 'Membro rebaixado para ' .. rankInfo.label .. '!')
                
                -- Buscar membros atualizados e enviar para todos
                SendUpdatedMembers()
            else
                TriggerClientEvent('Notify', source, 'negado', 'Erro ao atualizar permissões!')
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao rebaixar membro!')
        end
    end)
end)

-- Event para sair da organização
RegisterNetEvent('fortal_dip:leaveOrg')
AddEventHandler('fortal_dip:leaveOrg', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    local playerName = GetPlayerName(user_id)
end)

-- Debug: Verificar se o servidor está funcionando
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Resource iniciado com sucesso
    end
end)



-- ===== SISTEMA DE ESTATÍSTICAS =====

-- Event para buscar estatísticas
RegisterNetEvent('fortal_dip:getStatistics')
AddEventHandler('fortal_dip:getStatistics', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getStatistics', source, {})
        return 
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        TriggerClientEvent('fortal_dip:receiveData:getStatistics', source, {})
        return
    end
    
    -- Buscar todas as estatísticas disponíveis
    
    local query = [[
        SELECT date, type, count
        FROM ftdip_stats 
        ORDER BY date DESC, type ASC
    ]]
    
    exports.oxmysql:execute(query, {}, function(results)
        local statistics = {}
        local statsByDate = {}
        
        -- Inicializar com todas as datas encontradas no banco
        local datesInDB = {}
        
        -- Primeiro, vamos coletar todas as datas únicas dos resultados
        if results and type(results) == 'table' then
            for _, row in pairs(results) do
                local dateString = row.date
                if type(row.date) == 'number' then
                    dateString = os.date('%Y-%m-%d', row.date / 1000)
                end
                datesInDB[dateString] = true
            end
        end
        
        -- Se não há dados no banco, usar os últimos 30 dias como fallback
        if not next(datesInDB) then
            local currentTime = os.time()
            for i = 29, 0, -1 do
                local date = os.date('%Y-%m-%d', currentTime - (i * 24 * 60 * 60))
                datesInDB[date] = true
            end
        end
        
        -- Inicializar statsByDate com as datas encontradas
        for date, _ in pairs(datesInDB) do
            statsByDate[date] = {
                seized_items = 0,
                seized_vehicles = 0,
                occurrences = 0,
                arrests = 0,
                fines = 0
            }
        end
        
        for date, _ in pairs(statsByDate) do
        end
        
        -- Preencher com dados reais do banco (se existirem)
        if results and type(results) == 'table' then
            for _, row in pairs(results) do
                
                -- Converter timestamp para string de data se necessário
                local dateString = row.date
                if type(row.date) == 'number' then
                    dateString = os.date('%Y-%m-%d', row.date / 1000) -- Converter de milissegundos para segundos
                elseif type(row.date) == 'string' then
                    -- Se for string, extrair apenas a data (YYYY-MM-DD)
                    local year, month, day = string.match(row.date, "(%d+)-(%d+)-(%d+)")
                    if year and month and day then
                        dateString = year .. "-" .. month .. "-" .. day
                    end
                end
                
                if statsByDate[dateString] then
                    
                    if row.type == 'seized_items' then
                        statsByDate[dateString].seized_items = row.count
                    elseif row.type == 'seized_vehicles' then
                        statsByDate[dateString].seized_vehicles = row.count
                    elseif row.type == 'occurrences' then
                        statsByDate[dateString].occurrences = row.count
                    elseif row.type == 'arrests' then
                        statsByDate[dateString].arrests = row.count
                    elseif row.type == 'fines' then
                        statsByDate[dateString].fines = row.count
                    else
                    end
                else
                    for key, _ in pairs(statsByDate) do
                    end
                end
            end
        else
        end
        
        -- Converter para formato do frontend
        for date, stats in pairs(statsByDate) do
            
            -- Converter data para formato ISO
            local year, month, day = string.match(date, "(%d+)-(%d+)-(%d+)")
            local isoDate = nil
            
            if year and month and day then
                isoDate = os.date('%Y-%m-%dT00:00:00Z', os.time({
                    year = tonumber(year),
                    month = tonumber(month),
                    day = tonumber(day)
                }))
            else
                isoDate = os.date('%Y-%m-%dT00:00:00Z', os.time())
            end
            
            local statData = {
                date = isoDate,
                data = {
                    {
                        name = "Itens apreendidas",
                        Valor = stats.seized_items
                    },
                    {
                        name = "Veículos apreendidos",
                        Valor = stats.seized_vehicles
                    },
                    {
                        name = "B.O's registrados",
                        Valor = stats.occurrences
                    },
                    {
                        name = "Prisões realizadas",
                        Valor = stats.arrests
                    },
                    {
                        name = "Multas aplicadas",
                        Valor = stats.fines
                    }
                }
            }
            
            table.insert(statistics, statData)
        end
        
        TriggerClientEvent('fortal_dip:receiveData:getStatistics', source, statistics)
    end)
end)

-- Event para registrar item apreendido (simplificado)
RegisterNetEvent('fortal_dip:registerSeizedItem')
AddEventHandler('fortal_dip:registerSeizedItem', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.player_id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local officerName = GetPlayerName(user_id)
    local playerName = GetPlayerName(data.player_id)
    
    -- Registrar como histórico simples
    local query = [[
        INSERT INTO ftdip_history 
        (player_id, type, description, amount, months, officer_id, officer_name, created_at)
        VALUES (?, 'Item', 'Item apreendido', 0, 0, ?, ?, CURRENT_DATE)
    ]]
    
    local params = {
        data.player_id,
        user_id,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar estatísticas do dia
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
        end
    end)
end)

-- Event para registrar veículo apreendido (simplificado)
RegisterNetEvent('fortal_dip:registerSeizedVehicle')
AddEventHandler('fortal_dip:registerSeizedVehicle', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.player_id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local officerName = GetPlayerName(user_id)
    local playerName = GetPlayerName(data.player_id)
    
    -- Registrar como histórico simples
    local query = [[
        INSERT INTO ftdip_history 
        (player_id, type, description, amount, months, officer_id, officer_name, created_at)
        VALUES (?, 'Veículo', 'Veículo apreendido', 0, 0, ?, ?, CURRENT_DATE)
    ]]
    
    local params = {
        data.player_id,
        user_id,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar estatísticas do dia
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
        end
    end)
end)

-- Event para registrar B.O.
RegisterNetEvent('fortal_dip:registerOccurrence')
AddEventHandler('fortal_dip:registerOccurrence', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.description or not data.location then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local officerName = GetPlayerName(user_id)
    local occurrenceNumber = 'BO-' .. os.date('%Y%m%d') .. '-' .. math.random(1000, 9999)
    
    local query = [[
        INSERT INTO ftdip_bo 
        (occurrence_number, type, description, location, applicant_id, applicant_name, suspect_id, suspect_name, officer_id, officer_name, status, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Aberto', CURRENT_DATE)
    ]]
    
    local params = {
        occurrenceNumber,
        data.type or 'Roubo',
        data.description,
        data.location,
        data.applicant_id or nil,
        data.applicant_name or nil,
        data.suspect_id or nil,
        data.suspect_name or nil,
        user_id,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            
            -- Atualizar estatísticas na tabela ftdip_stats
            local today = os.date('%Y-%m-%d')
            local statsQuery = "INSERT INTO ftdip_stats (date, type, count) VALUES (?, 'occurrences', 1) ON DUPLICATE KEY UPDATE count = count + 1"
            local statsParams = {today}
            
            exports.oxmysql:execute(statsQuery, statsParams, function(statsResult)
                if statsResult then
                    
                    -- Notificar todos os clientes sobre a atualização das estatísticas
                    TriggerClientEvent('updateStatistics', -1)
                else
                end
            end)
            
            -- Atualizar estatísticas do dia (mantido para compatibilidade)
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
        end
    end)
end)

-- Atualizar estatísticas quando histórico é salvo
local originalSaveHistory = SavePlayerHistory
function SavePlayerHistory(playerId, type, description, amount, months, officerId, officerName)
    -- Chamar função original
    originalSaveHistory(playerId, type, description, amount, months, officerId, officerName)
    
    -- Atualizar estatísticas do dia
    UpdateDailyStats(os.date('%Y-%m-%d'))
end

-- ===== SISTEMA DE PROCURADOS =====

-- Event para buscar pessoas procuradas
RegisterNetEvent('fortal_dip:getWantedUsers')
AddEventHandler('fortal_dip:getWantedUsers', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        SELECT id, name, description, last_seen, location, photo, created_at, status
        FROM ftdip_wanted_users 
        WHERE status = 'Ativo'
        ORDER BY created_at DESC
    ]]
    
    exports.oxmysql:execute(query, {}, function(result)
        if result then
            local wantedUsers = {}
            for _, row in ipairs(result) do
                table.insert(wantedUsers, {
                    id = row.id,
                    name = row.name,
                    description = row.description,
                    lastSeen = row.last_seen,
                    location = row.location,
                    photo = row.photo,
                    date = os.date('%d/%m/%Y', os.time(os.date('*t', os.time())))
                })
            end
            TriggerClientEvent('fortal_dip:receiveData:getWantedUsers', source, wantedUsers)
        else
            TriggerClientEvent('fortal_dip:receiveData:getWantedUsers', source, {})
        end
    end)
end)

-- Event para buscar veículos procurados
RegisterNetEvent('fortal_dip:getWantedVehicles')
AddEventHandler('fortal_dip:getWantedVehicles', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        SELECT id, model, specifications, last_seen, location, created_at, status
        FROM ftdip_wanted_vehicles 
        WHERE status = 'Ativo'
        ORDER BY created_at DESC
    ]]
    
    exports.oxmysql:execute(query, {}, function(result)
        if result then
            local wantedVehicles = {}
            for _, row in ipairs(result) do
                table.insert(wantedVehicles, {
                    id = row.id,
                    model = row.model,
                    specifications = row.specifications,
                    lastSeen = row.last_seen,
                    location = row.location,
                    date = os.date('%d/%m/%Y', os.time(os.date('*t', os.time())))
                })
            end
            TriggerClientEvent('fortal_dip:receiveData:getWantedVehicles', source, wantedVehicles)
        else
            TriggerClientEvent('fortal_dip:receiveData:getWantedVehicles', source, {})
        end
    end)
end)

-- Event para adicionar pessoa procurada
RegisterNetEvent('fortal_dip:addWantedUser')
AddEventHandler('fortal_dip:addWantedUser', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.name or not data.description or not data.lastSeen or not data.location then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        INSERT INTO ftdip_wanted_users 
        (name, description, last_seen, location, photo, officer_id, status, created_at)
        VALUES (?, ?, ?, ?, ?, ?, 'Ativo', CURRENT_TIMESTAMP)
    ]]
    
    local params = {
        data.name,
        data.description,
        data.lastSeen,
        data.location,
        data.photo or nil,
        user_id
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de procurados para todos os policiais
            TriggerClientEvent('updateWantedUsers', -1)
            -- Atualizar status de procurado na busca
            TriggerClientEvent('updatePlayerHistory', -1)
        else
        end
    end)
end)

-- Event para adicionar veículo procurado
RegisterNetEvent('fortal_dip:addWantedVehicle')
AddEventHandler('fortal_dip:addWantedVehicle', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.model or not data.specifications or not data.lastSeen or not data.location then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        INSERT INTO ftdip_wanted_vehicles 
        (model, specifications, last_seen, location, officer_id, status, created_at)
        VALUES (?, ?, ?, ?, ?, 'Ativo', CURRENT_TIMESTAMP)
    ]]
    
    local params = {
        data.model,
        data.specifications,
        data.lastSeen,
        data.location,
        user_id
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de veículos procurados para todos os policiais
            TriggerClientEvent('updateWantedVehicles', -1)
        else
        end
    end)
end)

-- Event para remover pessoa procurada (marcar como capturada)
RegisterNetEvent('fortal_dip:removeWantedUser')
AddEventHandler('fortal_dip:removeWantedUser', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        UPDATE ftdip_wanted_users 
        SET status = 'Capturado', updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
    ]]
    
    local params = { data.id }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de procurados para todos os policiais
            TriggerClientEvent('updateWantedUsers', -1)
            -- Atualizar status de procurado na busca
            TriggerClientEvent('updatePlayerHistory', -1)
        else
        end
    end)
end)

-- Event para remover veículo procurado (marcar como recuperado)
RegisterNetEvent('fortal_dip:removeWantedVehicle')
AddEventHandler('fortal_dip:removeWantedVehicle', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        UPDATE ftdip_wanted_vehicles 
        SET status = 'Recuperado', updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
    ]]
    
    local params = { data.id }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de veículos procurados para todos os policiais
            TriggerClientEvent('updateWantedVehicles', -1)
        else
        end
    end)
end)

-- ===== SISTEMA DE BOLETINS DE OCORRÊNCIA (B.O.) =====

-- Event para buscar B.O.s do banco de dados
RegisterNetEvent('fortal_dip:getOccurrences')
AddEventHandler('fortal_dip:getOccurrences', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getOccurrences', source, {})
        return 
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        TriggerClientEvent('fortal_dip:receiveData:getOccurrences', source, {})
        return
    end
    
    local query = [[
        SELECT id, occurrence_number, type, description, 
               applicant_name, suspect_name, officer_name, status, created_at
        FROM ftdip_bo 
        ORDER BY created_at DESC
        LIMIT 50
    ]]
    
    exports.oxmysql:execute(query, {}, function(result)
        if result then
            local occurrences = {}
            for _, row in ipairs(result) do
                table.insert(occurrences, {
                    id = row.id,
                    occurrenceNumber = row.occurrence_number,
                    type = row.type,
                    description = row.description,
                    applicantName = row.applicant_name or "Não informado",
                    suspectName = row.suspect_name or "Não informado",
                    officerName = row.officer_name,
                    status = row.status,
                    date = os.date('%d/%m/%Y', os.time())
                })
            end
            TriggerClientEvent('fortal_dip:receiveData:getOccurrences', source, occurrences)
        else
            TriggerClientEvent('fortal_dip:receiveData:getOccurrences', source, {})
        end
    end)
end)

-- Verificar e criar tabela se necessário
RegisterNetEvent('fortal_dip:checkAndCreateTable')
AddEventHandler('fortal_dip:checkAndCreateTable', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local checkQuery = [[
        SELECT COUNT(*) as count FROM information_schema.tables 
        WHERE table_schema = DATABASE() AND table_name = 'ftdip_bo'
    ]]
    
    exports.oxmysql:execute(checkQuery, {}, function(result)
        if result and result[1] and result[1].count == 0 then
            
            local createQuery = [[
                CREATE TABLE IF NOT EXISTS `ftdip_bo` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `occurrence_number` varchar(50) NOT NULL,
                  `type` varchar(100) NOT NULL DEFAULT 'Boletim de Ocorrência',
                  `description` text NOT NULL,
                  `applicant_id` int(11) DEFAULT NULL,
                  `applicant_name` varchar(255) DEFAULT NULL,
                  `suspect_id` int(11) DEFAULT NULL,
                  `suspect_name` varchar(255) DEFAULT NULL,
                  `officer_id` int(11) NOT NULL,
                  `officer_name` varchar(255) NOT NULL,
                  `status` enum('Aberto','Em Andamento','Resolvido','Arquivado') NOT NULL DEFAULT 'Aberto',
                  `created_at` date NOT NULL DEFAULT (CURRENT_DATE),
                  `updated_at` date DEFAULT NULL,
                  PRIMARY KEY (`id`),
                  KEY `officer_id` (`officer_id`),
                  KEY `applicant_id` (`applicant_id`),
                  KEY `suspect_id` (`suspect_id`),
                  KEY `created_at` (`created_at`),
                  KEY `status` (`status`),
                  UNIQUE KEY `occurrence_number` (`occurrence_number`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]]
            
            exports.oxmysql:execute(createQuery, {}, function(createResult)
                if createResult then
                else
                end
            end)
        else
        end
    end)
end)

-- Event para criar novo B.O.
RegisterNetEvent('fortal_dip:createOccurrence')
AddEventHandler('fortal_dip:createOccurrence', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    if not data or not data.type or not data.description then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    -- Verificar se a tabela existe antes de tentar inserir
    local checkQuery = [[
        SELECT COUNT(*) as count FROM information_schema.tables 
        WHERE table_schema = DATABASE() AND table_name = 'ftdip_bo'
    ]]
    
    exports.oxmysql:execute(checkQuery, {}, function(checkResult)
        if not checkResult or not checkResult[1] or checkResult[1].count == 0 then
            return
        end
        
        
        -- Continuar com a criação do B.O.
        local identity = Utils.functions.getUserIdentity(user_id)
        local officerName = "Agente"
        
        if identity then
            if identity.name and identity.name2 then
                officerName = identity.name .. " " .. identity.name2
            elseif identity.name then
                officerName = identity.name
            end
        else
        end
        
        local occurrenceNumber = 'BO-' .. os.date('%Y%m%d') .. '-' .. math.random(1000, 9999)
        
        local query = [[
            INSERT INTO ftdip_bo 
            (occurrence_number, type, description, applicant_id, applicant_name, 
             suspect_id, suspect_name, officer_id, officer_name, status, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'Aberto', CURRENT_DATE)
        ]]
        
        local params = {
            occurrenceNumber,
            data.type,
            data.description,
            data.applicant_id or nil,
            data.applicant_name or nil,
            data.suspect_id or nil,
            data.suspect_name or nil,
            user_id,
            officerName
        }
        
        
        exports.oxmysql:execute(query, params, function(result)
            if result then
                
                -- Atualizar estatísticas na tabela ftdip_stats
                local today = os.date('%Y-%m-%d')
                local statsQuery = "INSERT INTO ftdip_stats (date, type, count) VALUES (?, 'occurrences', 1) ON DUPLICATE KEY UPDATE count = count + 1"
                local statsParams = {today}
                
                exports.oxmysql:execute(statsQuery, statsParams, function(statsResult)
                    if statsResult then
                        
                        -- Notificar todos os clientes sobre a atualização das estatísticas
                        TriggerClientEvent('updateStatistics', -1)
                    else
                    end
                end)
                
                -- Atualizar lista de B.O.s para todos os policiais
                TriggerClientEvent('updateOccurrences', -1)
            else
            end
        end)
    end)
end)

RegisterNetEvent('fortal_dip:deleteOccurrence')
AddEventHandler('fortal_dip:deleteOccurrence', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        DELETE FROM ftdip_bo WHERE id = ?
    ]]
    
    local params = { data.id }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de B.O.s para todos os policiais
            TriggerClientEvent('updateOccurrences', -1)
        else
        end
    end)
end)



-- Event para verificar permissões de páginas
RegisterNetEvent('fortal_dip:checkPagePermission')
AddEventHandler('fortal_dip:checkPagePermission', function(page)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('pagePermissionResult', source, false)
        return 
    end
    
    local canAccess = CanAccessPage(user_id, page)
    TriggerClientEvent('pagePermissionResult', source, canAccess)
end)

-- Event para obter informações da patente do jogador
RegisterNetEvent('fortal_dip:getPlayerRankInfo')
AddEventHandler('fortal_dip:getPlayerRankInfo', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:playerRankInfo', source, nil)
        return 
    end
    
    -- Verificar se tem permissão de agente
    local hasPermission = Utils.functions.hasPermission(user_id, Config.DefaultPermission)
    
    if not hasPermission then
        TriggerClientEvent('fortal_dip:playerRankInfo', source, nil)
        return
    end
    
    local rank = GetPlayerRank(user_id)
    
    -- Se tem permissão mas não está na tabela, enviar dados padrão com acesso total
    if not rank then
        local defaultData = {
            rank = 0,
            name = "Agente",
            label = "Agente",
            restrictedPages = {}, -- Sem páginas restritas = acesso total
            permissions = {
                canHire = true,
                canFire = true,
                canPromote = true,
                canDemote = true,
                canAnnounce = true,
                canWanted = true,
                canRemoveWanted = true,
                canViewHistory = true,
                canEditHistory = true,
                canViewStats = true,
                canViewMembers = true,
                canEditMembers = true,
                canPrison = true,
                canFine = true,
                canSearch = true,
                canLocked = true
            }
        }
        
        TriggerClientEvent('fortal_dip:playerRankInfo', source, defaultData)
        return
    end
    
    local rankInfo = Config.Hierarchy[rank]
    
    if not rankInfo then
        TriggerClientEvent('fortal_dip:playerRankInfo', source, nil)
        return
    end
    
    local data = {
        rank = rank,
        name = rankInfo.name,
        label = rankInfo.label,
        restrictedPages = rankInfo.restrictedPages or {},
        permissions = rankInfo.permissions or {}
    }
    
    TriggerClientEvent('fortal_dip:playerRankInfo', source, data)
end)

-- Event para verificar permissão de abertura do painel
RegisterNetEvent('fortal_dip:checkPanelPermission')
AddEventHandler('fortal_dip:checkPanelPermission', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:panelPermissionResult', source, false)
        return 
    end
    
    -- Verificar se tem permissão de agente (testar diferentes variações)
    local hasPermission = Utils.functions.hasPermission(user_id, Config.DefaultPermission)
    local hasPermissionLower = Utils.functions.hasPermission(user_id, "dip")
    local hasPermissionUpper = Utils.functions.hasPermission(user_id, "DIP")
    
    -- Se tem qualquer uma das permissões, permite acesso
    if hasPermission or hasPermissionLower or hasPermissionUpper then
        TriggerClientEvent('fortal_dip:panelPermissionResult', source, true)
        return
    end
    
    -- Se não tem permissão, verificar se está na tabela de membros
    local rank = GetPlayerRank(user_id)
    local finalPermission = rank ~= nil
    
    -- Enviar resultado para o cliente
    TriggerClientEvent('fortal_dip:panelPermissionResult', source, finalPermission)
end)

-- Event para buscar estatísticas do oficial
RegisterNetEvent('fortal_dip:getOfficerStats')
AddEventHandler('fortal_dip:getOfficerStats', function(officerId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if user_id then
        -- Buscar estatísticas do oficial no banco de dados
        local query = [[
            SELECT 
                os.user_id,
                os.arrests_made,
                os.fines_applied,
                os.total_fines_value,
                os.total_working_hours,
                os.vehicles_seized,
                os.reports_registered,
                fm.name,
                fm.rank,
                fm.rankLabel
            FROM ftdip_officer_stats os
LEFT JOIN ftdip_members fm ON os.user_id = fm.user_id
            WHERE os.user_id = ?
        ]]
        
        exports.oxmysql:executeSync(query, {officerId}, function(result)
            if result and result[1] then
                local stats = result[1]
                TriggerClientEvent('fortal_dip:receiveData:getOfficerStats', source, stats)
            else
                TriggerClientEvent('fortal_dip:receiveData:getOfficerStats', source, {})
            end
        end)
    else
        TriggerClientEvent('fortal_dip:receiveData:getOfficerStats', source, {})
    end
end)



function CanPerformAction(user_id, action)
    
    if not user_id then 
        return false 
    end
    
    local rank = GetPlayerRank(user_id)
    
    if not rank then 
        return false 
    end
    
    local rankInfo = Config.Hierarchy[rank]
    
    if not rankInfo or not rankInfo.permissions then 

        return false 
    end
    
    local hasPermission = rankInfo.permissions[action] == true

    
    return hasPermission
end

RegisterNetEvent('fortal_dip:removeHistory')
AddEventHandler('fortal_dip:removeHistory', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    -- Verificar permissão
    if not CanPerformAction(user_id, 'canEditHistory') then

        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para editar histórico!", 5000)
        return
    end
    
    local playerId = tonumber(data.playerId)
    local historyId = tonumber(data.id)
    local historyTime = data.time
    
    
    if not playerId or not historyId then
        TriggerClientEvent('Notify', source, 'negado', 'Dados inválidos!')
        return
    end
    
    -- Extrair valores do tempo/valor (ex: "10/5000" -> amount = 5000)
    local amount = 0
    if historyTime and type(historyTime) == 'string' then
        local parts = {}
        for part in historyTime:gmatch("[^/]+") do
            table.insert(parts, part)
        end
        if #parts >= 2 then
            amount = tonumber(parts[2]) or 0
        end
    end
    
    
    -- Excluir registro diretamente usando LIMIT 1
    local query = [[
        DELETE FROM ftdip_history 
        WHERE player_id = ? AND officer_id = ? AND amount = ? 
        ORDER BY created_at DESC LIMIT 1
    ]]
    
    
    exports.oxmysql:execute(query, {playerId, historyId, amount}, function(result)
        
        if result and result.affectedRows and result.affectedRows > 0 then
            
            -- Notificar o usuário
            TriggerClientEvent('Notify', source, 'sucesso', 'Registro removido com sucesso!')
            
            -- Atualizar dados do jogador para todos os clientes
            TriggerClientEvent('updatePlayerHistory', -1, playerId)
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao remover registro!')
        end
    end)
end)

RegisterNetEvent('fortal_dip:getOptionsOccurrence')
AddEventHandler('fortal_dip:getOptionsOccurrence', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('fortal_dip:receiveData:getOptionsOccurrence', source, {applicant = {}, suspects = {}})
        return 
    end
    
    local applicant = {}
    local suspects = {}
    
    local nearbyPlayers = GetNearbyPlayers(source, 2.0)
    for _, player in pairs(nearbyPlayers) do
        table.insert(applicant, {
            id = tonumber(player.passport),
            name = player.name
        })

        table.insert(suspects, {
            id = tonumber(player.passport),
            name = player.name
        })
    end
    
    local options = {
        applicant = applicant,
        suspects = suspects
    }

    TriggerClientEvent('fortal_dip:receiveData:getOptionsOccurrence', source, options)
end)


