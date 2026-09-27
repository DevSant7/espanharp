-- =====================================================
-- HUD System Otimizado - FiveM
-- =====================================================
-- Dependências
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("hud")
vRPserver = Tunnel.getInterface("vRP")

local ActiveFormulary = nil

local function ResolveFormulary(response)
    local request = ActiveFormulary
    if not request then return end

    ActiveFormulary = nil
    request.response = response
    request.done = true
end

local DS = {}
Tunnel.bindInterface("hud", DS)

-- Estados do jogador
local PlayerState = {
    user_id = 0,
    hunger = hudConfig['hungerValue'] or 0,
    thirst = hudConfig['thirstValue'] or 0,
    gems = 0,
    showHud = true,
    isActive = false,
    inVehicle = false,
    seatbelt = false,
    isMotorcycle = false,
    toggleCapuz = false,
    hideMap = GetResourceKvpInt('hud:hideMap') == 1
}

local HudLocks = {}

local function IsHudLocked()
    return next(HudLocks) ~= nil
end

hunger = 100
thirst = 100

local function syncNeedsVariables()
    hunger = PlayerState.hunger
    thirst = PlayerState.thirst
end

local VehicleState = {
    nitro = 0,
    nitroFuel = 0,
    lastVehicle = nil,
    handbrake = 0,
    seatbeltSpeed = 0,
    seatbeltVelocity = vec3(0, 0, 0)
}

local CommState = {
    radioPlayers = {},
    talking = 2,
    frequency = 0,
    isSpeaking = false
}

local Cache = {
    ped = nil,
    vehicle = nil,
    coords = nil,
    lastUpdate = 0,
    updateInterval = 500
}

local RadioFrequency = {
    cachedData = {},
    talking = {}
}

local CONSTANTS = {
    UPDATE_INTERVALS = {
        MAIN_HUD = 500,
        VEHICLE_DAMAGE = 100,
        SEATBELT = 50,
        NEEDS_DAMAGE = 5000
    },
    SEATBELT_EJECT_SPEED = 60,
    DAMAGE_THRESHOLDS = {
        LOW = { min = 3, max = 5, damage = 1 },
        HIGH = { min = 0, max = 2, damage = 2 }
    }
}

local function pushHudDiff(cache, data)
    local diff, has = {}, false
    for k, v in pairs(data) do
        if cache[k] ~= v then
            cache[k] = v
            diff[k] = v
            has = true
        end
    end
    if has then
        SendNUIMessage({ action = 'set:hud', data = diff })
    end
end

local function armorySignature(w)
    if not w.active then return "0" end
    return "1|" .. tostring(w.index) .. "|" .. tostring(w.wammo) .. "|" .. tostring(w.reload) .. "|" .. tostring(w.isWeapon)
end

local hudCache = {}
local vehCache = {}
local lastArmorySig = nil
local radarShown = false
local lastSentStreet = nil

local function GetCachedPed()
    local currentTime = GetGameTimer()
    if not Cache.ped or currentTime - Cache.lastUpdate > 100 then
        Cache.ped = PlayerPedId()
        Cache.lastUpdate = currentTime
    end
    return Cache.ped
end

local function UpdateRadarVisibility()
    local ped = GetCachedPed()
    local inVehicle = IsPedInAnyVehicle(ped, false)

    local isCreatingCharacter = LocalPlayer.state.onCreate or
                               LocalPlayer.state.editChar or
                               LocalPlayer.state.onSpawnSelect

    if isCreatingCharacter then
        DisplayRadar(false)
        radarShown = false
        return
    end

    if not PlayerState.showHud or IsHudLocked() then
        DisplayRadar(false)
        radarShown = false
        return
    end

    if PlayerState.hideMap then
        DisplayRadar(false)
        radarShown = false
        return
    end

    local shouldShowRadar = inVehicle or hudConfig.pinTheMinimap
    DisplayRadar(shouldShowRadar)

    if shouldShowRadar and not radarShown then
        SendNUIMessage({
            action = "refetch:minimapDimensions",
            data = {}
        })
    end
    radarShown = shouldShowRadar
end

local function ApplyHudVisibility()
    local visible = PlayerState.showHud == true and not IsHudLocked()
    HudVisible = visible
    SendNUIMessage({ action = 'set:visible', data = visible })
    UpdateRadarVisibility()
end

function GetMinimapPosition()
    local minimap = {}
    local resX, resY = GetActiveScreenResolution()
    local aspectRatio = GetAspectRatio()
    local scaleX = 1/resX
    local scaleY = 1/resY
    local minimapRawX, minimapRawY
    SetScriptGfxAlign(string.byte('L'), string.byte('B'))
    if IsBigmapActive() then
        minimapRawX, minimapRawY = GetScriptGfxPosition(-0.003975, 0.022 + (-0.460416666))
        minimap.width = scaleX*(resX/(2.52*aspectRatio))
        minimap.height = scaleY*(resY/(2.3374))
    else
        minimapRawX, minimapRawY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
        minimap.width = scaleX*(resX/(4*aspectRatio))
        minimap.height = scaleY*(resY/(5.674))
    end
    ResetScriptGfxAlign()
    minimap.leftX = minimapRawX
    minimap.rightX = minimapRawX+minimap.width
    minimap.topY = minimapRawY
    minimap.bottomY = minimapRawY+minimap.height
    minimap.X = minimapRawX+(minimap.width/2)
    minimap.Y = minimapRawY+(minimap.height/2)

    for k in pairs(minimap) do
        minimap[k] = minimap[k] * 100
    end

    return minimap
end

local function EjectFromVehicle(velocity)
    TriggerEvent("ragdoll", true)

    local ped = GetCachedPed()
    local vehicle = GetVehiclePedIsIn(ped, false)

    SetEntityNoCollisionEntity(ped, vehicle, false)
    SetEntityNoCollisionEntity(vehicle, ped, false)

    TriggerServerEvent("hud:VehicleEject", velocity)

    Wait(500)

    SetEntityNoCollisionEntity(ped, vehicle, true)
    SetEntityNoCollisionEntity(vehicle, ped, true)
end

-- =====================================================
-- EVENTOS DE STATUS
-- =====================================================

RegisterNetEvent("hud:Hunger", function(number)
    PlayerState.hunger = math.min(parseInt(number) or 0, 100)
    syncNeedsVariables()
end)

RegisterNetEvent("hud:Thirst", function(number)
    PlayerState.thirst = math.min(parseInt(number) or 0, 100)
    syncNeedsVariables()
end)

RegisterNetEvent("hud:setUserId", function(number)
    PlayerState.user_id = tonumber(number) or 0
    SendNUIMessage({
        action = 'set:hud',
        data = { user_id = PlayerState.user_id }
    })
end)

AddStateBagChangeHandler("Passport", ("player:%s"):format(LocalPlayer.state.Player), function(_, _, value)
    PlayerState.user_id = value
end)

RegisterNetEvent("hud:updateGems", function(number)
    PlayerState.gems = number
    SendNUIMessage({
        action = 'set:hud',
        data = { gems = PlayerState.gems }
    })
end)

RegisterNetEvent("hud:AddGemstone", function(number)
    PlayerState.gems = (PlayerState.gems or 0) + (parseInt(number) or 0)
    SendNUIMessage({
        action = 'set:hud',
        data = { gems = PlayerState.gems }
    })
end)

RegisterNetEvent("hud:RemoveGemstone", function(number)
    PlayerState.gems = math.max((PlayerState.gems or 0) - (parseInt(number) or 0), 0)
    SendNUIMessage({
        action = 'set:hud',
        data = { gems = PlayerState.gems }
    })
end)

-- =====================================================
-- CALLBACKS NUI
-- =====================================================

local FORMULARY_MAX_FIELDS = 24
local FORMULARY_MAX_KEY = 64
local FORMULARY_MAX_VALUE = 4096

local function sanitizeFormularyResponse(payload)
    if type(payload) ~= 'table' or type(payload.data) ~= 'table' then
        return { data = {} }
    end

    local sanitized = {}
    local fields = 0

    for key, value in pairs(payload.data) do
        if fields >= FORMULARY_MAX_FIELDS then break end

        if type(key) == 'string' and type(value) == 'string' then
            sanitized[string.sub(key, 1, FORMULARY_MAX_KEY)] = string.sub(value, 1, FORMULARY_MAX_VALUE)
            fields = fields + 1
        end
    end

    return { data = sanitized }
end

RegisterNUICallback('formularyResponse', function(data, cb)
    SetNuiFocus(false, false)
    ResolveFormulary(sanitizeFormularyResponse(data))
    return cb('Ok')
end)

RegisterNUICallback('fetch:binds', function(data, cb)
    local items = vSERVER.fetchBinds()
    cb(items)
end)

RegisterNUICallback('fetchHudLogo', function(_, cb)
    cb(hudConfig.logoUrl)
end)

RegisterNUICallback('getCityName', function(_, cb)
    cb("AMERICA")
end)

RegisterNUICallback('remove:focus', function(_, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('fetchMapPosition', function(_, cb)
    cb(GetMinimapPosition())
end)

RegisterNUICallback('get:hidemap', function(_, cb)
    cb(PlayerState.hideMap)
end)

RegisterNUICallback('post:toggleHidemap', function(_, cb)
    PlayerState.hideMap = not PlayerState.hideMap
    SetResourceKvpInt('hud:hideMap', PlayerState.hideMap and 1 or 0)
    UpdateRadarVisibility()
    cb(true)
end)

RegisterNuiCallback('formularyClosed', function(_, cb)
    SetNuiFocus(false, false)
    ResolveFormulary(false)
    cb({})
end)

RegisterNUICallback("get:colors", function (data, cb)
    cb({
        ["--primaryColor"]   = "#F50C0C",
        ["--secondaryColor"] = "#DB0B0B",
        ["--thirdyColor"]    = "#DB0B0B",
    })
end)

-- =====================================================
-- SISTEMA DE VEÍCULOS
-- =====================================================

AddEventHandler("gameEventTriggered", function(eventName, args)
    if eventName ~= "CEventNetworkPlayerEnteredVehicle" then return end
    if args[1] ~= NetworkGetPlayerIndexFromPed(PlayerPedId()) then return end

    PlayerState.inVehicle = true
    PlayerState.seatbelt = false
    UpdateRadarVisibility()

    -- Zera SEMPRE o estado do cinto ao entrar em QUALQUER veículo novo.
    -- Sem isso, a velocidade do veículo ANTERIOR vira o "baseline" e a HUD
    -- ejeta o jogador do carro recém-spawnado por uma garagem (black-garages,
    -- vrp_garages, etc.).
    VehicleState.seatbeltSpeed = 0
    VehicleState.seatbeltVelocity = vec3(0, 0, 0)

    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if currentVehicle and currentVehicle ~= 0 then
        VehicleState.seatbeltSpeed = GetEntitySpeed(currentVehicle) * 2.236936
        VehicleState.seatbeltVelocity = GetEntityVelocity(currentVehicle)
    end

    CreateThread(function()
        local ped = GetCachedPed()
        vehCache = {}

        while PlayerState.inVehicle and IsPedInAnyVehicle(ped, false) do
            local vehicle = GetVehiclePedIsIn(ped, false)
            if not vehicle or vehicle == 0 then break end

            PlayerState.isMotorcycle = GetVehicleClass(vehicle) == 8
            if PlayerState.isMotorcycle then
                DisplayRadar(true)
            end

            local vehicleData = {
                speed = hudConfig.getSpeedVehicle(vehicle),
                fuel = GetVehicleFuelLevel(vehicle),
                engine = GetVehicleEngineHealth(vehicle) / 10,
                rpm = GetVehicleCurrentRpm(vehicle),
                gear = GetVehicleCurrentGear(vehicle),
                vehicleOn = GetIsVehicleEngineRunning(vehicle),
                plate = GetVehicleNumberPlateText(vehicle)
            }

            if (vehicleData.speed == 0 and vehicleData.gear == 0) or
               (vehicleData.speed == 0 and vehicleData.gear == 1) then
                vehicleData.gear = "N"
            elseif vehicleData.speed > 0 and vehicleData.gear == 0 then
                vehicleData.gear = "R"
            end

            local _, light, fullLight = GetVehicleLightsState(vehicle)
            local lightOn = light == 1 or fullLight == 1
            local highLight = fullLight == 1

            if LocalPlayer.state.Nitro then
                VehicleState.nitro = VehicleState.nitroFuel
            else
                VehicleState.nitro = GlobalState["Nitro:" .. vehicleData.plate] or VehicleState.nitroFuel
            end

            local nitroHud = VehicleState.nitro > 0 and parseInt((VehicleState.nitro * 100) / 2000) or 0

            pushHudDiff(vehCache, {
                isDriving = true,
                RPM = math.min(vehicleData.rpm, 1.0),
                speed = vehicleData.speed,
                nitro = nitroHud,
                gear = vehicleData.gear,
                engine = vehicleData.engine,
                gas = vehicleData.fuel,
                light = lightOn,
                highLight = highLight,
                lock = GetVehicleDoorLockStatus(vehicle) == 2,
                seatbelt = PlayerState.seatbelt,
                isMotorcycle = PlayerState.isMotorcycle,
                ignition = vehicleData.vehicleOn,
                headlight = lightOn
            })

            Wait(150)
        end

        PlayerState.inVehicle = false
        PlayerState.seatbelt = false

        if not hudConfig.pinTheMinimap then
            DisplayRadar(false)
        end

        SendNUIMessage({
            action = 'set:hud',
            data = {
                isDriving = false,
                speed = 0,
                engine = 0,
                gas = 0,
                nitro = 0,
                light = false,
                lock = false,
                seatbelt = false,
                isMotorcycle = false,
            }
        })
    end)

    -- Thread de cinto (com blindagem contra garagem)
    CreateThread(function()
        local enterCooldown = true
        Wait(3000)                -- era 1500; garagens demoram pra registrar o veículo
        enterCooldown = false

        local ped = GetCachedPed()
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle and vehicle ~= 0 then
            VehicleState.seatbeltSpeed = GetEntitySpeed(vehicle) * 2.236936
            VehicleState.seatbeltVelocity = GetEntityVelocity(vehicle)
        end

        while PlayerState.inVehicle do
            ped = GetCachedPed()
            vehicle = GetVehiclePedIsIn(ped, false)

            local isEnteringOrExiting = GetIsTaskActive(ped, 160) or
                                        GetIsTaskActive(ped, 161) or
                                        GetIsTaskActive(ped, 167) or
                                        not IsPedInAnyVehicle(ped, false)

            local isSpawningVehicle = vehicle and vehicle ~= 0 and
                                      (not DoesEntityExist(vehicle) or
                                       GetEntitySpeed(vehicle) < 0.1 and
                                       not GetIsVehicleEngineRunning(vehicle))

            if vehicle and vehicle ~= 0
               and not IsPedOnAnyBike(ped)
               and not IsPedInAnyHeli(ped)
               and not IsPedInAnyPlane(ped)
               and not IsPedInAnyBoat(ped)
               and not isEnteringOrExiting
               and not isSpawningVehicle
               and not enterCooldown then

                local speed = GetEntitySpeed(vehicle) * 2.236936

                if speed ~= VehicleState.seatbeltSpeed then
                    if (VehicleState.seatbeltSpeed - speed) >= CONSTANTS.SEATBELT_EJECT_SPEED
                       and not PlayerState.seatbelt
                       and not LocalPlayer.state.SafeZone
                       and not LocalPlayer.state.inRacing
                       and not LocalPlayer.state.inEvent
                       and not LocalPlayer.state.inGarage then
                        EjectFromVehicle(VehicleState.seatbeltVelocity)
                    end

                    VehicleState.seatbeltVelocity = GetEntityVelocity(vehicle)
                    VehicleState.seatbeltSpeed = speed
                end
            end

            Wait(CONSTANTS.UPDATE_INTERVALS.SEATBELT)
        end
    end)
end)

local actualStreetName = nil
local pauseBreak = false

-- =====================================================
-- LOOP PRINCIPAL
-- =====================================================

CreateThread(function()
    while not LocalPlayer.state.Active do
        SendNUIMessage({ action = 'set:visible', data = false })
        DisplayRadar(false)
        Wait(100)
    end

    LoadPtfxAsset("veh_xs_vehicle_mods")
    RegisterKeyMapping("+shortcuts", "Visualizar atalhos.", "keyboard", "TAB")

    Wait(1000)

    while LocalPlayer.state.onCreate or LocalPlayer.state.editChar or LocalPlayer.state.onSpawnSelect do
        SendNUIMessage({ action = 'set:visible', data = false })
        DisplayRadar(false)
        Wait(500)
    end

    PlayerState.showHud = true
    HudVisible = true
    SendNUIMessage({ action = 'set:visible', data = true })

    -- Inicialização completa do HUD (garante que todos os campos apareçam
    -- no primeiro frame da NUI: vida, colete, fome, sede, stamina, passaporte,
    -- rádio, gemas, FPS, etc.)
    SendNUIMessage({
        action = 'set:hud',
        data = {
            isDriving  = false,
            isSpeaking = false,
            zone       = false,
            radio      = CommState.frequency or 0,
            voip_level = CommState.talking or 2,
            life       = 100,
            shield     = 0,
            stamina    = 100,
            thirst     = PlayerState.thirst,
            hunger     = PlayerState.hunger,
            gems       = PlayerState.gems,
            user_id    = PlayerState.user_id,
            time       = "00:00",
            street     = "",
            city       = "Norte",
            assault    = false,
            fps        = 0,
            showFps    = false,
            armory     = { active = false, index = "false", wammo = 0, reload = 0, isWeapon = false },
            baseUrl    = {
                items  = hudConfig.itemsUrl,
                armory = hudConfig.armoryUrl
            }
        }
    })

    while true do
        local idle = 5000

        local isCreatingCharacter = LocalPlayer.state.onCreate or
                                   LocalPlayer.state.editChar or
                                   LocalPlayer.state.onSpawnSelect

        if isCreatingCharacter then
            idle = 1000
            PlayerState.isActive = false
            SendNUIMessage({ action = 'set:visible', data = false })
            DisplayRadar(false)
        elseif LocalPlayer.state.Active and PlayerState.showHud and not IsHudLocked() then
            if not PlayerState.isActive then
                PlayerState.isActive = true
                hudCache = {}
                lastArmorySig = nil
                SendNUIMessage({ action = 'set:visible', data = true })
                SendNUIMessage({
                    action = 'set:hud',
                    data = {
                        baseUrl = {
                            items  = hudConfig.itemsUrl,
                            armory = hudConfig.armoryUrl
                        }
                    }
                })
            end
            idle = CONSTANTS.UPDATE_INTERVALS.MAIN_HUD

            local ped = GetCachedPed()
            local player = PlayerId()

            local playerData = {
                life = math.max(hudConfig.getLifeCalculate(ped), 0),
                stamina = hudConfig.getPlayerStamina(player),
                armour = hudConfig.getPedArmour(ped),
                coords = GetEntityCoords(ped),
                isArmed = IsPedArmed(ped, 6) or IsPedArmed(ped, 1),
                isSpeaking = NetworkIsPlayerTalking(player)
            }

            local streetHash = GetStreetNameAtCoord(playerData.coords.x, playerData.coords.y, playerData.coords.z)
            local streetName = GetStreetNameFromHashKey(streetHash)

            if hudConfig.modifyStreetNames and hudConfig.modifyStreets[streetName] then
                streetName = hudConfig.modifyStreets[streetName]
            end

            actualStreetName = streetName

            local hours, minutes = tonumber(GlobalState.Hours) or 0, tonumber(GlobalState.Minutes) or 0
            local timeString = string.format("%02d:%02d", hours, minutes)

            local weaponData = {}
            if playerData.isArmed then
                idle = 200
                local weapon = GetSelectedPedWeapon(ped)
                local totalAmmo = GetAmmoInPedWeapon(ped, weapon)
                local _, clipAmmo = GetAmmoInClip(ped, weapon)

                local weaponName = Weapons[weapon]
                if not weaponName then
                    if GetResourceState('europa_skins') == 'started' then
                        weaponName = exports.europa_skins:getWeaponBySkin(weapon) or "Arma Desconhecida"
                    else
                        weaponName = "Arma Desconhecida"
                    end
                end

                weaponData = {
                    active = true,
                    index = tostring(itemIndex(weaponName)),
                    isWeapon = not IsPedArmed(ped, 1),
                    wammo = clipAmmo,
                    reload = totalAmmo - clipAmmo
                }
            else
                weaponData.active = false
            end

            pushHudDiff(hudCache, {
                life = playerData.life,
                shield = playerData.armour,
                stamina = playerData.stamina,
                thirst = PlayerState.thirst,
                hunger = PlayerState.hunger,
                assault = GetHoursTime() or false,
                street = streetName,
                isSpeaking = playerData.isSpeaking,
                time = timeString,
                user_id = PlayerState.user_id,
                gems = PlayerState.gems,
                city = 'Norte',
            })

            local armorySig = armorySignature(weaponData)
            if armorySig ~= lastArmorySig then
                lastArmorySig = armorySig
                SendNUIMessage({ action = 'set:hud', data = { armory = weaponData } })
            end
        end

        UpdateRadarVisibility()
        SetBigmapActive(false, false)

        Wait(idle)
    end
end)

CreateThread(function()
    while true do
        if actualStreetName and actualStreetName ~= lastSentStreet then
            lastSentStreet = actualStreetName
            TriggerServerEvent('updatePlayerStreet', actualStreetName)
        end

        if IsPauseMenuActive() then
            if not pauseBreak then
                SendNUIMessage({ action = 'set:visible', data = false })
                pauseBreak = true
            end
        elseif pauseBreak and PlayerState.showHud and not IsHudLocked() then
            SendNUIMessage({ action = 'set:visible', data = true })
            pauseBreak = false
        end

        Wait(5000)
    end
end)

-- =====================================================
-- COMUNICAÇÃO
-- =====================================================

RegisterNetEvent("hud:Capuz", function()
    PlayerState.toggleCapuz = not PlayerState.toggleCapuz

    local ped = PlayerPedId()
    if PlayerState.toggleCapuz then
        SetPedComponentVariation(ped,1,69,2,2)
    else
        SetPedComponentVariation(ped,1,0,0,2)
    end

    SendNUIMessage({
        action = 'set:capuz',
        data = PlayerState.toggleCapuz
    })
end)

RegisterNetEvent("hud:Voip", function(number)
    local value = math.min(tonumber(number) or 2, 4)
    CommState.talking = value
    SendNUIMessage({
        action = 'set:hud',
        data = { voip_level = value }
    })
end)

RegisterNetEvent("hud:Radio", function(frequency)
    CommState.frequency = tonumber(frequency) or 0
    SendNUIMessage({
        action = 'set:hud',
        data = { radio = CommState.frequency }
    })
end)

RegisterNetEvent("pma-voice:setTalkingMode", function(mode)
    CommState.talking = mode or 2
    SendNUIMessage({
        action = 'set:hud',
        data = { isSpeaking = CommState.talking }
    })
end)

RegisterNetEvent("pma-voice:radioActive", function(state)
    local source = GetPlayerServerId(PlayerId())

    if not state then
        return removeUserTalking(source)
    end

    local playerData = getPlayerData(source)
    addUserTalking(source, playerData.id, playerData.name)
end)

RegisterNetEvent("pma-voice:setTalkingOnRadio", function(source, state)
    if not state then
        return removeUserTalking(source)
    end

    local playerData = getPlayerData(source)
    addUserTalking(source, playerData.id, playerData.name)
end)

function getPlayerData(source)
    local cachedData = RadioFrequency.cachedData[source]

    local playerData = cachedData or vSERVER.getUserName(source)
    if not cachedData then
        RadioFrequency.cachedData[source] = playerData
    end

    return playerData
end

function addUserTalking(source, id, name)
    RadioFrequency.talking[#RadioFrequency.talking + 1] = {
        source = source,
        id = id,
        name = name
    }

    SendNUIMessage({
        action = "radio:users",
        data = RadioFrequency.talking
    })
end

function removeUserTalking(source)
    for index, data in pairs(RadioFrequency.talking) do
        if data.source == source then
            RadioFrequency.talking[index] = nil
        end
    end

    SendNUIMessage({
        action = "radio:users",
        data = RadioFrequency.talking
    })
end

-- =====================================================
-- CONTROLE DA HUD
-- =====================================================

local hudControlEvents = {
    "character:hudActived",
    "hudActived",
    "hud:Active"
}

for _, eventName in ipairs(hudControlEvents) do
    RegisterNetEvent(eventName, function(bool)
        if bool == nil then bool = true end
        PlayerState.showHud = bool
        ApplyHudVisibility()
    end)
end

exports('LockHud', function()
    local owner = GetInvokingResource() or "desconhecido"
    if HudLocks[owner] then return true end

    HudLocks[owner] = true
    ApplyHudVisibility()
    return true
end)

exports('UnlockHud', function()
    local owner = GetInvokingResource() or "desconhecido"
    if not HudLocks[owner] then return false end

    HudLocks[owner] = nil
    ApplyHudVisibility()
    return true
end)

exports('IsHudLocked', function()
    return IsHudLocked()
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if not HudLocks[resourceName] then return end

    HudLocks[resourceName] = nil
    ApplyHudVisibility()
end)

exports('IsHudEnabled', function()
    return PlayerState.showHud == true
end)

CreateThread(function()
    while true do
        Wait(5000)

        if not (LocalPlayer.state.onCreate or LocalPlayer.state.editChar or LocalPlayer.state.onSpawnSelect) then
            ApplyHudVisibility()
        end
    end
end)

-- =====================================================
-- COMANDOS
-- =====================================================

local function OpenHudMenu()
    if HudVisible == false then return end

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'menu:hud',
        data = true
    })
end

RegisterCommand("hud", OpenHudMenu)
RegisterCommand("menu", OpenHudMenu)

local seatbeltThread = false
function SeatbeltVehicleLeaveThread()
    if seatbeltThread then return end
    seatbeltThread = true

    CreateThread(function()
        while PlayerState.seatbelt == true do
            DisableControlAction(0, 75, true)

            Wait(10)
        end

        seatbeltThread = false
    end)
end

RegisterCommand("setBelt", function()
    local ped = GetCachedPed()
    if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
        PlayerState.seatbelt = not PlayerState.seatbelt
        if PlayerState.seatbelt then
            TriggerEvent("sounds:Private", "belt", 0.5)
            SeatbeltVehicleLeaveThread()
        else
            TriggerEvent("sounds:Private", "unbelt", 0.5)
        end
    end
end)

-- =====================================================
-- FUNÇÕES EXPORTADAS
-- =====================================================

function DS.setZone(typeZone)
    SendNUIMessage({
        action = 'set:hud',
        data = { zone = typeZone }
    })
end

local FORMULARY_TIMEOUT_MS = 120000
local FORMULARY_POLL_MS = 50

function DS.Formulary(title, description, inputs)
    local request = { done = false, response = nil }
    ActiveFormulary = request

    SetNuiFocus(true, true)

    CreateThread(function()
        while not request.done do
            DisableAllControlActions(0)
            Wait(0)
        end
    end)

    SendNUIMessage({
        action = 'formularyRequest',
        data = {
            title = title,
            description = description,
            inputs = inputs
        }
    })

    local deadline = GetGameTimer() + FORMULARY_TIMEOUT_MS

    while not request.done and GetGameTimer() < deadline do
        Wait(FORMULARY_POLL_MS)
    end

    request.done = true

    local stillMine = ActiveFormulary == nil or ActiveFormulary == request

    if ActiveFormulary == request then
        ActiveFormulary = nil
        SendNUIMessage({ action = 'formularyDismiss' })
    end

    if stillMine then
        SetNuiFocus(false, false)
    end

    if type(request.response) ~= 'table' then return nil end

    return request.response
end

exports('formulary', DS.Formulary)
exports('setZone', DS.setZone)
exports('syncNeeds', syncNeedsVariables)

-- =====================================================
-- MINIMAPA
-- =====================================================

CreateThread(function()
    RequestStreamedTextureDict("circleminimap", false)
    while not HasStreamedTextureDictLoaded("circleminimap") do
        Wait(100)
    end

    SetMinimapClipType(1)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circleminimap", "radarmasksm")

    local positions = {
        minimap = { -0.0045, 0.002 - 0.025, 0.150, 0.188888 },
        minimap_mask = { 0.020, 0.030 - 0.025, 0.111, 0.159 },
        minimap_blur = { -0.03, 0.022 - 0.040, 0.266, 0.200 }
    }

    for component, pos in pairs(positions) do
        SetMinimapComponentPosition(component, "L", "B", pos[1], pos[2], pos[3], pos[4])
    end

    SetBigmapActive(true, false)
    Wait(50)
    SetBigmapActive(false, false)
    DisplayRadar(false)

    UpdateRadarVisibility()

    Wait(1000)
    syncNeedsVariables()

    Wait(1000 * 20)

    SendNUIMessage({
        action = "refetch:minimapDimensions",
        data = {}
    })
end)

-- =====================================================
-- FOME E SEDE
-- =====================================================

if hudConfig.hungerThirst then
    local function ensureNeedsInitialized()
        if not hunger then hunger = 100 end
        if not thirst then thirst = 100 end
    end

    local updateFoods = GetGameTimer()
    CreateThread(function()
        ensureNeedsInitialized()

        while true do
            local ped = PlayerPedId()
            if GetGameTimer() >= updateFoods and GetEntityHealth(ped) > 101 and not LocalPlayer.state.Farming and not LocalPlayer.state.SafeZone then
                updateFoods = GetGameTimer() + 5 * 60 * 1000

                thirst -= 4
                hunger -= 3

                if thirst <= 10 then
                    TriggerEvent('Notify', 'aviso', 'Você está ficando com sede', 5000)
                end
                if hunger <= 10 then
                    TriggerEvent('Notify', 'aviso', 'Você está ficando com fome', 5000)
                end

                vRPserver.FoodsServer()
            end

            Wait(30000)
        end
    end)

    local needsDamage = function()
        local applyDamage = function(damage, ped, health)
            SetFlash(0, 0, 500, 1000, 500)
            ApplyDamageToPed(ped, damage, false)

            local health = GetEntityHealth(ped)

            if health <= 0 then
                TriggerEvent('gameEventTriggered', 'CEventNetworkEntityDamage', {
                    PlayerPedId(),
                    PlayerPedId(),
                    1,
                    1,
                    1,
                    1,
                    'STATUS_DAMAGE'
                })
            end
        end
        local checkDamage = function(value, ped, health)
            if LocalPlayer.state.inPvp then return end
            if not value then return end

            if value == 0 then
                applyDamage(1, ped, health)
            elseif value < 20 then
                SetFlash(0, 0, 500, 1000, 500)
            end
        end
        while true do
            local ped = PlayerPedId()
            local health = GetEntityHealth(ped)
            if health > 0 then
                checkDamage(hunger, ped, health)
                checkDamage(thirst, ped, health)
            end
            Wait(10000)
        end
    end

    CreateThread(function()
        ensureNeedsInitialized()
        needsDamage()
    end)
end

-- =====================================================
-- EVENTOS DIVERSOS
-- =====================================================

AddEventHandler("hud:safeZoneStatus", function(payload)
    SendNUIMessage({
        action = 'set:safezone',
        data = payload
    })
end)

AddEventHandler("hud:notifyBlock", function(payload)
    SendNUIMessage({
        action = 'set:notify:block',
        data = payload
    })
end)

AddEventHandler("hud:setRobbery", function(payload)
    SendNUIMessage({
        action = 'set:robbery',
        data = payload
    })
end)

function updateTouretteStatus(status)
    SetNuiFocus(status, status)

    SendNUIMessage({
        action = 'set:tourret:visible',
        data = status
    })
end

RegisterNetEvent("hud:openTourette", function()
    updateTouretteStatus(true)
end)

RegisterNetEvent("hud:closeTourette", function()
    updateTouretteStatus(false)
end)

RegisterNUICallback("close:tourret", function(_, cb)
    updateTouretteStatus(false)

    cb(true)
end)

AddEventHandler("hud:setHappyHour", function(payload)
    SendNUIMessage({ action = 'set:happyhour', data = payload })
end)