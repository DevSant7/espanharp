
local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
vSURVIVAL = Tunnel.getInterface("survival")

local function InitDatabase()
    if GetResourceState('oxmysql') ~= 'started' then
        return
    end

    exports.oxmysql:execute([[ 
        CREATE TABLE IF NOT EXISTS admin_notify (
            id INT AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(255) NOT NULL,
            message TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )
    ]], {}, function(_)
        exports.oxmysql:execute("ALTER TABLE admin_notify DROP COLUMN IF EXISTS author", {}, function(_)
            exports.oxmysql:execute("ALTER TABLE admin_notify DROP COLUMN IF EXISTS author_id", {}, function(_)
                exports.oxmysql:execute("ALTER TABLE admin_notify DROP COLUMN IF EXISTS is_active", {}, function(_)
                end)
            end)
        end)
    end)

    exports.oxmysql:execute([[ 
        CREATE TABLE IF NOT EXISTS admin_chat (
            id INT AUTO_INCREMENT PRIMARY KEY,
            user_id INT NOT NULL,
            name VARCHAR(255) NOT NULL,
            message TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ]], {}, function(_)
    end)

    exports.oxmysql:execute([[ 
        CREATE TABLE IF NOT EXISTS admin_salary (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            `group` VARCHAR(255) NOT NULL,
            amount INT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )
    ]], {}, function(_)
    end)
end

CreateThread(function()
    InitDatabase()
end)

RegisterNetEvent("admin:getNotifications", function()
    local source = source
    exports.oxmysql:execute("SELECT * FROM admin_notify ORDER BY created_at DESC LIMIT 10", {}, function(result)
        TriggerClientEvent("admin:receiveNotifications", source, result)
    end)
end)

RegisterNetEvent("admin:createNotification", function(data)
    local source = source
    
    if not data.title or not data.message then
        TriggerClientEvent("admin:notificationResult", source, { success = false, message = "Título e mensagem são obrigatórios!" })
        return
    end
    
    exports.oxmysql:insert("INSERT INTO admin_notify (title, message) VALUES (?, ?)", {
        data.title,
        data.message
    }, function(insertId)
        if insertId then
            TriggerClientEvent("admin:notificationResult", source, { success = true, message = "Aviso criado com sucesso!" })
            
            TriggerClientEvent("admin:newNotification", -1, {
                id = insertId,
                title = data.title,
                message = data.message,
                created_at = os.date("%d/%m/%Y %H:%M")
            })
        else
            TriggerClientEvent("admin:notificationResult", source, { success = false, message = "Erro ao criar aviso!" })
        end
    end)
end)

RegisterNetEvent("admin:deleteNotification", function(notificationId)
    local source = source
    
    exports.oxmysql:execute("DELETE FROM admin_notify WHERE id = ?", { notificationId }, function(result)
        if result and result.affectedRows and result.affectedRows > 0 then
            TriggerClientEvent("admin:notificationResult", source, { success = true, message = "Aviso removido com sucesso!" })
            
            TriggerClientEvent("admin:notificationDeleted", -1, notificationId)
        else
            TriggerClientEvent("admin:notificationResult", source, { success = false, message = "Aviso não encontrado!" })
        end
    end)
end)

RegisterNetEvent("admin:editNotification", function(data)
    local source = source
    
    if not data.id or not data.title or not data.message then
        TriggerClientEvent("admin:notificationResult", source, { success = false, message = "Dados inválidos!" })
        return
    end
    
    exports.oxmysql:execute("UPDATE admin_notify SET title = ?, message = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?", {
        data.title,
        data.message,
        data.id
    }, function(result)
        if result and result.affectedRows and result.affectedRows > 0 then
            TriggerClientEvent("admin:notificationResult", source, { success = true, message = "Aviso atualizado com sucesso!" })
            
            TriggerClientEvent("admin:notificationUpdated", -1, {
                id = data.id,
                title = data.title,
                message = data.message,
                updated_at = os.date("%d/%m/%Y %H:%M")
            })
        else
            TriggerClientEvent("admin:notificationResult", source, { success = false, message = "Aviso não encontrado!" })
        end
    end)
end)

RegisterNetEvent("admin:getNotification", function(notificationId)
    local source = source
    
    exports.oxmysql:execute("SELECT * FROM admin_notify WHERE id = ?", { notificationId }, function(result)
        if result[1] then
            TriggerClientEvent("admin:receiveNotification", source, result[1])
        else
            TriggerClientEvent("admin:notificationResult", source, { success = false, message = "Aviso não encontrado!" })
        end
    end)
end)


RegisterCommand("admin", function(source, args)
    local user_id = vRP.getUserId(source)
    
    if user_id then
        if vRP.hasGroup(user_id, "Admin") then
            TriggerClientEvent("admin:openPanel", source)
        else
            TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para acessar o painel admin.", 5000)
        end
    end
end, false)


function getConnectedPlayers()
    local players = GetPlayers()
    local connectedPlayers = 0
    for k, v in pairs(players) do
        connectedPlayers = connectedPlayers + 1
    end
    return connectedPlayers
end

function getOnlinePlayersData()
    local players = GetPlayers()
    local slots = GetConvarInt("sv_maxclients")
    
    return {
        players = getConnectedPlayers(),
        slots = slots
    }
end

function getServerData()
    return {
        props = 0,
        vehicles = 0
    }
end


RegisterNetEvent("admin:getOnlinePlayers")
AddEventHandler("admin:getOnlinePlayers", function()
    local source = source
    local data = getOnlinePlayersData()
    TriggerClientEvent("admin:receiveOnlinePlayers", source, data)
end)

RegisterNetEvent("admin:getServerData")
AddEventHandler("admin:getServerData", function()
    local source = source
    TriggerClientEvent("admin:requestServerData", source)
end)

RegisterNetEvent("admin:receiveClientServerData")
AddEventHandler("admin:receiveClientServerData", function(data)
    local source = source
    TriggerClientEvent("admin:receiveServerData", source, data)
end)

RegisterNetEvent("admin:createAnnouncement")
AddEventHandler("admin:createAnnouncement", function(data)
    local source = source
    
    if not data.title or not data.message then
        TriggerClientEvent("admin:announcementResult", source, { success = false, message = "Título e mensagem são obrigatórios!" })
        return
    end
    
    TriggerClientEvent("Notify2", -1, "prefeitura", data.title, data.message, 15000)
    
    TriggerClientEvent("admin:announcementResult", source, { success = true, message = "Anúncio enviado com sucesso!" })
end)

RegisterNetEvent("admin:destroyAllVehicles")
AddEventHandler("admin:destroyAllVehicles", function()
    local source = source
    
    
    TriggerClientEvent("admin:destroyVehicles", -1)
    
    TriggerClientEvent("Notify2", source, "Sucesso", "Todos os carros foram destruídos!", 15000)
end)

RegisterNetEvent("admin:fixVehicle")
AddEventHandler("admin:fixVehicle", function()
    local source = source
    
    
    local vehicle, vehNet, vehPlate, vehName = vRPC.vehList(source, 10)
    
    if vehicle then
        local activePlayers = vRPC.activePlayers(source)
        for _, v in ipairs(activePlayers) do
            async(function()
                TriggerClientEvent("inventory:repairAdmin", v, vehNet, vehPlate)
            end)
        end
        TriggerClientEvent("Notify2", source, "Sucesso", "Veículo reparado com sucesso!", 15000)
    else
        TriggerClientEvent("Notify2", source, "Erro", "Você precisa estar em um veículo!", 15000)
    end
end)

RegisterNetEvent("admin:tuningVehicle")
AddEventHandler("admin:tuningVehicle", function()
    local source = source
    
    
    TriggerClientEvent("admin:vehicleTuning", source)
    
    TriggerClientEvent("Notify2", source, "Sucesso", "Menu de tuning aberto!", 15000)
end)

RegisterNetEvent("admin:teleportCDS")
AddEventHandler("admin:teleportCDS", function(cds)
    local source = source
    
    
    local coords = {}
    for coord in string.gmatch(cds or "0,0,0", "[^,]+") do
        table.insert(coords, tonumber(coord))
    end
    
    if #coords >= 3 then
        local userPed = GetPlayerPed(source)
        SetEntityCoords(userPed, coords[1], coords[2], coords[3])
        TriggerClientEvent("Notify2", source, "Sucesso", "Teleportado para CDS: " .. cds, 15000)
    else
        TriggerClientEvent("Notify2", source, "Erro", "Formato de CDS inválido! Use: x,y,z", 15000)
    end
end)

RegisterNetEvent("admin:removeWhitelist")
AddEventHandler("admin:removeWhitelist", function(id)
    local source = source
    
    
    local user_id = tonumber(id)
    
    if user_id and user_id > 0 then
        local identity = vRP.userIdentity(user_id)
        
        if identity and identity["steam"] then
            exports.oxmysql:execute("UPDATE accounts SET whitelist = ? WHERE steam = ?", { 0, identity["steam"] })
            TriggerClientEvent("Notify2", source, "Sucesso", "Whitelist removida do jogador ID: " .. user_id, 15000)
        else
            TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado!", 15000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 15000)
    end
end)

RegisterNetEvent("admin:addWhitelist")
AddEventHandler("admin:addWhitelist", function(id)
    local source = source
    
    
    local account_id = tonumber(id)
    
    if account_id and account_id > 0 then
        exports.oxmysql:execute("UPDATE accounts SET whitelist = ? WHERE id = ?", { 1, account_id })
        TriggerClientEvent("Notify2", source, "Sucesso", "Whitelist adicionada ao account ID: " .. account_id, 15000)
    else
        TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 15000)
    end
end)

RegisterNetEvent("admin:kickPlayer")
AddEventHandler("admin:kickPlayer", function(id)
    local source = source
    
    
    local user_id = tonumber(id)
    
    if user_id and user_id > 0 then
        vRP.kick(user_id, "Você foi expulso do servidor por um administrador.")
        TriggerClientEvent("Notify2", source, "Sucesso", "Jogador ID " .. user_id .. " foi expulso!", 15000)
    else
        TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 15000)
    end
end)

RegisterNetEvent("admin:revivePlayer")
AddEventHandler("admin:revivePlayer", function(id)
    local source = source
    local user_id = tonumber(id)
    if user_id and user_id > 0 then
        local targetSource = vRP.getUserSource(user_id)
        if targetSource then
            TriggerClientEvent("admin:setEntityHealth", targetSource, 200)
            TriggerClientEvent("Notify2", source, "Sucesso", "Jogador ID " .. user_id .. " foi revivido!", 15000)
        else
            TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado online!", 15000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 15000)
    end
end)

RegisterNetEvent("admin:sendChatMessage")
AddEventHandler("admin:sendChatMessage", function(message)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id then
        local identity = vRP.userIdentity(user_id)
        if identity and identity["name"] then
            local name = identity["name"]
            
            exports.oxmysql:execute("INSERT INTO admin_chat (user_id, name, message) VALUES (?, ?, ?)", 
                { user_id, name, message }, function(result)
                    if result and result.insertId then
                        local insertId = result.insertId
                        
                        local players = GetPlayers()
                        for _, playerId in pairs(players) do
                            local playerUserId = vRP.getUserId(tonumber(playerId))
                            if playerUserId and vRP.hasPermission(playerUserId, "Admin") then
                                TriggerClientEvent("admin:receiveChatMessage", tonumber(playerId), {
                                    id = insertId,
                                    user_id = user_id,
                                    name = name,
                                    message = message,
                                    created_at = os.date("%Y-%m-%d %H:%M:%S")
                                })
                            end
                        end
                    else
                    end
                end)
        else
        end
    else
    end
end)

RegisterNetEvent("admin:getChatMessages")
AddEventHandler("admin:getChatMessages", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        TriggerClientEvent("admin:setCurrentUserId", source, user_id)
        
        exports.oxmysql:execute("SELECT * FROM admin_chat ORDER BY created_at DESC LIMIT 50", {}, function(result)
            if result and #result > 0 then
                local messages = {}
                for i = #result, 1, -1 do
                    table.insert(messages, {
                        id = result[i].id,
                        user_id = result[i].user_id,
                        name = result[i].name,
                        message = result[i].message,
                        created_at = result[i].created_at
                    })
                end
                
                TriggerClientEvent("admin:receiveChatMessages", source, messages)
            else
                TriggerClientEvent("admin:receiveChatMessages", source, {})
            end
        end)
    else
        TriggerClientEvent("admin:receiveChatMessages", source, {})
    end
end)

RegisterNetEvent("admin:getUserInfo")
AddEventHandler("admin:getUserInfo", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local identity = vRP.userIdentity(user_id)
        
        if identity and identity["name"] then
            local userInfo = {
                id = user_id,
                name = identity["name"],
                permission = "Admin"
            }
            TriggerClientEvent("admin:receiveUserInfo", source, userInfo)
        else
        end
    else
    end
end)



RegisterNetEvent("admin:getPlayers")
AddEventHandler("admin:getPlayers", function(searchTerm)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local allPlayers = {}
        local addedIds = {} -- Para evitar duplicatas
        
        if searchTerm and searchTerm ~= "" then
            local players = GetPlayers()
            for _, playerId in pairs(players) do
                local playerUserId = vRP.getUserId(tonumber(playerId))
                if playerUserId then
                    if tonumber(searchTerm) and playerUserId == tonumber(searchTerm) then
                        local identity = vRP.userIdentity(playerUserId)
                        if identity and identity["name"] and identity["name2"] then
                            local role = vRP.userGroup(playerUserId)
                            local fullName = identity["name"] .. " " .. identity["name2"]
                            
                            table.insert(allPlayers, {
                                id = playerUserId,
                                name = fullName,
                                profession = role or "Civil",
                                passport = tostring(playerUserId),
                                vip = "Sem Vip",
                                status = "Online",
                                professionColor = "#df5454",
                                vipColor = "#F3C623",
                                online = true
                            })
                            addedIds[playerUserId] = true
                        end
                    elseif not tonumber(searchTerm) then
                        local identity = vRP.userIdentity(playerUserId)
                        if identity and identity["name"] and identity["name2"] then
                            local fullName = identity["name"] .. " " .. identity["name2"]
                            if string.find(string.lower(fullName), string.lower(searchTerm)) then
                                local role = vRP.userGroup(playerUserId)
                                
                                table.insert(allPlayers, {
                                    id = playerUserId,
                                    name = fullName,
                                    profession = role or "Civil",
                                    passport = tostring(playerUserId),
                                    vip = "Sem Vip",
                                    status = "Online",
                                    professionColor = "#df5454",
                                    vipColor = "#F3C623",
                                    online = true
                                })
                                addedIds[playerUserId] = true
                            end
                        end
                    end
                end
            end
            
            local query, params
            if tonumber(searchTerm) then
                query = "SELECT id, name, name2, serial FROM characters WHERE id = ? ORDER BY id ASC LIMIT ?"
                params = { tonumber(searchTerm), 10 }
            else
                query = "SELECT id, name, name2, serial FROM characters WHERE name LIKE ? OR name2 LIKE ? ORDER BY id ASC LIMIT ?"
                params = { "%" .. searchTerm .. "%", "%" .. searchTerm .. "%", 10 }
            end
            
            exports.oxmysql:execute(query, params, function(result)
                if result and #result > 0 then
                    for _, user in pairs(result) do
                        local user_id = user.id
                        
                        if not addedIds[user_id] then
                            local fullName = (user.name or "Individuo") .. " " .. (user.name2 or "Indigente")
                            local role = vRP.userGroup(user_id)
                            
                            table.insert(allPlayers, {
                                id = user_id,
                                name = fullName,
                                profession = role or "Civil",
                                passport = tostring(user_id),
                                vip = "Sem Vip",
                                status = "Offline",
                                professionColor = "#df5454",
                                vipColor = "#F3C623",
                                online = false
                            })
                            addedIds[user_id] = true
                        end
                    end
                end
                
                table.sort(allPlayers, function(a, b)
                    return a.id < b.id
                end)
                
                TriggerClientEvent("admin:receivePlayers", source, allPlayers)
            end)
        else
            local players = GetPlayers()
            for _, playerId in pairs(players) do
                local playerUserId = vRP.getUserId(tonumber(playerId))
                if playerUserId then
                    local identity = vRP.userIdentity(playerUserId)
                    if identity and identity["name"] and identity["name2"] then
                        local role = vRP.userGroup(playerUserId)
                        local fullName = identity["name"] .. " " .. identity["name2"]
                        
                        table.insert(allPlayers, {
                            id = playerUserId,
                            name = fullName,
                            profession = role or "Civil",
                            passport = tostring(playerUserId),
                            vip = "Sem Vip",
                            status = "Online",
                            professionColor = "#df5454",
                            vipColor = "#F3C623",
                            online = true
                        })
                        addedIds[playerUserId] = true
                    end
                end
            end
            
            exports.oxmysql:execute("SELECT id, name, name2, serial FROM characters ORDER BY id ASC LIMIT ?", { 10 }, function(result)
                if result and #result > 0 then
                    for _, user in pairs(result) do
                        local user_id = user.id
                        
                        if not addedIds[user_id] then
                            local fullName = (user.name or "Individuo") .. " " .. (user.name2 or "Indigente")
                            local role = vRP.userGroup(user_id)
                            
                            table.insert(allPlayers, {
                                id = user_id,
                                name = fullName,
                                profession = role or "Civil",
                                passport = tostring(user_id),
                                vip = "Sem Vip",
                                status = "Offline",
                                professionColor = "#df5454",
                                vipColor = "#F3C623",
                                online = false
                            })
                            addedIds[user_id] = true
                        end
                    end
                end
                
                table.sort(allPlayers, function(a, b)
                    return a.id < b.id
                end)
                
                TriggerClientEvent("admin:receivePlayers", source, allPlayers)
            end)
        end
    else
        TriggerClientEvent("admin:receivePlayers", source, {})
    end
end)


function playerGender(ped)
    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        return "Masculino"
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        return "Feminino"
    end
    return "Indefinido"
end

function getUserVehicles(user_id)
    local data = exports.oxmysql:executeSync("SELECT * FROM vehicles WHERE user_id = ?", { user_id })
    local arr = {}
    if data and #data > 0 then
        for _, v in pairs(data) do
                table.insert(arr, {
                    name = getVehicleDisplayName(v.vehicle), -- Usar nome amigável do veículo
                    spawn = v.vehicle,
                    plate = v.plate,
                    image = Config.imagesProvider.vehicles .. v.vehicle .. ".png", -- Usar nome técnico para imagem
                    attributes = {
                        engine = v.engine or 100,
                        body = v.body or 100,
                        gas = v.gas or 100,
                        trunk = v.trunk or 100
                    }
                })
        end
    end
    return arr
end

function getVehicleDisplayName(vehicleSpawn)
    local displayName = vehicleName(vehicleSpawn)
    if displayName and displayName ~= "" then
        return displayName
    end
    return vehicleSpawn
end
function getItemImageName(itemSpawn)
    local specialItems = {
        ["identity-1"] = "identity",
        ["WEAPON_PISTOL_AMMO"] = "pistolammo",
        ["WEAPON_RIFLE_AMMO"] = "rifleammo",
        ["WEAPON_SMG_AMMO"] = "smgammo",
        ["WEAPON_SHOTGUN_AMMO"] = "shotgunammo",
        ["WEAPON_SNIPER_AMMO"] = "sniperammo",
        ["WEAPON_HEAVY_AMMO"] = "heavyammo",
    }
    
    if specialItems[itemSpawn] then
        return specialItems[itemSpawn]
    end
    
    if string.find(itemSpawn, "WEAPON_") then
        local weaponType = string.match(itemSpawn, "(WEAPON_[%w_]+)")
        if weaponType then
            return weaponType:lower():gsub("weapon_", "")
        end
    end
    
    return itemSpawn:lower()
end

function getItemDisplayName(itemSpawn)
    if itemName then
        local displayName = itemName(itemSpawn)
        if displayName and displayName ~= "" then
            return displayName
        end
    end
    
    local items = Utils.functions.getItems()
    if items and items[itemSpawn] then
        return items[itemSpawn][1] or itemSpawn
    end
    
    return itemSpawn
end

function getUserItems(user_id)
    local dataTable = vRP.getDatatable(user_id)
    local arr = {}
    if dataTable and dataTable["inventory"] then
        for k, v in pairs(dataTable["inventory"]) do
                table.insert(arr, {
                    name = getItemDisplayName(v.item), -- Usar nome amigável do item
                    quantity = v.amount,
                    spawn = v.item,
                    image = Config.imagesProvider.items .. getItemImageName(v.item) .. ".png" -- Usar nome mapeado para imagem
                })
        end
    end
    return arr
end

function getUserProperties(user_id)
    local data = exports.oxmysql:executeSync("SELECT * FROM propertys WHERE user_id = ?", { user_id })
    local arr = {}
    if data and #data > 0 then
        for _, v in pairs(data) do
            table.insert(arr, {
                name = v.name,
                street = v.street or "Endereço não informado"
            })
        end
    end
    return arr
end

RegisterNetEvent("admin:getPlayerDetails")
AddEventHandler("admin:getPlayerDetails", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local targetUserId = tonumber(targetUserId)
        if not targetUserId then
            TriggerClientEvent("admin:receivePlayerDetails", source, {})
            return
        end
        
        local playerData = {}
        
        local targetSource = vRP.userSource(targetUserId)
        local isOnline = targetSource ~= nil
        
        if isOnline then
            local identity = vRP.userIdentity(targetUserId)
            local dataTable = vRP.getDatatable(targetUserId)
            local userPed = GetPlayerPed(targetSource)
            
            
            playerData = {
                id = targetUserId,
                name = (identity["name"] or "Individuo") .. " " .. (identity["name2"] or "Indigente"),
                age = identity["age"] or 25,
                gender = playerGender(userPed),
                phone = identity["phone"] or "N/A",
                nationality = identity["nationality"] or "Brasil",
                bank = vRP.getBank(targetUserId) or 0,
                wallet = dataTable and dataTable["dollars"] or 0,
                arrested = dataTable and dataTable["prison"] and "Preso" or "Livre",
                online = true,
                stats = {
                    health = math.floor((GetEntityHealth(userPed) - 100) / (GetPedMaxHealth(userPed) - 100) * 100),
                    armour = math.floor(GetPedArmour(userPed) / 100 * 100), -- Converter para porcentagem (máximo 100 de colete = 100%)
                    thirst = dataTable and dataTable["thirst"] or 100,
                    hunger = dataTable and dataTable["hunger"] or 100
                },
                vehicles = getUserVehicles(targetUserId),
                items = getUserItems(targetUserId),
                properties = getUserProperties(targetUserId)
            }
        else
            local identity = vRP.userIdentity(targetUserId)
            local dataTable = vRP.getDatatable(targetUserId)
            
            
            playerData = {
                id = targetUserId,
                name = (identity["name"] or "Individuo") .. " " .. (identity["name2"] or "Indigente"),
                age = identity["age"] or 25,
                gender = "Indefinido",
                phone = identity["phone"] or "N/A",
                nationality = identity["nationality"] or "Brasil",
                bank = vRP.getBank(targetUserId) or 0,
                wallet = dataTable and dataTable["dollars"] or 0,
                arrested = dataTable and dataTable["prison"] and "Preso" or "Livre",
                online = false,
                stats = {
                    health = 0,
                    armour = 0, -- Jogador offline não tem colete
                    thirst = dataTable and dataTable["thirst"] or 100,
                    hunger = dataTable and dataTable["hunger"] or 100
                },
                vehicles = getUserVehicles(targetUserId),
                items = getUserItems(targetUserId),
                properties = getUserProperties(targetUserId)
            }
        end
        
        TriggerClientEvent("admin:receivePlayerDetails", source, playerData)
    else
        TriggerClientEvent("admin:receivePlayerDetails", source, {})
    end
end)


local vehiclesCache = {}
local vehiclesLoaded = false

function loadVehiclesCache()
    if vehiclesLoaded then return vehiclesCache end
    
    local vehicles = {}
    local vrpVehicles = Utils.functions.getVehicles()
    
    if vrpVehicles then
        for k, v in pairs(vrpVehicles) do
            table.insert(vehicles, {
                id = #vehicles + 1,
                name = v[1] or "Veículo Desconhecido",
                spawn = k,
                image = Config.imagesProvider.vehicles .. k .. ".png",
                favorite = false,
                attributes = {
                    engine = 100,
                    body = 100,
                    gas = 100,
                    trunk = 0
                }
            })
        end
        vehiclesCache = vehicles
        vehiclesLoaded = true
    else
    end
    
    return vehiclesCache
end

function getServerVehiclesPaginated(page, limit, searchTerm, category)
    local allVehicles = loadVehiclesCache()
    local filteredVehicles = {}
    
    if searchTerm and searchTerm ~= "" then
        searchTerm = string.lower(searchTerm)
        for _, vehicle in ipairs(allVehicles) do
            local vehicleName = string.lower(vehicle.name)
            local vehicleSpawn = string.lower(vehicle.spawn)
            if string.find(vehicleName, searchTerm) or string.find(vehicleSpawn, searchTerm) then
                table.insert(filteredVehicles, vehicle)
            end
        end
    else
        filteredVehicles = allVehicles
    end
    
    if category and category ~= "all" and (not searchTerm or searchTerm == "") then
        local categoryFiltered = {}
        for _, vehicle in ipairs(filteredVehicles) do
            local vehicleName = string.lower(vehicle.name)
            local vehicleSpawn = string.lower(vehicle.spawn)
            
            local matchesCategory = false
            if category == "carros" then
                matchesCategory = string.find(vehicleName, "carro") or string.find(vehicleName, "car") or 
                                 string.find(vehicleSpawn, "car") or string.find(vehicleSpawn, "sedan") or
                                 string.find(vehicleSpawn, "suv") or string.find(vehicleSpawn, "hatch") or
                                 string.find(vehicleSpawn, "coupe") or string.find(vehicleSpawn, "sport") or
                                 string.find(vehicleSpawn, "super") or string.find(vehicleSpawn, "muscle") or
                                 string.find(vehicleSpawn, "compact") or string.find(vehicleSpawn, "luxury")
            elseif category == "motos" then
                matchesCategory = string.find(vehicleName, "moto") or string.find(vehicleName, "bike") or
                                 string.find(vehicleSpawn, "bike") or string.find(vehicleSpawn, "motorcycle") or
                                 string.find(vehicleSpawn, "motor") or string.find(vehicleSpawn, "sportbike") or
                                 string.find(vehicleSpawn, "cruiser") or string.find(vehicleSpawn, "chopper")
            elseif category == "caminhoes" then
                matchesCategory = string.find(vehicleName, "caminhão") or string.find(vehicleName, "truck") or
                                 string.find(vehicleSpawn, "truck") or string.find(vehicleSpawn, "van") or
                                 string.find(vehicleSpawn, "pickup") or string.find(vehicleSpawn, "trailer") or
                                 string.find(vehicleSpawn, "bus") or string.find(vehicleSpawn, "cargo")
            elseif category == "aeronaves" then
                matchesCategory = string.find(vehicleName, "aeronave") or string.find(vehicleName, "helicopter") or
                                 string.find(vehicleSpawn, "heli") or string.find(vehicleSpawn, "plane") or
                                 string.find(vehicleSpawn, "jet") or string.find(vehicleSpawn, "cargo") or
                                 string.find(vehicleSpawn, "military") or string.find(vehicleSpawn, "fighter")
            end
            
            if matchesCategory then
                table.insert(categoryFiltered, vehicle)
            end
        end
        filteredVehicles = categoryFiltered
    end
    
    local totalVehicles = #filteredVehicles
    local startIndex = (page - 1) * limit + 1
    local endIndex = math.min(startIndex + limit - 1, totalVehicles)
    
    local paginatedVehicles = {}
    for i = startIndex, endIndex do
        if filteredVehicles[i] then
            table.insert(paginatedVehicles, filteredVehicles[i])
        end
    end
    
    return {
        vehicles = paginatedVehicles,
        total = totalVehicles,
        page = page,
        limit = limit,
        hasMore = endIndex < totalVehicles
    }
end

RegisterNetEvent("admin:getServerVehicles")
AddEventHandler("admin:getServerVehicles", function(page, limit, searchTerm, category)
    local source = source
    local user_id = vRP.getUserId(source)
    
    page = page or 1
        limit = limit or 1200  -- Limite padrão de 1200 veículos por página
    searchTerm = searchTerm or ""
    category = category or "all"
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local result = getServerVehiclesPaginated(page, limit, searchTerm, category)
        TriggerClientEvent("admin:receiveServerVehicles", source, result)
    else
        TriggerClientEvent("admin:receiveVehiclesError", source, "Sem permissão para acessar veículos")
    end
end)

RegisterNetEvent("admin:spawnVehicle")
AddEventHandler("admin:spawnVehicle", function(vehicleSpawn)
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local ped = GetPlayerPed(source)
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        
        Utils.functions.createVehicle(user_id, source, vehicleSpawn, coords.x, coords.y, coords.z, heading)
        
        local vehicleName = getVehicleDisplayName(vehicleSpawn)
        
        TriggerClientEvent("Notify2", source, "Sucesso", "Veículo " .. vehicleName .. " spawnado!", 5000)
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

-- Duração de aluguel em segundos
local rentalDuration = {
    [5] = 432000,   -- 5 dias
    [10] = 864000,  -- 10 dias
    [15] = 1296000, -- 15 dias
    [20] = 1728000, -- 20 dias
    [30] = 2592000  -- 30 dias
}

RegisterNetEvent("admin:addVehicleToUser")
AddEventHandler("admin:addVehicleToUser", function(vehicleSpawn, targetUserId, duration)
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local permanent = duration == "permanente"
        local plate = vRP.generatePlate()
        
        if not permanent then
            -- Adicionar veículo com aluguel
            local rentalDays = rentalDuration[duration] or 864000 -- padrão 10 dias
            local rentalTimestamp = os.time() + rentalDays
            local taxTimestamp = os.time() + 604800 -- 7 dias para tax
            
            exports.oxmysql:execute("INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,rental,tax) VALUES(?,?,?,?,?,?)", {
                targetUserId,
                vehicleSpawn,
                plate,
                "false",
                rentalTimestamp,
                taxTimestamp
            }, function(result)
                if result and result.affectedRows and result.affectedRows > 0 then
                    local vehicleName = getVehicleDisplayName(vehicleSpawn)
                    TriggerClientEvent("Notify2", source, "Sucesso", "Veículo " .. vehicleName .. " adicionado por " .. duration .. " dias!", 5000)
                else
                    TriggerClientEvent("Notify2", source, "Erro", "Falha ao adicionar veículo!", 5000)
                end
            end)
        else
            -- Adicionar veículo permanente
            local taxTimestamp = os.time() + 604800 -- 7 dias para tax
            
            exports.oxmysql:execute("INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,rental,tax) VALUES(?,?,?,?,?,?)", {
                targetUserId,
                vehicleSpawn,
                plate,
                "false",
                0, -- permanente
                taxTimestamp
            }, function(result)
                if result and result.affectedRows and result.affectedRows > 0 then
                    local vehicleName = getVehicleDisplayName(vehicleSpawn)
                    TriggerClientEvent("Notify2", source, "Sucesso", "Veículo " .. vehicleName .. " adicionado permanentemente!", 5000)
                else
                    TriggerClientEvent("Notify2", source, "Erro", "Falha ao adicionar veículo!", 5000)
                end
            end)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

RegisterNetEvent("admin:removeVehicleFromUser")
AddEventHandler("admin:removeVehicleFromUser", function(vehicleSpawn, plate, targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        exports.oxmysql:execute("DELETE FROM vehicles WHERE user_id = ? AND vehicle = ? AND plate = ?", {
            targetUserId,
            vehicleSpawn,
            plate
        }, function(result)
            if result and result.affectedRows and result.affectedRows > 0 then
                local vehicleName = getVehicleDisplayName(vehicleSpawn)
                TriggerClientEvent("Notify2", source, "Sucesso", "Veículo " .. vehicleName .. " removido do usuário!", 5000)
            else
                TriggerClientEvent("Notify2", source, "Erro", "Veículo não encontrado!", 5000)
            end
        end)
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

function getVehicleDisplayName(vehicleSpawn)
    local vehicles = Utils.functions.getVehicles()
    if vehicles and vehicles[vehicleSpawn] then
        return vehicles[vehicleSpawn][1] or vehicleSpawn
    end
    return vehicleSpawn
end


function getAllServerItems()
    local items = {}
    
    local vrpItems = itemList()
    
    if vrpItems then
        for k, v in pairs(vrpItems) do
            table.insert(items, {
                id = #items + 1,
                name = v.name or "Item Desconhecido",
                spawn = k,
                image = Config.imagesProvider.items .. getItemImageName(k) .. ".png",
                weight = v.weight or 0,
                category = v.category or "misc",
                type = v.type or "Usável"
            })
        end
    else
    end
    
    return items
end

RegisterNetEvent("admin:getServerItems")
AddEventHandler("admin:getServerItems", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local items = getAllServerItems()
        TriggerClientEvent("admin:receiveServerItems", source, items)
    else
        TriggerClientEvent("admin:receiveItemsError", source, "Sem permissão para acessar itens")
    end
end)

RegisterNetEvent("admin:takeItem")
AddEventHandler("admin:takeItem", function(itemSpawn, quantity)
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local qty = tonumber(quantity) or 1
        
        if qty > 0 and qty <= 1000 then -- Limite de segurança
            local success = vRP.giveInventoryItem(user_id, itemSpawn, qty, true)
            
            if success then
                local itemName = getItemDisplayName(itemSpawn)
                
                TriggerClientEvent("Notify2", source, "Sucesso", "Você recebeu " .. qty .. "x " .. itemName, 5000)
            else
                TriggerClientEvent("Notify2", source, "Erro", "Falha ao dar item!", 5000)
            end
        else
            TriggerClientEvent("Notify2", source, "Erro", "Quantidade inválida!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)


-- Cache para organizações
local organizationsCache = {}
local organizationsCacheTime = 0

function getAllOrganizations()
    local currentTime = GetGameTimer()
    
    -- Verificar se o cache está habilitado e ainda é válido
    if Config.cache.organizations.enabled and organizationsCache and organizationsCacheTime and (currentTime - organizationsCacheTime) < Config.cache.organizations.duration then
        return organizationsCache
    end
    
    local startTime = GetGameTimer()
    
    local organizations = {}
    local groups = vRP.Groups()
    local filteredCount = 0
    
    if groups then
        local groupCount = 0
        for groupName, _ in pairs(groups) do
            groupCount = groupCount + 1
            if not string.find(string.lower(groupName), "^wait") then
                local groupData = vRP.DataGroups(groupName)
                local members = {}
                local leader = nil
                local onlineCount = 0
            
                if groupData then
                    for user_id, level in pairs(groupData) do
                        local userSource = vRP.userSource(user_id)
                        local identity = vRP.userIdentity(user_id)
                        
                        local fullName = "#" .. user_id
                        if identity then
                            if identity["name"] and identity["name2"] then
                                fullName = fullName .. " " .. identity["name"] .. " " .. identity["name2"]
                            elseif identity["name"] then
                                fullName = fullName .. " " .. identity["name"]
                            elseif identity["name2"] then
                                fullName = fullName .. " " .. identity["name2"]
                            else
                                fullName = fullName .. " Usuário Desconhecido"
                            end
                        else
                            fullName = fullName .. " Usuário Desconhecido"
                        end
                        
                        local member = {
                            id = user_id,
                            name = fullName,
                            level = level,
                            online = userSource ~= nil,
                            source = userSource
                        }
                        
                        table.insert(members, member)
                        
                        if userSource ~= nil then
                            onlineCount = onlineCount + 1
                        end
                        
                        if level == 1 then
                            leader = member
                        end
                    end
                end
            
                table.insert(organizations, {
                    id = #organizations + 1,
                    name = groupName,
                    leader = leader,
                    members = members,
                    totalMembers = #members,
                    onlineMembers = onlineCount
                })
            else
                filteredCount = filteredCount + 1
            end
        end
    end
    
    -- Atualizar cache
    organizationsCache = organizations
    organizationsCacheTime = currentTime
    
    local endTime = GetGameTimer()
    local loadTime = endTime - startTime
    
    return organizations
end

-- Função para limpar o cache de organizações (chamada quando há mudanças)
function clearOrganizationsCache()
    organizationsCache = {}
    organizationsCacheTime = 0
end

function getOrganizationMembers(groupName)
    local members = {}
    local groupData = vRP.DataGroups(groupName)
    
    if groupData then
        for user_id, level in pairs(groupData) do
            local userSource = vRP.userSource(user_id)
            local identity = vRP.userIdentity(user_id)
            
            local fullName = "#" .. user_id
            if identity then
                if identity["name"] and identity["name2"] then
                    fullName = fullName .. " " .. identity["name"] .. " " .. identity["name2"]
                elseif identity["name"] then
                    fullName = fullName .. " " .. identity["name"]
                elseif identity["name2"] then
                    fullName = fullName .. " " .. identity["name2"]
                else
                    fullName = fullName .. " Usuário Desconhecido"
                end
            else
                fullName = fullName .. " Usuário Desconhecido"
            end
            
            local member = {
                id = user_id,
                name = fullName,
                level = level,
                online = userSource ~= nil,
                source = userSource,
                role = level == 1 and "Líder" or "Membro"
            }
            
            table.insert(members, member)
        end
    end
    
    table.sort(members, function(a, b) return a.level < b.level end)
    
    return members
end

RegisterNetEvent("admin:getServerOrganizations")
AddEventHandler("admin:getServerOrganizations", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local startTime = GetGameTimer()
        local organizations = getAllOrganizations()
        local endTime = GetGameTimer()
        
        TriggerClientEvent("admin:receiveServerOrganizations", source, organizations)
    else
        TriggerClientEvent("admin:receiveOrganizationsError", source, "Sem permissão para acessar organizações")
    end
end)


RegisterNetEvent("admin:getOrganizationMembers")
AddEventHandler("admin:getOrganizationMembers", function(groupName)
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local members = getOrganizationMembers(groupName)
        TriggerClientEvent("admin:receiveOrganizationMembers", source, groupName, members)
    else
        TriggerClientEvent("admin:receiveOrganizationsError", source, "Sem permissão para acessar membros")
    end
end)


function getAllStaff()
    -- Consolidar por usuário, mantendo apenas o cargo de maior nível
    local userIdToStaff = {}

    for groupName, groupConfig in pairs(Config.staffGroups) do
        local groupData = vRP.DataGroups(groupName)

        if groupData then
            for user_id, _ in pairs(groupData) do
                local current = userIdToStaff[user_id]
                local userSource = vRP.userSource(user_id)
                local identity = vRP.userIdentity(user_id)

                local fullName = ""
                if identity then
                    if identity["name"] and identity["name2"] then
                        fullName = identity["name"] .. " " .. identity["name2"]
                    elseif identity["name"] then
                        fullName = identity["name"]
                    elseif identity["name2"] then
                        fullName = identity["name2"]
                    else
                        fullName = "Usuário Desconhecido"
                    end
                else
                    fullName = "Usuário Desconhecido"
                end

                -- Se já existe, manter o de maior nível
                if not current or groupConfig.level > current.level then
                    userIdToStaff[user_id] = {
                        id = user_id,
                        name = fullName,
                        group = groupName,
                        level = groupConfig.level,
                        online = userSource ~= nil,
                        source = userSource,
                        color = groupConfig.color,
                        bgColor = groupConfig.bgColor,
                        canPromote = groupConfig.canPromote,
                        canDemote = groupConfig.canDemote,
                        canManage = groupConfig.canManage
                    }
                end
            end
        end
    end

    -- Transformar mapa em lista
    local staffMembers = {}
    for _, member in pairs(userIdToStaff) do
        table.insert(staffMembers, member)
    end

    table.sort(staffMembers, function(a, b) return a.level > b.level end)
    return staffMembers
end

function promoteStaff(targetUserId, currentGroup, newGroup)
    if not Config.staffGroups[newGroup] then
        return false, "Grupo inválido"
    end
    
    vRP.remPermission(targetUserId, currentGroup)
    
    vRP.setPermission(targetUserId, newGroup)
    
    return true, "Membro promovido com sucesso"
end

function removeStaff(targetUserId, currentGroup)
    vRP.remPermission(targetUserId, currentGroup)
    
    return true, "Membro demitido com sucesso"
end

function getNextRank(currentGroup)
    for i, group in ipairs(Config.staffHierarchy) do
        if group == currentGroup and i < #Config.staffHierarchy then
            return Config.staffHierarchy[i + 1]
        end
    end
    return nil
end

function getPreviousRank(currentGroup)
    for i, group in ipairs(Config.staffHierarchy) do
        if group == currentGroup and i > 1 then
            return Config.staffHierarchy[i - 1]
        end
    end
    return nil
end

-- Evento para teleportar admin até jogador
RegisterNetEvent("admin:teleportToPlayer")
AddEventHandler("admin:teleportToPlayer", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local targetSource = vRP.userSource(targetUserId)
        
        if targetSource then
            -- Obter coordenadas do jogador alvo
            local targetPed = GetPlayerPed(targetSource)
            local targetCoords = GetEntityCoords(targetPed)
            
            -- Teleportar o admin até o jogador
            local adminPed = GetPlayerPed(source)
            SetEntityCoords(adminPed, targetCoords.x, targetCoords.y, targetCoords.z)
            
            -- Notificar o admin
            TriggerClientEvent("Notify2", source, "Sucesso", "Teleportado para o jogador ID: " .. targetUserId, 5000)
        else
            TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado ou offline!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

-- Evento para puxar jogador até admin
RegisterNetEvent("admin:pullPlayer")
AddEventHandler("admin:pullPlayer", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local targetSource = vRP.userSource(targetUserId)
        
        if targetSource then
            -- Obter coordenadas do admin
            local adminPed = GetPlayerPed(source)
            local adminCoords = GetEntityCoords(adminPed)
            
            -- Teleportar o jogador até o admin
            local targetPed = GetPlayerPed(targetSource)
            SetEntityCoords(targetPed, adminCoords.x, adminCoords.y, adminCoords.z)
            
            -- Notificar o admin
            TriggerClientEvent("Notify2", source, "Sucesso", "Jogador ID: " .. targetUserId .. " foi puxado até você!", 5000)
            
            -- Notificar o jogador puxado
            TriggerClientEvent("Notify2", targetSource, "Teleporte", "Você foi puxado por um administrador", 5000)
        else
            TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado ou offline!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

-- Evento para corrigir veículo do jogador
RegisterNetEvent("admin:fixPlayerVehicle")
AddEventHandler("admin:fixPlayerVehicle", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local targetSource = vRP.userSource(targetUserId)
        
        if targetSource then
            -- Verificar se o jogador está em um veículo
            local vehicle, vehNet, vehPlate, vehName = vRPC.vehList(targetSource, 10)
            
            if vehicle then
                -- Corrigir o veículo do jogador
                local activePlayers = vRPC.activePlayers(targetSource)
                for _, v in ipairs(activePlayers) do
                    async(function()
                        TriggerClientEvent("inventory:repairAdmin", v, vehNet, vehPlate)
                    end)
                end
                
                -- Notificar o admin
                TriggerClientEvent("Notify2", source, "Sucesso", "Veículo do jogador ID: " .. targetUserId .. " foi corrigido!", 5000)
                
                -- Notificar o jogador
                TriggerClientEvent("Notify2", targetSource, "Veículo", "Seu veículo foi corrigido por um administrador", 5000)
            else
                TriggerClientEvent("Notify2", source, "Erro", "Jogador não está em um veículo!", 5000)
            end
        else
            TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado ou offline!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

-- Evento para dar colete para jogador
RegisterNetEvent("admin:armorPlayer")
AddEventHandler("admin:armorPlayer", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local user_id_target = tonumber(targetUserId)
        
        if user_id_target and user_id_target > 0 then
            local targetSource = vRP.userSource(user_id_target)
            
            if targetSource then
                -- Dar colete para o jogador usando TriggerClientEvent
                TriggerClientEvent("admin:setEntityArmour", targetSource, 100)
                
                -- Notificar o admin
                TriggerClientEvent("Notify2", source, "Sucesso", "Colete dado para o jogador ID: " .. user_id_target, 5000)
                
                -- Notificar o jogador
                TriggerClientEvent("Notify2", targetSource, "Colete", "Você recebeu colete de um administrador", 5000)
            else
                TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado ou offline!", 5000)
            end
        else
            TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

-- Evento para matar jogador
RegisterNetEvent("admin:killPlayer")
AddEventHandler("admin:killPlayer", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local user_id_target = tonumber(targetUserId)
        
        if user_id_target and user_id_target > 0 then
            local targetSource = vRP.userSource(user_id_target)
            
            if targetSource then
                -- Matar o jogador definindo vida em 101 (abaixo de 100 = morto)
                TriggerClientEvent("admin:setEntityHealth", targetSource, 101)
                
                -- Notificar o admin
                TriggerClientEvent("Notify2", source, "Sucesso", "Jogador ID: " .. user_id_target .. " foi morto!", 5000)
                
                -- Notificar o jogador
                TriggerClientEvent("Notify2", targetSource, "Morte", "Você foi morto por um administrador", 5000)
            else
                TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado ou offline!", 5000)
            end
        else
            TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

-- Evento para dar god mode para jogador
RegisterNetEvent("admin:godPlayer")
AddEventHandler("admin:godPlayer", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local user_id_target = tonumber(targetUserId)
        
        if user_id_target and user_id_target > 0 then
            local targetSource = vRP.userSource(user_id_target)
            
            if targetSource then
                -- Dar vida máxima (200)
                TriggerClientEvent("admin:setEntityHealth", targetSource, 200)
                
                -- Restaurar sede, fome e remover estresse
                vRP.upgradeThirst(user_id_target, 100)
                vRP.upgradeHunger(user_id_target, 100)
                vRP.downgradeStress(user_id_target, 100)
                
                -- Notificar o admin
                TriggerClientEvent("Notify2", source, "Sucesso", "God mode dado para o jogador ID: " .. user_id_target, 5000)
                
                -- Notificar o jogador
                TriggerClientEvent("Notify2", targetSource, "God Mode", "Você recebeu god mode de um administrador", 5000)
            else
                TriggerClientEvent("Notify2", source, "Erro", "Jogador não encontrado ou offline!", 5000)
            end
        else
            TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

-- Evento para expulsar jogador
RegisterNetEvent("admin:kickPlayer")
AddEventHandler("admin:kickPlayer", function(targetUserId)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local user_id_target = tonumber(targetUserId)
        
        if user_id_target and user_id_target > 0 then
            -- Expulsar jogador usando vRP.kick
            vRP.kick(user_id_target, "Você foi expulso do servidor por um administrador.")
            
            -- Notificar o admin
            TriggerClientEvent("Notify2", source, "Sucesso", "Jogador ID: " .. user_id_target .. " foi expulso!", 5000)
        else
            TriggerClientEvent("Notify2", source, "Erro", "ID inválido!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

RegisterNetEvent("admin:getServerStaff")
AddEventHandler("admin:getServerStaff", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local staffMembers = getAllStaff()
        TriggerClientEvent("admin:receiveServerStaff", source, staffMembers)
    else
        TriggerClientEvent("admin:receiveStaffError", source, "Sem permissão para acessar staff")
    end
end)

RegisterNetEvent("admin:promoteStaff")
AddEventHandler("admin:promoteStaff", function(targetUserId, currentGroup, newGroup)
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local success, message = promoteStaff(targetUserId, currentGroup, newGroup)
        
        if success then
            -- Limpar cache de organizações quando há mudanças de permissão
            clearOrganizationsCache()
            
            TriggerClientEvent("Notify2", source, "Sucesso", message, 5000)
            
            local targetSource = vRP.userSource(targetUserId)
            if targetSource then
                TriggerClientEvent("Notify2", targetSource, "Promoção", "Você foi promovido para " .. newGroup, 5000)
            end
        else
            TriggerClientEvent("Notify2", source, "Erro", message, 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

RegisterNetEvent("admin:removeStaff")
AddEventHandler("admin:removeStaff", function(targetUserId, currentGroup)
    local source = source
    local user_id = vRP.getUserId(source)
    
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local success, message = removeStaff(targetUserId, currentGroup)
        
        if success then
            -- Limpar cache de organizações quando há mudanças de permissão
            clearOrganizationsCache()
            
            TriggerClientEvent("Notify2", source, "Sucesso", message, 5000)
            
            local targetSource = vRP.userSource(targetUserId)
            if targetSource then
                TriggerClientEvent("Notify2", targetSource, "Demissão", "Você foi demitido do staff", 5000)
            end
        else
            TriggerClientEvent("Notify2", source, "Erro", message, 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)


local function formatDate(dateString)
    local date = os.date("*t", dateString)
    return string.format("%02d/%02d/%04d %02d:%02d", date.day, date.month, date.year, date.hour, date.min)
end

-- Sistema de Salários
function giveSalary(user_id, value, group)
    local userSource = vRP.userSource(user_id)
    if user_id and userSource then 
        vRP.addBank(user_id, value)
        TriggerClientEvent("Notify", userSource, "importante", "Foi adicionado a sua conta bancária do salário do seu cargo " .. group .. " no valor de $" .. value, 5000)
    end 
end

function getUsersByPermission(permission)
    local users = {}
    local players = GetPlayers()
    
    for _, playerId in pairs(players) do
        local playerUserId = vRP.getUserId(tonumber(playerId))
        if playerUserId and vRP.hasPermission(playerUserId, permission) then
            table.insert(users, playerUserId)
        end
    end
    
    return users
end

function getSalaries()
    local data = exports.oxmysql:executeSync("SELECT * FROM admin_salary")
    local arr = {}
    
    if data and #data > 0 then
        for _, v in pairs(data) do
            table.insert(arr, {
                id = v.id,
                name = v.name,
                group = v.group,
                members = getUsersByPermission(v.group),
                salary = v.amount
            })
        end
    end
    
    return arr
end

-- Eventos de Salário
RegisterNetEvent("admin:addNewSalary")
AddEventHandler("admin:addNewSalary", function(name, group, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        if group ~= "" and amount > 0 then
            exports.oxmysql:execute("INSERT IGNORE INTO admin_salary(name, `group`, amount) VALUES(?, ?, ?)", {
                name,
                group,
                amount
            }, function(result)
                if result and result.affectedRows and result.affectedRows > 0 then
                    TriggerClientEvent("Notify", source, "sucesso", "Grupo de salário criado com sucesso!", 5000)
                    
                    -- Atualizar lista de salários
                    local salaries = getSalaries()
                    TriggerClientEvent("admin:receiveSalaries", source, salaries)
                else
                    TriggerClientEvent("Notify", source, "negado", "Falha ao criar grupo de salário!", 5000)
                end
            end)
        else
            TriggerClientEvent("Notify", source, "negado", "Dados inválidos!", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "negado", "Sem permissão!", 5000)
    end
end)

RegisterNetEvent("admin:removeSalary")
AddEventHandler("admin:removeSalary", function(name)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        exports.oxmysql:execute("DELETE FROM admin_salary WHERE name = ?", { name }, function(result)
            if result and result.affectedRows and result.affectedRows > 0 then
                TriggerClientEvent("Notify", source, "sucesso", "Grupo de salário removido com sucesso!", 5000)
                
                -- Atualizar lista de salários
                local salaries = getSalaries()
                TriggerClientEvent("admin:receiveSalaries", source, salaries)
            else
                TriggerClientEvent("Notify", source, "negado", "Grupo de salário não encontrado!", 5000)
            end
        end)
    else
        TriggerClientEvent("Notify", source, "negado", "Sem permissão!", 5000)
    end
end)

RegisterNetEvent("admin:updateSalary")
AddEventHandler("admin:updateSalary", function(group, amount)
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        if group ~= "" and amount > 0 then
            exports.oxmysql:execute("UPDATE admin_salary SET amount = ? WHERE `group` = ?", {
                amount,
                group
            }, function(result)
                if result and result.affectedRows and result.affectedRows > 0 then
                    TriggerClientEvent("Notify", source, "sucesso", "Salário atualizado com sucesso!", 5000)
                    
                    -- Atualizar lista de salários
                    local salaries = getSalaries()
                    TriggerClientEvent("admin:receiveSalaries", source, salaries)
                else
                    TriggerClientEvent("Notify2", source, "Erro", "Grupo não encontrado!", 5000)
                end
            end)
        else
            TriggerClientEvent("Notify2", source, "Erro", "Dados inválidos!", 5000)
        end
    else
        TriggerClientEvent("Notify2", source, "Erro", "Sem permissão!", 5000)
    end
end)

RegisterNetEvent("admin:getSalaries")
AddEventHandler("admin:getSalaries", function()
    local source = source
    local user_id = vRP.getUserId(source)
    
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local salaries = getSalaries()
        TriggerClientEvent("admin:receiveSalaries", source, salaries)
    else
        TriggerClientEvent("admin:receiveSalaries", source, {})
    end
end)

-- Sistema de pagamento automático de salários (a cada 30 minutos)
CreateThread(function()
    -- Primeiro pagamento imediato
    local data = exports.oxmysql:executeSync("SELECT * FROM admin_salary")
    if data and #data > 0 then
        for _, v in pairs(data) do
            local groupMembers = getUsersByPermission(v.group)
            if #groupMembers > 0 then
                for _, memberId in pairs(groupMembers) do
                    giveSalary(memberId, v.amount, v.group)
                end
            end
        end
    end
    
    while true do
        Wait(1000 * 60 * 30) -- 30 minutos
        
        local data = exports.oxmysql:executeSync("SELECT * FROM admin_salary")
        if data and #data > 0 then
            for _, v in pairs(data) do
                local groupMembers = getUsersByPermission(v.group)
                if #groupMembers > 0 then
                    for _, memberId in pairs(groupMembers) do
                        giveSalary(memberId, v.amount, v.group)
                    end
                end
            end
        end
    end
end)

