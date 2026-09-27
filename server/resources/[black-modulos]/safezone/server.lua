local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP")
swclient = Tunnel.getInterface("Swsafezone")

swzone = {}
Proxy.addInterface("Swsafezone", swzone)
Tunnel.bindInterface("Swsafezone", swzone)