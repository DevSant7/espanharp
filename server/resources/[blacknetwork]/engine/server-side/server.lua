-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("engine",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehFuels = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentFuel(fuelPrice,vehPlate,vFuel)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local gasPrice = parseInt(fuelPrice)
		if vRP.paymentFull(user_id,gasPrice) then
			local activePlayers = vRPC.activePlayers(source)
			for _,v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("engine:syncFuel",v,vehPlate,vFuel)
				end)
			end
			return true
		else
			TriggerClientEvent("Notify",source,"cancel","Negado","<b>Dólares</b> insuficientes.","vermelho",3000)
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.vehicleFuel(vehPlate)
	if vehFuels[vehPlate] == nil and vehPlate ~= nil then
		vehFuels[vehPlate] = 50
	end

	return vehFuels[vehPlate]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("engine:tryFuel")
AddEventHandler("engine:tryFuel",function(vehPlate,vFuel)
	vehFuels[vehPlate] = vFuel
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
exports("engineFuel",function(vehPlate)
	if vehFuels[vehPlate] == nil then
		vehFuels[vehPlate] = 50
	end

	return vehFuels[vehPlate]
end)

RegisterCommand("filltank", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(user_id, "Rm") then
        TriggerClientEvent("engine:fillFuel", source)
    end
end, false)
