local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
flx = {}
Tunnel.bindInterface("fortal_prisao", flx)

vCLIENT = Tunnel.getInterface("fortal_prisao")
vTASKBAR = Tunnel.getInterface("taskbar")


local Config = module("fortal_prisao", "shared/config")

local prisonStatusChecks = {}
local resourceStarted = false
local verificationInProgress = false

CreateThread(function()
    while true do
        Wait(300000) 
        prisonStatusChecks = {}
    end
end)

-- Thread para verificar e liberar jogadores automaticamente (DESABILITADA TEMPORARIAMENTE)
-- CreateThread(function()
--     while true do
--         Wait(60000) -- Verificar a cada 1 minuto
--         
--         local players = GetPlayers()
--         for _, playerId in ipairs(players) do
--             local user_id = vRP.getUserId(tonumber(playerId))
--             if user_id then
--                 local identity = vRP.userIdentity(user_id)
--                 if identity and parseInt(identity["prison"]) <= 0 then
--                     -- Jogador não deveria estar preso, verificar se está sincronizado
--                     local prisonType = GetPrisonTypeFromDatabase(user_id)
--                     if prisonType and prisonType ~= "" then
--                         -- Limpar tipo de prisão se ainda existir
--                         ClearPrisonType(user_id)
--                         print("^2[FORTAL PRISÃO]^7 Jogador " .. user_id .. " liberado automaticamente (tempo zerado)")
--                     end
--                 end
--             end
--         end
--     end
-- end)

CreateThread(function()
    Wait(8000) 
    if not resourceStarted and not verificationInProgress then
        resourceStarted = true
        verificationInProgress = true
        CheckAllPlayersPrisonStatus()
        verificationInProgress = false
    end
end)

CreateThread(function()
    Wait(30000)
    CheckAllPlayersPrisonStatus()
end)


function CheckAllPlayersPrisonStatus()
    if verificationInProgress then
        return
    end
    
    verificationInProgress = true
    
    local players = GetPlayers()
    local checkedCount = 0
    
    for _, playerId in ipairs(players) do
        local user_id = vRP.getUserId(tonumber(playerId))
        if user_id then
            local identity = vRP.userIdentity(user_id)
            if identity and parseInt(identity["prison"]) > 0 then
                -- Marcar como verificado para evitar duplicatas
                prisonStatusChecks[user_id] = true
                
                -- Obter tipo de prisão do banco de dados
                local prisonType = GetPrisonTypeFromDatabase(user_id)
                local prisonTime = parseInt(identity["prison"])
                
                -- Sincronizar prisão no cliente (sem teleporte)
                TriggerClientEvent("fortal_prisao:syncPrison", tonumber(playerId), true, false)
                TriggerClientEvent("fortal_prisao:show", tonumber(playerId), prisonTime, 0)
                TriggerClientEvent("fortal_prisao:setPrisonType", tonumber(playerId), prisonType)
                
                -- Teleportar para a prisão correta
                TriggerClientEvent("fortal_prisao:teleportToPrison", tonumber(playerId))
                
                checkedCount = checkedCount + 1
            end
        end
    end
    
    verificationInProgress = false
end

function CheckPlayerPrisonStatus(user_id, source)
    if not user_id or not source then
        return false
    end
    
    local identity = vRP.userIdentity(user_id)
    if identity and parseInt(identity["prison"]) > 0 then
        local prisonType = GetPrisonTypeFromDatabase(user_id)
        local prisonTime = parseInt(identity["prison"])

        TriggerClientEvent("fortal_prisao:syncPrison", source, true, false)
        TriggerClientEvent("fortal_prisao:show", source, prisonTime, 0)
        TriggerClientEvent("fortal_prisao:setPrisonType", source, prisonType)

        TriggerClientEvent("fortal_prisao:teleportToPrison", source)
        return true
    end
    
    return false
end

function ClearPrisonStatusCache()
    prisonStatusChecks = {}
end

function StorePrisonType(user_id, prisonType)
    local query = "INSERT INTO fortal_prison (user_id, prison_type) VALUES (?, ?) ON DUPLICATE KEY UPDATE prison_type = ?"
    local params = {user_id, prisonType, prisonType}
    
    local result = exports.oxmysql:executeSync(query, params)
    if result then
        return true
    else
        return false
    end
end

function GetPrisonTypeFromDatabase(user_id)
    local query = "SELECT prison_type FROM fortal_prison WHERE user_id = ?"
    local params = {user_id}
    
    local result = exports.oxmysql:executeSync(query, params)
    
    if result and result[1] and result[1].prison_type and result[1].prison_type ~= "" then
        return result[1].prison_type
    end
    
    return "normal"
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local prisonMarkers = {}
local prisonRecords = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function flx.getConfig()
    return Config
end

function flx.getPrisonTypes()
    return Config.PrisonTypes
end

function flx.getFineTypes()
    return Config.FineTypes
end

function flx.getSearch(id)
    if not id or id == 0 then
        return false
    end
    
    local data = vRP.userIdentity(id)
    
    if data then
        data['prisonlist'] = {}
        data['img'] = getUData(id, 'tablet_img') or ""
        return data
    else
        return false
    end
end

RegisterServerEvent("fortal_prisao:requestSearch")
AddEventHandler("fortal_prisao:requestSearch", function(userId, searchId)
    local source = source
    local searchData = flx.getSearch(userId)
    TriggerClientEvent("fortal_prisao:searchResponse", source, searchData, searchId)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function flx.initPrison(nuser_id, prisonType, services, fines, text, policeSource)
    local source = policeSource or source
    local user_id = vRP.getUserId(source)
    
    if nuser_id then
        if actived[nuser_id] == nil then
            actived[nuser_id] = true
            
            local identity = vRP.userIdentity(nuser_id)
            if identity then
                local otherPlayer = vRP.userSource(nuser_id)
                if otherPlayer then
                    TriggerClientEvent("fortal_prisao:syncPrison", otherPlayer, true, false)
                end

                if not Config.PrisonTypes[prisonType] then
                    prisonType = "normal"
                end

                StorePrisonType(nuser_id, prisonType)

                local maxServices = Config.PrisonTypes[prisonType].maxTime
                local minServices = Config.PrisonTypes[prisonType].minTime
                
                if services > maxServices then
                    services = maxServices
                elseif services < minServices then
                    services = Config.PrisonTypes[prisonType].defaultTime
                end
                
                local maxFine = Config.FineTypes[prisonType].maxAmount
                local minFine = Config.FineTypes[prisonType].minAmount
                
                if fines > maxFine then
                    fines = maxFine
                elseif fines < 0 then
                    fines = Config.FineTypes[prisonType].defaultAmount
                end

                vRP.initPrison(parseInt(nuser_id), services)

                if fines > 0 then
                    vRP.addFines(nuser_id, fines)
                end

                if user_id then
                    TriggerClientEvent("Notify", source, "verde", "Prisão efetuada.", 5000)
                end

                if otherPlayer then
                    TriggerClientEvent("fortal_prisao:show", otherPlayer, services, fines)
                    TriggerClientEvent("fortal_prisao:setPrisonType", otherPlayer, prisonType)

                    TriggerClientEvent("fortal_prisao:teleportToPrison", otherPlayer)
                end
            end
            
            actived[nuser_id] = nil
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REDUCEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function flx.reducePrison()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local randPercent = math.random(1000)
        local randItens = math.random(#Config.PrisonItems)
        local amountItens = math.random(Config.PrisonItems[randItens]["min"], Config.PrisonItems[randItens]["max"])
        
        if parseInt(randPercent) <= parseInt(Config.PrisonItems[randItens]["perc"]) then
            vRP.generateItem(user_id, Config.PrisonItems[randItens]["item"], amountItens, true)
        end

        local identity = vRP.userIdentity(user_id)

        if not identity then
            TriggerClientEvent("Notify", source, "vermelho", "Erro ao obter dados da prisão!", 5000)
            return
        end

        local currentPrisonType = GetPrisonTypeFromDatabase(user_id)

        local currentServices = parseInt(identity["prison"]) or 0
        local reductionAmount = Config.Timers.serviceReduction
        local newServices = math.max(0, currentServices - reductionAmount)

        if currentServices <= 0 then
            TriggerClientEvent("Notify", source, "amarelo", "Você não está preso!", 5000)
            return
        end

        vRP.initPrison(user_id, newServices)
    
        Wait(200)

        local updatedIdentity = vRP.userIdentity(user_id)
        local remainingServices = parseInt(updatedIdentity["prison"]) or 0
        
        if remainingServices <= 0 then
            -- Limpar tipo de prisão
            ClearPrisonType(user_id)
            
            -- Aguardar um pouco para garantir que foi processado
            Wait(200)
            
            TriggerClientEvent("fortal_prisao:syncPrison", source, false, true)
            TriggerClientEvent("fortal_prisao:hide", source)
            TriggerClientEvent("Notify", source, "verde", "Você foi liberado da prisão!", 5000)
            
        else
            TriggerClientEvent("fortal_prisao:asyncServices", source)
            TriggerClientEvent("fortal_prisao:updateTime", source, remainingServices, 0)
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKKEY
-----------------------------------------------------------------------------------------------------------------------------------------
function flx.checkKey()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local policeResult = vRP.numPermission("Police")
        if parseInt(#policeResult) <= Config.Police.minOfficers then
            TriggerClientEvent("Notify", source, "amarelo", "Sistema indisponível no momento.", 5000)
            return false
        end
        
        local consultItem = vRP.getInventoryItemAmount(user_id, "key")
        if consultItem[1] > 0 then
            if not vRP.checkBroken(consultItem[2]) then
                if vRP.tryGetInventoryItem(user_id, consultItem[2], 1, true) then
                    TriggerClientEvent("fortal_prisao:syncPrison", source, false, false)
                    prisonMarkers[source] = { 600, user_id }
                    
                    for k, v in pairs(policeResult) do
                        TriggerClientEvent("Notify", v, "amarelo", "Recebemos a informação de um fugitivo da penitenciária.", 5000)
                    end
                    
                    return true
                end
            end
        end
        
        return false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - PRISON MARKERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        for k, v in pairs(prisonMarkers) do
            if prisonMarkers[k][1] > 0 then
                prisonMarkers[k][1] = prisonMarkers[k][1] - 1
                
                if prisonMarkers[k][1] <= 0 then
                    if vRP.userSource(prisonMarkers[k][2]) then
                        -- Remover blip se necessário
                    end
                    
                    prisonMarkers[k] = nil
                end
            end
        end
        
        Wait(1000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect", function(user_id, source)
    CreateThread(function()
        Wait(3000) 
        
        if prisonStatusChecks[user_id] then
            return
        end

        if verificationInProgress then
            Wait(2000)
        end
        
        VerifyAndFixPrisonType(user_id, source)
        
        local isInPrison = CheckPlayerPrisonStatus(user_id, source)
        
        prisonStatusChecks[user_id] = true
        
    end)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UTILITY FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function getUData(user_id, key)
    return ""
end

function parseFormat(value)
    return tostring(value)
end

function flx.getPrisonCoords(prisonType)
    if prisonType == "maxima" then
        return Config.PrisonCoords.maxima
    else
        return {
            internal = Config.PrisonCoords.internal,
            external = Config.PrisonCoords.external,
            leaver = Config.PrisonCoords.leaver
        }
    end
end

function flx.getServiceLocations(prisonType)
    if prisonType == "maxima" then
        return Config.MaximaServiceLocations
    else
        return Config.ServiceLocations
    end
end

exports("initPrison", function(userId, prisonType, services, fines, text)
    flx.initPrison(userId, prisonType or "normal", services or 12, fines or 0, text or "")
end)

exports("getPrisonConfig", function()
    return Config
end)

RegisterNetEvent("fortal_prisao:reducePrison")
AddEventHandler("fortal_prisao:reducePrison", function()
    flx.reducePrison()
end)

RegisterNetEvent("fortal_prisao:syncPrisonApplied")
AddEventHandler("fortal_prisao:syncPrisonApplied", function(targetUserId, prisonTime, prisonType)
    local targetSource = vRP.userSource(targetUserId)
    if targetSource then
        TriggerClientEvent("fortal_prisao:syncPrison", targetSource, true, true)
        TriggerClientEvent("fortal_prisao:show", targetSource, prisonTime, 0)
        TriggerClientEvent("fortal_prisao:setPrisonType", targetSource, prisonType or "normal")
    end
end)

RegisterNetEvent("fortal_prisao:imprisonFromPolice")
AddEventHandler("fortal_prisao:imprisonFromPolice", function(targetUserId, prisonType, services, fines, text, policeSource)
    local source = policeSource or source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        flx.initPrison(targetUserId, prisonType, services, fines, text, policeSource)

        local targetSource = vRP.userSource(targetUserId)
        if targetSource then
            TriggerClientEvent("fortal_prisao:teleportToPrison", targetSource)
            TriggerClientEvent("fortal_prisao:show", targetSource, services, fines)
            TriggerClientEvent("Notify", targetSource, "vermelho", "Você foi preso por " .. services .. " meses!", 5000)
        end
    end
end)

RegisterNetEvent("fortal_prisao:checkPrisonStatus")
AddEventHandler("fortal_prisao:checkPrisonStatus", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        CheckPlayerPrisonStatus(user_id, source)
    end
end)

RegisterNetEvent("fortal_prisao:forceSync")
AddEventHandler("fortal_prisao:forceSync", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local identity = vRP.userIdentity(user_id)
        if identity and parseInt(identity["prison"]) > 0 then
            local prisonType = GetPrisonTypeFromDatabase(user_id)
            local prisonTime = parseInt(identity["prison"])

            TriggerClientEvent("fortal_prisao:syncPrison", source, true, true)
            TriggerClientEvent("fortal_prisao:show", source, prisonTime, 0)
            TriggerClientEvent("fortal_prisao:setPrisonType", source, prisonType)
        else
            TriggerClientEvent("Notify", source, "amarelo", "Você não está preso!", 3000)
        end
    end
end)

function VerifyAndFixPrisonType(user_id, source)
    local identity = vRP.userIdentity(user_id)
    if identity and parseInt(identity["prison"]) > 0 then
        local query = "SELECT prison_type FROM fortal_prison WHERE user_id = ?"
        local params = {user_id}
        local result = exports.oxmysql:executeSync(query, params)
        local storedType = result and result[1] and result[1].prison_type
        
        if not storedType or storedType == "" then
            local fallbackType = "normal" 
            StorePrisonType(user_id, fallbackType)

            if source then
                TriggerClientEvent("fortal_prisao:setPrisonType", source, fallbackType)
                TriggerClientEvent("fortal_prisao:syncPrison", source, true, false)
                TriggerClientEvent("fortal_prisao:show", source, parseInt(identity["prison"]), 0)
                TriggerClientEvent("fortal_prisao:teleportToPrison", source)
                TriggerClientEvent("Notify", source, "azul", "Tipo de prisão definido para Prisão Normal (padrão) - Teleportado", 3000)
            end
        else
            if source then
                TriggerClientEvent("fortal_prisao:setPrisonType", source, storedType)
                TriggerClientEvent("fortal_prisao:syncPrison", source, true, false)
                TriggerClientEvent("fortal_prisao:show", source, parseInt(identity["prison"]), 0)
                TriggerClientEvent("fortal_prisao:teleportToPrison", source)
                TriggerClientEvent("Notify", source, "azul", "Tipo de prisão sincronizado para " .. (storedType == "maxima" and "Segurança Máxima" or "Prisão Normal") .. " - Teleportado", 3000)
            end
        end
    end
end

function ClearPrisonType(user_id)
    local checkQuery = "SELECT COUNT(*) as count FROM fortal_prison WHERE user_id = ?"
    local checkParams = {user_id}
    local checkResult = exports.oxmysql:executeSync(checkQuery, checkParams)
    local initialCount = checkResult and checkResult[1] and checkResult[1].count or 0
    
    if initialCount == 0 then
        return true
    end

    local deleteQuery = "DELETE FROM fortal_prison WHERE user_id = ?"
    local deleteParams = {user_id}
    local deleteResult = exports.oxmysql:executeSync(deleteQuery, deleteParams)
    
    Wait(100)

    local verifyQuery = "SELECT COUNT(*) as count FROM fortal_prison WHERE user_id = ?"
    local verifyResult = exports.oxmysql:executeSync(verifyQuery, checkParams)
    local remainingCount = verifyResult and verifyResult[1] and verifyResult[1].count or 0
    
    if remainingCount == 0 then
        return true
    else
        local aggressiveDelete = exports.oxmysql:executeSync("DELETE FROM fortal_prison WHERE user_id = ? LIMIT 100", deleteParams)
        Wait(100)
        
        local finalCheck = exports.oxmysql:executeSync(verifyQuery, checkParams)
        local finalCount = finalCheck and finalCheck[1] and finalCheck[1].count or 0
        
        if finalCount == 0 then
            return true
        else
            return false
        end
    end
end

RegisterCommand("cleanprison", function(source, args)
    local user_id = vRP.getUserId(source)
    
    if not user_id or not vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando!", 5000)
        return
    end

    if not args[1] then
        TriggerClientEvent("Notify", source, "amarelo", "Uso: /cleanprison [ID]", 5000)
        return
    end
    
    local targetUserId = tonumber(args[1])
    if not targetUserId then
        TriggerClientEvent("Notify", source, "vermelho", "ID inválido!", 5000)
        return
    end

    local targetIdentity = vRP.userIdentity(targetUserId)
    if not targetIdentity then
        TriggerClientEvent("Notify", source, "vermelho", "Jogador não encontrado!", 5000)
        return
    end

    local prisonTime = parseInt(targetIdentity["prison"]) or 0
    if prisonTime <= 0 then
        TriggerClientEvent("Notify", source, "amarelo", "Este jogador não está preso!", 5000)
        return
    end

    local targetSource = vRP.userSource(targetUserId)

    -- Primeiro zerar o tempo de prisão
    vRP.initPrison(targetUserId, 0)
    
    -- Aguardar um pouco para garantir que foi processado
    Wait(300)
    
    -- Depois limpar o tipo de prisão
    local clearResult = ClearPrisonType(targetUserId)
    
    -- Aguardar mais um pouco para garantir que foi limpo
    Wait(200)
    
    -- Verificar novamente se foi limpo
    if not clearResult then
        -- Tentar novamente se falhou
        clearResult = ClearPrisonType(targetUserId)
        Wait(200)
    end
    
    if targetSource then
        TriggerClientEvent("fortal_prisao:syncPrison", targetSource, false, true)
        TriggerClientEvent("fortal_prisao:hide", targetSource)
        TriggerClientEvent("Notify", targetSource, "verde", "Você foi liberado da prisão por um administrador!", 5000)
    end

    if clearResult then
        TriggerClientEvent("Notify", source, "verde", "Jogador " .. targetUserId .. " foi liberado da prisão com sucesso! Tipo de prisão limpo.", 5000)
    else
        TriggerClientEvent("Notify", source, "vermelho", "ERRO: Não foi possível limpar o tipo de prisão do jogador " .. targetUserId .. "!", 5000)
    end
end, false)

-- Comando adicional para liberar prisão (mais simples)
RegisterCommand("liberar", function(source, args)
    local user_id = vRP.getUserId(source)
    
    if not user_id or not vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando!", 5000)
        return
    end

    if not args[1] then
        TriggerClientEvent("Notify", source, "amarelo", "Uso: /liberar [ID]", 5000)
        return
    end
    
    local targetUserId = tonumber(args[1])
    if not targetUserId then
        TriggerClientEvent("Notify", source, "vermelho", "ID inválido!", 5000)
        return
    end

    local targetIdentity = vRP.userIdentity(targetUserId)
    if not targetIdentity then
        TriggerClientEvent("Notify", source, "vermelho", "Jogador não encontrado!", 5000)
        return
    end

    local prisonTime = parseInt(targetIdentity["prison"]) or 0
    if prisonTime <= 0 then
        TriggerClientEvent("Notify", source, "amarelo", "Este jogador não está preso!", 5000)
        return
    end

    local targetSource = vRP.userSource(targetUserId)

    -- Primeiro zerar o tempo de prisão
    vRP.initPrison(targetUserId, 0)
    
    -- Aguardar processamento
    Wait(300)
    
    -- Depois limpar tipo de prisão
    local clearResult = ClearPrisonType(targetUserId)
    
    -- Aguardar mais um pouco
    Wait(200)
    
    -- Verificar novamente se foi limpo
    if not clearResult then
        clearResult = ClearPrisonType(targetUserId)
        Wait(200)
    end
    
    if targetSource then
        TriggerClientEvent("fortal_prisao:syncPrison", targetSource, false, true)
        TriggerClientEvent("fortal_prisao:hide", targetSource)
        TriggerClientEvent("Notify", targetSource, "verde", "Você foi liberado da prisão!", 5000)
    end

    if clearResult then
        TriggerClientEvent("Notify", source, "verde", "Jogador " .. targetUserId .. " foi liberado da prisão! Tipo de prisão limpo.", 5000)
    else
        TriggerClientEvent("Notify", source, "vermelho", "ERRO: Falha ao limpar tipo de prisão do jogador " .. targetUserId .. "!", 5000)
    end
end, false)

-- Comando super simples para limpar banco
RegisterCommand("limparbanco", function(source, args)
    local user_id = vRP.getUserId(source)
    
    if not user_id or not vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão!", 5000)
        return
    end

    if not args[1] then
        TriggerClientEvent("Notify", source, "amarelo", "Uso: /limparbanco [ID]", 5000)
        return
    end
    
    local targetUserId = tonumber(args[1])
    if not targetUserId then
        TriggerClientEvent("Notify", source, "vermelho", "ID inválido!", 5000)
        return
    end

    -- Verificar se existe
    local checkQuery = "SELECT * FROM fortal_prison WHERE user_id = ?"
    local checkParams = {targetUserId}
    local checkResult = exports.oxmysql:executeSync(checkQuery, checkParams)
    
    if not checkResult or #checkResult == 0 then
        TriggerClientEvent("Notify", source, "amarelo", "Jogador " .. targetUserId .. " não tem registros!", 5000)
        return
    end
    
    TriggerClientEvent("Notify", source, "azul", "Encontrados " .. #checkResult .. " registros para deletar", 5000)
    
    -- Deletar com TRUNCATE se for apenas um registro
    local deleteQuery = "DELETE FROM fortal_prison WHERE user_id = ?"
    local deleteResult = exports.oxmysql:executeSync(deleteQuery, checkParams)
    
    TriggerClientEvent("Notify", source, "azul", "DELETE executado. Resultado: " .. tostring(deleteResult), 5000)
    
    -- Verificar se foi deletado
    Wait(500)
    local finalCheck = exports.oxmysql:executeSync(checkQuery, checkParams)
    local finalCount = finalCheck and #finalCheck or 0
    
    if finalCount == 0 then
        TriggerClientEvent("Notify", source, "verde", "SUCCESS! Registros deletados. Restam: " .. finalCount, 5000)
        
        -- Zerar tempo de prisão também
        vRP.initPrison(targetUserId, 0)
        
        local targetSource = vRP.userSource(targetUserId)
        if targetSource then
            TriggerClientEvent("fortal_prisao:syncPrison", targetSource, false, true)
            TriggerClientEvent("fortal_prisao:hide", targetSource)
            TriggerClientEvent("Notify", targetSource, "verde", "Você foi liberado da prisão!", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "FAILED! Ainda restam " .. finalCount .. " registros!", 5000)
    end
end, false)

-- Comando de teste para verificar o banco
RegisterCommand("testeprison", function(source, args)
    local user_id = vRP.getUserId(source)
    
    if not user_id or not vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando!", 5000)
        return
    end

    if not args[1] then
        TriggerClientEvent("Notify", source, "amarelo", "Uso: /testeprison [ID]", 5000)
        return
    end
    
    local targetUserId = tonumber(args[1])
    if not targetUserId then
        TriggerClientEvent("Notify", source, "vermelho", "ID inválido!", 5000)
        return
    end

    -- Verificar se existe na tabela
    local checkQuery = "SELECT * FROM fortal_prison WHERE user_id = ?"
    local checkParams = {targetUserId}
    local checkResult = exports.oxmysql:executeSync(checkQuery, checkParams)
    
    if not checkResult or #checkResult == 0 then
        TriggerClientEvent("Notify", source, "amarelo", "Jogador " .. targetUserId .. " não tem registros na tabela fortal_prison!", 5000)
        return
    end
    
    TriggerClientEvent("Notify", source, "azul", "Jogador " .. targetUserId .. " tem " .. #checkResult .. " registros na tabela", 5000)
    
    -- Tentar deletar diretamente
    local deleteQuery = "DELETE FROM fortal_prison WHERE user_id = ?"
    local deleteResult = exports.oxmysql:executeSync(deleteQuery, checkParams)
    
    TriggerClientEvent("Notify", source, "azul", "Resultado do DELETE: " .. tostring(deleteResult), 5000)
    
    -- Verificar novamente
    Wait(200)
    local finalCheck = exports.oxmysql:executeSync(checkQuery, checkParams)
    local finalCount = finalCheck and #finalCheck or 0
    
    if finalCount == 0 then
        TriggerClientEvent("Notify", source, "verde", "SUCCESS: Registros deletados! Restam: " .. finalCount, 5000)
    else
        TriggerClientEvent("Notify", source, "vermelho", "FAILED: Ainda restam " .. finalCount .. " registros!", 5000)
    end
end, false)

-- Comando para forçar limpeza do banco de dados
RegisterCommand("forcecleanprison", function(source, args)
    local user_id = vRP.getUserId(source)
    
    if not user_id or not vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando!", 5000)
        return
    end

    if not args[1] then
        TriggerClientEvent("Notify", source, "amarelo", "Uso: /forcecleanprison [ID]", 5000)
        return
    end
    
    local targetUserId = tonumber(args[1])
    if not targetUserId then
        TriggerClientEvent("Notify", source, "vermelho", "ID inválido!", 5000)
        return
    end

    -- Verificar se o jogador existe na tabela fortal_prison
    local checkQuery = "SELECT * FROM fortal_prison WHERE user_id = ?"
    local checkParams = {targetUserId}
    local checkResult = exports.oxmysql:executeSync(checkQuery, checkParams)
    
    if not checkResult or #checkResult == 0 then
        TriggerClientEvent("Notify", source, "amarelo", "Jogador " .. targetUserId .. " não tem registros na tabela fortal_prison!", 5000)
        return
    end
    
    -- Forçar limpeza com DELETE direto
    local deleteQuery = "DELETE FROM fortal_prison WHERE user_id = ?"
    local deleteParams = {targetUserId}
    local deleteResult = exports.oxmysql:executeSync(deleteQuery, deleteParams)
    
    -- Verificar se foi deletado
    local verifyQuery = "SELECT COUNT(*) as count FROM fortal_prison WHERE user_id = ?"
    local verifyResult = exports.oxmysql:executeSync(verifyQuery, checkParams)
    local remainingCount = verifyResult and verifyResult[1] and verifyResult[1].count or 0
    
    if remainingCount == 0 then
        TriggerClientEvent("Notify", source, "verde", "FORÇADO: Tipo de prisão do jogador " .. targetUserId .. " foi removido do banco!", 5000)

        vRP.initPrison(targetUserId, 0)
        
        local targetSource = vRP.userSource(targetUserId)
        if targetSource then
            TriggerClientEvent("fortal_prisao:syncPrison", targetSource, false, true)
            TriggerClientEvent("fortal_prisao:hide", targetSource)
            TriggerClientEvent("Notify", targetSource, "verde", "Você foi liberado da prisão (forçado)!", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "vermelho", "ERRO: Não foi possível remover o tipo de prisão do jogador " .. targetUserId .. "!", 5000)
    end
end, false)

-- Comando para verificar status da prisão
RegisterCommand("prisonstatus", function(source, args)
    local user_id = vRP.getUserId(source)
    
    if not user_id or not vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este comando!", 5000)
        return
    end

    if not args[1] then
        TriggerClientEvent("Notify", source, "amarelo", "Uso: /prisonstatus [ID]", 5000)
        return
    end
    
    local targetUserId = tonumber(args[1])
    if not targetUserId then
        TriggerClientEvent("Notify", source, "vermelho", "ID inválido!", 5000)
        return
    end

    local targetIdentity = vRP.userIdentity(targetUserId)
    if not targetIdentity then
        TriggerClientEvent("Notify", source, "vermelho", "Jogador não encontrado!", 5000)
        return
    end

    local prisonTime = parseInt(targetIdentity["prison"]) or 0
    local prisonType = GetPrisonTypeFromDatabase(targetUserId)
    local targetSource = vRP.userSource(targetUserId)
    
    local statusMsg = string.format("^3[PRISÃO]^7 Jogador %d:\nTempo: %d meses\nTipo: %s\nOnline: %s", 
        targetUserId, 
        prisonTime, 
        prisonType == "maxima" and "Segurança Máxima" or "Normal",
        targetSource and "Sim" or "Não"
    )
    
    TriggerClientEvent("Notify", source, "azul", statusMsg, 8000)
end, false)

RegisterNetEvent("fortal_prisao:verifyPrisonType")
AddEventHandler("fortal_prisao:verifyPrisonType", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        VerifyAndFixPrisonType(user_id, source)
        TriggerClientEvent("Notify", source, "azul", "Tipo de prisão verificado!", 3000)
    end
end)



