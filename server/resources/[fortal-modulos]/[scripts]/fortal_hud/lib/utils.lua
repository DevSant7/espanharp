
if IsDuplicityVersion() then 
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRPC = Tunnel.getInterface("vRP")
    vRP = Proxy.getInterface("vRP")
    src = {}
    Tunnel.bindInterface("ilegal-control",src)
    clientAPI = Tunnel.getInterface("ilegal-control")
else
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRP = Proxy.getInterface("vRP")
    vRPS = Tunnel.getInterface("vRP")
    src = {}
    Tunnel.bindInterface("ilegal-control",src)
    serverAPI = Tunnel.getInterface("ilegal-control")
end 