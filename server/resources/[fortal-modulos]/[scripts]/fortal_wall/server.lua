local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "wall")

RegisterCommand("wall", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id, "Rm") then
            TriggerClientEvent("wall:toggle", source)
        end
    end
end, false)

RegisterNetEvent("wall:requestIds")
AddEventHandler("wall:requestIds", function()
    local source = source
    local ids = {}

    for _, userSource in pairs(GetPlayers()) do
        local user_id = vRP.getUserId(tonumber(userSource))
        if user_id then
            ids[tonumber(userSource)] = user_id
        end
    end

    TriggerClientEvent("wall:receiveIds", source, ids)
end)
