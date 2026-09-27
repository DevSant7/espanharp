
if IsDuplicityVersion() then 
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRPC = Tunnel.getInterface("vRP")
    vRP = Proxy.getInterface("vRP")
    src = {}
    Tunnel.bindInterface("garages",src)
    clientAPI = Tunnel.getInterface("garages")
else
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRP = Proxy.getInterface("vRP")
    src = {}
    Tunnel.bindInterface("garages",src)
    serverAPI = Tunnel.getInterface("garages")
end 