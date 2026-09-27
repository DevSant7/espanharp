local activeTimers = {}
local timerThread = false

--- Unix seconds on client; `os` is not available in FiveM client Lua.
local function unixNow()
    local fn = GetCloudTimeAsInt
    if type(fn) == "function" then
        return fn()
    end
    return 0
end

local function airdropSubFields(airdrop)
    if not airdrop or not airdrop.nextChestOpenAt then return nil, nil end
    local subRem = math.floor(airdrop.nextChestOpenAt - unixNow())
    if subRem <= 0 then return nil, nil end
    return "Caixa quente", subRem
end

local function sendTimersToNui()
    local timers = {}
    for key, data in pairs(activeTimers) do
        local remaining = data.expiresAt - unixNow()
        if remaining > 0 then
            local entry = {
                id = key,
                title = data.title,
                icon = data.icon,
                color = data.color,
                remaining = remaining,
            }
            if data.subLabel and data.subRemaining then
                local subRem = math.floor(data.subRemaining)
                if subRem > 0 then
                    entry.subLabel = data.subLabel
                    entry.subRemaining = subRem
                end
            end
            timers[#timers + 1] = entry
        end
    end

    SendNUIMessage({
        action = "set:eventTimers",
        data = #timers > 0 and timers or false,
    })
end

local function startTimerThread()
    if timerThread then return end
    timerThread = true

    CreateThread(function()
        while next(activeTimers) do
            sendTimersToNui()

            local anyAlive = false
            for key, data in pairs(activeTimers) do
                if data.expiresAt - unixNow() <= 0 then
                    activeTimers[key] = nil
                else
                    if data.subRemaining and data.subRemaining > 0 then
                        data.subRemaining = data.subRemaining - 1
                    end
                    anyAlive = true
                end
            end

            if not anyAlive then break end
            Wait(1000)
        end

        SendNUIMessage({ action = "set:eventTimers", data = false })
        timerThread = false
    end)
end

local function setAirdropTimerFromGlobal(airdrop)
    if not airdrop or not airdrop.expiresAt or airdrop.expiresAt - unixNow() <= 0 then return end
    local subLabel, subRem = airdropSubFields(airdrop)
    local color = airdrop.legendary and "#eab308" or "#3b82f6"
    activeTimers["airdrop"] = {
        title = "Airdrop",
        icon = "fa-solid fa-parachute-box",
        color = color,
        expiresAt = airdrop.expiresAt,
        subLabel = subLabel,
        subRemaining = subRem,
    }
    startTimerThread()
end

local function addTimer(key, title, icon, color, expiresAt)
    if not expiresAt or expiresAt - unixNow() <= 0 then return end
    activeTimers[key] = {
        title = title,
        icon = icon,
        color = color,
        expiresAt = expiresAt,
    }
    startTimerThread()
end

local function removeTimer(key)
    activeTimers[key] = nil
    if not next(activeTimers) then
        SendNUIMessage({ action = "set:eventTimers", data = false })
    else
        sendTimersToNui()
    end
end

-- Helicrash zone tracking
AddStateBagChangeHandler("inHeliCrash", ("player:%s"):format(GetPlayerServerId(PlayerId())), function(_, _, value)
    if value then
        local expiry = GlobalState["HelicrashExpiry"]
        if expiry and expiry - unixNow() > 0 then
            addTimer("helicrash", "Helicrash", "fa-solid fa-helicopter", "#ef4444", expiry)
        end
    else
        removeTimer("helicrash")
    end
end)

-- Airdrop zone tracking
AddStateBagChangeHandler("inAirdrop", ("player:%s"):format(GetPlayerServerId(PlayerId())), function(_, _, value)
    if value then
        setAirdropTimerFromGlobal(GlobalState["Airdrop"])
    else
        removeTimer("airdrop")
    end
end)

-- Cleanup when events end globally
AddStateBagChangeHandler("Helicrash", "global", function(_, _, value)
    if not value then
        removeTimer("helicrash")
    end
end)

AddStateBagChangeHandler("Airdrop", "global", function(_, _, value)
    if not value then
        removeTimer("airdrop")
        return
    end
    if LocalPlayer.state["inAirdrop"] then
        setAirdropTimerFromGlobal(value)
    end
end)
