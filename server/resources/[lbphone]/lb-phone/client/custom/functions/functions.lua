local hudDisabled = false

function ToggleHudComponents(visible)

    if hudDisabled == visible then

        return

    end

    hudDisabled = visible

    Citizen.CreateThreadNow(function()

        while hudDisabled and hudDisabled == visible do

            HideHudAndRadarThisFrame()

            HideHelpTextThisFrame()

            Wait(0)

        end

    end)

end

function DisplayCameraButtons(buttons)

    if hudDisabled or Config.Camera?.ShowTip == false then

        return

    end

    if #buttons > 0 then

        local tip = table.concat(buttons, "\n")

        AddTextEntry("CAMERA_TIP2", tip)

        BeginTextCommandDisplayHelp("CAMERA_TIP2")

        EndTextCommandDisplayHelp(0, true, true, 0)

    end

end

function StopDisplayingCameraButtons()

    ClearHelp(true)

end

function TakeControlOfEntity(entity)

    if NetworkHasControlOfEntity(entity) then

        return true

    end

    local timer = GetGameTimer() + 5000

    while not NetworkHasControlOfEntity(entity) and timer > GetGameTimer() do

        NetworkRequestControlOfEntity(entity)

        Wait(0)

    end

    return NetworkHasControlOfEntity(entity)

end

function LoadModel(model)

    model = type(model) == "number" and model or joaat(model)

    RequestModel(model)

    while not HasModelLoaded(model) do

        Wait(0)

    end

    return model

end

function WaitForNetworkId(netId)

    local timer = GetGameTimer() + 5000

    while not NetworkDoesNetworkIdExist(netId) do

        Wait(0)

        if GetGameTimer() > timer then

            return

        end

    end

    timer = GetGameTimer() + 5000

    while not DoesEntityExist(NetworkGetEntityFromNetworkId(netId)) do

        Wait(0)

        if GetGameTimer() > timer then

            return

        end

    end

    return NetworkGetEntityFromNetworkId(netId)

end

function DrawFlashlight(ped)

    local coords = GetPedBoneCoords(ped, 28422, 0.5, 0.0, 0.0)

    local forward = GetEntityForwardVector(ped)

    DrawSpotLightWithShadow(

        coords.x, coords.y, coords.z,

        forward.x, forward.y, forward.z,

        255, 255, 255,
        15.0,
        3.0,
        0.0,
        50.0,
        100.0,
        1
    )

    DrawSpotLightWithShadow(

        coords.x, coords.y, coords.z,

        forward.x, forward.y, forward.z,

        255, 255, 255,
        30.0,
        10.0,
        0.0,
        20.0,
        25.0,
        1
    )

end

local lastInteraction = 0

function CanInteract()

    if lastInteraction + 500 > GetGameTimer() then

        return false

    end

    lastInteraction = GetGameTimer()

    return true

end

function ReloadPhone()

    local wasOpen = phoneOpen

    debugprint("ReloadPhone triggered")

    LogOut()

    Wait(1000)

    FetchPhone()

    if wasOpen then

        ToggleOpen(true)

    end

end

exports("ReloadPhone", ReloadPhone)

function HasAccessToApp(appIdentifier, jobName, jobGrade)

    if not GetJob then

        debugprint("GetJob is not defined in framework functions")

        return true

    end

    if not GetJobGrade then

        debugprint("GetJobGrade is not defined in framework functions")

        return true

    end

    if not Config.WhitelistApps and not Config.BlacklistApps then

        return true

    end

    jobName = jobName or GetJob()

    jobGrade = jobGrade or GetJobGrade()

    local blacklistedJobs = Config.BlacklistApps and Config.BlacklistApps[appIdentifier]

    if blacklistedJobs then

        if table.type(blacklistedJobs) == "array" then

            if table.contains(blacklistedJobs, jobName) then

                debugprint("Player's job is blacklisted from app", appIdentifier)

                return false

            end

        else

            if blacklistedJobs[jobName] and jobGrade >= blacklistedJobs[jobName] then

                debugprint("Player's job is blacklisted from app", appIdentifier)

                return false

            end

        end

    end

    local allowedJobs = Config.WhitelistApps and Config.WhitelistApps[appIdentifier]

    if allowedJobs then

        if table.type(allowedJobs) == "array" then

            if table.contains(allowedJobs, jobName) then

                return true

            end

            debugprint("Player is not whitelisted for app", appIdentifier)

            return false

        else

            if allowedJobs[jobName] and jobGrade >= allowedJobs[jobName] then

                return true

            end

            debugprint("Player is not whitelisted for app", appIdentifier)

            return false

        end

    end

    return true

end

function GiveVehicleKey(vehicle, plate)

    TriggerEvent("vehiclekeys:client:SetOwner", plate)

end

AddCheck("playNativePhoneSound", function(soundType, soundName)

    if not IsEntityVisible(PlayerPedId()) then

        debugprint("Cancelling native phone sound due to player ped being invisible")

        return false

    end

    return true

end)