----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
cRP = {}
Tunnel.bindInterface("inventory", cRP)
vCLIENT = Tunnel.getInterface("inventory")

vGARAGE = Tunnel.getInterface("garages")
vPLAYER = Tunnel.getInterface("coreP")
vTASKBAR = Tunnel.getInterface("taskbar")
vWEPLANTS = Tunnel.getInterface("weplants")
vDOMINATION = Tunnel.getInterface("black_domination")
local dismantleCooldown = {}

Config = {} 

Config["imagesProvider"] = "https://cdn.blacknetwork.com.br/black_inventory/"

-- https://localhost/Imagens/black_inventory/
-- https://cdn.blacknetwork.com.br/black_inventory/

Config["UseItens"] = {
	["instaverify"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		TriggerClientEvent("inventory:Close",source)

		if vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot) then
			vRP.setPermission(user_id, 'Verificado')

			local temporaryItems = vRP.userData(user_id, 'temporary_items') or {}

			table.insert(temporaryItems, {
				type = 'group',
				group = 'Verificado',
				expiresAt = os.time() + 30 * 24 * 60 * 60
			})

			vRP.execute("playerdata/setUserdata",
			{ user_id = user_id, key = "temporary_items", value = json.encode(temporaryItems) })

			exports['coreP']:validateVerified(user_id)
		end
	end,
	["briefcase"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("briefcase:open",source,tonumber(splitName[2]))
		vRPC.createObjects(source,"anim@heists@box_carry@","idle","p_sec_case_02_s",49,28422,  0.0, -0.08, -0.08, 0.0, 0.0, 180.0)
	end,
	["boxwine"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("briefcase:open",source,tonumber(splitName[2]))
		vRPC.createObjects(source,"anim@heists@box_carry@","idle","boxwine_astra",49,28422,  0.0, -0.08, -0.08, 0.0, 0.0, 180.0)
	end,
	["maquininha"] = function(source,user_id) 
		TriggerClientEvent("inventory:Close",source)
		TriggerClientEvent("black-maquininha:machineOptions",source,{"open"})
	end,
	["spray05"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		if vDOMINATION.tryStartDomination(source) then
			vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot)
		end
	end,
	["tiner"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		if vDOMINATION.tryRemoveSpray(source) then
			vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot)
		end
	end,
	["compost"] = function(source, user_id, totalName, Amount, Slot, splitName)
		local homeName = exports["homes"]:homesTheft(source)
		if not homeName then
			local weWater = vWEPLANTS.checkWater(source)
			if weWater then
				TriggerClientEvent("Notify", source, "vermelho", "Local incorreto", "Só pode ser plantado em terra firme.", 3000)
				return
			end
	
			local status, x, y, z = vWEPLANTS.entityInWorldCoords(source)
			if status then
				local compost = vRP.getInventoryItemAmount(user_id, "compost")
				local bucket = vRP.getInventoryItemAmount(user_id, "bucket")
				local seed = vRP.getInventoryItemAmount(user_id, "cannabisseed")
	
				if compost[1] >= 1 and bucket[1] >= 1 and seed[1] >= 1 then
					Active[user_id] = os.time() + 7
					vRPC.stopActived(source)
					TriggerClientEvent("inventory:Close", source)
					TriggerClientEvent("inventory:blockButtons", source, true)
					TriggerClientEvent("Progress", source, 7000)
					vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
	
					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source, false)
							TriggerClientEvent("inventory:Buttons", source, false)
	
							vRP.tryGetInventoryItem(user_id, "compost", 1, Slot)
							vRP.tryGetInventoryItem(user_id, "bucket", 1, Slot)
							vRP.tryGetInventoryItem(user_id, "cannabisseed", 1, Slot)
							vRP.weedTimer(user_id, 1)
							vRP.upgradeStress(user_id, 1)
							vWEPLANTS.pressPlants(source, x, y, z)
							TriggerClientEvent("weplants:createBlip", source, x, y, z)
						end
						Citizen.Wait(0)
					until Active[user_id] == nil
				else
					TriggerClientEvent("Notify", source, "vermelho", "Itens insuficientes", "Você não possui todos os itens.", 6000)
				end
			end
		end
	end,
	
	["bucket"] = function(source, user_id, totalName, Amount, Slot, splitName)
		local homeName = exports["homes"]:homesTheft(source)
		if not homeName then
			local weWater = vWEPLANTS.checkWater(source)
			if weWater then
				TriggerClientEvent("Notify", source, "vermelho", "Local incorreto", "Só pode ser plantado em terra firme.", 3000)
				return
			end
	
			local status, x, y, z = vWEPLANTS.entityInWorldCoords(source)
			if status then
				local compost = vRP.getInventoryItemAmount(user_id, "compost")
				local bucket = vRP.getInventoryItemAmount(user_id, "bucket")
				local seed = vRP.getInventoryItemAmount(user_id, "cannabisseed")
	
				if compost[1] >= 1 and bucket[1] >= 1 and seed[1] >= 1 then
					Active[user_id] = os.time() + 7
					vRPC.stopActived(source)
					TriggerClientEvent("inventory:Close", source)
					TriggerClientEvent("inventory:blockButtons", source, true)
					TriggerClientEvent("Progress", source, 7000)
					vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
	
					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source, false)
							TriggerClientEvent("inventory:Buttons", source, false)
	
							vRP.tryGetInventoryItem(user_id, "compost", 1, Slot)
							vRP.tryGetInventoryItem(user_id, "bucket", 1, Slot)
							vRP.tryGetInventoryItem(user_id, "cannabisseed", 1, Slot)
							vRP.weedTimer(user_id, 1)
							vRP.upgradeStress(user_id, 1)
							vWEPLANTS.pressPlants(source, x, y, z)
							TriggerClientEvent("weplants:createBlip", source, x, y, z)
						end
						Citizen.Wait(0)
					until Active[user_id] == nil
				else
					TriggerClientEvent("Notify", source, "vermelho", "Itens insuficientes", "Você não possui todos os itens.", 6000)
				end
			end
		end
	end,
	
	["cannabisseed"] = function(source, user_id, totalName, Amount, Slot, splitName)
		local homeName = exports["homes"]:homesTheft(source)
		if not homeName then
			local weWater = vWEPLANTS.checkWater(source)
			if weWater then
				TriggerClientEvent("Notify", source, "vermelho", "Local incorreto", "Só pode ser plantado em terra firme.", 3000)
				return
			end
	
			local status, x, y, z = vWEPLANTS.entityInWorldCoords(source)
			if status then
				local compost = vRP.getInventoryItemAmount(user_id, "compost")
				local bucket = vRP.getInventoryItemAmount(user_id, "bucket")
				local seed = vRP.getInventoryItemAmount(user_id, "cannabisseed")
	
				if compost[1] >= 1 and bucket[1] >= 1 and seed[1] >= 1 then
					Active[user_id] = os.time() + 7
					vRPC.stopActived(source)
					TriggerClientEvent("inventory:Close", source)
					TriggerClientEvent("inventory:blockButtons", source, true)
					TriggerClientEvent("Progress", source, 7000)
					vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
	
					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source, false)
							TriggerClientEvent("inventory:Buttons", source, false)
	
							vRP.tryGetInventoryItem(user_id, "compost", 1, Slot)
							vRP.tryGetInventoryItem(user_id, "bucket", 1, Slot)
							vRP.tryGetInventoryItem(user_id, "cannabisseed", 1, Slot)
							vRP.weedTimer(user_id, 1)
							vRP.upgradeStress(user_id, 1)
							vWEPLANTS.pressPlants(source, x, y, z)
							TriggerClientEvent("weplants:createBlip", source, x, y, z)
						end
						Citizen.Wait(0)
					until Active[user_id] == nil
				else
					TriggerClientEvent("Notify", source, "vermelho", "Itens insuficientes", "Você não possui todos os itens.", 6000)
				end
			end
		end
	end,
	["vehkey"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local vehicle, vehNet, vehPlate = vRPC.vehList(source, 5)
		if vehicle then
			if vehPlate == splitName[2] then
				TriggerEvent("black:keyVehicle", source, vehNet)
			end
		end
	end,
	["newgarage"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot) then
			vRP.upgradeGarage(user_id)
			TriggerClientEvent("inventory:Update", source, "updateMochila")
			TriggerClientEvent("Notify", source, "check", "Sucesso", "Garagem liberada.", "verde", 5000)
		end
	end,
	["newlocate"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot) then
			vRP.updateLocate(user_id)
			TriggerClientEvent("inventory:Update", source, "updateMochila")
			TriggerClientEvent("Notify", source, "check", "Sucesso", "Nacionalidade atualizada.", "verde", 5000)
		end
	end,
	["newchars"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot) then
			vRP.upgradeChars(user_id)
			TriggerClientEvent("inventory:Update", source, "updateMochila")
			TriggerClientEvent("Notify", source, "check", "Sucesso", "Personagem liberado.", "verde", 5000)
		end
	end,
	["wheelchair"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local plateVehicle = "WCH" .. math.random(10000, 99999)

		if vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot) then
			TriggerEvent("plateEveryone", plateVehicle)
			vCLIENT.wheelChair(source, plateVehicle)
			TriggerClientEvent("inventory:Update", source, "updateMochila")
		end
	end,
	["backpolice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("fortal-character:Client:Skinshop:ToggleBackpack", source, 49)
	end,
	["cellphone"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("drugs:initService", source)
	end,
	["gemstone"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, Amount, false, Slot) then
			TriggerClientEvent("inventory:Update", source, "updateMochila")
			vRP.upgradeGemstone(user_id, Amount)
	
			local webhook = "https://discord.com/api/webhooks/1392962510352814282/CxjBCiRqzmVkVnz77dtATNLTqQy7dhayl7rvJzDQ6WHZ7s8wce69Jr1RDLZBG03_1CFs"
			local identity = vRP.userIdentity(user_id)
			if webhook and identity then
				local embed = {
					{
						["color"] = 0,
						["title"] = "💎 Usuário usou o item `Gemstone`",
						["fields"] = {
							{
								["name"] = "Usuário",
								["value"] = "```"..identity.name.." "..identity.name2.." (ID: "..user_id..")```",
								["inline"] = true
							},
							{
								["name"] = "Quantidade",
								["value"] = "```"..tostring(Amount).."```",
								["inline"] = true
							}
						},
						["footer"] = {
							["text"] = os.date("%d/%m/%Y %H:%M:%S")
						}
					}
				}
	
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Inventory Logs", embeds = embed}), { ['Content-Type'] = 'application/json' })
			end
		end
	end,	
	["backpack"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.getWeight(user_id) >= 100 then
			return
		end

		Active[user_id] = os.time() + 7
		TriggerClientEvent("Progress", source, 7000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:blockButtons", source, true)
		vRPC.playAnim(source, true, { "clothingtie", "try_tie_negative_a" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, slot) then
					vRP.setWeight(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["rottweiler"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_rottweiler")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["husky"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_husky")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["shepherd"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_shepherd")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["retriever"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_retriever")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["poodle"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_poodle")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["pug"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_pug")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["westy"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_westy")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["cat"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("dynamic:animalSpawn", source, "a_c_cat_01")
		vRPC.playAnim(source, true, { "rcmnigel1c", "hailing_whistle_waive_a" }, false)
	end,
	["dismantle"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		local now = os.time()
	
		if dismantleCooldown[user_id] and dismantleCooldown[user_id] > now then
			local remaining = dismantleCooldown[user_id] - now
			local minutes = math.floor(remaining / 60)
			local seconds = remaining % 60
			local timeText = string.format("%02d:%02d", minutes, seconds)
			TriggerClientEvent("Notify", source, "important", "Aguarde", "Você já desmontou recentemente. Tempo restante: " .. timeText, "amarelo", 7000)
			return
		end

		if not vCLIENT.DismantleStatus(source) then
			vCLIENT.Dismantle(source, math.random(100, 1001))
			vRP.removeInventoryItem(user_id, "dismantle", 1, true)
			dismantleCooldown[user_id] = now + 300
		end
	end,
	["namechange"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)

		local name = vRP.prompt(source, "Primeiro Nome:", "")
		local name2 = vRP.prompt(source, "Segundo Nome:", "")
		
		if (not name or name == "") or (not name2 or name2 == "") then
			return
		end

		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			TriggerClientEvent("Notify", source, "check", "Sucesso", "Passaporte atualizado.", "verde", 5000)
			TriggerClientEvent("inventory:Update", source, "updateMochila")
			vRP.upgradeNames(user_id, name, name2)
		end
	end,
	["chip"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)

		local newPhone = vRP.prompt(source, "Digite o novo número no formato: XXXXXX", "")

		if newPhone == "" then
			return
		end
		if not vRP.userPhone(newPhone) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				TriggerClientEvent("Notify", source, "check", "Sucesso", "Telefone atualizado.", "verde", 5000)

				vRP.upgradePhone(user_id, newPhone)
			end
		else
			TriggerClientEvent("Notify", source, "important", "Atenção", "Número escolhido já possui um proprietário.",
				"amerelo", 5000)
		end

	end,
	["dices"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 10
		TriggerClientEvent("Progress", source, 1750)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "anim@mp_player_intcelebrationmale@wank", "wank" }, true)

		Citizen.Wait(1750)

		Active[user_id] = nil
		vRPC.stopAnim(source, false)
		TriggerClientEvent("inventory:Buttons", source, false)

		local Dice = math.random(6)
		local activePlayers = vRPC.activePlayers(source)
		for _, v in ipairs(activePlayers) do
			async(function()
				TriggerClientEvent("showme:pressMe", v, source, "<img src='images/" .. Dice .. ".png'>", 10, true)
			end)
		end
	end,
	["deck"] = function(source,user_id,totalName,Amount,Slot,splitName) -- 
		TriggerClientEvent("inventory:Close", source)

		local card = math.random(13)
		local cards = { "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K" }

		local naipe = math.random(4)
		local naipes = { "de paus", "de espada", "de ouros", "de copas" }

		local identity = vRP.userIdentity(user_id)
		TriggerClientEvent("chatME", source,
			"^5CARTAS^9" ..
			identity["name"] .. " " .. identity["name2"] .. "^0 tirou " .. cards[card] ..
			" " .. naipes[naipe] .. " do baralho.")

		local players = vRPC.nearestPlayers(source, 5)
		for _, v in pairs(players) do
			TriggerClientEvent("chatME", v[2],
				"^5CARTAS^9" ..
				identity["name"] .. " " .. identity["name2"] .. "^0 tirou " .. cards[card] .. naipes[naipe] .. " do baralho.")
		end
	end,
	["bandage"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
			if vRP.getHealth(source) > 101 and vRP.getHealth(source) < 200 then
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress", source, 10000)
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source, false)
						TriggerClientEvent("inventory:Buttons", source, false)

						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							TriggerClientEvent("sounds:source", source, "bandage", 0.5)
							Healths[user_id] = os.time() + 60
							vRP.upgradeStress(user_id, 3)
							vRPC.updateHealth(source, 15)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			else
				TriggerClientEvent("Notify", source, "important", "Atenção",
					"Não pode utilizar de vida cheia ou nocauteado.", "amarelo", 5000)
			end
		else
			local healTimers = parseInt(Healths[user_id] - os.time())
			TriggerClientEvent("Notify", source, "important", "Atenção", "Aguarde " .. healTimers .. " segundos.",
				"atenção", 5000)
		end

	end,
	["sulfuric"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 3
		TriggerClientEvent("Progress", source, 3000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_suicide", "pill" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRPC.downHealth(source, 100)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil

	end,
	["analgesic"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
			if vRP.getHealth(source) > 101 and vRP.getHealth(source) < 200 then
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress", source, 3000)
				TriggerClientEvent("inventory:Close", source)
				vRPC.playAnim(source, true, { "mp_suicide", "pill" }, true)
				TriggerClientEvent("inventory:Buttons", source, true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source, false)
						TriggerClientEvent("inventory:Buttons", source, false)

						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							Healths[user_id] = os.time() + 30
							vRP.upgradeStress(user_id, 15)
							vRPC.updateHealth(source, 8)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			else
				TriggerClientEvent("Notify", source, "azul", "Não pode utilizar de vida cheia ou nocauteado.", 5000)
			end
		else
			local healTimers = parseInt(Healths[user_id] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. healTimers .. " segundos</b>.", 5000)
		end
	end,
	["oxy"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
			if vRP.getHealth(source) > 101 and vRP.getHealth(source) < 200 then
				Active[user_id] = os.time() + 3
				TriggerClientEvent("Progress", source, 3000)
				TriggerClientEvent("inventory:Close", source)
				vRPC.playAnim(source, true, { "mp_suicide", "pill" }, true)
				TriggerClientEvent("inventory:Buttons", source, true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source, false)
						TriggerClientEvent("inventory:Buttons", source, false)

						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							Healths[user_id] = os.time() + 30
							vRP.upgradeStress(user_id, 15)
							vRPC.updateHealth(source, 8)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			else
				TriggerClientEvent("Notify", source, "azul", "Não pode utilizar de vida cheia ou nocauteado.", 5000)
			end
		else
			local healTimers = parseInt(Healths[user_id] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. healTimers .. " segundos</b>.", 5000)
		end
	end,
	["soap"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if cRP.haveEvidences(source) then
			Active[user_id] = os.time() + 15
			TriggerClientEvent("Progress", source, 15000)
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("inventory:Buttons", source, true)
			vRPC.playAnim(source, false, { "amb@world_human_bum_wash@male@high@base", "base" }, true)

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					vRPC.removeObjects(source)
					TriggerClientEvent("inventory:Buttons", source, false)

					if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
						TriggerClientEvent("get:clear_evidence", source)
						TriggerClientEvent("Notify", source, "important", "Atenção", "Residuo removido", "amarelo", 5000)
					end
				end
				Citizen.Wait(100)
			until Active[user_id] == nil
		else
			TriggerClientEvent("Notify", source, "important", "Atenção", "Você não está com resíduos no corpo.","amarelo", 5000)
		end
	end,
	["joint"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local consultItem = vRP.getInventoryItemAmount(user_id, "lighter")
		if consultItem[1] <= 0 then
			return
		end

		Active[user_id] = os.time() + 30
		TriggerClientEvent("Progress", source, 30000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_aa_smoke@male@idle_a", "idle_c", "prop_cs_ciggy_01", 49, 28422)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.weedTimer(user_id, 1)
					vRP.downgradeHunger(user_id, 5)
					vRP.downgradeThirst(user_id, 5)
					vRP.downgradeStress(user_id, 20)
					vPLAYER.movementClip(source, "move_m@shadyped@a")
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["lean"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 3
		TriggerClientEvent("Progress", source, 3000)
		TriggerClientEvent("inventory:Close", source)
		vRPC.playAnim(source, true, { "mp_suicide", "pill" }, true)
		TriggerClientEvent("inventory:Buttons", source, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.chemicalTimer(user_id, 10)
					vRP.downgradeStress(user_id, 25)
					TriggerClientEvent("cleanEffectDrugs", source)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["ecstasy"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 3
		TriggerClientEvent("Progress", source, 3000)
		TriggerClientEvent("inventory:Close", source)
		vRPC.playAnim(source, true, { "mp_suicide", "pill" }, true)
		TriggerClientEvent("inventory:Buttons", source, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.chemicalTimer(user_id, 10)
					TriggerClientEvent("setEcstasy", source)
					TriggerClientEvent("setEnergetic", source, 10, 1.30)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cocaine"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 5
		TriggerClientEvent("Progress", source, 5000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.chemicalTimer(user_id, 10)
					vRP.downgradeHunger(user_id, 55)
					vRP.downgradeThirst(user_id, 55)
					TriggerClientEvent("setCocaine", source)

					TriggerClientEvent("setEnergetic", source, 15, 1.20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["meth"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if Armors[user_id] then
			if os.time() < Armors[user_id] then
				local armorTimers = parseInt(Armors[user_id] - os.time())
				TriggerClientEvent("Notify", source, "important", "Atenção", "Aguarde <b>" .. armorTimers ..
					" segundos</b>.", "amarelo", 5000)
				return
			end
		end

		Active[user_id] = os.time() + 10
		TriggerClientEvent("Progress", source, 10000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					TriggerClientEvent("setMeth", source)
					Armors[user_id] = os.time() + 30
					vRP.chemicalTimer(user_id, 10)
					vRP.setArmour(source, 20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cigarette"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local consultItem = vRP.getInventoryItemAmount(user_id, "lighter")
		if consultItem[1] <= 0 then
			TriggerClientEvent("Notify", source, "important", "Atenção", "Você não possui um isqueiro", 5000)
			return
		end

		Active[user_id] = os.time() + 60
		TriggerClientEvent("Progress", source, 60000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_aa_smoke@male@idle_a", "idle_c", "prop_cs_ciggy_01", 49, 28422)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 35)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	["vape"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 10
		TriggerClientEvent("Progress", source, 10000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop",
			"ba_prop_battle_vape_01", 49, 18905, 0.08, -0.00, 0.03, -150.0, 90.0, -10.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRP.downgradeStress(user_id, 50)
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["medkit"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (Healths[user_id] == nil or os.time() > Healths[user_id]) then
			if vRP.getHealth(source) > 101 and vRP.getHealth(source) < 200 then
				Active[user_id] = os.time() + 20
				TriggerClientEvent("Progress", source, 20000)
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source, false)
						TriggerClientEvent("inventory:Buttons", source, false)

						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							TriggerClientEvent("resetBleeding", source)
							Healths[user_id] = os.time() + 120
							vRPC.updateHealth(source, 40)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			else
				TriggerClientEvent("Notify", source, "important", "Atenção",
					"Não pode utilizar de vida cheia ou nocauteado.", 5000)
			end
		else
			local healTimers = parseInt(Healths[user_id] - os.time())
			TriggerClientEvent("Notify", source, "azul", "Aguarde <b>" .. healTimers .. " segundos</b>.", 5000)
		end
	end,
	["gauze"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 5
		TriggerClientEvent("Progress", source, 5000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "amb@world_human_clipboard@male@idle_a", "idle_c" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					TriggerClientEvent("sounds:source", source, "bandage", 0.5)
					TriggerClientEvent("resetBleeding", source)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["binoculars"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local ped = GetPlayerPed(source)
		if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
			return
		end

		Active[user_id] = os.time() + 5
		TriggerClientEvent("Progress", source, 5000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				TriggerClientEvent("useBinoculos", source)
				TriggerClientEvent("inventory:Buttons", source, false)
				vRPC.createObjects(source, "amb@world_human_binoculars@male@enter", "enter", "prop_binoc_01", 50, 28422)
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["evidence01"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vector3(312.45, -562.14, 43.29))

		if distance <= 1.0 then
			local userSerial = vRP.userSerial(splitName[2])
			if userSerial then
				local identity = vRP.userIdentity(userSerial["id"])
				if identity then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Evidência de " .. identity["name2"] .. ".",
						"amarelo", 5000)
				end
			end
		end
	end,
	["evidence02"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vector3(312.45, -562.14, 43.29))

		if distance <= 1.0 then
			local userSerial = vRP.userSerial(splitName[2])
			if userSerial then
				local identity = vRP.userIdentity(userSerial["id"])
				if identity then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Evidência de " .. identity["name2"] .. ".",
						"amarelo", 5000)
				end
			end
		end
	end,
	["evidence03"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vector3(312.45, -562.14, 43.29))

		if distance <= 1.0 then
			local userSerial = vRP.userSerial(splitName[2])
			if userSerial then
				local identity = vRP.userIdentity(userSerial["id"])
				if identity then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Evidência de " .. identity["name2"] .. ".",
						"amarelo", 5000)
				end
			end
		end
	end,
	["evidence04"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)
		local distance = #(coords - vector3(312.45, -562.14, 43.29))

		if distance <= 1.0 then
			local userSerial = vRP.userSerial(splitName[2])
			if userSerial then
				local identity = vRP.userIdentity(userSerial["id"])
				if identity then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Evidência de " .. identity["name2"] .. ".",
						"amarelo", 5000)
				end
			end
		end
	end,
	["camera"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local ped = GetPlayerPed(source)
		if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") then
			return
		end

		Active[user_id] = os.time() + 5
		TriggerClientEvent("Progress", source, 5000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				TriggerClientEvent("useCamera", source)
				TriggerClientEvent("inventory:Buttons", source, false)
				vRPC.createObjects(source, "amb@world_human_paparazzi@male@base", "base", "prop_pap_camera_01", 49, 28422)
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["teddy"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		vRPC.createObjects(source, "impexp_int-0", "mp_m_waremech_01_dual-0", "v_ilev_mr_rasberryclean", 49, 24817, -0.20,
			0.46, -0.016, -180.0, -90.0, 0.0)
	end,
	["rose"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		vRPC.createObjects(source, "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "prop_single_rose", 49,
			18905, 0.13, 0.15, 0.0, -100.0, 0.0, -20.0)

	end,
	["firecracker"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vRPC.inVehicle(source) and not vCLIENT.checkCracker(source) then
			Active[user_id] = os.time() + 3
			TriggerClientEvent("Progress", source, 3000)
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("inventory:Buttons", source, true)
			vRPC.playAnim(source, false, { "anim@mp_fireworks", "place_firework_3_box" }, true)

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					vRPC.stopAnim(source, false)
					TriggerClientEvent("inventory:Buttons", source, false)

					if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
						TriggerClientEvent("inventory:Firecracker", source)
					end
				end

				Citizen.Wait(100)
			until Active[user_id] == nil
		end
		
	end,
	["gsrkit"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local otherPlayer = vRPC.nearestPlayer(source)
		if otherPlayer then
			Active[user_id] = os.time() + 10
			TriggerClientEvent("Progress", source, 10000)
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("inventory:Buttons", source, true)

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					TriggerClientEvent("inventory:Buttons", source, false)

					if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
						if cRP.gsrCheck(otherPlayer) then
							TriggerClientEvent("Notify", source, "check", "Sucesso", "Resultado positivo.", "verde", 5000)
						else
							TriggerClientEvent("Notify", source, "important", "Atenção", "Resultado negativo.", "amarelo", 3000)
						end
					end
				end

				Citizen.Wait(100)
			until Active[user_id] == nil
		end
	end,
	["gdtkit"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local otherPlayer = vRPC.nearestPlayer
		if otherPlayer then
			local nuser_id = vRP.getUserId(otherPlayer)
			local identity = vRP.userIdentity(nuser_id)
			if nuser_id and identity then
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress", source, 10000)
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						TriggerClientEvent("inventory:Buttons", source, false)

						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							local weed = vRP.weedReturn(nuser_id)
							local chemical = vRP.chemicalReturn(nuser_id)
							local alcohol = vRP.alcoholReturn(nuser_id)

							local chemStr = ""
							local alcoholStr = ""
							local weedStr = ""

							if chemical == 0 then
								chemStr = "Nenhum"
							elseif chemical == 1 then
								chemStr = "Baixo"
							elseif chemical == 2 then
								chemStr = "Médio"
							elseif chemical >= 3 then
								chemStr = "Alto"
							end

							if alcohol == 0 then
								alcoholStr = "Nenhum"
							elseif alcohol == 1 then
								alcoholStr = "Baixo"
							elseif alcohol == 2 then
								alcoholStr = "Médio"
							elseif alcohol >= 3 then
								alcoholStr = "Alto"
							end

							if weed == 0 then
								weedStr = "Nenhum"
							elseif weed == 1 then
								weedStr = "Baixo"
							elseif weed == 2 then
								weedStr = "Médio"
							elseif weed >= 3 then
								weedStr = "Alto"
							end

							openIdentity[user_id] = true
							TriggerClientEvent("vRP:Identity", source,
								{
									mode = "fidentity",
									nome = identity["name"] .. " " .. identity["name2"],
									nacionalidade = identity["locate"],
									porte = identity["port"],
									sangue = bloodTypes(identity["blood"])
								})
							TriggerClientEvent("Notify", source, "azul",
								"<b>Químicos:</b> " .. chemStr .. "<br><b>Álcool:</b> " ..
								alcoholStr .. "<br><b>Drogas:</b> " .. weedStr, 8000)
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			end
		end
	end,
	["identity"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local owner = splitName[2]
		if owner then
			TriggerEvent("RenderIdentity", source, owner)
			TriggerClientEvent("inventory:Close", source)
		else
			TriggerEvent("RenderIdentity", source, owner)
			TriggerClientEvent("inventory:Close", source)
		end
		return
	end,
	["carta"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("carta:toggleNUI", source, true) 
	end,
	["tablet"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("fortal_police:openPanel", source)
	end,
	["nitro"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vRPC.inVehicle(source) then
			local vehicle, vehNet, vehPlate = vRPC.vehList(source, 4)
			if vehicle then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 10
				TriggerClientEvent("Progress", source, 10000)
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				local activePlayers = vRPC.activePlayers(source)
				for _, v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncHoodOptions", v, vehNet, "open")
					end)
				end

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source, false)
						TriggerClientEvent("inventory:Buttons", source, false)

						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							local Nitro = GlobalState["Nitro"]
							Nitro[vehPlate] = 200
							GlobalState["Nitro"] = Nitro
						end
					end

					Citizen.Wait(100)
				until Active[user_id] == nil

				local activePlayers = vRPC.activePlayers(source)
				for _, v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncHoodOptions", v, vehNet, "close")
					end)
				end
			end
		end
	end,
	["vest"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if Armors[user_id] then
			if os.time() < Armors[user_id] then
				local armorTimers = parseInt(Armors[user_id] - os.time())
				TriggerClientEvent("Notify", source, "important", "Atenção", "Aguarde <b>" .. armorTimers ..
					" segundos</b>.", "amarelo", 5000)
				return
			end
		end

		Active[user_id] = os.time() + 30
		TriggerClientEvent("Progress", source, 30000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "clothingtie", "try_tie_negative_a" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					Armors[user_id] = os.time() + 200
					vRP.setArmour(source, 100)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["GADGET_PARACHUTE"] = function(source,user_id,totalName,Amount,Slot,splitName)
		Active[user_id] = os.time() + 5
		TriggerClientEvent("Progress", source, 5000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vCLIENT.parachuteColors(source)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["advtoolbox"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vRPC.inVehicle(source) then
			local vehicle, vehNet, vehPlate = vRPC.vehList(source, 4)
			if vehicle then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 100
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				local activePlayers = vRPC.activePlayers(source)
				for _, v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncHoodOptions", v, vehNet, "open")
					end)
				end

				if vTASKBAR.taskMechanic(source) then
					local numberItem = splitName[2]
					if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
						numberItem = numberItem - 1

						if numberItem > 0 then
							vRP.giveInventoryItem(user_id, "advtoolbox-" .. numberItem, 1, false)
						end

						local activePlayers = vRPC.activePlayers(source)
						for _, v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("inventory:repairVehicle", v, vehNet, vehPlate)
							end)
						end

						vRP.upgradeStress(user_id, 2)
					end
				end

				local activePlayers = vRPC.activePlayers(source)
				for _, v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncHoodOptions", v, vehNet, "close")
					end)
				end

				TriggerClientEvent("inventory:Buttons", source, false)
				vRPC.stopAnim(source, false)
				Active[user_id] = nil
			end
		end
	end,
	["toolbox"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vRPC.inVehicle(source) then
			local vehicle, vehNet, vehPlate = vRPC.vehList(source, 4)
			if vehicle then
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 100
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, false, { "mini@repair", "fixing_a_player" }, true)

				local activePlayers = vRPC.activePlayers(source)
				for _, v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncHoodOptions", v, vehNet, "open")
					end)
				end

				if vTASKBAR.taskMechanic(source) then
					if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
						local activePlayers = vRPC.activePlayers(source)
						for _, v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("inventory:repairVehicle", v, vehNet, vehPlate)
							end)
						end

						vRP.upgradeStress(user_id, 2)
					end
				end

				local activePlayers = vRPC.activePlayers(source)
				for _, v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncHoodOptions", v, vehNet, "close")
					end)
				end

				TriggerClientEvent("inventory:Buttons", source, false)
				vRPC.stopAnim(source, false)
				Active[user_id] = nil
			end
		end
	end,
	["lockpick"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local vehicle, vehNet, vehPlate, vehName, vehBlock, vehHealth, vehClass = vRPC.vehList(source, 4)
		if vehicle then
			if vehClass == 15 or vehClass == 16 or vehClass == 19 then
				return
			end

			if vRPC.inVehicle(source) and not vCLIENT.DismantleStatus(source) then
				vRPC.stopActived(source)
				vGARAGE.startAnimHotwired(source)
				Active[user_id] = os.time() + 100
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)

				if vTASKBAR.taskLockpick(source) then
					vRP.upgradeStress(user_id, 2)
					TriggerEvent("plateEveryone", vehPlate)
					TriggerEvent("platePlayers", vehPlate, user_id)
					local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
					if GetVehicleDoorLockStatus(idNetwork) == 2 then
						SetVehicleDoorsLocked(idNetwork, 1)
					end
					TriggerClientEvent("Notify", source, "check", "Sucesso", "Roubo concluído.", "verde",5000)
					if vCLIENT.DismantleStatus(source) then
						TriggerClientEvent("target:Dismantles", source)
						local police = vRP.numPermission("Police")

						for _, v in pairs(police) do
							TriggerClientEvent("police:trackStolenVehicle", v, vehNet)
						end

						TriggerClientEvent("police:trackStolenVehicle", source, vehNet)
					end

					if math.random(100) >= 75 then
						local activePlayers = vRPC.activePlayers(source)
						for _, v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("inventory:vehicleAlarm", v, vehNet, vehPlate)
							end)
						end

						local coords = vRPC.getEntityCoords(source)
						local policeResult = vRP.numPermission("Police")
						for k, v in pairs(policeResult) do
							async(function()
								TriggerClientEvent("NotifyPush", v,
									{
										code = 31,
										title = "Roubo de Veículo",
										x = coords["x"],
										y = coords["y"],
										z = coords["z"],
										vehicle = vehicleName(vehName) .. " - " .. vehPlate,
										time = "Recebido às " .. os.date("%H:%M"),
										blipColor = 44
									})
							end)
						end

						if vCLIENT.DismantleStatus(source) then
							TriggerClientEvent("inventory:DisPed", source)
						end
					end
				else
					TriggerClientEvent("Notify", source, "important", "Atenção", "Você falhou! Tente novamente.","amarelo", 5000)
				end

				if parseInt(math.random(1000)) >= 900 then
					vRP.removeInventoryItem(user_id, totalName, 1, false)
					TriggerClientEvent("itensNotify", source, { "quebrou", "lockpick", 1, "Lockpick de Alumínio" })
				end

				TriggerClientEvent("inventory:Buttons", source, false)
				vGARAGE.stopAnimHotwired(source, vehicle)
				Active[user_id] = nil
			else
				vRPC.stopActived(source)
				Active[user_id] = os.time() + 100
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, false, { "missfbi_s4mop", "clean_mop_back_player" }, true)

				if vCLIENT.DismantleStatus(source) and vehPlate == "DISM" .. (1000 + user_id) then
					if vTASKBAR.taskLockpick(source) then
						vRP.upgradeStress(user_id, 2)
						TriggerEvent("plateEveryone", vehPlate)
						local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
						if GetVehicleDoorLockStatus(idNetwork) == 2 then
							SetVehicleDoorsLocked(idNetwork, 1)
						end
						TriggerClientEvent("Notify", source, "check", "Sucesso", "Roubo concluído.", "verde",5000)

						local activePlayers = vRPC.activePlayers(source)
						for _, v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("inventory:vehicleAlarm", v, vehNet, vehPlate)
							end)
						end

						if vCLIENT.DismantleStatus(source) then
							TriggerClientEvent("target:Dismantles", source)
							local police = vRP.numPermission("Police")
							for _, v in pairs(police) do
								TriggerClientEvent("police:trackStolenVehicle", v, vehNet)
							end

							TriggerClientEvent("police:trackStolenVehicle", source, vehNet)
						end

						if math.random(100) >= 75 then
							local coords = vRPC.getEntityCoords(source)
							local policeResult = vRP.numPermission("Police")
							for k, v in pairs(policeResult) do
								async(function()
									TriggerClientEvent("NotifyPush", v,
										{
											code = 31,
											title = "Roubo de Veículo",
											x = coords["x"],
											y = coords["y"],
											z = coords["z"],
											vehicle = vehicleName(vehName) .. " - " .. vehPlate,
											time = "Recebido às " .. os.date("%H:%M"),
											blipColor = 44
										})
								end)
							end

							if vCLIENT.DismantleStatus(source) then
								TriggerClientEvent("inventory:DisPed", source)
								
							end
						end
					else
						TriggerClientEvent("Notify", source, "important", "Atenção", "Você falhou! Tente novamente.","amarelo", 5000)
					end
				else
					if vTASKBAR.taskLockpick(source) then
						vRP.upgradeStress(user_id, 2)
						TriggerEvent("plateEveryone", vehPlate)
						local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
						if GetVehicleDoorLockStatus(idNetwork) == 2 then
							SetVehicleDoorsLocked(idNetwork, 1)
						end
						TriggerClientEvent("Notify", source, "check", "Sucesso", "Roubo concluído.", "verde",5000)


						if math.random(100) >= 75 then
							local activePlayers = vRPC.activePlayers(source)
							for _, v in ipairs(activePlayers) do
								async(function()
									TriggerClientEvent("inventory:vehicleAlarm", v, vehNet, vehPlate)
								end)
							end

							local coords = vRPC.getEntityCoords(source)
							local policeResult = vRP.numPermission("Police")
							for k, v in pairs(policeResult) do
								async(function()
									TriggerClientEvent("NotifyPush", v,
										{
											code = 31,
											title = "Roubo de Veículo",
											x = coords["x"],
											y = coords["y"],
											z = coords["z"],
											vehicle = vehicleName(vehName) .. " - " .. vehPlate,
											time = "Recebido às " .. os.date("%H:%M"),
											blipColor = 44
										})
								end)
							end
						end
					else
						TriggerClientEvent("Notify", source, "important", "Atenção", "Você falhou! Tente novamente.","amarelo", 5000)
					end
				end

				if parseInt(math.random(1000)) >= 900 then
					vRP.removeInventoryItem(user_id, totalName, 1, false)
					TriggerClientEvent("itensNotify", source, { "quebrou", "lockpick", 1, "Lockpick de Alumínio" })
				end

				TriggerClientEvent("inventory:Buttons", source, false)
				vRPC.stopAnim(source, false)
				Active[user_id] = nil
			end
		end
	end,
	["lockpick2"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vPLAYER.getHandcuff(source) then
			local homeName = exports["homes"]:homesTheft(source)
			if homeName then
				vRPC.stopActived(source)
				vRP.upgradeStress(user_id, 2)
				Active[user_id] = os.time() + 100
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, false, { "missheistfbi3b_ig7", "lift_fibagent_loop" }, false)

				if vTASKBAR.taskLockpick(source) then
					TriggerEvent("fx:RouberysProperty", source, homeName)
				end

				if parseInt(math.random(1000)) >= 900 then
					vRP.generateItem(user_id, "brokenpick", 1, false)
					vRP.removeInventoryItem(user_id, totalName, 1, false)
					TriggerClientEvent("itensNotify", source, { "quebrou", "lockpick2", 1, "Lockpick de Cobre" })
				end

				TriggerClientEvent("inventory:Buttons", source, false)
				vRPC.stopAnim(source, false)
				Active[user_id] = nil
			end
		end
	end,
	["repairkit01"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		local source = source
		local user_id = vRP.getUserId(source)
		TriggerClientEvent("inventory:Close", source)
	
		if user_id then
			local userInventory = vRP.userInventory(user_id)
			local hasCommonItemsToRepair = false
	
			for slot, item in pairs(userInventory) do
				if itemRepair(item.item) == "repairkit01" then 
					local splitName = splitString(item.item, "-")
					local dataTable = vRP.getDatatable(user_id)
					dataTable["inventory"][slot] = { item = splitName[1] .. "-" .. os.time(), amount = item.amount }
					vRP.setDatatable(user_id, "inventory", dataTable["inventory"])
					hasCommonItemsToRepair = true
				end
			end
	
			if hasCommonItemsToRepair then
				vRP.tryGetInventoryItem(user_id, "repairkit04", 1, false)
				TriggerClientEvent("Notify", source, "verde", "Os itens foram reparados com sucesso.", 5000)
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não possui itens comuns danificados para reparar.", 5000)
			end
		end
	end,
	
	["repairkit02"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		local source = source
		local user_id = vRP.getUserId(source)
		TriggerClientEvent("inventory:Close", source)
	
		if user_id then
			local userInventory = vRP.userInventory(user_id)
			local hasCommonItemsToRepair = false
	
			for slot, item in pairs(userInventory) do
				if itemRepair(item.item) == "repairkit02" then 
					local splitName = splitString(item.item, "-")
					local dataTable = vRP.getDatatable(user_id)
					dataTable["inventory"][slot] = { item = splitName[1] .. "-" .. os.time(), amount = item.amount }
					vRP.setDatatable(user_id, "inventory", dataTable["inventory"])
					hasCommonItemsToRepair = true
				end
			end
	
			if hasCommonItemsToRepair then
				vRP.tryGetInventoryItem(user_id, "repairkit04", 1, false)
				TriggerClientEvent("Notify", source, "verde", "Os itens foram reparados com sucesso.", 5000)
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não possui itens comuns danificados para reparar.", 5000)
			end
		end
	end,
	
	["repairkit03"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		local source = source
		local user_id = vRP.getUserId(source)
		TriggerClientEvent("inventory:Close", source)
	
		if user_id then
			local userInventory = vRP.userInventory(user_id)
			local hasCommonItemsToRepair = false
	
			for slot, item in pairs(userInventory) do
				if itemRepair(item.item) == "repairkit03" then 
					local splitName = splitString(item.item, "-")
					local dataTable = vRP.getDatatable(user_id)
					dataTable["inventory"][slot] = { item = splitName[1] .. "-" .. os.time(), amount = item.amount }
					vRP.setDatatable(user_id, "inventory", dataTable["inventory"])
					hasCommonItemsToRepair = true
				end
			end
	
			if hasCommonItemsToRepair then
				vRP.tryGetInventoryItem(user_id, "repairkit04", 1, false)
				TriggerClientEvent("Notify", source, "verde", "Os itens foram reparados com sucesso.", 5000)
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não possui itens comuns danificados para reparar.", 5000)
			end
		end
	end,
	
	["repairkit04"] = function(source,user_id,totalName,Amount,Slot,splitName) 
		local source = source
		local user_id = vRP.getUserId(source)
		TriggerClientEvent("inventory:Close", source)
	
		if user_id then
			local userInventory = vRP.userInventory(user_id)
			local hasCommonItemsToRepair = false
	
			for slot, item in pairs(userInventory) do
				if itemRepair(item.item) == "repairkit04" then 
					local splitName = splitString(item.item, "-")
					local dataTable = vRP.getDatatable(user_id)
					dataTable["inventory"][slot] = { item = splitName[1] .. "-" .. os.time(), amount = item.amount }
					vRP.setDatatable(user_id, "inventory", dataTable["inventory"])
					hasCommonItemsToRepair = true
				end
			end
	
			if hasCommonItemsToRepair then
				vRP.tryGetInventoryItem(user_id, "repairkit04", 1, false)
				TriggerClientEvent("Notify", source, "verde", "Os itens foram reparados com sucesso.", 5000)
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não possui itens comuns danificados para reparar.", 5000)
			end
		end
	end,
	["blocksignal"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vPLAYER.getHandcuff(source) then
			local vehicle, vehNet, vehPlate = vRPC.vehList(source, 4)
			if vehicle and vRPC.inVehicle(source) then
				if exports["black_garages_v2"]:vehSignal(vehPlate) == nil then
					vRPC.stopActived(source)
					vGARAGE.startAnimHotwired(source)
					Active[user_id] = os.time() + 100
					TriggerClientEvent("inventory:Close", source)
					TriggerClientEvent("inventory:Buttons", source, true)

					if vTASKBAR.taskLockpick(source) then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							TriggerClientEvent("Notify", source, "check", "Sucesso", "Bloqueador de Sinal instalado.", "verde",
								5000)
							TriggerEvent("signalRemove", vehPlate)
						end
					end

					TriggerClientEvent("inventory:Buttons", source, false)
					vGARAGE.stopAnimHotwired(source)
					Active[user_id] = nil
				else
					TriggerClientEvent("Notify", source, "important", "Atenção", ">Bloqueador de Sinal já instalado.",
						"amarelo", 5000)
				end
			end
		end
	end,
	["postit"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("postit:initPostit", source)
	end,
	["energetic"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "prop_energy_drink", 49, 60309, 0.0, 0.0, 0.0,
			0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					TriggerClientEvent("setEnergetic", source, 20, 1.10)
					vRP.upgradeStress(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["absolut"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "p_whiskey_notop", 49, 28422,
			0.0, 0.0, 0.05, 0.0, 0.0, 0.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.alcoholTimer(user_id, 1)
					vRP.upgradeThirst(user_id, 20)
					TriggerClientEvent("setDrunkTime", source, 90)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["hennessy"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "p_whiskey_notop", 49, 28422,
			0.0, 0.0, 0.05, 0.0, 0.0, 0.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.alcoholTimer(user_id, 1)
					vRP.upgradeThirst(user_id, 20)
					TriggerClientEvent("setDrunkTime", source, 300)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["chandon"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_beer_blr", 49, 28422, 0.0,
			0.0, -0.10, 0.0, 0.0, 0.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.alcoholTimer(user_id, 1)
					vRP.upgradeThirst(user_id, 20)
					TriggerClientEvent("setDrunkTime", source, 300)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["dewars"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_drinking@beer@male@idle_a", "idle_a", "prop_beer_blr", 49, 28422, 0.0,
			0.0, -0.10, 0.0, 0.0, 0.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.alcoholTimer(user_id, 1)
					vRP.upgradeThirst(user_id, 20)
					TriggerClientEvent("setDrunkTime", source, 300)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil

	end,
	["scanner"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Scanners[user_id] = true
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		TriggerClientEvent("inventory:updateScanner", source, true)
		vRPC.createObjects(source, "mini@golfai", "wood_idle_a", "w_am_digiscanner", 49, 18905, 0.15, 0.1, 0.0, -270.0,
			-180.0, -170.0)
	end,
	["orangejuice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 50)
					vRP.downgradeStress(user_id, 20)
					vRP.generateItem(user_id, "emptybottle", 1)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["oragrapejuice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 50)
					vRP.generateItem(user_id, "emptybottle", 1)

				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["passionjuice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 50)
					vRP.generateItem(user_id, "emptybottle", 1)

					if nameItem == "passionjuice" then
						vRP.downgradeStress(user_id, 10)
					end
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["tangejuice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 50)
					vRP.downgradeStress(user_id, 20)
					vRP.generateItem(user_id, "emptybottle", 1)

					
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["grapejuice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 50)
					vRP.downgradeStress(user_id, 20)
					vRP.generateItem(user_id, "emptybottle", 1)

					
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil 
	end,
	["strawberryjuice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 50)
					vRP.downgradeStress(user_id, 20)
					vRP.generateItem(user_id, "emptybottle", 1)

					
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["bananajuice"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 50)
					vRP.downgradeStress(user_id, 20)
					vRP.generateItem(user_id, "emptybottle", 1)

					
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["orange"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["apple"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["strawberry"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["coffee2"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["mushroom"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["tomato"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["passion"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["banana"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["tange"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["grape"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 3)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["mushroomtea"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				TriggerClientEvent("inventory:Buttons", source, false)
				vRPC.removeObjects(source, "one")
				Active[user_id] = nil

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					TriggerClientEvent("player:MushroomTea", source)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["water"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 15)
					vRP.generateItem(user_id, "emptybottle", 1)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["milkbottle"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 20)
					vRP.generateItem(user_id, "emptybottle", 1)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["sinkalmy"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 5)
					vRP.chemicalTimer(user_id, 3)
					vRP.downgradeStress(user_id, 25)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["ritmoneury"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "vw_prop_casino_water_bottle_01a", 49, 60309, 0.0,
			0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 5)
					vRP.chemicalTimer(user_id, 3)
					vRP.downgradeStress(user_id, 40)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cola"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "prop_ecola_can", 49, 60309, 0.01, 0.01, 0.05,
			0.0, 0.0, 90.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["soda"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "ng_proc_sodacan_01b", 49, 60309, 0.0, 0.0, -0.04,
			0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	
	["fishingrod"] = function(source,user_id,totalName,Amount,Slot,splitName)
        TriggerClientEvent("inventory:Close", source)
        TriggerClientEvent("inventory:Buttons", source, true)

        TriggerClientEvent("inventory:getFishingCoords", source)
    end,

	["coffee"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					TriggerClientEvent("setEnergetic", source, 10, 1.05)
					vRP.upgradeThirst(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil

	end,
	["batlepass"] = function(source,user_id,totalName,Amount,Slot,splitName)
		print(source, user_id, totalName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			TriggerClientEvent("inventory:Close", source)
			vRP.setPermission(user_id, 'batlepass')
		end
	end,
	["streamerpremium"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.giveInventoryItem(user_id, 'newgarage', 1, true)
			vRP.giveInventoryItem(user_id, 'backpack', 1, true)
			vRP.giveInventoryItem(user_id, 'dollars', 25000, true)
			vRP.setPermission(user_id, 'Streamer')
			vRP.setPermission(user_id, 'Spotify')
			TriggerClientEvent("initial_streamer:Open", source)
		end
	end,

	["foodbox"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.giveInventoryItem(user_id, 'hamburger2', 3, true)
			vRP.giveInventoryItem(user_id, 'orangejuice', 3, true)
			TriggerClientEvent("inventory:Close", source)
		end
	end,
	["foodbox2"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.giveInventoryItem(user_id, 'hamburger2', 6, true)
			vRP.giveInventoryItem(user_id, 'orangejuice', 6, true)
			TriggerClientEvent("inventory:Close", source)
		end
	end,
	["foodbox3"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.giveInventoryItem(user_id, 'hamburger2', 9, true)
			vRP.giveInventoryItem(user_id, 'orangejuice', 9, true)
			TriggerClientEvent("inventory:Close", source)
		end
	end,


	["bronzepremium"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.giveInventoryItem(user_id, 'gemstone', 30, true)
			vRP.giveInventoryItem(user_id, 'newgarage', 1, true)
			vRP.giveInventoryItem(user_id, 'backpack', 1, true)
			vRP.giveInventoryItem(user_id, 'dollars', 15000, true)
			vRP.setPermission(user_id, 'Bronze')
			local days = 30
			vRP.execute("playerdata/setUserdata",
				{ user_id = user_id, key = "Vip", value = json.encode(os.time() + (days * 24 * 60 * 60)) })
		end
	end,
	["pratapremium"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.giveInventoryItem(user_id, 'gemstone', 60, true)
			vRP.giveInventoryItem(user_id, 'newgarage', 2, true)
			vRP.giveInventoryItem(user_id, 'backpack', 3, true)
			vRP.giveInventoryItem(user_id, 'newchars', 1, true)
			vRP.giveInventoryItem(user_id, 'dollars', 35000, true)
			vRP.setPermission(user_id, 'Prata')
			local days = 30
			vRP.execute("playerdata/setUserdata",
				{ user_id = user_id, key = "Vip", value = json.encode(os.time() + (days * 24 * 60 * 60)) })
		end
	end,
	["goldpremium"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.giveInventoryItem(user_id, 'gemstone', 100, true)
			vRP.giveInventoryItem(user_id, 'newgarage', 3, true)
			vRP.giveInventoryItem(user_id, 'newchars', 1, true)
			vRP.giveInventoryItem(user_id, 'backpack', 5, true)
			vRP.giveInventoryItem(user_id, 'dollars', 80000, true)
			vRP.setPermission(user_id, 'Ouro')
			local days = 30
			vRP.execute("playerdata/setUserdata",
				{ user_id = user_id, key = "Vip", value = json.encode(os.time() + (days * 24 * 60 * 60)) })
		end
	end,
	["spotify"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.setPermission(user_id, 'Spotify')
			local days = 30
			vRP.execute("playerdata/setUserdata",
				{ user_id = user_id, key = "Vip", value = json.encode(os.time() + (days * 24 * 60 * 60)) })
		end
	end,
	["pizza"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					if nameItem == "pizza" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "pizza2" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "sushi" then
						vRP.upgradeHunger(user_id, 30)
					elseif nameItem == "nigirizushi" then
						vRP.upgradeHunger(user_id, 25)
					end
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["pizza2"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					if nameItem == "pizza" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "pizza2" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "sushi" then
						vRP.upgradeHunger(user_id, 30)
					elseif nameItem == "nigirizushi" then
						vRP.upgradeHunger(user_id, 25)
					end
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["sushi"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					if nameItem == "pizza" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "pizza2" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "sushi" then
						vRP.upgradeHunger(user_id, 30)
					elseif nameItem == "nigirizushi" then
						vRP.upgradeHunger(user_id, 25)
					end
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["nigirizushi"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					if nameItem == "pizza" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "pizza2" then
						vRP.upgradeHunger(user_id, 40)
					elseif nameItem == "sushi" then
						vRP.upgradeHunger(user_id, 30)
					elseif nameItem == "nigirizushi" then
						vRP.upgradeHunger(user_id, 25)
					end
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["hamburger"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	--------------------------- UWU CAFÉ - BUBBLE TEAS
	["blue_boba"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "blue_boba", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["green_boba"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "green_boba", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["orange_boba"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "orange_boba", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["pink_boba"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "pink_boba", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 15)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	--------------------------- UWU CAFÉ - CAT CUPS
	["cat_hotchoc"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "cat_hotchoc", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_latte"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "cat_latte", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_matcha"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "cat_matcha", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_tea"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "cat_tea", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	--------------------------- UWU CAFÉ - DONUTS
	["bear_donut"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "bear_donut", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_donut_a"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_donut_a", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_donut_b"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_donut_b", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_donut_c"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_donut_c", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_donut_d"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_donut_d", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_donut_e"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_donut_e", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_donut_f"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_donut_f", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["raccoon_donut"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "raccoon_donut", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	--------------------------- UWU CAFÉ - COMIDA
	["bentobox"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 20
		TriggerClientEvent("Progress", source, 20000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "bentobox", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 25)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_burrito"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 20
		TriggerClientEvent("Progress", source, 20000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_burrito", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 25)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	--------------------------- UWU CAFÉ - FRAPPES
	["berry_frappe"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "berry_frappe", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 18)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["caramel_frappe"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "caramel_frappe", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 18)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["matcha_frappe"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "matcha_frappe", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 18)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["mocha_frappe"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrinking", "loop_bottle", "mocha_frappe", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeThirst(user_id, 18)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	--------------------------- UWU CAFÉ - RAMEN
	["chicken_ramen"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 25
		TriggerClientEvent("Progress", source, 25000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "chicken_ramen", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 30)
					vRP.upgradeThirst(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["miso_bowl"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 25
		TriggerClientEvent("Progress", source, 25000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "miso_bowl", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 30)
					vRP.upgradeThirst(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["pork_ramen"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 25
		TriggerClientEvent("Progress", source, 25000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "pork_ramen", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 30)
					vRP.upgradeThirst(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["tofu_ramen"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 25
		TriggerClientEvent("Progress", source, 25000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "tofu_ramen", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 30)
					vRP.upgradeThirst(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,

	--------------------------- UWU CAFÉ - DOCES
	["blue_mochi"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "blue_mochi", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_cake_pop"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_cake_pop", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_cookie_a"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_cookie_a", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cat_cookie_b"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "cat_cookie_b", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["green_mochi"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "green_mochi", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["orange_mochi"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "orange_mochi", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["pawcakes"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "pawcakes", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["pink_mochi"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "pink_mochi", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["taiyaki"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 12
		TriggerClientEvent("Progress", source, 12000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "taiyaki", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["hamburger2"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["hamburger3"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["hamburger4"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["hamburger5"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_cs_burger_01", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cannedsoup"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["canofbeans"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 20)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["miner"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			vRP.generateItem(user_id, "notebook", 1)
			vRP.generateItem(user_id, "techtrash", 50)
			vRP.generateItem(user_id, "aluminum", 125)
			vRP.generateItem(user_id, "sheetmetal", 15)
			TriggerClientEvent("inventory:Update", source, "updateMochila")
		end
	end,
	["weedseed"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not exports["homes"]:checkHotel(user_id) then
			TriggerClientEvent("inventory:Close", source)
			local consultItem = vRP.getInventoryItemAmount(user_id, "bucket")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Necessário possuir 1x Balde.", "amarelo",
					5000)
				return
			end

			local application, coords = vRPC.objectCoords(source, "bkr_prop_weed_med_01a")
			if application then
				local Route = GetPlayerRoutingBucket(source)
				vRP.removeInventoryItem(user_id, "bucket", 1, false)
				vRP.removeInventoryItem(user_id, totalName, 1, false)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
				exports["plants"]:initPlants("weedseed", coords, Route, "bkr_prop_weed_med_01a", user_id)
			end
		end
	end,
	["cokeseed"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not exports["homes"]:checkHotel(user_id) then
			TriggerClientEvent("inventory:Close", source)
			local consultItem = vRP.getInventoryItemAmount(user_id, "bucket")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Necessário possuir 1x Balde.", "amarelo",
					5000)
				return
			end

			local application, coords = vRPC.objectCoords(source, "bkr_prop_weed_med_01a")
			if application then
				local Route = GetPlayerRoutingBucket(source)
				vRP.removeInventoryItem(user_id, "bucket", 1, false)
				vRP.removeInventoryItem(user_id, totalName, 1, false)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
				exports["plants"]:initPlants("cokeseed", coords, Route, "bkr_prop_weed_med_01a", user_id)
			end
		end
	end,
	["weed"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local consultItem = vRP.getInventoryItemAmount(user_id,"weed")
		local consultItem2 = vRP.getInventoryItemAmount(user_id,"silk")
		if consultItem[1] and consultItem2[1] >= Amount then
			vCLIENT.blockButtons(source,true)
			
	
			Active[user_id] = os.time() + parseInt(Amount * 5)
			TriggerClientEvent("Progress",source,parseInt(Amount*5000))
			TriggerClientEvent("inventory:Close",source)
			TriggerClientEvent("inventory:blockButtons",source,true)
			vRPC.playAnim(source,false,{"amb@world_human_clipboard@male@idle_a","idle_c"},true)
	
	
			repeat
				if os.time() >= parseInt(Active[user_id]) then
						TriggerClientEvent("inventory:blockButtons",source,false)
						Active[user_id] = nil
						vRPC.stopAnim(source,false)
	
						if vRP.tryGetInventoryItem(user_id,"weed",Amount,true,slot) and vRP.tryGetInventoryItem(user_id,"silk",Amount,true) then
								vRP.giveInventoryItem(user_id,"joint",Amount,true)
						end
				end
				Citizen.Wait(100)
			until Active[user_id] == nil
		end
	end,
	["mushseed"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local rand = math.random(2)
		TriggerClientEvent("inventory:Close", source)
		local application, coords = vRPC.objectCoords(source, "prop_stoneshroom1" .. rand)
		if application then
			local Route = GetPlayerRoutingBucket(source)
			vRP.removeInventoryItem(user_id, totalName, 1, false)
			TriggerClientEvent("inventory:Update", source, "updateMochila")
			exports["plants"]:initPlants("mushseed", coords, Route, "prop_stoneshroom1" .. rand, user_id)
		end
	end,
	["tablecoke"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local favela = cRP.favelaDistance(source)
		if favela == true then
			TriggerClientEvent("inventory:Close", source)
			local application, coords, heading = vRPC.objectCoords(source, "bkr_prop_coke_table01a")
			if application then
				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until Objects[tostring(Number)] == nil

					Objects[tostring(Number)] = {
						x = mathLegth(coords["x"]),
						y = mathLegth(coords["y"]),
						z = mathLegth(coords["z"]),
						h = heading,
						object = "bkr_prop_coke_table01a",
						item = "tablecoke",
						distance = 50,
						mode = "1"
					}
					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
					TriggerClientEvent("inventory:Close", source)
				end
			end
		end
	end,
	["tablemeth"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local favela = cRP.favelaDistance(source)

		if favela == true then
			TriggerClientEvent("inventory:Close", source)
			local application, coords, heading = vRPC.objectCoords(source, "bkr_prop_meth_table01a")

			if application then
				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until Objects[tostring(Number)] == nil

					Objects[tostring(Number)] = {
						x = mathLegth(coords["x"]),
						y = mathLegth(coords["y"]),
						z = mathLegth(coords["z"]),
						h = heading,
						object = "bkr_prop_meth_table01a",
						item = totalName,
						distance = 50,
						mode = "1"
					}
					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
					TriggerClientEvent("inventory:Close", source)
				end
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado",
				"Você precisa estar em uma favela para poder montar a mesa", "vermelho", 5000)
		end
	end,
	["tableweed"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local favela = cRP.favelaDistance(source)
		if favela == true then
			TriggerClientEvent("inventory:Close", source)
			local application, coords, heading = vRPC.objectCoords(source, "bkr_prop_weed_table_01a")
			if application then
				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until Objects[tostring(Number)] == nil

					Objects[tostring(Number)] = {
						x = mathLegth(coords["x"]),
						y = mathLegth(coords["y"]),
						z = mathLegth(coords["z"]),
						h = heading,
						object = "bkr_prop_weed_table_01a",
						item = totalName,
						distance = 50,
						mode = "1"
					}
					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
					TriggerClientEvent("inventory:Close", source)
				end
			end
		end
	end,
	["tablelean"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local favela = cRP.favelaDistance(source)
		if favela == true then
			TriggerClientEvent("inventory:Close", source)
			local application, coords, heading = vRPC.objectCoords(source, "bkr_prop_weed_table_01a")
			if application then
				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					local Number = 0

					repeat
						Number = Number + 1
					until Objects[tostring(Number)] == nil

					Objects[tostring(Number)] = {
						x = mathLegth(coords["x"]),
						y = mathLegth(coords["y"]),
						z = mathLegth(coords["z"]),
						h = heading,
						object = "bkr_prop_weed_table_01a",
						item = totalName,
						distance = 50,
						mode = "1"
					}
					TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
					TriggerClientEvent("inventory:Close", source)
				end
			end
		end
	end,
	["tableoxy"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		local application, coords, heading = vRPC.objectCoords(source, "bkr_prop_weed_table_01a")
		if application then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				local Number = 0

				repeat
					Number = Number + 1
				until Objects[tostring(Number)] == nil

				Objects[tostring(Number)] = {
					x = mathLegth(coords["x"]),
					y = mathLegth(coords["y"]),
					z = mathLegth(coords["z"]),
					h = heading,
					object = "bkr_prop_weed_table_01a",
					item = totalName,
					distance = 50,
					mode = "1"
				}
				TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				TriggerClientEvent("inventory:Close", source)
			end
		end
	end,
	["adrenaline"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local distance = vCLIENT.adrenalineDistance(source)
		local parAmount = vRP.numPermission("Paramedic")
		if distance then
			local otherPlayer = vRPC.nearestPlayer(source, 2)
			if otherPlayer then
				local nuser_id = vRP.getUserId(otherPlayer)
				if nuser_id then
					if vRP.getHealth(otherPlayer) <= 101 then
						Active[user_id] = os.time() + 15
						vRPC.stopActived(source)
						TriggerClientEvent("Progress", source, 15000)
						TriggerClientEvent("inventory:Close", source)
						TriggerClientEvent("inventory:blockButtons", source, true)
						vRPC.playAnim(source, false, { "mini@cpr@char_a@cpr_str", "cpr_pumpchest" }, true)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.removeObjects(source)
								TriggerClientEvent("inventory:blockButtons", source, false)

								if vRP.tryGetInventoryItem(user_id, totalName, 1, true, slot) then
									vRP.upgradeThirst(user_id, 10)
									vRP.upgradeHunger(user_id, 10)
									vRPC.revivePlayer(otherPlayer, 110)
									TriggerClientEvent("resetBleeding", otherPlayer)
								end
							end

							Citizen.Wait(10)
						until Active[user_id] == nil
					end
				end
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado",
				"Você precisa estar no Hospital para usar a adrenalina!", "vermelho", 5000)
		end
	end,
	["campfire"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		local application, coords, heading = vRPC.objectCoords(source, "prop_beach_fire")
		if application then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				local Number = 0

				repeat
					Number = Number + 1
				until Objects[tostring(Number)] == nil

				Objects[tostring(Number)] = {
					x = mathLegth(coords["x"]),
					y = mathLegth(coords["y"]),
					z = mathLegth(coords["z"]) - 0.6,
					h = heading,
					object = "prop_beach_fire",
					item = totalName,
					distance = 50,
					mode = "2"
				}
				TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				TriggerClientEvent("inventory:Close", source)
			end
		end
	end,
	["spike"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		local application, coords, heading = vRPC.objectCoords(source, "p_ld_stinger_s")
		if application then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				local Number = 0

				repeat
					Number = Number + 1
				until Objects[tostring(Number)] == nil

				Objects[tostring(Number)] = {
					x = mathLegth(coords["x"]),
					y = mathLegth(coords["y"]),
					z = mathLegth(coords["z"]),
					h = heading,
					object = "p_ld_stinger_s",
					item = totalName,
					distance = 100,
					mode = "3"
				}			

				vRPC.playAnim(source, true, { "pickup_object", "pickup_low" }, false)
				
				TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				TriggerClientEvent("inventory:Close", source)
			end
		end
	end,
	["drone"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close",source)
		if vRP.getInventoryItemAmount(user_id,"dronecontrol")[1] >= 1 then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then

				TriggerClientEvent("Drones:UseDrone", source, {
					label = "Basit Drone 1",                      
					name = "drone",                               
					public = true,                                
					price = 10000,                                
					model = GetHashKey('ch_prop_casino_drone_02a'),       
					stats = {                        
						  speed   = 1.0,            
						  agility = 1.0,            
						  range   = 100.0,          
						  maxSpeed    = 2,             
						  maxAgility  = 2,
						  maxRange    = 200,
					},
					abilities = {
						infared     = true,  -- infared/heat-vision
						nightvision = true,  -- nightvision
						boost       = false,  -- boost
						tazer       = false,  -- tazer 
						explosive   = false,  -- explosion
					},
					restrictions = {}, 
				})
	
			end	
		else
			TriggerClientEvent("Notify",source,"amarelo","Precisa do <b>"..itemName("dronecontrol").."</b>.",5000,"Atenção")
		end
	end,
	["barrier"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		local application, coords, heading = vRPC.objectCoords(source, "prop_mp_barrier_02b")
		if application then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				local Number = 0

				repeat
					Number = Number + 1
				until Objects[tostring(Number)] == nil

				Objects[tostring(Number)] = {
					x = mathLegth(coords["x"]),
					y = mathLegth(coords["y"]),
					z = mathLegth(coords["z"]),
					h = heading,
					object = "prop_mp_barrier_02b",
					item = totalName,
					distance = 100,
					mode = "3"
				}
				TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				TriggerClientEvent("inventory:Close", source)
			end
		end
	end,
	["medicbag"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		local application, coords, heading = vRPC.objectCoords(source, "xm_prop_x17_bag_med_01a")
		if application then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				local Number = 0

				repeat
					Number = Number + 1
				until Objects[tostring(Number)] == nil

				Objects[tostring(Number)] = {
					x = mathLegth(coords["x"]),
					y = mathLegth(coords["y"]),
					z = mathLegth(coords["z"]),
					h = heading,
					object = "xm_prop_x17_bag_med_01a",
					item = totalName,
					distance = 50,
					mode = "5"
				}
				TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				TriggerClientEvent("inventory:Close", source)
			end
		end
	end,
	["chair01"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		local application, coords, heading = vRPC.objectCoords(source, "prop_off_chair_01")
		if application then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				local Number = 0

				repeat
					Number = Number + 1
				until Objects[tostring(Number)] == nil

				Objects[tostring(Number)] = {
					x = mathLegth(coords["x"]),
					y = mathLegth(coords["y"]),
					z = mathLegth(coords["z"]),
					h = heading,
					object = "prop_off_chair_01",
					item = totalName,
					distance = 50,
					mode = "4"
				}
				TriggerClientEvent("objects:Adicionar", -1, tostring(Number), Objects[tostring(Number)])
				TriggerClientEvent("inventory:Close", source)
			end
		end
	end,
	["c4"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("cashmachine:machineRobbery", source, user_id, totalName, 1, true, slot)
	end,
	["carp"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["codfish"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["catfish"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["goldenfish"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["horsefish"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["tilapia"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["pacu"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["pirarucu"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["tambaqui"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if (vRP.inventoryWeight(user_id) + (itemWeight("fishfillet") * 2)) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				vRP.generateItem(user_id, "fishfillet", 2)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end,
	["cookedfishfillet"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					if nameItem == "cookedfishfillet" then
						vRP.upgradeHunger(user_id, 20)
					else
						vRP.upgradeHunger(user_id, 30)
					end
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cookedmeat"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_player_inteat@burger", "mp_player_int_eat_burger" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					if nameItem == "cookedfishfillet" then
						vRP.upgradeHunger(user_id, 20)
					else
						vRP.upgradeHunger(user_id, 30)
					end
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["hotdog"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", "prop_cs_hotdog_01", 49,
			28422)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["sandwich"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_sandwich_01", 49, 18905,
			0.13, 0.05, 0.02, -50.0, 16.0, 60.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["tacos"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_taco_01", 49, 18905, 0.16,
			0.06, 0.02, -50.0, 220.0, 60.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["fries"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_food_bs_chips", 49, 18905,
			0.10, 0.0, 0.08, 150.0, 320.0, 160.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["milkshake"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 30)
					vRP.upgradeThirst(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cappuccino"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@world_human_aa_coffee@idle_a", "idle_a", "p_amb_coffeecup_01", 49, 28422)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 30)
					vRP.upgradeThirst(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["applelove"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_choc_ego", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 10)
					vRP.upgradeHunger(user_id, 8)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["cupcake"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_choc_ego", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 25)
					vRP.upgradeHunger(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["marshmallow"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 3
		TriggerClientEvent("Progress", source, 3000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, true, { "mp_suicide", "pill" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source)
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 8)
					vRP.upgradeHunger(user_id, 4)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["chocolate"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "prop_choc_ego", 49, 60309)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 10)
					vRP.upgradeHunger(user_id, 5)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["donut"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "amb@code_human_wander_eating_donut@male@idle_a", "idle_c", "prop_amb_donut", 49,
			28422)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.downgradeStress(user_id, 10)
					vRP.upgradeHunger(user_id, 10)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["notepad"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("notepad:createNotepad", source)
		end
	end,
	["notebook"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("notebook:openSystem", source)
	end,
	["tyres"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vRPC.inVehicle(source) then
			if not vCLIENT.checkWeapon(source, "WEAPON_WRENCH") then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Chave Inglesa não encontrada.", "amarelo",
					5000)
				return
			end

			local tyreStatus, Tyre, vehNet, vehPlate = vCLIENT.tyreStatus(source)
			if tyreStatus then
				local Vehicle = NetworkGetEntityFromNetworkId(vehNet)
				if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
					if vCLIENT.tyreHealth(source, vehNet, Tyre) ~= 1000.0 then
						vRPC.stopActived(source)
						Active[user_id] = os.time() + 100
						TriggerClientEvent("inventory:Close", source)
						TriggerClientEvent("inventory:Buttons", source, true)
						vRPC.playAnim(source, false,
							{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" },
							true)

						if vTASKBAR.taskTyre(source) then
							if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
								local activePlayers = vRPC.activePlayers(source)
								for _, v in ipairs(activePlayers) do
									async(function()
										TriggerClientEvent("inventory:repairTyre", v, vehNet, Tyre, vehPlate)
									end)
								end
							end
						end

						TriggerClientEvent("inventory:Buttons", source, false)
						vRPC.stopAnim(source, false)
						Active[user_id] = nil
					end
				end
			end
		end
	end,
	["premiumplate"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if vRPC.inVehicle(source) then
			TriggerClientEvent("inventory:Close", source)

			local vehModel = vRPC.vehicleName(source)
			local vehicle = vRP.query("vehicles/selectVehicles", { user_id = user_id, vehicle = vehModel })

			if vehicle[1] then
				local vehPlate = vRP.prompt(source, "Placa:", "")

				if not vehPlate or vehPlate == "" or string.upper(vehPlate) == "CREATIVE" then
					return
				end
				
				local namePlate = vehPlate

				local plateCheck = sanitizeString(namePlate, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", true)

				if string.len(namePlate) ~= 8 then
					TriggerClientEvent("Notify", source, "important", "Atenção",
						"O nome de definição para a placa deve conter 8 caracteres.", "amarelo", 5000)
					return
				else
					if vRP.userPlate(namePlate) then
						TriggerClientEvent("Notify", source, "cancel", "Negado",
							"A placa escolhida já está sendo registrada em outro veículo.", "vermelho", 5000)
						return
					else
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							vRP.execute("vehicles/plateVehiclesUpdate",
								{ user_id = user_id, vehicle = vehModel, plate = string.upper(namePlate) })
							TriggerClientEvent("Notify", source, "check", "Sucesso", "Placa atualizada.", "verde", 5000)
						end
					end
				end
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Modelo de veículo não encontrado.", "vermelho", 5000)
			end
		end
	end,
	["radio"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("radio:openSystem", source)
	end,
	["divingsuit"] = function(source,user_id,totalName,Amount,Slot,splitName)
		TriggerClientEvent("hud:Diving", source)
	end,
	
	["handcuff"] = function(source, user_id, totalName, Amount, Slot, splitName)
		if not vRPC.inVehicle(source) then
			local otherPlayer = vRPC.nearestPlayer(source, 0.8)
			if otherPlayer then
				if vPLAYER.getHandcuff(otherPlayer) then
					-- Desalgema
					vRPC.playAnim(source, false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }, false)
					TriggerClientEvent("inventory:Close", source)
					TriggerClientEvent("player:Commands", otherPlayer, false)
					Wait(300)
					vRPC.stopAnim(source, false)
					vPLAYER.toggleHandcuff(otherPlayer)
					TriggerClientEvent("custom:removeCuffProp", otherPlayer) -- Remove o prop da algema
					TriggerClientEvent("sounds:source", source, "uncuff", 1.0)
					TriggerClientEvent("sounds:source", otherPlayer, "uncuff", 1.0)
				else
					-- Algema
					TriggerClientEvent("player:Commands", otherPlayer, true)
					TriggerClientEvent("player:playerCarry", otherPlayer, source, "handcuff")
	
					vRPC.playAnim(otherPlayer, false, { "mp_arrest_paired", "crook_p2_back_left" }, false)
					vRPC.playAnim(source, false, { "mp_arrest_paired", "cop_p2_back_left" }, false)
	
					TriggerClientEvent("inventory:Close", source)
					Wait(300)
	
					vPLAYER.toggleHandcuff(otherPlayer)
					TriggerClientEvent("inventory:Close", otherPlayer)
	
					TriggerClientEvent("custom:applyHandcuffProp", otherPlayer) -- Cria o prop da algema
	
					TriggerClientEvent("sounds:source", source, "cuff", 1.0)
					TriggerClientEvent("sounds:source", otherPlayer, "cuff", 1.0)
	
					TriggerClientEvent("player:playerCarry", otherPlayer, source, "uncuff")
					vRPC.stopAnim(source, false)
				end
			end
		end
	end,
	
	["hood"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local otherPlayer = vRPC.nearestPlayer(source, 3)
		if otherPlayer and vPLAYER.getHandcuff(otherPlayer) then
			TriggerClientEvent("hud:Hood", otherPlayer)
			TriggerClientEvent("inventory:Close", otherPlayer)
		end
	end,
	["rope"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vRPC.inVehicle(source) then
			if Carry[user_id] then
				TriggerClientEvent("player:ropeCarry", Carry[user_id], source)
				TriggerClientEvent("player:Commands", Carry[user_id], false)
				vRPC.removeObjects(Carry[user_id])
				vRPC.removeObjects(source)
				Carry[user_id] = nil
			else
				local otherPlayer = vRPC.nearestPlayer(source, 3)
				if otherPlayer and (vRP.getHealth(otherPlayer) <= 101 or vPLAYER.getHandcuff(otherPlayer)) then
					Carry[user_id] = otherPlayer

					TriggerClientEvent("player:ropeCarry", Carry[user_id], source)
					TriggerClientEvent("player:Commands", Carry[user_id], true)
					TriggerClientEvent("inventory:Close", Carry[user_id])

					vRPC.playAnim(source, true, { "missfinale_c2mcs_1", "fin_c2_mcs_1_camman" }, true)
					vRPC.playAnim(otherPlayer, false, { "nm", "firemans_carry" }, true)
				end
			end
		end
	end,
	["premium"] = function(source,user_id,totalName,Amount,Slot,splitName)
		if not vRP.userPremium(user_id) then
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				TriggerClientEvent("inventory:Update", source, "updateMochila")
				vRP.setPremium(user_id)
			end
		else
			if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
				TriggerClientEvent("inventory:Update", source, "updateMochila")
				vRP.upgradePremium(user_id)
			end
		end
	end,
	["TrackPM"] = function(source, user_id, totalName, Amount, Slot, splitName)
		if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
			TriggerClientEvent("inventory:Update", source, "updateMochila")
			TriggerClientEvent("inventory:Close", user_id)
	
			local coords = vRPC.getEntityCoords(source)
			if coords then
				local police = vRP.getUsersByPermission("Police")
				for _, police_id in pairs(police) do
					local police_src = vRP.getUserSource(police_id)
					if police_src then
						TriggerClientEvent("police:trackBlip", police_src, coords)
					end
				end
			end
		end
	end,
	["pager"] = function(source,user_id,totalName,Amount,Slot,splitName)
		local otherPlayer = vRPC.nearestPlayer(source, 3)
		if otherPlayer then
			if vPLAYER.getHandcuff(otherPlayer) then
				local nuser_id = vRP.getUserId(otherPlayer)
				if nuser_id then
					if vRP.hasGroup(nuser_id, "Ranger") then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							vRP.removePermission(nuser_id, "Police")
							TriggerEvent("blipsystem:serviceExit", otherPlayer)
							TriggerClientEvent("radio:outServers", otherPlayer)
							vRP.updatePermission(nuser_id, "Ranger", "waitRanger")
							TriggerClientEvent("vRP:PoliceService", otherPlayer, false)
							TriggerClientEvent("service:Label", otherPlayer, "Ranger", "Entrar em Serviço", 5000)
							TriggerClientEvent("Notify", source, "important", "Atenção", "Todas as comunicações foram retiradas.",
								"amarelo", 5000)
						end
					end

					if vRP.hasGroup(nuser_id, "State") then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							vRP.removePermission(nuser_id, "Police")
							TriggerEvent("blipsystem:serviceExit", otherPlayer)
							TriggerClientEvent("radio:outServers", otherPlayer)
							vRP.updatePermission(nuser_id, "State", "waitState")
							TriggerClientEvent("vRP:PoliceService", otherPlayer, false)
							TriggerClientEvent("service:Label", otherPlayer, "State", "Entrar em Serviço", 5000)
							TriggerClientEvent("Notify", source, "important", "Atenção", "Todas as comunicações foram retiradas.",
								"amarelo", 5000)
						end
					end

					if vRP.hasGroup(nuser_id, "Lspd") then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							vRP.removePermission(nuser_id, "Police")
							vRP.updatePermission(nuser_id, "Lspd", "waitLspd")
							TriggerEvent("blipsystem:serviceExit", otherPlayer)
							TriggerClientEvent("radio:outServers", otherPlayer)
							TriggerClientEvent("vRP:PoliceService", otherPlayer, false)
							TriggerClientEvent("service:Label", otherPlayer, "Lspd", "Entrar em Serviço", 5000)
							TriggerClientEvent("Notify", source, "important", "Atenção", "Todas as comunicações foram retiradas.",
								"amarelo", 5000)
						end
					end

					if vRP.hasGroup(nuser_id, "Police") then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							TriggerEvent("blipsystem:serviceExit", otherPlayer)
							TriggerClientEvent("radio:outServers", otherPlayer)
							vRP.updatePermission(nuser_id, "Police", "waitPolice")
							TriggerClientEvent("vRP:PoliceService", otherPlayer, false)
							TriggerClientEvent("service:Label", otherPlayer, "Police", "Entrar em Serviço", 5000)
							TriggerClientEvent("Notify", source, "important", "Atenção", "Todas as comunicações foram retiradas.",
								"amarelo", 5000)
						end
					end

					if vRP.hasGroup(nuser_id, "Corrections") then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							vRP.removePermission(nuser_id, "Police")
							TriggerClientEvent("radio:outServers", otherPlayer)
							TriggerEvent("blipsystem:serviceExit", otherPlayer)
							TriggerClientEvent("vRP:PoliceService", otherPlayer, false)
							vRP.updatePermission(nuser_id, "Corrections", "waitCorrections")
							TriggerClientEvent("service:Label", otherPlayer, "Corrections", "Entrar em Serviço", 5000)
							TriggerClientEvent("Notify", source, "important", "Atenção", "Todas as comunicações foram retiradas.",
								"amarelo", 5000)
						end
					end

					if vRP.hasGroup(nuser_id, "Paramedic") then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
							TriggerClientEvent("radio:outServers", otherPlayer)
							TriggerEvent("blipsystem:serviceExit", otherPlayer)
							vRP.updatePermission(nuser_id, "Paramedic", "waitParamedic")
							TriggerClientEvent("service:Label", otherPlayer, "Paramedic", "Entrar em Serviço", 5000)
							TriggerClientEvent("Notify", source, "important", "Atenção", "Todas as comunicações foram retiradas.",
								"amarelo", 5000)
						end
					end
				end
			end
		end
	end,
	--SÃO JOÃO
	["Pacoca"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)

		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", `akira_pacoca`, 49, 60309, 0.0, 0.0, -0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["Pipoca"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "akira_pipoca", 49, 60309, 0.0,0.0,-0.06, 0.0, 0.0, 130.0)


		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["Milho"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "akira_milho", 49, 60309, 0.0,0.0,-0.06, 0.0, 0.0, 130.0)


		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["Pamonha"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "akira_pamonha", 49, 60309, 0.0,0.0,-0.06, 0.0, 0.0, 130.0)


		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end,
	["Canjica"] = function(source,user_id,totalName,Amount,Slot,splitName)
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_inteat@burger", "mp_player_int_eat_burger", "akira_cangica", 49, 60309, 0.0,0.0,-0.06, 0.0, 0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)

				if vRP.tryGetInventoryItem(user_id, totalName, 1, true, Slot) then
					vRP.upgradeHunger(user_id, 50)
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end
}

Config["Drugs"] = {
	{ item = "cokesack", priceMin = 400, priceMax = 700, randMin = 2, randMax = 5 },
	{ item = "methsack", priceMin = 400, priceMax = 700, randMin = 2, randMax = 5 },
	{ item = "joint", priceMin = 400, priceMax = 700, randMin = 2, randMax = 5 },
	{ item = "lean", priceMin = 400, priceMax = 700, randMin = 2, randMax = 5 },
}

Config["favelasCds"] = {
	{1309.46,-183.36,107.38},
	{1355.82,-734.01,67.21},
	{-2382.61,1763.36,212.07},
	{-1771.85,-247.51,52.64},
	{2890.21,2676.48,96.48},
	{-1745.41,-41.96,85.43},
	{-1444.02,2224.37,30.45}
}

Config["dismantleItens"] = {
	{ "plastic", 10, 12 },   
	{ "glass", 12, 18 },
	{ "rubber", 12, 18 },
	{ "aluminum", 12, 18 },
	{ "copper", 12, 18 }
}

Config["stealpedsList"] = {
	{ item = "notepad", min = 1, max = 5 },
	{ item = "mouse", min = 1, max = 1 },
	{ item = "silverring", min = 1, max = 1 },
	{ item = "goldring", min = 1, max = 1 },
	{ item = "watch", min = 1, max = 2 },
	{ item = "ominitrix", min = 1, max = 1 },
	{ item = "bracelet", min = 1, max = 1 },
	{ item = "spray01", min = 1, max = 2 },
	{ item = "spray02", min = 1, max = 2 },
	{ item = "spray03", min = 1, max = 2 },
	{ item = "spray04", min = 1, max = 2 },
	{ item = "dices", min = 1, max = 2 },
	{ item = "dish", min = 1, max = 3 },
	{ item = "WEAPON_SHOES", min = 1, max = 2 },
	{ item = "rimel", min = 1, max = 3 },
	{ item = "blender", min = 1, max = 1 },
	{ item = "switch", min = 1, max = 3 },
	{ item = "brush", min = 1, max = 2 },
	{ item = "domino", min = 1, max = 3 },
	{ item = "floppy", min = 1, max = 4 },
	{ item = "deck", min = 1, max = 2 },
	{ item = "pliers", min = 1, max = 2 },
	{ item = "slipper", min = 1, max = 1 },
	{ item = "soap", min = 1, max = 1 },
	{ item = "dollars", min = 425, max = 525 },
	{ item = "card01", min = 1, max = 1 },
	{ item = "card02", min = 1, max = 1 },
	{ item = "card04", min = 1, max = 1 },
	{ item = "card05", min = 1, max = 1 }
}

Config["stealItens"] = {
	[1] = { ["item"] = "pendrive", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[2] = { ["item"] = "slipper", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[3] = { ["item"] = "soap", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[4] = { ["item"] = "pliers", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[5] = { ["item"] = "deck", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[6] = { ["item"] = "floppy", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[7] = { ["item"] = "domino", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[8] = { ["item"] = "brush", ["min"] = 1, ["max"] = 4, ["rand"] = 225 },
	[9] = { ["item"] = "rimel", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	[10] = { ["item"] = "sneakers", ["min"] = 1, ["max"] = 2, ["rand"] = 225 },
	[11] = { ["item"] = "dices", ["min"] = 2, ["max"] = 4, ["rand"] = 225 },
	[12] = { ["item"] = "spray04", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[13] = { ["item"] = "spray03", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[14] = { ["item"] = "spray02", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[15] = { ["item"] = "spray01", ["min"] = 2, ["max"] = 3, ["rand"] = 225 },
	[16] = { ["item"] = "bracelet", ["min"] = 2, ["max"] = 4, ["rand"] = 200 },
	[17] = { ["item"] = "xbox", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[18] = { ["item"] = "playstation", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[19] = { ["item"] = "watch", ["min"] = 2, ["max"] = 3, ["rand"] = 200 },
	[20] = { ["item"] = "goldcoin", ["min"] = 4, ["max"] = 6, ["rand"] = 175 },
	[21] = { ["item"] = "silvercoin", ["min"] = 4, ["max"] = 8, ["rand"] = 175 },
	[22] = { ["item"] = "goldring", ["min"] = 1, ["max"] = 2, ["rand"] = 175 },
	[23] = { ["item"] = "silverring", ["min"] = 1, ["max"] = 2, ["rand"] = 175 },
	[24] = { ["item"] = "oxy", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[25] = { ["item"] = "analgesic", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	[26] = { ["item"] = "firecracker", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[27] = { ["item"] = "pager", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[28] = { ["item"] = "GADGET_PARACHUTE", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[29] = { ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 1, ["rand"] = 50 },
	[30] = { ["item"] = "WEAPON_WRENCH", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[31] = { ["item"] = "WEAPON_POOLCUE", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[32] = { ["item"] = "WEAPON_BAT", ["min"] = 1, ["max"] = 1, ["rand"] = 125 },
	[33] = { ["item"] = "notebook", ["min"] = 1, ["max"] = 1, ["rand"] = 75 },
	[34] = { ["item"] = "camera", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[35] = { ["item"] = "binoculars", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[36] = { ["item"] = "hennessy", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[37] = { ["item"] = "dewars", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[38] = { ["item"] = "teddy", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	[39] = { ["item"] = "chocolate", ["min"] = 1, ["max"] = 3, ["rand"] = 225 },
	[40] = { ["item"] = "lighter", ["min"] = 1, ["max"] = 1, ["rand"] = 225 },
	[41] = { ["item"] = "divingsuit", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[42] = { ["item"] = "cellphone", ["min"] = 1, ["max"] = 1, ["rand"] = 150 },
	[43] = { ["item"] = "tyres", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[44] = { ["item"] = "notepad", ["min"] = 1, ["max"] = 5, ["rand"] = 225 },
	[45] = { ["item"] = "brokenpick", ["min"] = 1, ["max"] = 3, ["rand"] = 175 },
	[46] = { ["item"] = "plate", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[47] = { ["item"] = "emptybottle", ["min"] = 2, ["max"] = 5, ["rand"] = 225 },
	[48] = { ["item"] = "bait", ["min"] = 1, ["max"] = 6, ["rand"] = 225 },
	[49] = { ["item"] = "switchblade", ["min"] = 1, ["max"] = 1, ["rand"] = 175 },
	[50] = { ["item"] = "card01", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	[51] = { ["item"] = "card02", ["min"] = 1, ["max"] = 1, ["rand"] = 200 },
	[52] = { ["item"] = "spray05", ["min"] = 1, ["max"] = 2, ["rand"] = 200 },
	[53] = { ["item"] = "tiner", ["min"] = 1, ["max"] = 2, ["rand"] = 200 }
}

Config["mobileTheft"] = {
	["MOBILE"] = {
		{ item = "notepad", min = 1, max = 5 },
		{ item = "keyboard", min = 1, max = 1 },
		{ item = "mouse", min = 1, max = 1 },
		{ item = "silverring", min = 1, max = 1 },
		{ item = "goldring", min = 1, max = 1 },
		{ item = "watch", min = 2, max = 4 },
		{ item = "playstation", min = 1, max = 1 },
		{ item = "xbox", min = 1, max = 1 },
		{ item = "legos", min = 1, max = 1 },
		{ item = "ominitrix", min = 1, max = 1 },
		{ item = "bracelet", min = 1, max = 1 },
		{ item = "pendrive", min = 1, max = 3 },
		{ item = "dildo", min = 1, max = 1 },
		{ item = "alicate", min = 1, max = 1 },
		{ item = "lockpick", min = 1, max = 1 },
		{ item = "lockpick2", min = 1, max = 1 },
		{ item = "joint", min = 8, max = 13 },
		{ item = "plasticbottle", min = 4, max = 9 },
		{ item = "glassbottle", min = 4, max = 9 },
		{ item = "elastic", min = 4, max = 9 },
		{ item = "battery", min = 4, max = 9 },
		{ item = "metalcan", min = 4, max = 9 },
		{ item = "vape", min = 1, max = 1 },
		{ item = "card01", min = 1, max = 1 },
		{ item = "card02", min = 1, max = 1 },
		{ item = "tiner", min = 1, max = 3 },
		{ item = "spra05", min = 1, max = 3 },
		{ item = "card04", min = 1, max = 1 },
		{ item = "pager", min = 1, max = 1 },
	},
	["LOCKER"] = {
		{ item = "card04", min = 1, max = 1 },
		{ item = "card05", min = 1, max = 1 },
		{ item = "WEAPON_PISTOL_MK2", min = 1, max = 1 },
		{ item = "WEAPON_PISTOL_AMMO", min = 10, max = 30 },
	}
}

Config["lootItens"] = {
	["Medic"] = {
		["null"] = 75,
		["cooldown"] = 3600,
		["list"] = {
			[1] = { ["item"] = "alcohol", ["min"] = 1, ["max"] = 4 },
			[2] = { ["item"] = "syringe", ["min"] = 1, ["max"] = 4 },
			[3] = { ["item"] = "codeine", ["min"] = 1, ["max"] = 4 },
			[4] = { ["item"] = "amphetamine", ["min"] = 1, ["max"] = 4 },
			[5] = { ["item"] = "acetone", ["min"] = 1, ["max"] = 4 },
			[6] = { ["item"] = "adrenaline", ["min"] = 1, ["max"] = 4 },
			[7] = { ["item"] = "cotton", ["min"] = 1, ["max"] = 4 },
			[8] = { ["item"] = "plaster", ["min"] = 1, ["max"] = 4 },
			[9] = { ["item"] = "saline", ["min"] = 1, ["max"] = 4 },
			[10] = { ["item"] = "sulfuric", ["min"] = 1, ["max"] = 4 },
			[11] = { ["item"] = "analgesic", ["min"] = 1, ["max"] = 4 }
		}
	},
	["Weapons"] = {
		["null"] = 50,
		["cooldown"] = 7200,
		["list"] = {
			[1] = { ["item"] = "roadsigns", ["min"] = 1, ["max"] = 4 },
			[2] = { ["item"] = "techtrash", ["min"] = 1, ["max"] = 4 },
			[3] = { ["item"] = "pistolbody", ["min"] = 2, ["max"] = 4 },
			[4] = { ["item"] = "smgbody", ["min"] = 1, ["max"] = 3 },
			[5] = { ["item"] = "riflebody", ["min"] = 1, ["max"] = 2 },
			[6] = { ["item"] = "sheetmetal", ["min"] = 1, ["max"] = 4 },
			[7] = { ["item"] = "c4", ["min"] = 1, ["max"] = 1 },
			[8] = { ["item"] = "metalcan", ["min"] = 2, ["max"] = 6 },
			[9] = { ["item"] = "copper", ["min"] = 2, ["max"] = 6 },
			[10] = { ["item"] = "nitro", ["min"] = 1, ["max"] = 4 }
		}
	},
	["Supplies"] = {
		["null"] = 75,
		["cooldown"] = 3600,
		["list"] = {
			[1] = { ["item"] = "toolbox", ["min"] = 1, ["max"] = 2 },
			[2] = { ["item"] = "tyres", ["min"] = 1, ["max"] = 1 },
			[3] = { ["item"] = "roadsigns", ["min"] = 4, ["max"] = 4 },
			[4] = { ["item"] = "tiner", ["min"] = 1, ["max"] = 3 },
			[5] = { ["item"] = "animalfat", ["min"] = 4, ["max"] = 4 },
			[6] = { ["item"] = "cotton", ["min"] = 4, ["max"] = 4 },
			[7] = { ["item"] = "spray05", ["min"] = 1, ["max"] = 3 },
			[8] = { ["item"] = "sulfuric", ["min"] = 4, ["max"] = 4 },
			[9] = { ["item"] = "saline", ["min"] = 4, ["max"] = 4 },
			[10] = { ["item"] = "alcohol", ["min"] = 4, ["max"] = 4 },
			[11] = { ["item"] = "syringe", ["min"] = 4, ["max"] = 4 },
			[12] = { ["item"] = "card01", ["min"] = 1, ["max"] = 1 },
			[13] = { ["item"] = "weed", ["min"] = 4, ["max"] = 4 },
			[14] = { ["item"] = "compost", ["min"] = 4, ["max"] = 4 },
			[15] = { ["item"] = "cannabisseed", ["min"] = 4, ["max"] = 4 },
			[16] = { ["item"] = "bucket", ["min"] = 2, ["max"] = 4 },
			[17] = { ["item"] = "silk", ["min"] = 4, ["max"] = 4 }
		}
	}
}

Config["tableList"] = {
	["emptybottle"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 3, ["need"] = "emptybottle", ["needAmount"] = 1,  ["item"] = "water", ["itemAmount"] = 1 }
	},
	["tablecoke"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 5, ["need"] = {
			{ ["item"] = "sulfuric", ["amount"] = 1 },
			{ ["item"] = "cokeseed", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "cocaine", ["itemAmount"] = 3 }
	},
	["tablemeth"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "saline", ["amount"] = 1 },
			{ ["item"] = "acetone", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "meth", ["itemAmount"] = 3 }
	},
	["tableweed"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "silk", ["amount"] = 1 },
			{ ["item"] = "weedleaf", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "joint", ["itemAmount"] = 3 }
	},
	["tablelean"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "codeine", ["amount"] = 1 },
			{ ["item"] = "amphetamine", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "lean", ["itemAmount"] = 3 }
	},
	["tableoxy"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "analgesic", ["amount"] = 1 },
			{ ["item"] = "ritmoneury", ["amount"] = 1 }
		}, ["needAmount"] = 1, ["item"] = "oxy", ["itemAmount"] = 3 }
	},
	["foodJuice"] = {
		["anim"] = { "amb@prop_human_parking_meter@female@idle_a","idle_a_female" },
		[1] = { ["timer"] = 10, ["item"] = "foodjuice", ["itemAmount"] = 1 }
	},
	["foodBurger"] = {
		["anim"] = { "anim@amb@business@coc@coc_unpack_cut@","fullcut_cycle_v6_cokecutter" },
		[1] = { ["timer"] = 10, ["need"] = {
			{ ["item"] = "tomato", ["amount"] = 2 },
			{ ["item"] = "bread", ["amount"] = 2 },
			{ ["item"] = "carne", ["amount"] = 1 },
			{ ["item"] = "ketchup", ["amount"] = 3 },
		}, ["needAmount"] = 1, ["item"] = "foodbox", ["itemAmount"] = 1 }
	},
	["scanner"] = {
		[1] = { ["timer"] = 5, ["item"] = "sheetmetal", ["itemAmount"] = 1 },
		[2] = { ["timer"] = 5, ["item"] = "roadsigns", ["itemAmount"] = 1 },
		[3] = { ["timer"] = 5, ["item"] = "syringe", ["itemAmount"] = 1 },
		[4] = { ["timer"] = 5, ["item"] = "fishingrod", ["itemAmount"] = 1 },
		[5] = { ["timer"] = 5, ["item"] = "plate", ["itemAmount"] = 1 },
		[6] = { ["timer"] = 5, ["item"] = "aluminum", ["itemAmount"] = 1 },
		[7] = { ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		[8] = { ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		[9] = { ["timer"] = 5, ["item"] = "battery", ["itemAmount"] = 1 },
		[10] = { ["timer"] = 5, ["item"] = "metalcan", ["itemAmount"] = 1 }
	},
	["cemitery"] = {
		[1] = { ["timer"] = 5, ["item"] = "silk", ["itemAmount"] = 1 },
		[2] = { ["timer"] = 5, ["item"] = "cotton", ["itemAmount"] = 1 },
		[3] = { ["timer"] = 5, ["item"] = "plaster", ["itemAmount"] = 1 },
		[4] = { ["timer"] = 5, ["item"] = "pouch", ["itemAmount"] = 1 },
		[5] = { ["timer"] = 5, ["item"] = "switchblade", ["itemAmount"] = 1 },
		[6] = { ["timer"] = 5, ["item"] = "joint", ["itemAmount"] = 1 },
		[7] = { ["timer"] = 5, ["item"] = "weedseed", ["itemAmount"] = 1 },
		[8] = { ["timer"] = 5, ["item"] = "cokeseed", ["itemAmount"] = 1 },
		[9] = { ["timer"] = 5, ["item"] = "mushseed", ["itemAmount"] = 1 },
		[10] = { ["timer"] = 5, ["item"] = "acetone", ["itemAmount"] = 1 },
		[11] = { ["timer"] = 5, ["item"] = "water", ["itemAmount"] = 1 },
		[12] = { ["timer"] = 5, ["item"] = "copper", ["itemAmount"] = 1 },
		[13] = { ["timer"] = 5, ["item"] = "cigarette", ["itemAmount"] = 1 },
		[14] = { ["timer"] = 5, ["item"] = "lighter", ["itemAmount"] = 1 },
		[15] = { ["timer"] = 5, ["item"] = "dollars", ["itemAmount"] = 1 },
		[16] = { ["timer"] = 5, ["item"] = "elastic", ["itemAmount"] = 1 },
		[17] = { ["timer"] = 5, ["item"] = "rose", ["itemAmount"] = 1 },
		[18] = { ["timer"] = 5, ["item"] = "teddy", ["itemAmount"] = 1 },
		[19] = { ["timer"] = 5, ["item"] = "binoculars", ["itemAmount"] = 1 },
		[20] = { ["timer"] = 5, ["item"] = "camera", ["itemAmount"] = 1 },
		[21] = { ["timer"] = 5, ["item"] = "silverring", ["itemAmount"] = 1 },
		[22] = { ["timer"] = 5, ["item"] = "goldring", ["itemAmount"] = 1 },
		[23] = { ["timer"] = 5, ["item"] = "silvercoin", ["itemAmount"] = 1 },
		[24] = { ["timer"] = 5, ["item"] = "goldcoin", ["itemAmount"] = 1 },
		[25] = { ["timer"] = 5, ["item"] = "watch", ["itemAmount"] = 1 },
		[26] = { ["timer"] = 5, ["item"] = "bracelet", ["itemAmount"] = 1 },
		[27] = { ["timer"] = 5, ["item"] = "dices", ["itemAmount"] = 1 },
		[28] = { ["timer"] = 5, ["item"] = "cup", ["itemAmount"] = 1 },
		[30] = { ["timer"] = 5, ["item"] = "card01", ["itemAmount"] = 1 },
		[31] = { ["timer"] = 5, ["item"] = "card04", ["itemAmount"] = 1 },
		[32] = { ["timer"] = 5, ["item"] = "card05", ["itemAmount"] = 1 },
		[29] = { ["timer"] = 5, ["item"] = "slipper", ["itemAmount"] = 1 }
	},
}

Config["dismantleVehs"] = {
	"baller", "jackal", "mule", "youga", "mesa", "nemesis", "primo", "biff", "bison", "seminole", "zion2", "landstalker",
	"panto","boxville2", "premier", "scrap", "rhapsody", "pcj", "jester", "superd", "sentinel", "bus", "sentinel2", "blazer2",
	"asea","regina", "pounder", "huntley", "tornado", "rubble", "tribike", "bjxl", "patriot", "ingot", "serrano", "fq2","bobcatxl",
	"journey", "bfinjection", "sanchez2", "surfer2", "caddy2", "rebel2", "bagger", "dilettante", "blista", "hexer",
	"buffalo", "emperor2", "fugitive", "rocoto", "dukes", "thrust", "faggio2", "double", "camper", "massacro", "feltzer2",
	"sabregt", "ninef2", "banshee", "infernus", "bullet", "coquette", "phoenix", "cavalcade", "stratum", "minivan",
	"picador","taco", "glendale", "intruder", "ruffian", "schafter2", "asterope", "mixer2", "rumpo", "exemplar", "surfer",
	"cavalcade2","panto", "prairie", "rhapsody", "blista", "dilettante", "emperor2", "emperor", "bfinjection", "ingot", "regina",
	"asbo", "brioso", "club", "weevil", "felon", "felon2", "jackal", "oracle", "zion", "zion2", "buccaneer", "virgo",
	"voodoo", "bifta", "rancherxl", "bjxl", "cavalcade", "gresley", "habanero", "rocoto", "primo", "stratum", "pigalle",
	"peyote", "manana", "streiter","exemplar", "windsor", "windsor2", "blade", "clique", "dominator", "faction2", "gauntlet", "moonbeam", "nightshade",
	"sabregt2", "tampa", "rebel", "baller", "cavalcade2", "fq2", "huntley", "landstalker", "patriot", "radi", "xls",
	"blista2","retinue", "stingergt", "surano", "specter", "sultan", "schwarzer", "schafter2", "ruston", "rapidgt", "raiden",
	"ninef","ninef2", "omnis", "massacro", "jester", "feltzer2", "futo", "carbonizzare","voltic", "sc1", "sultanrs", "tempesta", "nero", "nero2", "reaper", "gp1", "infernus", "bullet", "banshee2",
	"turismo2", "retinue","mamba", "infernus2", "feltzer3", "coquette2", "futo2", "zr350", "tampa2", "sugoi", "sultan2", "schlagen", "penumbra",
	"pariah","paragon", "jester3", "gb200", "elegy", "furoregt","zentorno", "xa21", "visione", "vagner", "vacca", "turismor", "t20", "osiris", "italigtb", "entityxf", "cheetah",
	"autarch", "sultan3","cypher", "vectre", "growler", "comet6", "jester4", "euros", "calico", "neon", "kuruma", "issi7", "italigto", "komoda",
	"elegy2", "coquette4","mazdarx72", "rangerover", "civictyper", "subaruimpreza", "corvettec7", "ferrariitalia", "mustang1969", "vwtouareg",
	"mercedesg65", "bugattiatlantic", "m8competition", "audirs6", "audir8", "silvias15", "camaro", "mercedesamg63",
	"dodgechargerrt69", "skyliner342", "astonmartindbs", "panameramansory", "lamborghinihuracanlw", "lancerevolutionx",
	"porsche911", "jeepcherokee", "dodgecharger1970", "golfgti", "subarubrz", "nissangtr", "mustangfast", "golfmk7",
	"lancerevolution9", "shelbygt500", "ferrari812", "bmwm4gts", "ferrarif12", "bmwm5e34", "toyotasupra2", "escalade2021",
	"fordmustang", "mclarensenna", "lamborghinihuracan", "acuransx", "toyotasupra", "escaladegt900", "bentleybacalar"
}




Config["Logs"] = {
	Badges = function(source,user_id,item,amount)

	end,
	Drops = function(source,user_id,item,amount)

	end,
	Pickup = function(source,user_id,item,amount)

	end,
	SendItem = function(source,user_id,nuser_id,item,amount)

	end,
}