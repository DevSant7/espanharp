local display = false
local playerIds = {}

RegisterNetEvent("wall:toggle")
AddEventHandler("wall:toggle", function()
    display = not display
    if display then
        TriggerServerEvent("wall:requestIds")
        Notify("~g~Wall HUD ativado")
    else
        Notify("~r~Wall HUD desativado")
    end
end)

RegisterNetEvent("wall:receiveIds")
AddEventHandler("wall:receiveIds", function(data)
    playerIds = data
end)

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function DrawRichText3D(x, y, z, lines)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if not onScreen then return end

    local lineHeight = 0.015
    for i, lineData in ipairs(lines) do
        local text, r, g, b = table.unpack(lineData)

        SetTextScale(0.36, 0.36)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(1, 1, 1, 1, 255)
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y + (i - 1) * lineHeight)
    end
end

function GetWeaponNameFromHash(hash)
    local weapons = {
        [GetHashKey("WEAPON_PISTOL")] = "Pistola",
        [GetHashKey("WEAPON_COMBATPISTOL")] = "P. Combate",
        [GetHashKey("WEAPON_SMG")] = "SMG",
        [GetHashKey("WEAPON_ASSAULTRIFLE")] = "Fuzil",
        [GetHashKey("WEAPON_CARBINERIFLE")] = "Carabina",
        [GetHashKey("WEAPON_MICROSMG")] = "Micro SMG",
        [GetHashKey("WEAPON_KNIFE")] = "Faca",
        [GetHashKey("WEAPON_UNARMED")] = "Nenhuma"
    }
    return weapons[hash] or "Desconhecida"
end

-- Loop principal
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if display then
            local myPed = PlayerPedId()
            local myCoords = GetEntityCoords(myPed)
            local players = GetActivePlayers()

            for _, player in pairs(players) do
                if player ~= PlayerId() then
                    local targetPed = GetPlayerPed(player)
                    if DoesEntityExist(targetPed) and IsEntityOnScreen(targetPed) then
                        local coords = GetEntityCoords(targetPed)
                        local dist = #(myCoords - coords)

                        if dist < 1000.0 then
                            local health = math.max(0, GetEntityHealth(targetPed) - 100)
                            local armor = GetPedArmour(targetPed)
                            local weaponHash = GetSelectedPedWeapon(targetPed)
                            local weaponName = GetWeaponNameFromHash(weaponHash)
                            local nome = GetPlayerName(player)
                            local serverId = GetPlayerServerId(player)
                            local user_id = playerIds[serverId] or "??"

                            local hudLines = {
                                {string.format("[%s] Nome: %s", user_id, nome), 255, 255, 255},
                                {string.format("Vida: ~g~%d%%~s~ | Colete: ~b~%d%%~s~", health, armor), 255, 255, 255},
                                {string.format("Arma: %s", weaponName), 255, 255, 255}
                            }

                          
                            DrawRichText3D(coords.x, coords.y, coords.z + 0.3, hudLines)

                            DrawLine(myCoords.x, myCoords.y, myCoords.z, coords.x, coords.y, coords.z + 0.3,255, 0, 0, 200)
                        end
                    end
                end
            end
        end
    end
end)
