RegisterCommand("tropecar", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasGroup(user_id, "Admin") then
        local target_id = parseInt(args[1])
        local target_source = vRP.getUserSource(target_id)
        if target_source then
            TriggerClientEvent("tropecar:acao", target_source)
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "O passaporte "..target_id.." tropeçou e caiu.", 5000)
        else
            TriggerClientEvent("Notify", source, "vermelho", "Erro", "Passaporte não encontrado ou offline.", 5000)
        end
    end
end, false)

RegisterCommand("getplayerbucket", function(source)
	print(GetPlayerRoutingBucket(source))
end)

CreateThread(function()
	for name, command in pairs(Commands) do
		RegisterCommand(name, function(source, args, rawCommand)
			local user_id = vRP.getUserId(source)
			if command["permissions"] ~= nil and command["permissions"] ~= false then
				for _, permission in pairs(command["permissions"]) do
					if (vRP.hasGroup(user_id, permission)) then
						CreateThread(function()command["callback"](source, args, rawCommand)end)
						return
					end
				end
			else
				CreateThread(function()command["callback"](source, args, rawCommand)end)
			end
		end)
	end
end)

local cdsEvento = nil

RegisterCommand("criarevento", function(source)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, "Admin") then
        local fcoords = vRP.prompt(source, "Insira as coordenadas do evento (x,y,z):", "")
        if not fcoords or fcoords == "" then
            TriggerClientEvent("Notify", source, "vermelho", "Coordenadas inválidas.", 5000)
            return
        end

        local coords = {}
        for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
            table.insert(coords, tonumber(coord))
        end

        if #coords < 3 then
            TriggerClientEvent("Notify", source, "vermelho", "Você deve inserir pelo menos X,Y,Z.", 5000)
            return
        end

        cdsEvento = vector3(coords[1], coords[2], coords[3])
        TriggerClientEvent("Notify", source, "verde", "Evento criado com sucesso!", 5000)
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para isso.", 5000)
    end
end)

RegisterCommand("evento", function(source)
    if cdsEvento then
        TriggerClientEvent("evento:teleportar", source, cdsEvento)
    else
        TriggerClientEvent("Notify", source, "amarelo", "Nenhum evento ativo no momento.", 5000)
    end
end)

RegisterCommand("finalizarevento", function(source)
    local user_id = vRP.getUserId(source)
    if user_id and vRP.hasPermission(user_id, "Admin") then
        cdsEvento = nil
        TriggerClientEvent("Notify", source, "verde", "Evento finalizado com sucesso!", 5000)
    else
        TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para isso.", 5000)
    end
end)


RegisterCommand("ptr", function(source)
    local user_id = vRP.getUserId(source)
    if user_id then
        local policia = vRP.getUsersByPermission("Police") or {}
        local quantidade = #policia

        TriggerClientEvent("Notify", source, "check", "Policiais em serviço", "👮‍♂️ Policiais online: " .. quantidade, "verde", 9000)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.tryEnablePassports()
	local source = source 
	local user_id = vRP.getUserId(source) 
	if user_id then 
		if vRP.hasPermission(user_id,"Admin",3) then 
			clientAPI.passportInit(source)
		end 
	end 
end 

function src.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)

			vRP.updateTxt(user_id..".txt",mathLegth(coords.x)..","..mathLegth(coords.y)..","..mathLegth(coords.z)..","..mathLegth(heading))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACECOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local checkPoints = 0
function src.raceCoords(vehCoords,leftCoords,rightCoords)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		checkPoints = checkPoints + 1

		vRP.updateTxt("races.txt","["..checkPoints.."] = {")

		vRP.updateTxt("races.txt","{ "..mathLegth(vehCoords["x"])..","..mathLegth(vehCoords["y"])..","..mathLegth(vehCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(leftCoords["x"])..","..mathLegth(leftCoords["y"])..","..mathLegth(leftCoords["z"]).." },")
		vRP.updateTxt("races.txt","{ "..mathLegth(rightCoords["x"])..","..mathLegth(rightCoords["y"])..","..mathLegth(rightCoords["z"]).." }")

		vRP.updateTxt("races.txt","},")
	end
end

AddEventHandler('vRP:playerSpawn',function(user_id,source,firstspawn)
	if user_id then
		local playerData = vRP.getUData(user_id,'Vip')
		local time = json.decode(playerData) or 0

		if os.time() <= time then
			vRP.removePermission(user_id,'group')
		end
	end
end)

AddEventHandler('vRP:playerSpawn', function(playerId, source)
	local data = vRP.userData('temporary_items') or {}
	local currentTime = os.time()

	local updated = false

	for _, infos in pairs(data) do
		if infos.expiresAt <= currentTime then
			if infos.type == 'group' then
				vRP.removePermission(playerId, infos.group)
			end

			data[_] = nil

			updated = true
		end
	end

	if updated then
		vRP.execute("playerdata/setUserdata",
		{ user_id = playerId, key = "temporary_items", value = json.encode(data) })
	end
end)

function getPhoneData(playerId)
    local result = vRP.query('vRP/getLbPhone', {
        playerId = playerId
    })

    if type(result) == 'table' and result[1] then
        local formattedNumber = exports['lb-phone']:FormatNumber(result[1].phone_number)

        return formattedNumber, result[1].phone_number
    end
end


CreateThread(function()
	if GetResourceState('lb-phone') == 'started' then
		local apps = {
			'birdy',
			'trendy',
			'instapic'
		}

		function getUserNameApps(playerId)
			local formattedNumber, playerNumber = getPhoneData(playerId)
		
			if playerNumber then
				local playerNames = {}

				local tables = {
					'phone_twitter_accounts',
					'phone_instagram_accounts',
					'phone_tiktok_accounts'
				}

				for _, table in pairs(tables) do
					local result = exports['oxmysql']:query_async('select username from ' .. table .. ' where phone_number = ?', {
						playerNumber
					})

					if type(result) == 'table' and result[1] then
						playerNames[_] = result[1].username
					end
				end
			end
		end		

		function validateVerified(playerId, userNames)

			if not userNames then
				userNames = getUserNameApps(playerId)
			end
			
			if userNames then
				if vRP.hasGroup(playerId, 'Verificado') then
					for _, userName in pairs(userNames) do
						if userName then
							local app = apps[_]

							if not exports["lb-phone"]:IsVerified(app, userName) then
								exports['lb-phone']:ToggleVerified(app, userName, true)
							end
						end
					end
				else
					for _, userName in pairs(userNames) do
						if userName then
							local app = apps[_]

							if exports["lb-phone"]:IsVerified(app, userName) then
								exports['lb-phone']:ToggleVerified(app, userName, false)
							end
						end
					end
				end
			end
		end

		AddEventHandler('playerConnect', function(playerId, source)
			local userNames = getUserNameApps(playerId)

			validateVerified(playerId, userNames)
		end)	

		exports('validateVerified', validateVerified)
	end
end)


RegisterNetEvent("limirio:trySetBooster")
AddEventHandler("limirio:trySetBooster",function(playerId,action)
    if action == "add" then 
        local nsrc = vRP.getUserSource(playerId) 

        vRP.setPermission(playerId,"Booster")
    elseif action == "remove" then 
        vRP.removePermission(playerId,"Booster")
    end
end)

RegisterNetEvent("ban10/10")
AddEventHandler("ban10/10", function()
    local source = source
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassInvisible", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassFreecam", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassSpectate", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassGodMode", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassInfStamina", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassNoclip", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassSpeedHack", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassTeleport", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassInfAmmo", true)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassVehicleFixAndGodMode", true)
end)

----------------------------------
-- RemoveFiveguardTempBypass  --> AQUI VOCÊ REVOGA AS PERMISSÕES TEMPORÁRIAS
----------------------------------
RegisterNetEvent("unban10/10")
AddEventHandler("unban10/10", function()
    local source = source
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassInvisible", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassFreecam", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassSpectate", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassGodMode", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassInfStamina", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassNoclip", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassSpeedHack", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassTeleport", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassInfAmmo", false)
    exports["fortal-payment"]:SetTempPermission(source, "Client", "BypassVehicleFixAndGodMode", false)
end)
