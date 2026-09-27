
if IsDuplicityVersion() then 
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRPC = Tunnel.getInterface("vRP")
    vRP = Proxy.getInterface("vRP")
    src = {}
    Tunnel.bindInterface("black-groups",src)
    clientAPI = Tunnel.getInterface("black-groups")
else
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRP = Proxy.getInterface("vRP")
    src = {}
    Tunnel.bindInterface("black-groups",src)
    serverAPI = Tunnel.getInterface("black-groups")
end 