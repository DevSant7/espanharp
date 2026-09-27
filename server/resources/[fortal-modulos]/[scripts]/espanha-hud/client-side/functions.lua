local assault = false

function getSeatbealt(bealt)
    local veh = GetClosestVehicleFromPlayer(5.0)
    if GetVehicleClass(veh) ~= 8 then
        if bealt then
            TriggerEvent("sounds:Private", "belt", 0.5)
            if hudConfig['setMiniMapBelt'] then
                DisplayRadar(true)
            end
        else
            TriggerEvent("sounds:Private", "unbelt", 0.5)
            if hudConfig['setMiniMapBelt'] then
                DisplayRadar(false)
            end
        end
    end
end

function setHudNitro(nitro)
    SendNUIMessage({ action = 'hud:setData', data = { nitro = nitro } })
end

exports('setHudNitro', setHudNitro)

local ASSAULT_NORTH_MIN_Y = 1500

local function isInAssaultNorthRegion()
    return GetEntityCoords(PlayerPedId()).y >= ASSAULT_NORTH_MIN_Y
end

function GetHoursTime()
    local horas = tonumber(GlobalState.Hours) or tonumber(GlobalState["Hours"])
    if horas == nil then
        if assault then
            assault = false
            TriggerEvent('hud:setRobbery', false)
        end
        return false
    end

    local inWindow = horas >= 22 or horas < 7
    local active = inWindow and isInAssaultNorthRegion()

    if active then
        if not assault then
            assault = true
            TriggerEvent('chat:ClientMessage', 'global', "[22:00] Início de assaltos no Norte... cuidado.", 'Prefeitura', true)
            TriggerEvent('hud:setRobbery', 'Assalto!')
        end
    else
        if assault then
            assault = false
            TriggerEvent('chat:ClientMessage', 'global', "[07:00] Fim de assaltos no Norte... Ruas pacificadas!", 'Prefeitura', true)
            TriggerEvent('hud:setRobbery', false)
        end
    end

    return active
end

RegisterKeyMapping("setBelt", "Cinto", "keyboard", "g")

RegisterNUICallback('get:logo', function(data, cb)
    local logoUrl = hudConfig['logoUrl'] or "https://guardianstore.com.br/images/logo.png"
    cb(logoUrl)
end)