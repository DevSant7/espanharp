
local duiObj = nil
local duiHandle = nil
local txd = nil
local txn = nil
local duiCoords = nil
local duiData = {
    show = true,
    distance = 0,
    laps = 1,
    MaxLaps = 5
}


local function createCheckpointDUI(text, coords)
    if duiObj then
        DestroyDui(duiObj)
        duiObj = nil
        duiHandle = nil
        txd = nil
        txn = nil
    end

    local resourceName = GetCurrentResourceName()
    local duiURL = "nui://" .. resourceName .. "/web-side/build/index.html"
    
    duiObj = CreateDui(duiURL, 1280, 720)
    duiHandle = GetDuiHandle(duiObj)
    
    if not duiHandle then
        return false
    end
    
    txd = CreateRuntimeTxd('raceDuiTxd')
    txn = CreateRuntimeTextureFromDuiHandle(txd, 'raceDuiTxn', duiHandle)
    
    Wait(100)
    
    if not txn then
        return false
    end
    
    duiCoords = vector3(coords[1], coords[2], coords[3])

    SendDuiMessage(duiObj, json.encode(duiData))
    
    return true
end


local function destroyCheckpointDUI()
    if duiObj then
        DestroyDui(duiObj)
        duiObj = nil
        duiHandle = nil
        txd = nil
        txn = nil
        duiCoords = nil
        duiData = {
            show = true,
            distance = 0,
            laps = 1,
            MaxLaps = 5
        }
    end
end

Citizen.CreateThread(function()
    while true do
        if duiCoords and duiObj and txn then
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)
            local distance = #(playerPos - duiCoords)

            duiData.distance = math.floor(distance)
            SendDuiMessage(duiObj, json.encode(duiData))
            
            local onScreen, _x, _y = GetScreenCoordFromWorldCoord(duiCoords.x, duiCoords.y, duiCoords.z)
            
            if onScreen and distance < 200.0 then
                local scale = math.max(0.2, math.min(0.6, 0.8 / (distance / 25)))
                
                DrawSprite('raceDuiTxd', 'raceDuiTxn', _x, _y, scale, scale, 0.0, 255, 255, 255, 255)
            end
        end
        Wait(0)
    end
end)

-- EXPORTS PARA USO EXTERNO
exports('createDUI', function(text, coords)
    return createCheckpointDUI(text, coords)
end)

exports('destroyDUI', function()
    destroyCheckpointDUI()
end)

exports('getDUICoords', function()
    return duiCoords
end)

exports('isDUIActive', function()
    return duiObj ~= nil
end)

exports('updateDUIMessage', function(data)
    if duiObj then
        if data.laps then duiData.laps = data.laps end
        if data.MaxLaps then duiData.MaxLaps = data.MaxLaps end
        if data.show ~= nil then duiData.show = data.show end
        
        SendDuiMessage(duiObj, json.encode(duiData))
    end
end)

exports('showUI', function(visible, data)
    SetNuiFocus(false, false)
    
    if visible and duiObj then
        SendDuiMessage(duiObj, json.encode(data or {show = true}))
    elseif duiObj then
        SendDuiMessage(duiObj, json.encode({show = false}))
    end
end)

RegisterNuiCallbackType('hideUI')
RegisterNUICallback('hideUI', function(data, cb)
    exports['race-dui']:showUI(false)
    cb({})
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        SetNuiFocus(false, false)
    end
end)
