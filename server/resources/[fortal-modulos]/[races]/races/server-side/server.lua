local json = json or {}
if not json.encode then
function json.encode(val)
if val == nil then
    return "null"
elseif type(val) == "number" then
    return tostring(val)
elseif type(val) == "string" then
    return string.format("%q", val)
elseif type(val) == "boolean" then
    return tostring(val)
elseif type(val) == "table" then
    local s = {}
    local is_array = true
    for k, v in pairs(val) do
        if type(k) == "number" and k == #s + 1 then
            table.insert(s, json.encode(v))
        else
            is_array = false
            break
        end
    end
    if is_array then
        return "[" .. table.concat(s, ",") .. "]"
    else
        s = {}
        for k, v in pairs(val) do
            table.insert(s, string.format("%q:%s", k, json.encode(v)))
        end
        return "{" .. table.concat(s, ",") .. "}"
    end
else
    return "null"
end
end
end

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
cRP = {}
Tunnel.bindInterface("races",cRP)

local ilegalRace = {}

local function getVehicleInfo(vehicleHash)
if Config.VehicleMapping[vehicleHash] then
    return Config.VehicleMapping[vehicleHash][1], Config.VehicleMapping[vehicleHash][2]
else
    return "Desconhecido", "comum"
end
end

local activeRaces = {}
local raceCooldowns = {}
local nextInstanceId = 1

local function isRaceInCooldown(raceId)
    if not raceCooldowns[raceId] then
        return false
    end
    
    local currentTime = os.time()
    
    return (currentTime - raceCooldowns[raceId]) < Config.General.CooldownTime
end

local function getCooldownTimeRemaining(raceId)
    if not raceCooldowns[raceId] then
        return 0
    end
    
    local currentTime = os.time()
    local elapsed = currentTime - raceCooldowns[raceId]
    
    return math.max(0, Config.General.CooldownTime - elapsed)
end

local function generateInstanceId()
    local id = nextInstanceId
    nextInstanceId = nextInstanceId + 1
    return id
end

local function getRacePlayerCount(raceId, instanceId)
local count = 0
if activeRaces[raceId] and activeRaces[raceId][instanceId] and activeRaces[raceId][instanceId].players then
for _, playerData in pairs(activeRaces[raceId][instanceId].players) do
    if GetPlayerPing(playerData.source) > 0 then
        count = count + 1
    end
end
end
return count
end

local function cleanupRaceInstance(raceId, instanceId)
if activeRaces[raceId] and activeRaces[raceId][instanceId] then
activeRaces[raceId][instanceId] = nil

if next(activeRaces[raceId]) == nil then
    activeRaces[raceId] = nil
end
end
end

local function findPlayerInRaces(user_id)
for raceId, instances in pairs(activeRaces) do
for instanceId, raceData in pairs(instances) do
    if raceData.players[user_id] then
        return raceId, instanceId
    end
end
end
return nil, nil
end

local function findOrCreateWaitingInstance(raceId)
if activeRaces[raceId] then
for instanceId, raceData in pairs(activeRaces[raceId]) do
    if raceData.status == "waiting" and getRacePlayerCount(raceId, instanceId) < raceData.maxPlayers then
        return instanceId
    end
end
end

local instanceId = generateInstanceId()
if not activeRaces[raceId] then
activeRaces[raceId] = {}
end

activeRaces[raceId][instanceId] = {
players = {},
status = "waiting",
teleportTriggered = false,
maxPlayers = #Config.Races[raceId]["cars"],
waitStartTime = GetGameTimer(),
waitDuration = Config.General.WaitTime * 1000,
finishOrder = {} -- Para rastrear ordem de chegada
}

return instanceId
end

local function getPaymentByPosition(position)
    return Config.Payments[position] or Config.Payments.default
end

function cRP.checkPermissionAndItem(raceId)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        -- Verificar grupos restritos
        for _, group in pairs(Config.Permissions.RestrictedGroups) do
            if vRP.hasGroup(user_id, group) then
                TriggerClientEvent('Notify', source, 'vermelho', 'Importante', Config.Notifications.NoPermission, 5000)
                return false
            end
        end

        -- Verificar cooldown ANTES de pedir o item
        if isRaceInCooldown(raceId) then
            local timeRemaining = getCooldownTimeRemaining(raceId)
            local minutes = math.floor(timeRemaining / 60)
            local seconds = timeRemaining % 60
            TriggerClientEvent('Notify', source, 'amarelo', 'Corrida em Cooldown', 
                string.format(Config.Notifications.RaceInCooldown, minutes, seconds), 5000)
            return false
        end

        -- Verificar se já está em corrida
        local currentRaceId, currentInstanceId = findPlayerInRaces(user_id)
        if currentRaceId then
            TriggerClientEvent('Notify', source, 'vermelho', Config.Notifications.AlreadyInRace, 5000)
            return false
        end

        -- Verificar se tem o item necessário (SEM CONSUMIR ainda)
        if vRP.getInventoryItemAmount(user_id, Config.Items.IllegalRaceItem)[1] < 1 then
            TriggerClientEvent('Notify', source, 'vermelho', 'Item', Config.Notifications.NoRequiredItem, 5000)
            return false
        end

        -- AGORA SIM consumir o item (só depois de todas as verificações)
        if not vRP.tryGetInventoryItem(user_id, Config.Items.IllegalRaceItem, 1, true) then
            TriggerClientEvent('Notify', source, 'vermelho', 'Item', Config.Notifications.NoRequiredItem, 5000)
            return false
        end

        -- Criar ou encontrar instância
        local instanceId = findOrCreateWaitingInstance(raceId)
        local raceData = activeRaces[raceId][instanceId]

        if not raceData.players[user_id] then
            local initialCoords = Config.Races[raceId]["init"]
            raceData.players[user_id] = {
                source = source,
                currentCheckpoint = 1,
                timeInRace = 0,
                lastKnownCoords = { initialCoords[1], initialCoords[2], initialCoords[3] },
                instanceId = instanceId
            }
        end

        -- Configurar corrida ilegal
        ilegalRace[user_id] = true
        TriggerEvent("blipsystem:serviceEnter",source,"Corredor",48)

        -- Alertar polícia
        local policeResult = vRP.numPermission("Police")
        for k,v in pairs(policeResult) do
            async(function()
                TriggerClientEvent("Notify",v,"amarelo", Config.Notifications.PoliceDetection, 5000)
                vRPC.playSound(v, Config.Sounds.PoliceAlertSound, Config.Sounds.PoliceAlertSoundSet)
            end)
        end

        return true, ilegalRace[user_id]
    end
    return false
end

function cRP.requestTeleportToStart(raceId)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then return false end

    local currentRaceId, instanceId = findPlayerInRaces(user_id)
    if not currentRaceId or currentRaceId ~= raceId then
        return false
    end

    local raceData = activeRaces[raceId][instanceId]
    if not raceData or raceData.teleportTriggered then
        return false
    end

    raceData.teleportTriggered = true
    raceData.status = "teleporting"
    
    raceCooldowns[raceId] = os.time()

    local playersToTeleport = {}
    for pId, pData in pairs(raceData.players) do
        if GetPlayerPing(pData.source) > 0 then
            table.insert(playersToTeleport, { id = pId, source = pData.source })
        end
    end

    local availablePositions = {}
    for i = 1, #Config.Races[raceId]["cars"] do
        table.insert(availablePositions, i)
    end
    
    for i = #availablePositions, 2, -1 do
        local j = math.random(i)
        availablePositions[i], availablePositions[j] = availablePositions[j], availablePositions[i]
    end

    for index, playerData in ipairs(playersToTeleport) do
        if index <= #availablePositions then
            local positionIndex = availablePositions[index]
            local carPosition = Config.Races[raceId]["cars"][positionIndex]
            
            raceData.players[playerData.id].assignedPositionIndex = positionIndex

            TriggerClientEvent("races:teleportToStart", playerData.source, 
                { carPosition[1], carPosition[2], carPosition[3] }, 
                carPosition[4] or 0.0
            )
        else
            TriggerClientEvent('Notify', playerData.source, 'vermelho', Config.Notifications.NotEnoughSlots, 5000)
            raceData.players[playerData.id] = nil
        end
    end

    local allParticipantSources = {}
    for _, playerData in ipairs(playersToTeleport) do
        table.insert(allParticipantSources, playerData.source)
    end

    SetTimeout(Config.General.PostTeleportDelay, function()
        raceData.status = "countdown"
        for _, playerData in ipairs(playersToTeleport) do
            TriggerClientEvent("races:startRace", playerData.source, Config.General.CountdownTime, allParticipantSources)
        end

        SetTimeout(Config.General.CountdownTime * 1000, function()
            raceData.status = "in_progress"
        end)
    end)
    return true
end

CreateThread(function()
    while true do
        for raceId, instances in pairs(activeRaces) do
            for instanceId, raceData in pairs(instances) do
                if raceData.status == "waiting" and not raceData.teleportTriggered then
                    local currentTime = GetGameTimer()
                    local waitEndTime = raceData.waitStartTime + raceData.waitDuration
                    local timeRemaining = math.max(0, math.floor((waitEndTime - currentTime) / 1000))
                    
                    if timeRemaining <= 0 then
                        raceData.teleportTriggered = true
                        
                        local playerFound = false
                        for pId, pData in pairs(raceData.players) do
                            if GetPlayerPing(pData.source) > 0 then
                                raceData.teleportTriggered = false
                                cRP.requestTeleportToStart(raceId)
                                playerFound = true
                                break
                            end
                        end
                        
                        if not playerFound then
                            cleanupRaceInstance(raceId, instanceId)
                        end
                    else
                        local currentRunners = getRacePlayerCount(raceId, instanceId)
                        for pId, pData in pairs(raceData.players) do
                            if GetPlayerPing(pData.source) > 0 then
                                TriggerClientEvent("races:updateHoverWaitPlayers", pData.source, currentRunners, raceData.maxPlayers)
                                TriggerClientEvent("races:syncHoverWaitTime", pData.source, timeRemaining)
                            end
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)

function cRP.finishRace(id,points)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local playerPed = GetPlayerPed(source)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vehicleHash = 0
        local vehicleDisplayName = "Desconhecido"
        local vehicleClass = "comum"

        if vehicle and vehicle ~= 0 then
            vehicleHash = GetEntityModel(vehicle)
            vehicleDisplayName, vehicleClass = getVehicleInfo(vehicleHash)
        end

        local vehicleHashString = tostring(vehicleHash)

        -- Salvar record no banco
        local consult = vRP.query("races/checkResult",{ raceid = id, user_id = parseInt(user_id) })
        if consult[1] then
            if parseInt(points) < parseInt(consult[1]["points"]) then
                vRP.execute("races/updateRecords",{ raceid = id, user_id = parseInt(user_id), vehicle = vehicleHashString, points = parseInt(points) })
            end
        else
            local identity = vRP.userIdentity(user_id)
            vRP.execute("races/insertRecords",{ raceid = id, user_id = parseInt(user_id), name = identity["name"].." "..identity["name2"], vehicle = vehicleHashString, points = parseInt(points) })
        end

        -- Processar pagamento baseado na posição
        local currentRaceId, instanceId = findPlayerInRaces(user_id)
        if currentRaceId and currentRaceId == id and activeRaces[id][instanceId] then
            local raceData = activeRaces[id][instanceId]
            
            -- Marcar como terminado e registrar ordem de chegada
            if not raceData.players[user_id].finished then
                raceData.players[user_id].finished = true
                raceData.players[user_id].finishTime = math.floor(points/1000)
                
                -- Adicionar à ordem de chegada
                table.insert(raceData.finishOrder, {
                    user_id = user_id,
                    source = source,
                    finishTime = math.floor(points/1000)
                })
                
                -- Calcular posição final
                local finalPosition = #raceData.finishOrder
                
                -- Dar pagamento baseado na posição
                if ilegalRace[user_id] then
                    local paymentAmount = getPaymentByPosition(finalPosition)
                    vRP.generateItem(user_id, "dollarsroll", paymentAmount, true)
                    
                    -- Notificar jogador sobre posição e pagamento
                    local positionText = finalPosition == 1 and "1º lugar" or 
                                       finalPosition == 2 and "2º lugar" or 
                                       finalPosition == 3 and "3º lugar" or 
                                       finalPosition .. "º lugar"
                    
                    TriggerClientEvent('Notify', source, 'verde', 'Corrida Finalizada', 
                        string.format("Você terminou em %s e recebeu $%d!", positionText, paymentAmount), 8000)
                    
                    TriggerEvent("blipsystem:serviceExit", source)
                    vRP.upgradeStress(user_id,10)
                    ilegalRace[user_id] = nil
                end
            end
            
            -- Verificar se todos terminaram
            local allFinished = true
            for pId, pData in pairs(raceData.players) do
                if GetPlayerPing(pData.source) > 0 and not pData.finished then
                    allFinished = false
                    break
                end
            end
            
            if allFinished then
                SetTimeout(Config.General.RaceCleanupDelay * 1000, function()
                    cleanupRaceInstance(id, instanceId)
                end)
            end
        end
    end
end

vRP.prepare("races/checkMyResult",
[[
WITH RaceRanking AS (
SELECT user_id, name, points, vehicle,
  RANK() OVER (ORDER BY points ASC) AS position
FROM races
WHERE raceid = @raceid
)
SELECT user_id, name, points, vehicle, position
FROM RaceRanking
WHERE user_id = @user_id;
]])

vRP.prepare("races/requestRanking", "SELECT name, user_id,vehicle, points FROM races WHERE raceid = @raceid ORDER BY points ASC LIMIT @limit")

function cRP.requestRanking(id)
local source = source
local user_id = vRP.getUserId(source)
local records = {}
local rank = vRP.query("races/requestRanking",{ raceid = id, limit = Config.RankingLimit })
for k,v in pairs(rank) do
local vehicleHashString = v["vehicle"]
local vehicleDisplayName = "Desconhecido"
local vehicleClass = "comum"

if vehicleHashString and vehicleHashString ~= "" then
    local vehicleHash = tonumber(vehicleHashString)
    if vehicleHash then
        vehicleDisplayName, vehicleClass = getVehicleInfo(vehicleHash)
    end
end

records[k] = {
    name = v["name"],
    id = v["user_id"],
    vehicle = vehicleDisplayName,
    vehicleTag = vehicleClass,
    time = v["points"],
    position = k
}
end

local consult = vRP.query("races/checkMyResult",{ raceid = id, user_id = parseInt(user_id) })
local yourRecord = false
if consult and consult[1] then
local vehicleHashString = consult[1]["vehicle"]
local vehicleDisplayName = "Desconhecido"
local vehicleClass = "comum"

if vehicleHashString and vehicleHashString ~= "" then
    local vehicleHash = tonumber(vehicleHashString)
    if vehicleHash then
        vehicleDisplayName, vehicleClass = getVehicleInfo(vehicleHash)
    end
end

yourRecord = {
    name = consult[1]["name"],
    id = consult[1]["user_id"],
    position = consult[1]["position"],
    vehicle = vehicleDisplayName,
    vehicleTag = vehicleClass,
    time = consult[1]["points"]
}
end
return records,yourRecord 
end

function cRP.updatePlayerRaceProgress(raceId, checkpoint, x, y, z, time)
local source = source
local user_id = vRP.getUserId(source)

local currentRaceId, instanceId = findPlayerInRaces(user_id)
if currentRaceId and currentRaceId == raceId and activeRaces[raceId][instanceId] then
local playerData = activeRaces[raceId][instanceId].players[user_id]
playerData.currentCheckpoint = checkpoint
playerData.timeInRace = time
playerData.lastKnownCoords = {x, y, z}
end
end

CreateThread(function()
while true do
for raceId, instances in pairs(activeRaces) do
    for instanceId, raceData in pairs(instances) do
        if raceData.status == "in_progress" then
            local playersInRace = {}
            local finishedPlayers = {}
            
            for user_id, playerData in pairs(raceData.players) do
                if GetPlayerPing(playerData.source) > 0 then
                    local identity = vRP.userIdentity(user_id)
                    local playerName = identity["name"].." "..identity["name2"]
                    
                    local playerPed = GetPlayerPed(playerData.source)
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    local vehicleDisplayName = "Desconhecido"
                    local vehicleClass = "comum"

                    if vehicle and vehicle ~= 0 then
                        local vehicleHash = GetEntityModel(vehicle)
                        vehicleDisplayName, vehicleClass = getVehicleInfo(vehicleHash)
                    end

                    if playerData.finished then
                        table.insert(finishedPlayers, {
                            user_id = user_id,
                            source = playerData.source,
                            name = playerName,
                            currentCheckpoint = #Config.Races[raceId]["coords"],
                            timeInRace = playerData.finishTime,
                            distanceToCheckpoint = 0,
                            vehicle = vehicleDisplayName,
                            vehicleTag = vehicleClass,
                            finished = true
                        })
                    else
                        if playerData.lastKnownCoords and #playerData.lastKnownCoords >= 3 and Config.Races[raceId] and Config.Races[raceId]["coords"][playerData.currentCheckpoint] then
                            local targetCheckpointCoords = Config.Races[raceId]["coords"][playerData.currentCheckpoint][1]
                            
                            if targetCheckpointCoords and #targetCheckpointCoords >= 3 then
                                local dist = #(vector3(playerData.lastKnownCoords[1], playerData.lastKnownCoords[2], playerData.lastKnownCoords[3]) - vector3(targetCheckpointCoords[1], targetCheckpointCoords[2], targetCheckpointCoords[3]))
                                
                                table.insert(playersInRace, {
                                    user_id = user_id,
                                    source = playerData.source,
                                    name = playerName,
                                    currentCheckpoint = playerData.currentCheckpoint,
                                    timeInRace = playerData.timeInRace,
                                    distanceToCheckpoint = dist,
                                    vehicle = vehicleDisplayName,
                                    vehicleTag = vehicleClass,
                                    finished = false
                                })
                            end
                        end
                    end
                end
            end

            table.sort(playersInRace, function(a, b)
                if a.currentCheckpoint ~= b.currentCheckpoint then
                    return a.currentCheckpoint > b.currentCheckpoint
                else
                    return a.distanceToCheckpoint < b.distanceToCheckpoint
                end
            end)

            table.sort(finishedPlayers, function(a, b)
                return a.timeInRace < b.timeInRace
            end)

            local allPlayers = {}
            for i, player in ipairs(finishedPlayers) do
                player.position = i
                table.insert(allPlayers, player)
            end
            
            local activeStartPos = #finishedPlayers + 1
            for i, player in ipairs(playersInRace) do
                player.position = activeStartPos + i - 1
                table.insert(allPlayers, player)
            end

            local fullRankingListForClient = {}
            for i, rankedPlayer in ipairs(allPlayers) do
                table.insert(fullRankingListForClient, {
                    id = rankedPlayer.user_id,
                    source = rankedPlayer.source,
                    name = rankedPlayer.name,
                    vehicle = rankedPlayer.vehicle,
                    vehicleTag = rankedPlayer.vehicleTag,
                    time = rankedPlayer.timeInRace,
                    position = rankedPlayer.position,
                    finished = rankedPlayer.finished or false
                })
            end

            for _, playerRankData in ipairs(allPlayers) do
                local myPos = playerRankData.position
                local myProfile = {
                    name = playerRankData.name,
                    id = playerRankData.user_id,
                    pos = myPos,
                    time = playerRankData.timeInRace,
                    vehicle = playerRankData.vehicle,
                    vehicleTag = playerRankData.vehicleTag,
                    finished = playerRankData.finished or false
                }
                
                TriggerClientEvent("races:updateInRaceRanking", playerRankData.source, fullRankingListForClient, myPos, #allPlayers, myProfile)
            end
        end
    end
end
Wait(1000)
end
end)

function cRP.exitRace()
local source = source
local user_id = vRP.getUserId(source)
if user_id then
local currentRaceId, instanceId = findPlayerInRaces(user_id)
if currentRaceId and instanceId then
    local raceData = activeRaces[currentRaceId][instanceId]
    if raceData.players[user_id] and not raceData.players[user_id].finished then
        raceData.players[user_id] = nil
        
        local hasActivePlayers = false
        for pId, pData in pairs(raceData.players) do
            if GetPlayerPing(pData.source) > 0 and not pData.finished then
                hasActivePlayers = true
                break
            end
        end
        
        if not hasActivePlayers and raceData.status == "waiting" then
            cleanupRaceInstance(currentRaceId, instanceId)
        elseif not hasActivePlayers and raceData.status == "in_progress" then
            SetTimeout(Config.General.EmptyRaceCleanupDelay * 1000, function()
                if activeRaces[currentRaceId] and activeRaces[currentRaceId][instanceId] then
                    local stillEmpty = true
                    for pId, pData in pairs(activeRaces[currentRaceId][instanceId].players) do
                        if GetPlayerPing(pData.source) > 0 then
                            stillEmpty = false
                            break
                        end
                    end
                    if stillEmpty then
                        cleanupRaceInstance(currentRaceId, instanceId)
                    end
                end
            end)
        end
    end
end

if ilegalRace[user_id] then
    TriggerEvent("blipsystem:serviceExit",source)
    ilegalRace[user_id] = nil
end
end
end

AddEventHandler("playerDisconnect",function(user_id)
if ilegalRace[user_id] then
ilegalRace[user_id] = nil
end

local currentRaceId, instanceId = findPlayerInRaces(user_id)
if currentRaceId and instanceId then
activeRaces[currentRaceId][instanceId].players[user_id] = nil

if next(activeRaces[currentRaceId][instanceId].players) == nil then
    cleanupRaceInstance(currentRaceId, instanceId)
end
end
end)

AddEventHandler("playerConnect",function(user_id,source)
if Config.Races and next(Config.Races) then
TriggerClientEvent("races:Table",source,Config.Races)
end
end)

function cRP.connect()
if Config.Races and next(Config.Races) then
TriggerClientEvent("races:Table",source,Config.Races)
end
end
