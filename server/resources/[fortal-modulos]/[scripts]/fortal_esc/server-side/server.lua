Proxy = module('vrp', 'lib/Proxy')
Tunnel = module('vrp', 'lib/Tunnel')
vRP = Proxy.getInterface('vRP')

local cache = {
    ["ffa"]   = {},
    ["1x1"]   = {},
    ["pista"] = {},
    ["users"] = {}
}

Utils.functions.prepare("lil/getRelationship", "SELECT * FROM black_relationship WHERE user_id = @user_id")
Utils.functions.prepare("lil/insertRelationsip",
    "INSERT IGNORE INTO black_relationship (user_id,relationship,nuser_id) VALUES (@user_id,@relationship,@nuser_id)")
Utils.functions.prepare("lil/removeRelationship", "DELETE FROM black_relationship WHERE user_id = @user_id")
Utils.functions.prepare("lil/createRelationshipDb", [[
        CREATE TABLE IF NOT EXISTS `black_relationship` (
            `user_id` INT(11) NULL DEFAULT NULL,
            `relationship` INT(11) NULL DEFAULT NULL,
            `nuser_id` INT(11) NULL DEFAULT NULL
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB
        ;
        ]])
Utils.functions.prepare("lil/createElogiosDb", [[
        CREATE TABLE IF NOT EXISTS `black_elogios` (
            `user_id` INT(11) NULL DEFAULT NULL,
            `data` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci'
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB
        ;
        ]])
Utils.functions.prepare("lil/createDominationsDb", [[
        CREATE TABLE  IF NOT EXISTS `black_dominations` (
            `orgName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
            `dominationsAmount` INT(11) NULL DEFAULT NULL
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB
        ;
        ]])
Utils.functions.prepare("lil/createInvitesDb", [[
        CREATE TABLE IF NOT EXISTS `black_invites` (
             `orgName` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
             `invitesAmount` INT(11) NULL DEFAULT NULL
        )
        COLLATE='utf8mb4_general_ci'
        ENGINE=InnoDB
        ;
        ]])

Utils.functions.prepare("lil/insertData", "INSERT IGNORE INTO black_elogios (user_id,data) VALUES (@user_id,@data)")
Utils.functions.prepare("lil/getUserElogios", "SELECT * FROM black_elogios WHERE user_id = @user_id")
Utils.functions.prepare("lil/getElogios", "SELECT * FROM black_elogios")
Utils.functions.prepare("lil/updateElogios", "UPDATE black_elogios SET data = @data WHERE user_id = @user_id")

Utils.functions.prepare('black/getTopAbates', 'SELECT user_id, abates FROM black_rankedKD ORDER BY abates DESC')
Utils.functions.prepare('black/getAbatesByUserId',
    'SELECT user_id, abates FROM black_rankedKD WHERE user_id = @user_id')
Utils.functions.prepare('black/createUser', 'INSERT INTO black_rankedKD (user_id, abates) VALUES (@user_id, @abates)')
Utils.functions.prepare('black/incrementAbates',
    'UPDATE black_rankedKD SET abates = abates + 1 WHERE user_id = @user_id');
Utils.functions.prepare('black/getTopHours', 'SELECT user_id, playTime FROM black_esc ORDER BY playTime DESC')
Utils.functions.prepare('black/getMoneyTop', 'SELECT id, bank FROM characters ORDER BY bank DESC')
Utils.functions.prepare('black/getDiamondsTop', 'SELECT steam, gems FROM characters ORDER BY gems DESC')
Utils.functions.prepare("black/getElogiosTop", "SELECT * FROM black_elogios")
Utils.functions.prepare("black/getUserIdBySteam", "SELECT id FROM characters WHERE steam = @steam")
Utils.functions.prepare('black/saveProfile',
    'UPDATE black_esc SET imageUrl = @imageUrl, instagram = @instagram, tiktok = @tiktok WHERE user_id = @user_id');
Utils.functions.prepare('black/getLevelDay', "SELECT * FROM black_esc WHERE user_id = @user_id")
Utils.functions.prepare('black/insertLevelDay', 'INSERT INTO black_esc (user_id) VALUES (@user_id)')
Utils.functions.prepare('black/updateDay', 'UPDATE black_esc SET playTime = @playTime WHERE user_id = @user_id');
Utils.functions.prepare('black/updateLevel', 'UPDATE black_esc SET level = @level WHERE user_id = @user_id');
Utils.functions.prepare('black/updateItensResgatados',
    'UPDATE black_esc SET itensResgatados = @itensResgatados WHERE user_id = @user_id');
Utils.functions.prepare('black/getFollowersRanking',
    "SELECT * FROM phone_instagram_accounts ORDER BY follower_count DESC")
Utils.functions.prepare("black/addInvites",
    "UPDATE black_invites SET invitesAmount = invitesAmount + 1 WHERE orgName = @orgName")
Utils.functions.prepare("black/getInvitesRanking",
    "SELECT orgName, invitesAmount FROM black_invites ORDER BY invitesAmount DESC")
Utils.functions.prepare("black/addDominations",
    "UPDATE black_dominations SET dominationsAmount = dominationsAmount + 1 WHERE orgName = @orgName")
Utils.functions.prepare("black/getDominationRanking",
    "SELECT orgName,dominationsAmount FROM black_dominations ORDER BY dominationsAmount DESC")
    
Utils.functions.prepare("black/updateRelationshipStatus", "UPDATE characters SET state = 'Namorando' WHERE id = @user_id")
Utils.functions.prepare("black/updateRelationshipStatus2", "UPDATE characters SET state = 'Solteiro' WHERE id = @user_id")

Utils.functions.prepare("vehicles/removeVehicles3", [[
	DELETE FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle
]])

Utils.functions.prepare("vehicles/addVehicles3", [[
	INSERT INTO vehicles(user_id, vehicle,tax, plate, work, vip_expiry)
	VALUES(@user_id, @vehicle,@tax, @plate, @work, @vip_expiry)
]])

Utils.functions.prepare("fortal/addTempVehicle", [[
    INSERT INTO fortal_esc_vehicles(user_id, vehicle, vip_expiry)
    VALUES(@user_id, @vehicle, @vip_expiry)
    ON DUPLICATE KEY UPDATE vip_expiry = @vip_expiry
]])


Utils.functions.prepare("fortal/getExpiredVehicles", [[
    SELECT user_id, vehicle FROM fortal_esc_vehicles WHERE vip_expiry <= @now
]])

Utils.functions.prepare("fortal/removeTempVehicle", [[
    DELETE FROM fortal_esc_vehicles WHERE user_id = @user_id AND vehicle = @vehicle
]])


CreateThread(function()
    Utils.functions.execute("lil/createRelationshipDb")
    Utils.functions.execute("lil/createElogiosDb")
    Utils.functions.execute("lil/createDominationsDb")
    Utils.functions.execute("lil/createInvitesDb")
end)

local function parseJsonString(str)
    local tbl = {}
    for k, v in string.gmatch(str, '"(%d+)":(%w+)') do
        tbl[k] = (v == "true")
    end
    return tbl
end

local function lenght(d)
    local data = parseJsonString(d)
    local count = 0
    for _, _ in pairs(data) do
        count = count + 1
    end
    return count
end

local function addElogio(nuser_id, user_id)
    if not user_id or not nuser_id then return end

    local query = Utils.functions.query("lil/getUserElogios", { user_id = nuser_id })
    local count = 0

    if #query > 0 then
        count = tonumber(query[1].data) or 0
        count = count + 1
        Utils.functions.execute("lil/updateElogios", { user_id = nuser_id, data = count })
    else
        count = 1
        Utils.functions.execute("lil/insertData", { user_id = nuser_id, data = count })
    end
end

function src.checkRelationship()
    local r        = async()
    local source   = source
    local user_id  = Utils.functions.getUserId(source)
    local nsource  = Utils.functions.getNearestPlayer(source, 2)
    local nuser_id = Utils.functions.getUserId(nsource)

    if user_id then
        local query = Utils.functions.query("lil/getRelationship", { user_id = nuser_id })

        if query[1] and query[1].nuser_id == user_id then
            r(true)
            return r:wait()
        end
    end

    r(false)
    return r:wait()
end


function src.checkElogio()
    local r        = async()
    local source   = source
    local user_id  = Utils.functions.getUserId(source)
    local nsource  = Utils.functions.getNearestPlayer(source, 2)
    local nuser_id = Utils.functions.getUserId(nsource)
    if user_id then
        local query = Utils.functions.query("lil/getUserElogios", { user_id = nuser_id })
        if #query > 0 then
            for k, _ in pairs(parseJsonString(query[1].data)) do
                if tonumber(k) == user_id then
                    r(true)
                    return r:wait()
                end
            end
        end
    end
    r(false)
    return r:wait()
end

RegisterServerEvent("player:tryRelationship")
AddEventHandler("player:tryRelationship", function(entity)
    local source              = source
    local user_id             = Utils.functions.getUserId(source)
    local userIdentity        = Utils.functions.getUserIdentity(user_id)
    local otherPlayer         = entity[1]
    local otherPlayerId       = Utils.functions.getUserId(otherPlayer)
    local otherPlayerIdentity = Utils.functions.getUserIdentity(otherPlayerId)

    local consultItem = vRP.getInventoryItemAmount(user_id, "silverring")
		if consultItem[1] <= 0 then
            Utils.functions.notify(source, "Você precisa de uma aliança para fazer o pedido!")
			return
		end


    if user_id and otherPlayerId then
        local relationship1 = Utils.functions.query("lil/getRelationship", { user_id = user_id })
        local relationship2 = Utils.functions.query("lil/getRelationship", { user_id = otherPlayerId })

        local isFree1 = not relationship1[1] or not relationship1[1].relationship or relationship1[1].relationship < 1
        local isFree2 = not relationship2[1] or not relationship2[1].relationship or relationship2[1].relationship < 1

        if isFree1 and isFree2 then
            TriggerClientEvent("startProposeAnimation", source)

            local accepted = Utils.functions.request(otherPlayer,
                string.format(Config.messages["try_relationship_request"], userIdentity.name .. " " .. userIdentity.name2),
                5000)

            if accepted then
                vRP.tryGetInventoryItem(user_id, "silverring", 1, true)

                Utils.functions.notify(source, Config.messages["relationship_accepted"])
                Utils.functions.notify(source, string.format(Config.messages["relationship_accepted2"],
                    otherPlayerIdentity.name .. " " .. otherPlayerIdentity.name2))
                Utils.functions.chatMessage(-1, "Prefeitura", string.format(Config.messages["warning_relationship"], userIdentity.name .. " " .. userIdentity.name2, otherPlayerIdentity.name .. " " .. otherPlayerIdentity.name2))

                Utils.functions.execute("lil/insertRelationsip", {
                    user_id = user_id,
                    relationship = 1,
                    nuser_id = otherPlayerId
                })
                Utils.functions.execute("lil/insertRelationsip", {
                    user_id = otherPlayerId,
                    relationship = 1,
                    nuser_id = user_id
                })

                Utils.functions.execute("black/updateRelationshipStatus", { user_id = user_id })
                Utils.functions.execute("black/updateRelationshipStatus", { user_id = otherPlayerId })
            end
        elseif relationship1[1] and relationship1[1].relationship == 1 then
            Utils.functions.notify(otherPlayer, Config.messages["in_relationship"])
        elseif relationship2[1] and relationship2[1].relationship == 1 then
            Utils.functions.notify(otherPlayer, Config.messages["in_relationship2"])
        end
    end
end)



RegisterServerEvent("player:finishRelationship")
AddEventHandler("player:finishRelationship", function(entity)
    local source              = source
    local user_id             = Utils.functions.getUserId(source)
    local userIdentity        = Utils.functions.getUserIdentity(user_id)
    local otherPlayer         = entity[1]
    local otherPlayerId       = Utils.functions.getUserId(otherPlayer)
    local otherPlayerIdentity = Utils.functions.getUserIdentity(otherPlayerId)
    if user_id and otherPlayerId then
        local query  = Utils.functions.query("lil/getRelationship", { user_id = user_id })
        local query1 = Utils.functions.query("lil/getRelationship", { user_id = otherPlayerId })
        if query[1].nuser_id == otherPlayerId and query1[1].nuser_id == user_id then
            if Utils.functions.request(source, Config.messages["finish_relationship_request"], 5000) then
                Utils.functions.notify(source, Config.messages["relationship_finished"])
                Utils.functions.notify(otherPlayer, Config.messages["relationship_finished2"])
                Utils.functions.execute("lil/removeRelationship", {
                    user_id = user_id
                })
                Utils.functions.execute("lil/removeRelationship", {
                    user_id = otherPlayerId
                })
                Utils.functions.chatMessage(source, "Prefeitura",
                    string.format(Config.messages["warning_relationship2"], userIdentity.name .. "" .. userIdentity
                        .name2, otherPlayerIdentity.name .. "" .. otherPlayerIdentity.name2))

                Utils.functions.execute("black/updateRelationshipStatus2", { user_id = user_id })
                Utils.functions.execute("black/updateRelationshipStatus2", { user_id = otherPlayerId })
            end
        else
            Utils.functions.notify(source, Config.messages["try_finish_relationship"])
        end
    end
end)


RegisterServerEvent("target:addElogio")
AddEventHandler("target:addElogio", function(entity)
    local source   = source
    local nsource  = entity[1]
    local user_id  = Utils.functions.getUserId(source)
    local nuser_id = Utils.functions.getUserId(nsource)
    if user_id then
        local identity  = Utils.functions.getUserIdentity(user_id)
        local identity2 = Utils.functions.getUserIdentity(nuser_id)

        addElogio(nuser_id, user_id)


        Utils.functions.notify(source, string.format(Config.messages["add_compliment"], identity2["name"] .. " " .. identity2["name2"]))
        Utils.functions.notify(nsource, string.format(Config.messages["compliment_received"], identity["name"] .. " " .. identity["name2"]))
    end
end)

local function lenght(d)
    local count = 0
    for _, _ in pairs(d) do
        count = count + 1
    end
    return count
end

local function updatePlayersCount(arena)
    for k, _ in pairs(cache[arena]) do
        local nsrc = Utils.functions.getUserSource(tonumber(k))
        if nsrc then
            client.sendUiMessage(nsrc, {
                action = "getPlayersOn",
                data   = lenght(cache[arena])
            })
        end
    end
end

local function generateArenaId()
    local letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local code = ""

    math.randomseed(os.time())

    for i = 1, 8 do
        local index = math.random(1, #letters)
        code = code .. letters:sub(index, index)
    end

    return code
end

local function showScoreboard(arenaId)
    local arenaData = cache["1x1"][arenaId]
    local players = {}

    for k, _ in pairs(arenaData) do
        if k ~= "round" and k ~= "spawns" and k ~= "bucket" then
            local nsrc = Utils.functions.getUserSource(tonumber(k))
            if nsrc then
                local identity = Utils.functions.getUserIdentity(tonumber(k))
                table.insert(players,
                    { source = nsrc, id = tonumber(k), name = identity["name"] .. " " .. identity["name2"] })
            end
        end
    end

    if #players == 2 then
        for i = 1, 2 do
            local player = players[i]
            local rival  = players[3 - i]
            
            -- Abrir interface X1
            client.sendUiMessage(player.source, { action = "openX1", data = true })
            
            -- Enviar dados do scoreboard
            client.sendUiMessage(player.source, {
                action = "setScoreBoard",
                data   = {
                    currentRound = arenaData.round or 1,
                    maxRounds = Config.arenas["1x1"].rounds,
                    playerName  = player.name,
                    playerScore = arenaData[tostring(player.id)].points or 0,
                    rivalName   = rival.name,
                    rivalScore  = arenaData[tostring(rival.id)].points or 0
                }
            })
            
            client.sendUiMessage(player.source, {
                action = "setVisibleExitArena",
                data   = true
            })
        end
    end
end


local function addUserToCache(source, user_id, arena, arenaId)
    if user_id and (not cache[arena] or not cache[arena][tostring(user_id)] or not cache[arena][arenaId] or not cache[arena][arenaId][tostring(user_id)]) then
        local userPed       = GetPlayerPed(source)
        local pedHealth     = GetEntityHealth(userPed)
        local pedArmour     = GetPedArmour(userPed)
        local pedCoords     = GetEntityCoords(userPed)
        local pedHeading    = GetEntityHeading(userPed)
        local userInventory = Utils.functions.getUserInventory(user_id)
        if userInventory then
            Utils.functions.bypassAC(source)

            if not cache.users[tostring(user_id)] then
                cache.users[tostring(user_id)] = {}
            end

            cache.users[tostring(user_id)] = {
                source    = source,
                health    = pedHealth,
                armour    = pedArmour or 0,
                lastCoord = pedCoords,
                inventory = userInventory,
                vehicle   = nil
            }

            if arena ~= "1x1" then
                cache[arena][tostring(user_id)] = true
            else
                if not cache[arena][arenaId] then
                    cache[arena][arenaId] = {}
                end

                if not cache[arena][arenaId].bucket then
                    cache[arena][arenaId].bucket = math.random(0, 343568)
                end

                cache[arena][arenaId][tostring(user_id)] = {
                    points = 0,
                    spawn  = nil
                }

                cache[arena][arenaId].round              = 1
                cache[arena][arenaId].spawns             = Config.arenas[arena].spawnpoints
            end

            Player(source).state:set("inArena", true, true)
            Player(source).state:set("currentArena", arena, true)

            if arenaId then
                Player(source).state:set("currentArenaId", arenaId, true)
            end

            for _, v in pairs(userInventory) do
                Utils.functions.remItem(user_id, v.item, v.amount)
            end

            client.setPlayerHealth(source, Config.arenas.maxHealth)
            client.giveArenaNeeds(source, arena)
            if arena ~= "1x1" then
                SetPlayerRoutingBucket(source, Config.arenas[arena].bucket)
            else
                SetPlayerRoutingBucket(source, cache[arena][arenaId].bucket)
            end
            SetPedArmour(userPed, Config.arenas.armour and 100 or 0)

            if arena ~= "1x1" then
                local spawn     = math.random(1, #Config.arenas[arena].spawnpoints)
                local spawnData = Config.arenas[Player(source).state.currentArena].spawnpoints[spawn]

                SetEntityCoords(userPed, spawnData.x, spawnData.y, spawnData.z)

                if arena == "pista" then
                    local myVeh, netId = Utils.functions.createVehicle(user_id, source,
                        Config.arenas["pista"].vehicle, spawnData.x, spawnData.y, spawnData.z, pedHeading,
                        Config.arenas[arena].bucket)
                    if myVeh then
                        Wait(100)
                        cache.users[tostring(user_id)].vehicle = netId
                    end
                end
            else
                if arenaId then
                    local spawn = 1
                    local arenaData = cache[arena][arenaId].spawns


                    while arenaData[spawn] and arenaData[spawn].using and spawn < #arenaData do
                        spawn = spawn + 1
                    end

                    SetEntityCoords(userPed, arenaData[spawn].cds.x, arenaData[spawn].cds.y, arenaData[spawn].cds.z)
                    SetEntityHeading(userPed, arenaData[spawn].heading)

                    cache[arena][arenaId][tostring(user_id)].spawn = spawn
                    arenaData[spawn].using = true
                end
            end

            if arena ~= "1x1" then
                updatePlayersCount(arena)

                -- Sistema PVP - APENAS enviar openPvp, sem setVisible
                client.sendUiMessage(source, {
                    action = "openPvp",
                    data   = true
                })
                
                client.sendUiMessage(source, {
                    action = "getPlayersKills",
                    data   = 0
                })
                client.sendUiMessage(source, {
                    action = "setVisibleExitArena",
                    data   = true
                })
            else
                showScoreboard(arenaId)
            end
        end
    end
end

local function remUserToCache(source, user_id, arena, arenaId)
    if user_id and (cache[arena][tostring(user_id)] or (arenaId and cache[arena][arenaId] and cache[arena][arenaId][tostring(user_id)])) then
        local userPed    = GetPlayerPed(source)
        local lastCoords = cache["users"][tostring(user_id)].lastCoord

        Utils.functions.bypassAC(source)
        client.setPlayerHealth(source, cache.users[tostring(user_id)].health)
        client.remArenaNeeds(source, arena)
        SetPlayerRoutingBucket(source, 0)
        SetPedArmour(userPed, cache.users[tostring(user_id)].armour)
        SetEntityCoords(userPed, lastCoords.x, lastCoords.y, lastCoords.z)

        for k, v in pairs(cache["users"][tostring(user_id)].inventory) do
            Utils.functions.giveItem(user_id, k, v.item, v.amount)
        end

        if arena ~= "1x1" then
            cache[arena][tostring(user_id)] = nil
        else
            if arenaId and cache[arena][arenaId] then
                if lenght(cache[arena][arenaId]) >= 2 then
                    cache[arena][arenaId][tostring(user_id)] = nil
                else
                    cache[arena][arenaId] = nil
                end
            end
        end

        Player(source).state:set("inArena", false, true)
        Player(source).state:set("currentArena", nil, true)

        if arenaId then
            Player(source).state:set("currentArenaId", nil, true)
        end

        if arena ~= "1x1" then
            if arena == "pista" then
                DeleteEntity(NetworkGetEntityFromNetworkId(cache.users[tostring(user_id)].vehicle))
            end

            -- Sistema PVP - APENAS enviar closePvp, sem setVisible
            client.sendUiMessage(source, {
                action = "closePvp",
                data   = true
            })

            updatePlayersCount(arena)
        else
            -- Sistema X1 - fechar interface X1
            client.sendUiMessage(source, {
                action = "closeX1",
                data   = true
            })
        end

        client.sendUiMessage(source, {
            action = "setVisibleExitArena",
            data   = false
        })

        Utils.functions.setData(user_id, "health", cache.users[tostring(user_id)].health)
        Utils.functions.setData(user_id, "armour", cache.users[tostring(user_id)].armour)
        Utils.functions.setData(user_id, "inventory", cache.users[tostring(user_id)].inventory)

        cache.users[tostring(user_id)] = nil
    end
end

local function replacePlayerInArena(nsrc)
    local user_id = Utils.functions.getUserId(nsrc)
    local arena   = Player(nsrc).state.currentArena
    if user_id and arena == "1x1" then
        local userPed   = GetPlayerPed(nsrc)
        local arenaId   = Player(nsrc).state.currentArenaId
        local arenaData = cache[arena][arenaId].spawns
        local spawn     = cache[arena][arenaId][tostring(user_id)].spawn

        SetEntityCoords(userPed, arenaData[spawn].cds.x, arenaData[spawn].cds.y, arenaData[spawn].cds.z)
        SetEntityHeading(userPed, arenaData[spawn].heading)
        client.ressurectPlayer(nsrc)
    end
end

function src.respawnVehicle()
    local source  = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if Player(source).state.inArena and Player(source).state.currentArena then
            local userPed    = GetPlayerPed(source)
            local pedCoords  = GetEntityCoords(userPed)
            local pedHeading = GetEntityHeading(userPed)

            DeleteEntity(NetworkGetEntityFromNetworkId(cache.users[tostring(user_id)].vehicle))

            local myVeh, netId = Utils.functions.createVehicle(user_id, source, Config.arenas["pista"].vehicle,
                pedCoords.x, pedCoords.y, pedCoords.z, pedHeading,
                Config.arenas[Player(source).state.currentArena].bucket)
            if myVeh then
                Wait(100)
                SetPedIntoVehicle(userPed, myVeh, -1)
                cache.users[tostring(user_id)].vehicle = netId
            end
        end
    end
end

src.replacePlayerInArena = replacePlayerInArena

RegisterServerEvent("black:enterFFA")
AddEventHandler("black:enterFFA", function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if Player(source).state.inArena then return end
        addUserToCache(source, user_id, "ffa")
    end
end)

RegisterServerEvent("black:enter1x1")
AddEventHandler("black:enter1x1", function()
    local source    = source
    local user_id   = Utils.functions.getUserId(source)
    local user_name = Utils.functions.getUserName(user_id)
    if user_id then
        local otherPlayerId = Utils.functions.prompt(source, Config.messages["prompt"])
        if otherPlayerId and otherPlayerId ~= user_id then
            local nsrc = Utils.functions.getUserSource(otherPlayerId)
            if nsrc and not Player(nsrc).state.inArena then
                local inviteStatus = Utils.functions.request(nsrc, string.format(Config.messages["request"], user_name))
                if inviteStatus then
                    local arenaId = generateArenaId()
                    addUserToCache(source, user_id, "1x1", arenaId)
                    addUserToCache(nsrc, otherPlayerId, "1x1", arenaId)
                else
                    Utils.functions.notify(source, Config.messages["invite_denied"])
                end
            end
        else
            Utils.functions.notify(source, Config.messages["unknown_user"])
        end
    end
end)

RegisterServerEvent("black:enterPista")
AddEventHandler("black:enterPista", function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if Player(source).state.inArena then return end
        addUserToCache(source, user_id, "pista")
    end
end)

RegisterServerEvent("black:exitArena")
AddEventHandler("black:exitArena", function(arena)
    if not Player(source).state.inArena then return end
    local source = source
    local user_id = Utils.functions.getUserId(source)
    local arenaId = Player(source).state.currentArenaId
    if user_id then
        remUserToCache(source, user_id, arena, arenaId)
    end
end)

RegisterServerEvent("black_esc:arenas:registerKill")
AddEventHandler("black_esc:arenas:registerKill", function(nsrc)
    local source = source
    if nsrc == 0 or nsrc == source then return end

    client.countKills(nsrc)

    local user_id = Utils.functions.getUserId(source)
    local nuser_id = Utils.functions.getUserId(nsrc)
    if user_id and nuser_id then
        local identity = Utils.functions.getUserIdentity(user_id)
        local identity2 = Utils.functions.getUserIdentity(nuser_id)

        if Player(source).state.inArena and Player(source).state.currentArena ~= "1x1" then
            for k, _ in pairs(cache[Player(source).state.currentArena]) do
                local nsrc = Utils.functions.getUserSource(tonumber(k))
                if nsrc then
                    client.sendUiMessage(nsrc, {
                        action = "setNotifyKilled",
                        data = {
                            playerName = identity["name"] .. " " .. identity["name2"],
                            playerId   = user_id,
                            killedBy   = identity2["name"] .. " " .. identity2["name2"],
                            killedById = nuser_id
                        }
                    })
                end
            end
        elseif Player(source).state.currentArena == "1x1" then
            local arenaId    = Player(source).state.currentArenaId
            local arenaCache = cache["1x1"][arenaId]

            if arenaCache.round <= Config.arenas["1x1"].rounds then
                local playerPoints = arenaCache[tostring(user_id)].points
                local rivalPoints = arenaCache[tostring(nuser_id)].points

                rivalPoints = rivalPoints + 1
                arenaCache[tostring(nuser_id)].points = rivalPoints

                -- Verificar se alguém ganhou
                local maxPoints = math.ceil(Config.arenas["1x1"].rounds / 2)
                if rivalPoints >= maxPoints then
                    -- Fim do jogo
                    local winnerName = identity2["name"] .. " " .. identity2["name2"]
                    local message = string.format(Config.messages["1x1_finish"], winnerName, rivalPoints)

                    for _, player in ipairs({ source, nsrc }) do
                        Utils.functions.notify(player, message)
                    end

                    Wait(3000)

                    -- Remove os jogadores do cache
                    remUserToCache(source, user_id, "1x1", arenaId)
                    remUserToCache(nsrc, nuser_id, "1x1", arenaId)
                else
                    -- Próximo round
                    arenaCache.round = arenaCache.round + 1

                    -- local message = string.format(Config.messages["starting_nextround"], arenaCache.round)
                    for _, player in ipairs({ source, nsrc }) do
                        -- Utils.functions.notify(player, message)
                        
                        -- Enviar notificação de round starting
                        client.sendUiMessage(player, {
                            action = "setRoundStarting",
                            data = {
                                round = arenaCache.round,
                                message = message
                            }
                        })
                    end

                    -- Atualizar scoreboard para ambos os jogadores
                    client.sendUiMessage(source, {
                        action = "setScoreBoard",
                        data = {
                            currentRound = arenaCache.round,
                            maxRounds = Config.arenas["1x1"].rounds,
                            playerName = identity["name"] .. " " .. identity["name2"],
                            playerScore = playerPoints,
                            rivalName = identity2["name"] .. " " .. identity2["name2"],
                            rivalScore = rivalPoints
                        }
                    })

                    client.sendUiMessage(nsrc, {
                        action = "setScoreBoard",
                        data = {
                            currentRound = arenaCache.round,
                            maxRounds = Config.arenas["1x1"].rounds,
                            playerName = identity2["name"] .. " " .. identity2["name2"],
                            playerScore = rivalPoints,
                            rivalName = identity["name"] .. " " .. identity["name2"],
                            rivalScore = playerPoints
                        }
                    })

                    Wait(3000)

                    -- Reposicionar jogadores
                    replacePlayerInArena(source)
                    replacePlayerInArena(nsrc)
                    client.giveArenaNeeds(source, "1x1")
                    client.giveArenaNeeds(nsrc, "1x1")
                end
            end
        end
    end
end)

AddEventHandler("playerDisconnect", function(user_id, source)
    local source = source
    if not Player(source).state.inArena then return end
    local user_id = Utils.functions.getUserId(source)
    local arena   = Player(source).state.currentArena
    if user_id and cache[arena][tostring(user_id)] then
        if arena == "pista" then
            DeleteEntity(NetworkGetEntityFromNetworkId(cache.users[tostring(user_id)].vehicle))
        end

        Utils.functions.saveUser(user_id, cache["users"][tostring(user_id)].lastCoord,
            cache.users[tostring(user_id)].health, cache.users[tostring(user_id)].armour,
            cache.users[tostring(user_id)].inventory)

        updatePlayersCount(arena)
        cache[arena][tostring(user_id)] = nil
        cache.users[tostring(user_id)]  = nil
    end
end)

src.getLevelDay = function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        local result = Utils.functions.query('black/getLevelDay', { user_id = user_id })
        if result[1] == nil then
            Utils.functions.execute('black/insertLevelDay', { user_id = user_id })
        end

        return result[1]['level']
    end
    return false
end


local resgateCooldown = {}

local veiculosTemporarios = {
    sanchez = 15,
    atwin2024 = 15,
    ftnivusv2 = 20
}

src.resgateItem = function(item)
    local source = source
    local user_id = Utils.functions.getUserId(source)

    if user_id and not resgateCooldown[user_id] then
        resgateCooldown[user_id] = true
        SetTimeout(2000, function() resgateCooldown[user_id] = nil end)

        local result = Utils.functions.query('black/getLevelDay', { user_id = user_id })
        if result[1] then
            local databaseResultItens = result[1]['itensResgatados']
            local databaseEncode = {}

            if databaseResultItens and databaseResultItens ~= "" then
                local success, decoded = pcall(json.decode, databaseResultItens)
                if success and decoded then
                    databaseEncode = decoded
                end
            end

            if type(databaseEncode) == "table" then
                for _, v in ipairs(databaseEncode) do
                    if v and v.name == item.name and v.level == item.level and v.rescued then
                        return false 
                    end
                end
            end

            table.insert(databaseEncode, {
                name = item.name,
                quantity = item.quantity,
                level = item.level, 
                rescued = true
            })
            
            Utils.functions.execute('black/updateItensResgatados', {
                user_id = user_id,
                itensResgatados = json.encode(databaseEncode)
            })

            if veiculosTemporarios[item.name] then
                local dias = veiculosTemporarios[item.name]
                local vip_expiry = os.time() + (dias * 24 * 60 * 60)

                Utils.functions.execute("vehicles/addVehicles3", {
                    user_id = user_id,
                    vehicle = item.name,
                    tax = 1,
                    plate = Utils.functions.generatePlate(),
                    work = "false",
                    vip_expiry = vip_expiry
                })
            
                Utils.functions.execute("fortal/addTempVehicle", {
                    user_id = user_id,
                    vehicle = item.name,
                    vip_expiry = vip_expiry
                })
            
                Utils.functions.notify(source, "O veículo ~b~" .. item.name .. "~s~ já está disponível na sua garagem!")
            else
                Utils.functions.giveItem(user_id, item.name, item.quantity, true)
            end
            
            
            return true
        end
    end
    return false
end

CreateThread(function()
    while true do
        Wait(10 * 60 * 1000)
        local now = os.time()
        local expirados = Utils.functions.query("fortal/getExpiredVehicles", { now = now })

        for _, v in pairs(expirados) do
            local user_id = v.user_id
            local vehicle = v.vehicle

            print("[BattlePass] Removendo veículo expirado:", user_id, vehicle)

            vRP.execute("vehicles/removeVehicles3", {
                user_id = user_id,
                vehicle = vehicle
            })

            Utils.functions.execute("fortal/removeTempVehicle", {
                user_id = user_id,
                vehicle = vehicle
            })
        end
    end
end)


src.itensResgatados = function(item)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        local result = Utils.functions.query('black/getLevelDay', { user_id = user_id })
        if result and result[1] then
            local databaseResultItens = result[1]['itensResgatados']
            
          
            if not databaseResultItens or databaseResultItens == "" then
                return false
            end

            local success, databaseEncode = pcall(json.decode, databaseResultItens)
            if not success or not databaseEncode then
                print("Error decoding JSON in itensResgatados:", databaseResultItens)
                return false
            end
            
            if type(databaseEncode) == "table" then
                for _, v in pairs(databaseEncode) do
                    if v and v.name == item.name and v.level == item.level and v.rescued == true then
                        return true
                    end
                end
            end
        end
    end
    return false
end


src.GetTableKD = function()
    local tableKD = {}
    local result  = Utils.functions.query('black/getTopAbates')
    for k, v in pairs(result) do
        local userName = Utils.functions.getUserName(v.user_id)
        if userName then
            tableKD[#tableKD + 1] = {
                position   = k,
                playerName = userName,
                playerId   = v.user_id,
                kill       = v.abates
            }
        end
    end

    return tableKD
end

src.AddKill = function(nsource)
    local nuser_id = Utils.functions.getUserId(nsource)
    if nuser_id then
        local result = Utils.functions.query('black/getAbatesByUserId', { user_id = nuser_id })
        if not result[1] then
            Utils.functions.execute('black/createUser', { user_id = nuser_id, abates = 0 })
            result = Utils.functions.query('black/getAbatesByUserId', { user_id = nuser_id })
        end

        Utils.functions.execute('black/incrementAbates', { user_id = nuser_id });
    end
    return false
end

src.GetTableHours = function()
    local tableHours = {}
    local result     = Utils.functions.query('black/getTopHours')
    if #result > 0 then
        for k, v in pairs(result) do
            local userName = Utils.functions.getUserName(v.user_id)
            if userName then
                tableHours[#tableHours + 1] = {
                    position   = k,
                    playerName = userName,
                    playerId   = v.user_id,
                    hours      = v.playTime
                }
            end
        end
    end

    return tableHours
end

src.getInfos = function()
    local source  = source
    local user_id = Utils.functions.getUserId(source)

    if user_id then
        return {
            id = user_id,
            name = Utils.functions.getUserName(user_id) or "Indefinido",
            image = Utils.functions.getUserImage(user_id) or "",
            phone = Utils.functions.getUserPhone(user_id) or "000-000",
            state = Utils.functions.getUserState(user_id) or "Desconhecido",
            playTime = Utils.functions.playTime(user_id) or 0,
            job = Utils.functions.getUserJob(user_id) or "Desempregado",
            vipStatus = Utils.functions.getUserVip(user_id) or false,
            money = Utils.functions.getUserBank(user_id) or 0
        }
    end

    return {
        id = 0,
        name = "Carregando...",
        image = "",
        phone = "000-000",
        state = "Desconhecido",
        playTime = 0,
        job = "Desconhecido",
        vipStatus = false,
        money = 0
    }
end


src.getvip = function()
    local source  = source
    local user_id = Utils.functions.getUserId(source)
    local data    = {}

    if user_id then
        data = Utils.functions.getVip(user_id)
    end

    return data
end


src.getPermPass = function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        return Utils.functions.hasPermission(user_id, Config.passPremium)
    end
end

src.saveProfile = function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        Utils.functions.execute('black/saveProfile', {
            user_id = user_id,
            imageUrl = data.imageUrl,
            instagram = data.instagramUrl,
            tiktok = data.tiktokUrl
        })
    end
end

src.verifyProfile = function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        local result = Utils.functions.query('black/getLevelDay', { user_id = user_id })
        if not result[1] then
            Utils.functions.execute('black/insertLevelDay', { user_id = user_id })
        end
    end
end

Utils.functions.prepare('black/updateLevel2', 'UPDATE black_esc SET level = level + @level WHERE user_id = @user_id')

CreateThread(function()
    while true do
        Wait(3600000) 

        for _, source in ipairs(GetPlayers()) do
            local user_id = Utils.functions.getUserId(source) 
            if user_id then
                Utils.functions.execute('black/updateLevel2', {
                    level = 10,
                    user_id = user_id
                })
            end
        end
    end
end)

Utils.functions.prepare('black/updateDay2', 'UPDATE black_esc SET playTime = playTime + @playTime WHERE user_id = @user_id')

CreateThread(function()
    while true do
        Wait(3600000) 

        for _, source in ipairs(GetPlayers()) do
            local user_id = Utils.functions.getUserId(source)
            if user_id then
                Utils.functions.execute('black/updateDay2', {
                    playTime = 1,
                    user_id = user_id
                })

            end
        end
    end
end)

Utils.functions.prepare('black/getRanking', "SELECT * FROM black_esc ORDER BY playTime DESC")

src.getRanking = function(source)
    local users = {}
    local usersWeek = {}
    local myRanking = {
        pos = 0,
        name = "Desconhecido",
        image = "http://104.234.63.114/inventory/logo.png",
        value = "0 horas",
    }

    local ranking = Utils.functions.query('black/getRanking', {})
    local user_id = Utils.functions.getUserId(source)

    local count = 0

    for k, v in ipairs(ranking) do
        if tonumber(v.playTime) > 0 then
            local identity = Utils.functions.getUserIdentity(v.user_id)
            if identity then
                count = count + 1
                if count > 49 then break end 

                local fullName = identity.name .. " " .. identity.name2
                local img = v.imageUrl and v.imageUrl ~= "" and v.imageUrl or "http://104.234.63.114/inventory/logo.png"

                table.insert(users, {
                    pos = count,
                    id = v.user_id,
                    name = fullName,
                    value = v.playTime .. " horas"
                })

                if count <= 3 then
                    table.insert(usersWeek, {
                        name = fullName,
                        value = v.playTime .. " horas"
                    })
                end

                if v.user_id == user_id then
                    myRanking = {
                        pos = count,
                        name = fullName,
                        image = img,
                        value = v.playTime .. " horas"
                    }
                end
            end
        end
    end

    return {
        users = users,
        usersWeek = usersWeek,
        myRanking = myRanking
    }
end


Utils.functions.prepare('black/getRankingGems', "SELECT * FROM characters ORDER BY gems DESC")

src.getRankingGems = function(source)
    local users = {}
    local usersWeek = {} 
    local myRanking = {
        pos = 0,
        name = "Desconhecido",
        image = "http://104.234.63.114/inventory/logo.png",
        value = "0 gemas",
    }

    local ranking = Utils.functions.query('black/getRankingGems', {})
    local user_id = Utils.functions.getUserId(source)

    for k, v in ipairs(ranking) do
        if tonumber(v.gems) > 0 and not (v.id == 3 or v.id == 460 or v.id == 451 or v.id == 21) then
            local identity = Utils.functions.getUserIdentity(v.id)
            if identity then
                local fullName = identity.name .. " " .. identity.name2
                local img = v.image and v.image ~= "" and v.image or "http://104.234.63.114/inventory/logo.png"
    
                table.insert(users, {
                    pos = #users + 1,
                    id = v.id,
                    name = fullName,
                    value = v.gems .. " gemas"
                })
    
                if #usersWeek < 3 then
                    table.insert(usersWeek, {
                        name = fullName,
                        value = v.gems .. " gemas"
                    })
                end
    
                if v.id == user_id then
                    myRanking = {
                        pos = #users,
                        name = fullName,
                        image = img,
                        value = v.gems .. " gemas"
                    }
                end
            end
        end
    end
    

    return {
        users = users,
        usersWeek = usersWeek,
        myRanking = myRanking
    }
end

src.getRankingKills = function(source)
    local users = {}
    local usersWeek = {} 
    local myRanking = {
        pos = 0,
        name = "Desconhecido",
        image = "http://104.234.63.114/inventory/logo.png",
        value = "0 abates",
    }

    local ranking = Utils.functions.query('black/getTopAbates', {})
    local user_id = Utils.functions.getUserId(source)

    local count = 0

    for k, v in ipairs(ranking) do
        if tonumber(v.abates) > 0 then
            local identity = Utils.functions.getUserIdentity(v.user_id)
            if identity then
                count = count + 1
                if count > 49 then break end 

                local fullName = identity.name .. " " .. identity.name2
                local img = "http://104.234.63.114/inventory/logo.png" 
                
                local userInfo = Utils.functions.query('black/getLevelDay', {user_id = v.user_id})
                if userInfo and userInfo[1] and userInfo[1].imageUrl and userInfo[1].imageUrl ~= "" then
                    img = userInfo[1].imageUrl
                end
    
                table.insert(users, {
                    pos = count,
                    id = v.user_id,
                    name = fullName,
                    value = v.abates .. " abates"
                })
    
                if count <= 3 then
                    table.insert(usersWeek, {
                        name = fullName,
                        value = v.abates .. " abates"
                    })
                end
    
                if v.user_id == user_id then
                    myRanking = {
                        pos = count,
                        name = fullName,
                        image = img,
                        value = v.abates .. " abates"
                    }
                end
            end
        end
    end
    
    if myRanking.pos == 0 then
        local myAbates = Utils.functions.query('black/getAbatesByUserId', {user_id = user_id})
        if myAbates and myAbates[1] then
            local identity = Utils.functions.getUserIdentity(user_id)
            if identity then
                local fullName = identity.name .. " " .. identity.name2
                local img = "http://104.234.63.114/inventory/logo.png"

                local userInfo = Utils.functions.query('black/getLevelDay', {user_id = user_id})
                if userInfo and userInfo[1] and userInfo[1].imageUrl and userInfo[1].imageUrl ~= "" then
                    img = userInfo[1].imageUrl
                end

                local position = 1
                for _, r in ipairs(ranking) do
                    if tonumber(r.abates) > tonumber(myAbates[1].abates) then
                        position = position + 1
                    end
                end
                
                myRanking = {
                    pos = position,
                    name = fullName,
                    image = img,
                    value = myAbates[1].abates .. " abates"
                }
            end
        end
    end

    return {
        users = users,
        usersWeek = usersWeek,
        myRanking = myRanking
    }
end

Utils.functions.prepare(
    'black/getRankingElogios',
    "SELECT * FROM black_elogios ORDER BY data DESC"
)

Utils.functions.prepare(
    'black/getElogiosByUserId',
    "SELECT data FROM black_elogios WHERE user_id = @user_id LIMIT 1"
)

src.getRankingElogios = function(source)
    local users = {}
    local usersWeek = {}
    local myRanking = {
        pos = 0,
        name = "Desconhecido",
        image = "http://104.234.63.114/inventory/logo.png",
        value = "0 elogios",
    }

    local ranking = Utils.functions.query('black/getRankingElogios', {})
    local user_id = Utils.functions.getUserId(source)
    local count = 0

    for _, v in ipairs(ranking) do
        local elogios = tonumber(v.data) or 0

        if elogios > 0 then
            local identity = Utils.functions.getUserIdentity(v.user_id)
            if identity then
                count = count + 1
                if count > 49 then break end

                local fullName = identity.name .. " " .. identity.name2
                local img = "http://104.234.63.114/inventory/logo.png"

                local userInfo = Utils.functions.query('black/getLevelDay', { user_id = v.user_id })
                if userInfo and userInfo[1] and userInfo[1].imageUrl and userInfo[1].imageUrl ~= "" then
                    img = userInfo[1].imageUrl
                end

                table.insert(users, {
                    pos = count,
                    id = v.user_id,
                    name = fullName,
                    value = elogios .. " elogios"
                })

                if count <= 3 then
                    table.insert(usersWeek, {
                        name = fullName,
                        value = elogios .. " elogios"
                    })
                end

                if v.user_id == user_id then
                    myRanking = {
                        pos = count,
                        name = fullName,
                        image = img,
                        value = elogios .. " elogios"
                    }
                end
            end
        end
    end

    if myRanking.pos == 0 then
        local myElogios = Utils.functions.query('black/getElogiosByUserId', { user_id = user_id })
        if myElogios and myElogios[1] then
            local elogios = tonumber(myElogios[1].data) or 0
            if elogios > 0 then
                local identity = Utils.functions.getUserIdentity(user_id)
                if identity then
                    local fullName = identity.name .. " " .. identity.name2
                    local img = "http://104.234.63.114/inventory/logo.png"

                    local userInfo = Utils.functions.query('black/getLevelDay', { user_id = user_id })
                    if userInfo and userInfo[1] and userInfo[1].imageUrl and userInfo[1].imageUrl ~= "" then
                        img = userInfo[1].imageUrl
                    end

                    local position = 1
                    for _, r in ipairs(ranking) do
                        local rElogios = tonumber(r.data) or 0
                        if rElogios > elogios then
                            position = position + 1
                        end
                    end

                    myRanking = {
                        pos = position,
                        name = fullName,
                        image = img,
                        value = elogios .. " elogios"
                    }
                end
            end
        end
    end

    return {
        users = users,
        usersWeek = usersWeek,
        myRanking = myRanking
    }
end

