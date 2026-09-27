Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

RegisterCommand("me",function(source,args,rawCommand)
	local otherPlayer = vRPC.nearestPlayer(source,3.0)
	if otherPlayer then 
		TriggerClientEvent("showme:pressMe", otherPlayer,source, rawCommand:sub(4), 10)
	end
	TriggerClientEvent("showme:pressMe", source,source, rawCommand:sub(4), 10)
end)