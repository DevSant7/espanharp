-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getDiscord()
	return GetNumPlayerIndices()
end

function src.carryAdmin()
	local source = source 
	local user_id = vRP.getUserId(source)
	if user_id then 
		local otherPlayer = vRPC.nearestPlayer(source, 0.8)
		if otherPlayer and vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("toggleCarry", otherPlayer, source)
		end
	end
end 

RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress", function(number)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.upgradeStress(user_id, parseInt(number))
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress", function(number)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		vRP.upgradeStress(user_id, number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("downgradeStress")
AddEventHandler("downgradeStress", function(number)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		vRP.downgradeStress(user_id, number)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:KICKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("police:runCheckIdentity")
AddEventHandler("police:runCheckIdentity", function(entity)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id and entity[1] then
		local target = entity[1]
		local target_id = vRP.getUserId(target)

		if vRP.hasGroup(user_id, "Police") and target_id then

			if vRP.request(target, "Você aceita mostrar sua identidade?") then
				TriggerEvent("RenderIdentity", source, target_id)
			else
				TriggerClientEvent("Notify", source, "importante", "O cidadão recusou mostrar a identidade.", "vermelho", 5000)
			end
		end
	end
end)

RegisterServerEvent("player:kickSystem")
AddEventHandler("player:kickSystem", function(message)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if not vRP.hasGroup(user_id, "Admin") then
			vRP.kick(user_id, message)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DOORS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("player:Doors")
AddEventHandler("player:Doors", function(number)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local vehicle, vehNet = vRPC.vehList(source, 5)

		if vehicle then
			local activePlayers = vRPC.activePlayers(source)
			for _, v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("player:syncDoors", v, vehNet, number)
				end)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getSalary()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.userPremium(user_id) then
			TriggerEvent("vRP:updateSalary", user_id, 1000)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$1000</b> recebido.", "amarelo", 5000)
		end

		--- SALÁRIOS VIPS ---

		if vRP.hasPermission(user_id, "Bronze") then
			TriggerEvent("vRP:updateSalary", user_id, 500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$500</b> recebido.", "amarelo", 5000)
		end

		if vRP.hasPermission(user_id, "Prata") then
			TriggerEvent("vRP:updateSalary", user_id, 1000)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$1000</b> recebido.", "amarelo", 5000)
		end

		if vRP.hasPermission(user_id, "Ouro") then
			TriggerEvent("vRP:updateSalary", user_id, 1500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$1500</b> recebido.", "amarelo", 5000)
		end

		if vRP.hasPermission(user_id, "Streamer") then
			TriggerEvent("vRP:updateSalary", user_id, 500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$500</b> recebido.", "amarelo", 5000)
		end

		--- GRUPOS ---

		-- if vRP.hasPermission(user_id, "Police") then
		-- 	TriggerEvent("vRP:updateSalary", user_id, 2500)
		-- 	TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$2500</b> recebido.", "amarelo", 5000)
		-- end

		if vRP.hasPermission(user_id, "Paramedic") then
			TriggerEvent("vRP:updateSalary", user_id, 5500)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$5000</b> recebido.", "amarelo", 5000)
		end

		if vRP.hasPermission(user_id, "Dip") then
			TriggerEvent("vRP:updateSalary", user_id, 5000)
			TriggerClientEvent("Notify", source, "check", "Atenção", "Salário de <b>$5000</b> recebido.", "amarelo", 5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function src.shotsFired()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local policeResult = vRP.numPermission("Police")

		for k, v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("NotifyPush", v, {
					code = 10,
					title = "Confronto em andamento",
					x = coords["x"],
					y = coords["y"],
					z = coords["z"],
					criminal = "Disparos de arma de fogo",
					blipColor = 6
				})
			end)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CARRYPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------

local playerCarry = {}

RegisterServerEvent("player:carryPlayer")
AddEventHandler("player:carryPlayer", function()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if not vRPC.inVehicle(source) then
			if playerCarry[user_id] then
				TriggerClientEvent("player:playerCarry", playerCarry[user_id], source)
				TriggerClientEvent("player:Commands", playerCarry[user_id], false)
				playerCarry[user_id] = nil
			else
				local otherPlayer = vRPC.nearestPlayer(source)

				if otherPlayer then
					playerCarry[user_id] = otherPlayer

					TriggerClientEvent("player:playerCarry", playerCarry[user_id], source)
					TriggerClientEvent("player:Commands", playerCarry[user_id], true)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------

AddEventHandler("playerDisconnect", function(user_id)
	if playerCarry[user_id] then
		TriggerClientEvent("player:Commands", playerCarry[user_id], false)
		playerCarry[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions", function(mode)
	local source = source
	local vehicle, vehNet = vRPC.vehSitting(source)

	if vehicle then
		local activePlayers = vRPC.activePlayers(source)

		for _, v in ipairs(activePlayers) do
			async(function()
				TriggerClientEvent("player:syncWins", v, vehNet, mode)
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CVFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("player:cvFunctions")
AddEventHandler("player:cvFunctions", function(mode)
	local source = source
	local distance = 1.1

	if mode == "rv" then
		distance = 10
	end

	local otherPlayer = vRPC.nearestPlayer(source, distance)

	if otherPlayer then
		local user_id = vRP.getUserId(source)
		local consultItem = vRP.getInventoryItemAmount(user_id, "rope")

		if vRP.hasGroup(user_id, "Emergency") or consultItem[1] >= 1 then
			local vehicle, vehNet = vRPC.vehList(source, 5)

			if vehicle then
				local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
				local doorStatus = GetVehicleDoorLockStatus(idNetwork)

				if parseInt(doorStatus) <= 1 then
					if mode == "rv" then
						clientAPI.removeVehicle(otherPlayer)
					elseif mode == "cv" then
						clientAPI.putVehicle(otherPlayer, vehNet)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk", function()
	local source = source
	local otherPlayer = vRPC.nearestPlayer(source)

	if otherPlayer then
		TriggerClientEvent("player:checkTrunk", otherPlayer)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTFIT - REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------

local removeFit = {
	["homem"] = {
		["hat"] = {
			item = -1,
			texture = 0
		},
		["pants"] = {
			item = 61,
			texture = 0
		},
		["vest"] = {
			item = 0,
			texture = 0
		},
		["backpack"] = {
			item = 0,
			texture = 0
		},
		["bracelet"] = {
			item = -1,
			texture = 0
		},
		["decals"] = {
			item = 0,
			texture = 0
		},
		["mask"] = {
			item = 0,
			texture = 0
		},
		["shoes"] = {
			item = 5,
			texture = 0
		},
		["tshirt"] = {
			item = 15,
			texture = 0
		},
		["torso"] = {
			item = 15,
			texture = 0
		},
		["accessory"] = {
			item = 0,
			texture = 0
		},
		["watch"] = {
			item = -1,
			texture = 0
		},
		["arms"] = {
			item = 15,
			texture = 0
		},
		["glass"] = {
			item = 0,
			texture = 0
		},
		["ear"] = {
			item = -1,
			texture = 0
		}
	},
	["mulher"] = {
		["hat"] = {
			item = -1,
			texture = 0
		},
		["pants"] = {
			item = 15,
			texture = 0
		},
		["vest"] = {
			item = 0,
			texture = 0
		},
		["backpack"] = {
			item = 0,
			texture = 0
		},
		["bracelet"] = {
			item = -1,
			texture = 0
		},
		["decals"] = {
			item = 0,
			texture = 0
		},
		["mask"] = {
			item = 0,
			texture = 0
		},
		["shoes"] = {
			item = 35,
			texture = 0
		},
		["tshirt"] = {
			item = 14,
			texture = 0
		},
		["torso"] = {
			item = 15,
			texture = 0
		},
		["accessory"] = {
			item = 0,
			texture = 0
		},
		["watch"] = {
			item = -1,
			texture = 0
		},
		["arms"] = {
			item = 15,
			texture = 0
		},
		["glass"] = {
			item = 0,
			texture = 0
		},
		["ear"] = {
			item = -1,
			texture = 0
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions", function(mode)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if mode == "aplicar" then
			local result = vRP.getSrvdata("saveClothes:" .. user_id)

			if result["pants"] ~= nil then
				vRPC.playAnim(source, true, {"clothingshirt","try_shirt_positive_d"}, false)
				SetTimeout(3000, function()
					TriggerEvent("fortal-character:Server:Skinshop:Save", source, result)
					TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas aplicadas.", "verde", 3000)
					vRPC.stopAnim(source)
				end)
			else
				TriggerClientEvent("Notify", source, "important", "Atenção", "Roupas não encontradas.", "amarelo", 3000)
			end
		elseif mode == "preaplicar" then
			if vRP.hasGroup(user_id, "Bronze") or vRP.hasGroup(user_id, "Prata") or vRP.hasGroup(user_id, "Ouro") or vRP.hasGroup(user_id, "Diamante") then
				local result = vRP.getSrvdata("premClothes:" .. user_id)

				if result["pants"] ~= nil then
					TriggerEvent("fortal-character:Server:Skinshop:Save", source, result)
					TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas aplicadas.", "verde", 3000)
				else
					TriggerClientEvent("Notify", source, "important", "Atenção", "Roupas não encontradas.", "amarelo", 3000)
				end
			end
		elseif mode == "salvar" then
			local checkBackpack = vCHARACTER.checkBackpack(source)
			if not checkBackpack then
				local custom = vCHARACTER.getCustomization(source)
				if custom then
					vRP.setSrvdata("saveClothes:" .. user_id, custom)
					TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas salvas.", "verde", 3000)
				end
			else
				TriggerClientEvent("Notify", source, "important", "Atenção", "Remova do corpo o acessório item.", "amarelo", 5000)
			end
		elseif mode == "presalvar" then
			if vRP.hasGroup(user_id, "Bronze") or vRP.hasGroup(user_id, "Prata") or vRP.hasGroup(user_id, "Ouro") or vRP.hasGroup(user_id, "Diamante") then
				local checkBackpack = vCHARACTER.checkBackpack(source)

				if not checkBackpack then
					local custom = vCHARACTER.getCustomization(source)

					if custom then
						vRP.setSrvdata("premClothes:" .. user_id, custom)
						TriggerClientEvent("Notify", source, "check", "Sucesso", "Roupas salvas.", "verde", 3000)
					end
				else
					TriggerClientEvent("Notify", source, "important", "Atenção", "Remova do corpo o acessório item.", "amarelo", 5000)
				end
			end
		elseif mode == "remover" then
			local model = vRP.modelPlayer(source)

			if model == "mp_m_freemode_01" then
				TriggerEvent("fortal-character:Server:Skinshop:Save", source, removeFit["homem"])
			elseif model == "mp_f_freemode_01" then
				TriggerEvent("fortal-character:Server:Skinshop:Save", source, removeFit["mulher"])
			end
		else
			TriggerClientEvent("fortal-character:Client:Skinshop:Set" .. mode, source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
local Debug = {}
RegisterNetEvent("player:Debug")
AddEventHandler("player:Debug",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and not Debug[user_id] or os.time() > Debug[user_id] then
		local query = vRP.query("playerdata/getUserdata",{ user_id = user_id, key = "Clothings" })
        if query[1] then 
			TriggerEvent("fortal-character:Server:Skinshop:Save", source, json.decode(query[1].dvalue))
        end
		TriggerClientEvent("reloadtattos",source)
		TriggerClientEvent("target:Debug",source)
		TriggerClientEvent("Notify", source, "check", "Sucesso", "Personagem recarregado.", "verde", 3000)

		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)

		Debug[user_id] = os.time() + 300

		local allObjects = GetAllObjects()

		for _, object in pairs(allObjects) do
			local objectCoords = GetEntityCoords(object)
			local distance = #(objectCoords - coords)
			if distance <= 2.0 then
				DeleteEntity(object)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHLOGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:deathLogs")
AddEventHandler("player:deathLogs", function(data)
    if data and data.victimServerId then
        local victimUserId = vRP.getUserId(data.victimServerId)
        if victimUserId then
            local killerUserId = nil
            if data.suicide then
                killerUserId = victimUserId
            else
                killerUserId = data.killerServerId and vRP.getUserId(data.killerServerId)
                if not killerUserId then
                    killerUserId = victimUserId
                end
            end
            exports["config"]:SendLog("PlayerDeath", killerUserId, victimUserId, data)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
function src.bikesBackpack()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local amountWeight = 10
		local myWeight = vRP.getWeight(user_id)

		if parseInt(myWeight) < 45 then
			amountWeight = 15
		elseif parseInt(myWeight) >= 45 and parseInt(myWeight) <= 79 then
			amountWeight = 10
		elseif parseInt(myWeight) >= 80 and parseInt(myWeight) <= 95 then
			amountWeight = 5
		elseif parseInt(myWeight) >= 100 and parseInt(myWeight) <= 148 then
			amountWeight = 2
		elseif parseInt(myWeight) >= 150 then
			amountWeight = 1
		end

		vRP.setWeight(user_id, amountWeight)
	end
end

function src.ClearGunsAnDead()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		TriggerEvent("inventory:clearWeapons", user_id)
	end
end
