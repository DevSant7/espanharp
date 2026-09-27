Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

local SERVER = IsDuplicityVersion()
local CLIENT = not SERVER

if SERVER then
    src = {}
    Tunnel.bindInterface("fortal_esc",src)
    client = Tunnel.getInterface("fortal_esc")
    vSURVIVAL = Tunnel.getInterface("survival")
    vKEYBOARD = Tunnel.getInterface("keyboard")
    vREQUEST = Tunnel.getInterface("request")
end

if CLIENT then
    src = {}
    Tunnel.bindInterface("fortal_esc",src)
    server = Tunnel.getInterface("fortal_esc")
    vSURVIVAL = Tunnel.getInterface("survival")
end