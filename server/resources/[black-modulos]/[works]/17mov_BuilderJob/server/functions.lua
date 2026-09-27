local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

Config.Framework = "STANDALONE"
local cachedNames = {}

function GetPlayerIdentity(source)
    if not source or source == -1 then return "Example Name" end

    if cachedNames[source] then
        return cachedNames[source]
    end

    local name = GetPlayerName(source)
    cachedNames[source] = name or "Espanha"
    return cachedNames[source]
end

function Notify(source, msg)
    if not source then return end

    if Config.UseBuiltInNotifications and Config.useModernUI then
        TriggerClientEvent("17mov_DrawDefaultNotification" .. GetCurrentResourceName(), source, msg)
    else
        TriggerClientEvent("17mov_DrawDefaultNotification" .. GetCurrentResourceName(), source, msg)
    end
end

function Pay(source, amount, lobbySize, rawProgress)
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.generateItem(user_id, "dollars", amount, true)
    end
end

function PayPenalty(source, amount)
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.tryPayment(user_id, amount)
    end
end

function isHaveRequiredItem(source)
    if Config.RequiredItem ~= "none" then
        local user_id = vRP.getUserId(source)
        if user_id then
            return vRP.getInventoryItemAmount(user_id, Config.RequiredItem) > 0
        else
            return false
        end
    end
    return true
end

function GetPlayerJob(source)
    return "unknown"
end
