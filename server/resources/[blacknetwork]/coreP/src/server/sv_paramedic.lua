-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local bloodTimers = {}
local extractPerson = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:REPOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Repose")
AddEventHandler("paramedic:Repose",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 and vRP.getHealth(entity) > 101 then
		if vRP.hasGroup(user_id,"Paramedic") then
			local timer = vRP.prompt(source,"Minutos:","")
			if timer == "" or parseInt(timer) <= 0 then
				return
			end

			local nuser_id = vRP.getUserId(entity)
			local playerTimer = parseInt(timer * 60)
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				if vRP.request(source,"Adicionar <b>"..timer.." minutos</b> de repouso no(a) <b>"..identity["name"].."</b>?.","Aplicar") then
					TriggerClientEvent("Notify",source,"check","Sucesso","Aplicou <b>"..timer.." minutos</b> de repouso.","verde",10000)
					TriggerEvent("Repose",entity,nuser_id,playerTimer)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:TREATMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Treatment")
AddEventHandler("paramedic:Treatment", function(entity)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id and vRP.getHealth(source) > 101 and vRP.getHealth(entity) > 101 then
		if vRP.hasGroup(user_id, "Paramedic") then
			local nuser_id = vRP.getUserId(entity)
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				local price = 1500

				if vRP.request(entity, "Deseja pagar <b>$" .. parseFormat(price) .. "</b> pelo tratamento médico?") then
					if vRP.paymentFull(nuser_id, price) then
						if vRP.tryGetInventoryItem(user_id, "syringe0" .. identity["blood"], 1) then
							if bloodTimers[nuser_id] == nil then
								bloodTimers[nuser_id] = os.time() + 1800
							end

							vRP.addBank(user_id, price) 

							vRP.upgradeStress(nuser_id, 10)
							TriggerClientEvent("checkin:startTreatment", entity)
							TriggerClientEvent("Notify", source, "importante", "Tratamento iniciado com sucesso.", "verde", 5000)
							TriggerClientEvent("Notify", entity, "importante", "Você pagou <b>$" .. parseFormat(price) .. "</b> pelo tratamento.", "verde", 5000)
						else
							TriggerClientEvent("Notify", source, "importante", "Você precisa de <b>1x " .. itemName("syringe0" .. identity["blood"]) .. "</b>.", "amarelo", 5000)
						end
					else
						TriggerClientEvent("Notify", entity, "vermelho", "<b>Dólares</b> insuficientes para o tratamento.", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "amarelo", "O paciente recusou o tratamento.", 5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:BED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Bed")
AddEventHandler("paramedic:Bed",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasGroup(user_id,"Paramedic") then
			TriggerClientEvent("target:pacienteDeitar",entity)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:REVIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Revive")
AddEventHandler("paramedic:Revive",function(entity)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and vRP.getHealth(entity) <= 101 then
        if vRP.hasGroup(user_id,"Paramedic") or vRP.hasGroup(user_id,"Police")  then
            local consult = vRP.getInventoryItemAmount(user_id,"defibrillator")
            if consult[2] == "defibrillator" then
                local nuser_id = vRP.getUserId(entity)
                TriggerClientEvent("Progress",source,10000)
                TriggerClientEvent("vRP:Cancel",source,true)
                vRPC.playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)

                SetTimeout(10000,function()
                    vRPC.removeObjects(source)
                    vRPC.revivePlayer(entity,110)
                    vRP.upgradeThirst(nuser_id,10)
                    vRP.upgradeHunger(nuser_id,10)
                    vRP.upgradeStress(nuser_id,10)
                    TriggerClientEvent("resetBleeding",entity)
                    TriggerClientEvent("vRP:Cancel",source,false)
                end)
            else
                TriggerClientEvent("Notify",source,"important","Atenção","Desfibrilador não encontrado.","amarelo",5000)
            end
        end
    end
end)


local locaisPermitidos = {
    { x = 307.22, y = -587.28, z = 43.29 }, 
    { x = 2535.14, y = -364.45, z = 92.99 },
	{ x = 224.0, y = 209.16, z = 105.09},
	{ x = 3617.37, y = 3739.38, z = 28.68}
}

local function dentroDeAreaPermitida(coords)
    for _, localPos in pairs(locaisPermitidos) do
        local dist = #(coords - vector3(localPos.x, localPos.y, localPos.z))
        if dist <= 20.0 then
            return true
        end
    end
    return false
end

RegisterCommand('re', function(source)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)

    if not vRP.hasGroup(user_id, "Police") and not dentroDeAreaPermitida(coords) then
        TriggerClientEvent("Notify", source, "importante", "Atenção", "Você não pode usar esse comando aqui.", "amarelo", 5000)
        return
    end

    local entity = vRPC.nearestPlayer(source, 3.0)
    if entity and vRP.getHealth(entity) <= 101 then
        if vRP.hasGroup(user_id, "Paramedic") or vRP.hasGroup(user_id, "Police") then
            local consult = vRP.getInventoryItemAmount(user_id, "defibrillator")
            if consult[2] == "defibrillator" then
                local nuser_id = vRP.getUserId(entity)
                TriggerClientEvent("Progress", source, 10000)
                TriggerClientEvent("vRP:Cancel", source, true)
                vRPC.playAnim(source, false, { "mini@cpr@char_a@cpr_str", "cpr_pumpchest" }, true)

                SetTimeout(10000, function()
                    vRPC.removeObjects(source)
                    vRPC.revivePlayer(entity, 110)
                    vRP.upgradeThirst(nuser_id, 10)
                    vRP.upgradeHunger(nuser_id, 10)
                    vRP.upgradeStress(nuser_id, 10)
                    TriggerClientEvent("resetBleeding", entity)
                    TriggerClientEvent("vRP:Cancel", source, false)
                end)
            else
                TriggerClientEvent("Notify", source, "importante", "Atenção", "Desfibrilador não encontrado.", "amarelo", 5000)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Bleeding")
AddEventHandler("paramedic:Bleeding",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 and vRP.getHealth(entity) > 101 then
		if vRP.hasGroup(user_id,"Paramedic") then
			if vRP.tryGetInventoryItem(user_id,"gauze",1) then
				TriggerClientEvent("resetBleeding",entity)
				TriggerClientEvent("Notify",source,"blood","Atenção","Sangramento parou.","amarelo",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDIC:DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:Diagnostic")
AddEventHandler("paramedic:Diagnostic",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		if vRP.hasGroup(user_id,"Paramedic") then
			local userResult = ""
			local nuser_id = vRP.getUserId(entity)
			local identity = vRP.userIdentity(nuser_id)
			if identity then
				local userDiagnostic,userBleeding = clientAPI.getDiagnostic(entity)

				if userBleeding == 3 then
					userResult = "<b>Sangramento:</b> Baixo<br>"
				elseif userBleeding == 4 then
					userResult = "<b>Sangramento:</b> Médio<br>"
				elseif userBleeding >= 5 then
					userResult = "<b>Sangramento:</b> Alto<br>"
				end

				if userDiagnostic["taser"] then
					userResult = userResult.."<b>Batimentos:</b> Acelerados<br>"
				else
					userResult = userResult.."<b>Batimentos:</b> Normal<br>"
				end

				if userDiagnostic["vehicle"] then
					userResult = userResult.."<b>Fraturas:</b> Atropelado<br>"
				else
					userResult = userResult.."<b>Fraturas:</b> Nenhuma<br>"
				end

				userResult = userResult.."<b>Tipo Sanguíneo:</b> "..bloodTypes(identity["blood"])

				TriggerClientEvent("drawInjuries",source,entity,userDiagnostic)

				TriggerClientEvent("Notify",source,"important","Atenção",userResult,"amarelo",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local preset = {
	["1"] = {
		["mp_m_freemode_01"] = {
			["hats"] = { item = -1, texture = 0 },
			["pants"] = { item = 23, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelets"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 34, texture = 0 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 15, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watches"] = { item = -1, texture = 0 },
			["arms"] = { item = 15, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ears"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hats"] = { item = -1, texture = 0 },
			["pants"] = { item = 57, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelets"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 16, texture = 0 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 15, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watches"] = { item = -1, texture = 0 },
			["arms"] = { item = 15, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ears"] = { item = -1, texture = 0 }
		}
	},
	["2"] = {
		["mp_m_freemode_01"] = {
			["hats"] = { item = -1, texture = 0 },
			["pants"] = { item = 41, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelets"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 122, texture = 0 },
			["shoes"] = { item = 47, texture = 3 },
			["tshirt"] = { item = 97, texture = 0 },
			["torso"] = { item = 49, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watches"] = { item = -1, texture = 0 },
			["arms"] = { item = 4, texture = 3 },
			["glass"] = { item = 0, texture = 0 },
			["ears"] = { item = -1, texture = 0 }
		},
		["mp_f_freemode_01"] = {
			["hats"] = { item = -1, texture = 0 },
			["pants"] = { item = 86, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelets"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 90, texture = 0 },
			["mask"] = { item = 122, texture = 0 },
			["shoes"] = { item = 48, texture = 3 },
			["tshirt"] = { item = 15, texture = 0 },
			["torso"] = { item = 188, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watches"] = { item = -1, texture = 0 },
			["arms"] = { item = 127, texture = 3 },
			["glass"] = { item = 0, texture = 0 },
			["ears"] = { item = -1, texture = 0 }
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETBURN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:presetBurn")
AddEventHandler("paramedic:presetBurn",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Emergency") then
			local model = vRP.modelPlayer(entity)
			if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerEvent("fortal-character:Server:Skinshop:Save", entity,preset["1"][model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETPLASTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:presetPlaster")
AddEventHandler("paramedic:presetPlaster",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Emergency") then
			local model = vRP.modelPlayer(entity)
			if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
				TriggerEvent("fortal-character:Server:Skinshop:Save", entity,preset["2"][model])
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:EXTRACTBLOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:extractBlood")
AddEventHandler("paramedic:extractBlood",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nuser_id = vRP.getUserId(entity)
		if nuser_id then
			if extractPerson[nuser_id] == nil then
				extractPerson[nuser_id] = true

				local ped = GetPlayerPed(entity)
				if GetEntityHealth(ped) >= 170 then
					local identity = vRP.userIdentity(nuser_id)
					if identity then
						if vRP.request(entity,"Deseja iniciar a doação sangue?") then
							if bloodTimers[nuser_id] == nil then
								bloodTimers[nuser_id] = os.time()
							end

							if os.time() >= bloodTimers[nuser_id] then
								if vRP.tryGetInventoryItem(user_id,"syringe",3) then
									vRPC.downHealth(entity,50)
									bloodTimers[nuser_id] = os.time() + 10800
									vRP.generateItem(user_id,"syringe0"..identity["blood"],5,true)

									if extractPerson[nuser_id] then
										extractPerson[nuser_id] = nil
									end
								else
									TriggerClientEvent("Notify",source,"important","Atenção","Precisa de <b>3x "..itemName("syringe").."</b>.","amarelo",5000)
								end
							else
								TriggerClientEvent("Notify",source,"important","Atenção","No momento não é possível efetuar a extração, o mesmo ainda está se recuperando ou se acidentou recentemente.","amarelo",10000)
							end
						end
					end
				else
					TriggerClientEvent("Notify",source,"important","Atenção","Sistema imunológico do paciente muito fraco.","amarelo",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:BLOODDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("paramedic:bloodDeath")
AddEventHandler("paramedic:bloodDeath",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		bloodTimers[user_id] = os.time() + 10800
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if extractPerson[user_id] then
		extractPerson[user_id] = nil
	end
end)