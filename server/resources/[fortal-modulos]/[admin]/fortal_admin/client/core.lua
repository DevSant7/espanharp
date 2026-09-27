AddEventHandler("onClientResourceStart",function(Resource)
	if GetCurrentResourceName() == Resource then
		SetNuiFocus(false,false)
	end
end)


local notifications = {}
local isAdminPanelOpen = false


RegisterNetEvent("admin:openPanel")
AddEventHandler("admin:openPanel", function()
    local Ped = PlayerPedId()
    if GetEntityHealth(Ped) > 100 then
        isAdminPanelOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({ action = "setVisible", data = true })
        
        TriggerServerEvent("admin:getNotifications")
        
        TriggerServerEvent("admin:getOnlinePlayers")
        
        TriggerServerEvent("admin:getServerData")
        
        print("^2[FORTAL-ADMIN]^7 Painel admin aberto, NUI focus ativado")
    end
end)

RegisterNetEvent("admin:receiveNotifications")
AddEventHandler("admin:receiveNotifications", function(data)
    notifications = data
    SendNUIMessage({ 
        action = "updateNotifications", 
        data = notifications 
    })
end)

RegisterNetEvent("admin:notificationResult")
AddEventHandler("admin:notificationResult", function(result)
    SendNUIMessage({ 
        action = "notificationResult", 
        data = result 
    })
    
    if result.success then
        TriggerServerEvent("admin:getNotifications")
    end
end)

RegisterNetEvent("admin:newNotification")
AddEventHandler("admin:newNotification", function(notification)
    table.insert(notifications, 1, notification)
    if #notifications > 10 then
        table.remove(notifications, #notifications)
    end
    
    SendNUIMessage({ 
        action = "updateNotifications", 
        data = notifications 
    })
end)

RegisterNetEvent("admin:notificationDeleted")
AddEventHandler("admin:notificationDeleted", function(notificationId)
    for i = #notifications, 1, -1 do
        if notifications[i].id == notificationId then
            table.remove(notifications, i)
            break
        end
    end
    
    SendNUIMessage({ 
        action = "updateNotifications", 
        data = notifications 
    })
end)

RegisterNetEvent("admin:notificationUpdated")
AddEventHandler("admin:notificationUpdated", function(updatedNotification)
    for i = 1, #notifications do
        if notifications[i].id == updatedNotification.id then
            notifications[i] = updatedNotification
            break
        end
    end
    
    SendNUIMessage({ 
        action = "updateNotifications", 
        data = notifications 
    })
end)

RegisterNetEvent("admin:receiveNotification")
AddEventHandler("admin:receiveNotification", function(notification)
    SendNUIMessage({ 
        action = "receiveNotification", 
        data = notification 
    })
end)

RegisterNetEvent("admin:receiveOnlinePlayers")
AddEventHandler("admin:receiveOnlinePlayers", function(data)
    SendNUIMessage({ 
        action = "updateOnlinePlayers", 
        data = data 
    })
end)

RegisterNetEvent("admin:receiveServerData")
AddEventHandler("admin:receiveServerData", function(data)
    SendNUIMessage({ 
        action = "updateServerData", 
        data = data 
    })
end)

RegisterNetEvent("admin:announcementResult")
AddEventHandler("admin:announcementResult", function(result)
    SendNUIMessage({ 
        action = "announcementResult", 
        data = result 
    })
end)



function enumerateObjects()
    return enumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function enumerateVehicles()
    return enumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function enumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local handle, entity = initFunc()
        if not entity or entity == 0 then
            disposeFunc(handle)
            return
        end

        local enum = {handle = handle, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(entity)
            next, entity = moveFunc(handle)
        until not next

        enum.destructor, enum.handle = nil, nil
        disposeFunc(handle)
    end)
end

local entityEnumerator = {
    __gc = function(enum)
        if enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

function getClientServerData()
    local objects = {}
    local vehicles = {}
    
    for obj in enumerateObjects() do
        local model = GetEntityModel(obj)
        table.insert(objects, {obj = obj, model = model})
    end
    
    for vehicle in enumerateVehicles() do
        local model = GetEntityModel(vehicle)
        table.insert(vehicles, {vehicle = vehicle, model = model})
    end
    
    return {
        props = #objects,
        vehicles = #vehicles
    }
end

function deleteAllVehicles()
    for vehicle in enumerateVehicles() do 
        DeleteVehicle(vehicle)
        if (DoesEntityExist(vehicle)) then 
            DeleteVehicle(vehicle) 
        end
    end 
end



RegisterNetEvent("admin:requestServerData")
AddEventHandler("admin:requestServerData", function()
    local data = getClientServerData()
    TriggerServerEvent("admin:receiveClientServerData", data)
end)

RegisterNetEvent("admin:destroyVehicles")
AddEventHandler("admin:destroyVehicles", function()
    deleteAllVehicles()
end)

RegisterNetEvent("admin:receiveChatMessage")
AddEventHandler("admin:receiveChatMessage", function(message)
    SendNUIMessage({ action = "receiveChatMessage", data = message })
end)

RegisterNetEvent("admin:receiveChatMessages")
AddEventHandler("admin:receiveChatMessages", function(messages)
    SendNUIMessage({ action = "receiveChatMessages", data = messages })
end)

RegisterNetEvent("admin:setCurrentUserId")
AddEventHandler("admin:setCurrentUserId", function(userId)
    SendNUIMessage({ action = "setCurrentUserId", data = userId })
end)

RegisterNetEvent("admin:receiveUserInfo")
AddEventHandler("admin:receiveUserInfo", function(userInfo)
    SendNUIMessage({ action = "receiveUserInfo", data = userInfo })
end)

RegisterNetEvent("admin:setEntityHealth")
AddEventHandler("admin:setEntityHealth", function(health)
    SetEntityHealth(PlayerPedId(), health)
end)

RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin", function(vehNet, vehPlate)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        
        if vehicle ~= 0 and DoesEntityExist(vehicle) then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            SetVehicleEngineOn(vehicle, true, true)
            SetVehicleEngineHealth(vehicle, 1000.0)
            SetVehicleBodyHealth(vehicle, 1000.0)
            SetVehiclePetrolTankHealth(vehicle, 1000.0)
            SetVehicleDirtLevel(vehicle, 0.0)
            SetVehicleFuelLevel(vehicle, 100.0)
            
            for i = 0, 5 do
                SetVehicleTyreFixed(vehicle, i)
            end
            
            for i = 0, 6 do
                RollUpWindow(vehicle, i)
                RollDownWindow(vehicle, i)
            end
        end
    end
end)

RegisterNetEvent("admin:vehicleTuning")
AddEventHandler("admin:vehicleTuning", function()
end)



RegisterNUICallback("hideFrame", function(Data, Callback)
    isAdminPanelOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "setVisible", data = false })
    print("^3[FORTAL-ADMIN]^7 Painel admin fechado, NUI focus desativado")
    Callback("Ok")
end)

RegisterNUICallback("createNotification", function(data, Callback)
    TriggerServerEvent("admin:createNotification", data)
    Callback("Ok")
end)

RegisterNUICallback("deleteNotification", function(data, Callback)
    TriggerServerEvent("admin:deleteNotification", data.id)
    Callback("Ok")
end)

RegisterNUICallback("editNotification", function(data, Callback)
    TriggerServerEvent("admin:editNotification", data)
    Callback("Ok")
end)

RegisterNUICallback("getNotification", function(data, Callback)
    TriggerServerEvent("admin:getNotification", data.id)
    Callback("Ok")
end)

RegisterNUICallback("getNotifications", function(data, Callback)
    TriggerServerEvent("admin:getNotifications")
    Callback("Ok")
end)

RegisterNUICallback("getOnlinePlayers", function(data, Callback)
    TriggerServerEvent("admin:getOnlinePlayers")
    Callback("Ok")
end)

RegisterNUICallback("getServerData", function(data, Callback)
    TriggerServerEvent("admin:getServerData")
    Callback("Ok")
end)

RegisterNUICallback("createAnnouncement", function(data, Callback)
    TriggerServerEvent("admin:createAnnouncement", data)
    Callback("Ok")
end)

RegisterNUICallback("destroyAllVehicles", function(data, Callback)
    TriggerServerEvent("admin:destroyAllVehicles")
    Callback("Ok")
end)

RegisterNUICallback("fixVehicle", function(data, Callback)
    TriggerServerEvent("admin:fixVehicle")
    Callback("Ok")
end)

RegisterNUICallback("tuningVehicle", function(data, Callback)
    TriggerServerEvent("admin:tuningVehicle")
    Callback("Ok")
end)

RegisterNUICallback("teleportCDS", function(data, Callback)
    TriggerServerEvent("admin:teleportCDS", data.cds)
    Callback("Ok")
end)

RegisterNUICallback("removeWhitelist", function(data, Callback)
    TriggerServerEvent("admin:removeWhitelist", data.id)
    Callback("Ok")
end)

RegisterNUICallback("addWhitelist", function(data, Callback)
    TriggerServerEvent("admin:addWhitelist", data.id)
    Callback("Ok")
end)

RegisterNUICallback("kickPlayer", function(data, Callback)
    TriggerServerEvent("admin:kickPlayer", data.id)
    Callback("Ok")
end)

RegisterNUICallback("sendChatMessage", function(data, Callback)
    TriggerServerEvent("admin:sendChatMessage", data.message)
    Callback("Ok")
end)

RegisterNUICallback("getChatMessages", function(data, Callback)
    TriggerServerEvent("admin:getChatMessages")
    Callback("Ok")
end)

RegisterNUICallback("getUserInfo", function(data, Callback)
    TriggerServerEvent("admin:getUserInfo")
    Callback("Ok")
end)

RegisterNUICallback("revivePlayer", function(data, Callback)
    TriggerServerEvent("admin:revivePlayer", data.id)
    Callback("Ok")
end)

RegisterNUICallback("getPlayers", function(data, Callback)
    TriggerServerEvent("admin:getPlayers", data)
    Callback("Ok")
end)

RegisterNetEvent("admin:receivePlayers")
AddEventHandler("admin:receivePlayers", function(players)
    SendNUIMessage({ action = "receivePlayers", data = players })
end)

RegisterNUICallback("getPlayerDetails", function(Data, Callback)
    TriggerServerEvent("admin:getPlayerDetails", Data)
    Callback("Ok")
end)

RegisterNetEvent("admin:receivePlayerDetails")
AddEventHandler("admin:receivePlayerDetails", function(playerData)
    SendNUIMessage({ action = "receivePlayerDetails", data = playerData })
end)

RegisterNUICallback("getServerItems", function(data, Callback)
    TriggerServerEvent("admin:getServerItems")
    Callback("Ok")
end)

RegisterNUICallback("takeItem", function(data, Callback)
    
    if data.item and data.quantity then
        TriggerServerEvent("admin:takeItem", data.item, data.quantity)
    else
    end
    
    Callback("Ok")
end)

RegisterNUICallback("getServerVehicles", function(data, Callback)
    TriggerServerEvent("admin:getServerVehicles", data.page, data.limit, data.searchTerm, data.category)
    Callback("Ok")
end)

RegisterNUICallback("spawnVehicle", function(data, Callback)
    TriggerServerEvent("admin:spawnVehicle", data.vehicle.spawn)
    isAdminPanelOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "setVisible", data = false })
    Callback("Ok")
end)

RegisterNUICallback("addVehicleToUser", function(data, Callback)
    TriggerServerEvent("admin:addVehicleToUser", data.vehicle.spawn, data.userId, data.duration)
    Callback("Ok")
end)

RegisterNUICallback("removeVehicleFromUser", function(data, Callback)
    TriggerServerEvent("admin:removeVehicleFromUser", data.vehicle.spawn, data.vehicle.plate, data.userId)
    Callback("Ok")
end)

RegisterNetEvent("admin:receiveServerItems")
AddEventHandler("admin:receiveServerItems", function(items)
    SendNUIMessage({ action = "receiveServerItems", data = items })
end)

RegisterNetEvent("admin:receiveItemsError")
AddEventHandler("admin:receiveItemsError", function(errorMessage)
    SendNUIMessage({ action = "receiveItemsError", data = errorMessage })
end)

RegisterNetEvent("admin:receiveServerVehicles")
AddEventHandler("admin:receiveServerVehicles", function(vehicles)
    SendNUIMessage({ action = "receiveServerVehicles", data = vehicles })
end)

RegisterNetEvent("admin:receiveVehiclesError")
AddEventHandler("admin:receiveVehiclesError", function(errorMessage)
    SendNUIMessage({ action = "receiveVehiclesError", data = errorMessage })
end)

-- Callback NUI para teleportar para jogador
RegisterNUICallback("teleportPlayer", function(data, Callback)
    print("^3[TELEPORT]^7 Frontend solicitou teleporte para jogador: " .. tostring(data.playerId))
    TriggerServerEvent("admin:teleportToPlayer", data.playerId)
    Callback("Ok")
end)

-- Callback NUI para puxar jogador até admin
RegisterNUICallback("pullPlayer", function(data, Callback)
    print("^3[PULL]^7 Frontend solicitou puxar jogador: " .. tostring(data.playerId))
    TriggerServerEvent("admin:pullPlayer", data.playerId)
    Callback("Ok")
end)

-- Callback NUI para corrigir veículo do jogador
RegisterNUICallback("fixPlayerVehicle", function(data, Callback)
    print("^3[FIX-VEHICLE]^7 Frontend solicitou corrigir veículo do jogador: " .. tostring(data.playerId))
    TriggerServerEvent("admin:fixPlayerVehicle", data.playerId)
    Callback("Ok")
end)

-- Callback NUI para expulsar jogador
RegisterNUICallback("kickPlayer", function(data, Callback)
    print("^3[KICK]^7 Frontend solicitou expulsar jogador: " .. tostring(data.playerId))
    TriggerServerEvent("admin:kickPlayer", data.playerId)
    Callback("Ok")
end)

-- Evento para definir vida do jogador
RegisterNetEvent("admin:setPlayerHealth")
AddEventHandler("admin:setPlayerHealth", function(health)
    local ped = GetPlayerPed(PlayerId())
    SetEntityHealth(ped, health)
end)

-- Evento para definir vida de entidade (usado pelo servidor)
RegisterNetEvent("admin:setEntityHealth")
AddEventHandler("admin:setEntityHealth", function(health)
    local ped = GetPlayerPed(PlayerId())
    SetEntityHealth(ped, health)
    print("^2[CLIENT]^7 Vida definida para: " .. health)
end)

-- Evento para definir colete de entidade (usado pelo servidor)
RegisterNetEvent("admin:setEntityArmour")
AddEventHandler("admin:setEntityArmour", function(armour)
    local ped = GetPlayerPed(PlayerId())
    SetPedArmour(ped, armour)
    print("^2[CLIENT]^7 Colete definido para: " .. armour)
end)

RegisterNetEvent("admin:receiveServerOrganizations")
AddEventHandler("admin:receiveServerOrganizations", function(organizations)
    print("^2[ORGANIZATIONS]^7 Recebendo " .. #organizations .. " organizações do servidor")
    SendNUIMessage({ action = "receiveServerOrganizations", data = organizations })
end)

RegisterNetEvent("admin:receiveOrganizationMembers")
AddEventHandler("admin:receiveOrganizationMembers", function(groupName, members)
    SendNUIMessage({ action = "receiveOrganizationMembers", data = { groupName = groupName, members = members } })
end)

RegisterNetEvent("admin:receiveOrganizationsError")
AddEventHandler("admin:receiveOrganizationsError", function(errorMessage)
    SendNUIMessage({ action = "receiveOrganizationsError", data = errorMessage })
end)

RegisterNUICallback("getServerOrganizations", function(data, Callback)
    print("^3[ORGANIZATIONS]^7 Frontend solicitou organizações do servidor")
    TriggerServerEvent("admin:getServerOrganizations")
    Callback("Ok")
    print("^2[ORGANIZATIONS]^7 Callback enviado para o frontend")
end)

RegisterNUICallback("getOrganizationMembers", function(data, Callback)
    print("^3[ORGANIZATIONS]^7 Frontend solicitou membros da organização: " .. tostring(data.groupName))
    TriggerServerEvent("admin:getOrganizationMembers", data.groupName)
    Callback("Ok")
end)

RegisterNUICallback("armorPlayer", function(data, Callback)
    print("^3[ARMOR]^7 Frontend solicitou dar colete para jogador: " .. tostring(data.playerId))
    TriggerServerEvent("admin:armorPlayer", data.playerId)
    Callback("Ok")
end)

RegisterNUICallback("killPlayer", function(data, Callback)
    print("^3[KILL]^7 Frontend solicitou matar jogador: " .. tostring(data.playerId))
    TriggerServerEvent("admin:killPlayer", data.playerId)
    Callback("Ok")
end)

RegisterNUICallback("godPlayer", function(data, Callback)
    print("^3[GOD]^7 Frontend solicitou dar god mode para jogador: " .. tostring(data.playerId))
    TriggerServerEvent("admin:godPlayer", data.playerId)
    Callback("Ok")
end)

RegisterNUICallback("getServerStaff", function(data, Callback)
    TriggerServerEvent("admin:getServerStaff")
    Callback("Ok")
end)

RegisterNUICallback("promoteStaff", function(data, Callback)
    TriggerServerEvent("admin:promoteStaff", data.targetUserId, data.currentGroup, data.newGroup)
    Callback("Ok")
end)

RegisterNUICallback("removeStaff", function(data, Callback)
    TriggerServerEvent("admin:removeStaff", data.targetUserId, data.currentGroup)
    Callback("Ok")
end)

RegisterNetEvent("admin:receiveServerStaff")
AddEventHandler("admin:receiveServerStaff", function(staffMembers)
    SendNUIMessage({ action = "receiveServerStaff", data = staffMembers })
end)

RegisterNetEvent("admin:receiveStaffError")
AddEventHandler("admin:receiveStaffError", function(errorMessage)
    SendNUIMessage({ action = "receiveStaffError", data = errorMessage })
end)

-- Callbacks para sistema de salários
RegisterNUICallback("addNewSalary", function(data, Callback)
    print("^3[FORTAL-ADMIN]^7 Callback addNewSalary recebido:", json.encode(data))
    print("^3[FORTAL-ADMIN]^7 NUI focus ativo:", isAdminPanelOpen)
    TriggerServerEvent("admin:addNewSalary", data.name, data.group, data.amount)
    Callback("Ok")
end)

RegisterNUICallback("removeSalary", function(data, Callback)
    TriggerServerEvent("admin:removeSalary", data.name)
    Callback("Ok")
end)

RegisterNUICallback("updateSalary", function(data, Callback)
    TriggerServerEvent("admin:updateSalary", data.group, data.amount)
    Callback("Ok")
end)

RegisterNUICallback("getSalaries", function(data, Callback)
    TriggerServerEvent("admin:getSalaries")
    Callback("Ok")
end)

RegisterNetEvent("admin:receiveSalaries")
AddEventHandler("admin:receiveSalaries", function(salaries)
    SendNUIMessage({ action = "receiveSalaries", data = salaries })
end)