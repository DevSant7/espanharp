-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("service",cRP)
vCLIENT = Tunnel.getInterface("service")

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("service:Toggle")
AddEventHandler("service:Toggle",function(Service,Color)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local splitName = splitString(Service,"-")
		local serviceName = splitName[1]

		local policeBlipColor = 38
		local paramedicBlipColor = 1
		local mechanicBlipColor = 5
		local dipBlipColor = 40

		if vRP.hasPermission(user_id,serviceName) then
			vRP.removePermission(user_id,serviceName)
			TriggerEvent("blipsystem:serviceExit",source)

			if serviceName == "Police" then
				TriggerClientEvent("vRP:PoliceService",source,false)
			elseif serviceName == "Paramedic" then
				TriggerClientEvent("vRP:ParamedicService",source,false)
			elseif serviceName == "Mechanic" then
				TriggerClientEvent("vRP:MechanicService",source,false)
			elseif serviceName == "Dip" then
				TriggerClientEvent("vRP:DipService",source,false)
			end

			local level = vRP.DataGroups(serviceName)[tostring(user_id)]
			vRP.remPermission(user_id,serviceName)
			vRP.setPermission(user_id,"wait"..serviceName,level)

			TriggerClientEvent("Notify",source,"check","Sucesso","Saiu de serviço.","verde",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Entrar em Serviço",5000)

		elseif vRP.hasPermission(user_id,"wait"..serviceName) then
			vRP.remPermission(user_id,"wait"..serviceName)

			if serviceName == "Police" then
				vRP.insertPermission(source,user_id,"Police")
				TriggerClientEvent("vRP:PoliceService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"PM",policeBlipColor)
			elseif serviceName == "Paramedic" then
				vRP.insertPermission(source,user_id,serviceName)
				TriggerClientEvent("vRP:ParamedicService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"Paramedic",paramedicBlipColor)
			elseif serviceName == "Mechanic" then
				vRP.insertPermission(source,user_id,serviceName)
				TriggerClientEvent("vRP:MechanicService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"Mechanic",mechanicBlipColor)
			elseif serviceName == "Dip" then
				vRP.insertPermission(source,user_id,serviceName)
				TriggerClientEvent("vRP:DipService",source,true)
				TriggerEvent("blipsystem:serviceEnter",source,"DIP",dipBlipColor)
			end

			local level = vRP.DataGroups("wait"..serviceName)[tostring(user_id)]
			vRP.setPermission(user_id,serviceName,level)

			TriggerClientEvent("Notify",source,"check","Sucesso","Entrou em serviço.","verde",5000)
			TriggerClientEvent("service:Label",source,serviceName,"Sair de Serviço",5000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SPLIT FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function splitString(str,sep)
	local t = {}
	for part in string.gmatch(str, "([^"..sep.."]+)") do
		table.insert(t, part)
	end
	return t
end
