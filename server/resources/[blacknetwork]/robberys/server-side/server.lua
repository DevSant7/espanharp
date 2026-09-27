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
Tunnel.bindInterface("robberys",cRP)
vCLIENT = Tunnel.getInterface("robberys")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYAVAILABLE
-----------------------------------------------------------------------------------------------------------------------------------------
local robberyAvailable = {
	["departamentStore"] = os.time(),
	["ammunation"] = os.time(),
	["fleecas"] = os.time(),
	["barbershop"] = os.time(),
	["banks"] = os.time(),
	["acougue"] = os.time(),
	["niobio"] = os.time(),
	["joalheria"] = os.time(),
	["galinheiro"] = os.time()
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkRobbery(robberyId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robberys[robberyId] then
			local prev = robberys[robberyId]
			if os.time() >= robberyAvailable[prev["type"]] then
				local policeResult = vRP.numPermission("Police")
				if parseInt(#policeResult) >= parseInt(prev["cops"]) then
					local consultItem = vRP.getInventoryItemAmount(user_id,prev["item"])
					
					if consultItem[1] <= 0 then
						TriggerClientEvent("Notify",source,"important","Atenção","Precisa de <b>1x "..itemName(prev["item"]).."</b>.","amarelo",5000)
						return false
					end

					if vRP.checkBroken(consultItem[2]) then
						TriggerClientEvent("Notify",source,"important","Atenção","<b>"..itemName(prev["item"]).."</b> quebrado.","amarelo",5000)
						return false
					end

					if vRP.tryGetInventoryItem(user_id,consultItem[2],1) then
						robberyAvailable[prev["type"]] = os.time() + (prev["cooldown"] * 60)
						TriggerClientEvent("player:applyGsr",source)

						for k,v in pairs(policeResult) do
							async(function()
								TriggerClientEvent("NotifyPush",v,{ code = 31, title = prev["name"], x = prev["coords"][1], y = prev["coords"][2], z = prev["coords"][3], time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
								vRPC.playSound(v,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
							end)
						end
						args = {["1"] = prev["name"],coords = prev["coords"]}
						exports["logsystem"]:SendLog("RouberyStart",user_id,nil,args)

						return true
					end
				else
					TriggerClientEvent("Notify",source,"important","Atenção","Sem policiais suficientes.","amarelo",5000)
				end
			else
				TriggerClientEvent("Notify",source,"important","Atenção","Sistema indisponível no momento.","amarelo",5000)
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.paymentRobbery(robberyId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,10)
		TriggerEvent("Wanted",source,user_id,900)

		local identity = vRP.userIdentity(user_id)
		for k,v in pairs(robberys[robberyId]["payment"]) do
			local value = math.random(v[2],v[3])

			vRP.generateItem(user_id,v[1],parseInt(value),true)
			args = {["1"] = RouberyAmout}
			exports["logsystem"]:SendLog("RouberyAmout",user_id,nil,args)
			if robberys[robberyId]["locate"] ~= identity["locate"] then
				vRP.generateItem(user_id,v[1],parseInt(value * 0.1),true)
			end
		end
	end
end

function cRP.paymentAtm()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,10)
		TriggerEvent("Wanted",source,user_id,900)

		vRP.generateItem(user_id,"dollarsroll",math.random(3000,5000),true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	cRP.ResourceStarted()
end)

function cRP.ResourceStarted()
	vCLIENT.inputRobberys(source,robberys)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:JEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
local jewelryShowcase = {}
local jewelryTimers = os.time()
local jewelryCooldowns = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:INITJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("robberys:initJewelry")
AddEventHandler("robberys:initJewelry",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if os.time() >= jewelryCooldowns then
			local policeResult = vRP.numPermission("Police")
			if parseInt(#policeResult) >= 8 then
				local consultItem = vRP.getInventoryItemAmount(user_id,"pendrive")
				if consultItem[1] <= 0 then
					TriggerClientEvent("Notify",source,"important","Atenção","Precisa de <b>1x Pendrive</b>.","amarelo",5000)
					return false
				end

				if vRP.checkBroken(consultItem[2]) then
					TriggerClientEvent("Notify",source,"important","Atenção","<b>Pendrive</b> quebrado.","amarelo",5000)
					return false
				end

				if vRP.tryGetInventoryItem(user_id,consultItem[2],1) then
					TriggerClientEvent("Notify",source,"important","Atenção","Sistema corrompido.","amarelo",5000)
					jewelryCooldowns = os.time() + 7200
					jewelryTimers = os.time() + 600
					jewelryShowcase = {}

					for k,v in pairs(policeResult) do
						async(function()
							TriggerClientEvent("NotifyPush",v,{ code = 31, title = "Joalheria", x = -633.07, y = -238.7, z = 38.06, time = "Recebido às "..os.date("%H:%M"), blipColor = 22 })
							vRPC.playSound(v,"Beep_Green","DLC_HEIST_HACKING_SNAKE_SOUNDS")
						end)
					end
				end
			else
				TriggerClientEvent("Notify",source,"important","Atenção","Sistema indisponível no momento.","amarelo",5000)
			end
		else
			TriggerClientEvent("Notify",source,"important","Atenção","Sistema indisponível no momento.","amarelo",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERYS:JEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("robberys:jewelry")
AddEventHandler("robberys:jewelry",function(entity)
	local source = source
	local showcase = entity[1]
	local user_id = vRP.getUserId(source)
	if user_id then
		if os.time() <= jewelryTimers then
			if jewelryShowcase[showcase] == nil then
				jewelryShowcase[showcase] = true
				TriggerClientEvent("vRP:Cancel",source,true)
				vRPC.playAnim(source,false,{"oddjobs@shop_robbery@rob_till","loop"},true)

				SetTimeout(20000,function()
					vRPC.stopAnim(source,false)
					vRP.upgradeStress(user_id,10)
					TriggerEvent("Wanted",source,user_id,60)
					TriggerClientEvent("vRP:Cancel",source,false)
					vRP.generateItem(user_id,"watch",math.random(20,30),true)
				end)
			else
				TriggerClientEvent("Notify",source,"azul","Vitrine vazia.",3000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Necessário corromper o sistema.",3000)
		end
	end
end)

atmTimers = os.time()
local robberys = {}
function cRP.checkSystems(shopId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policeResult = vRP.numPermission("Police")
		if (robberys[user_id + shopId] and robberys[user_id + shopId].shopId == shopId) then
			TriggerClientEvent("Notify", source, "important", "Atenção","Você precisa aguardar "..robberys[user_id + shopId].time - os.time().." Segundos.","amarelo", 5000)
		else
			if not (os.time() < atmTimers) then
				if #policeResult == 0 then
					TriggerClientEvent("Notify", source, "important", "Atenção","Sistema indisponível no momento.","amarelo", 5000)
					return false
				else
					local consultItem = vRP.getInventoryItemAmount(user_id,"floppy")
					if consultItem[1] <= 0 then
						TriggerClientEvent("Notify", source, "important", "Atenção","Necessário possuir um <b>Disquete</b>.","amarelo", 5000)
						return false
					end
				end
			
				robberys[user_id + shopId] = { shopId = shopId, time = os.time() + 300 }
				vRP.upgradeStress(user_id,10)
				atmTimers = os.time() + 30
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				-- TriggerClientEvent("player:applyGsr",source)
	
				vRP.tryGetInventoryItem(user_id,'floppy',1,true)
	
				for k,v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Caixa Eletrônico", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
	
				return true
			else
				TriggerClientEvent("Notify", source, "important", "Atenção","Você precisa aguardar "..atmTimers - os.time().." Segundos.","amarelo", 5000)
			end
		end
	end

	return false
end

CreateThread(function ()
	while true do
		for key, value in pairs(robberys) do
			if (os.time() >= value.time) then
				robberys[key] = nil
			end
		end
		Wait(1000)
	end
end)