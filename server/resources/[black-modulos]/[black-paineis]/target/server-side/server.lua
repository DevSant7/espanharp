local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

local vFunc = {}

Tunnel.bindInterface("target",vFunc)

local Authenticated = true

vFunc.IsAuth = function()
    return Authenticated
end

