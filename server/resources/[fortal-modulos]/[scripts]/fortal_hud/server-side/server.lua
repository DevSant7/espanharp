GlobalState["Nitro"] = {}
GlobalState["Hours"] = 12
GlobalState["Minutes"] = 0
GlobalState["Weather"] = "CLEAR"
local wantedTimers = {}
local reposeTimers = {}
local callTimers = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEATHERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local weatherList = { "EXTRASUNNY","SMOG","OVERCAST","CLOUDS","CLEARING" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		GlobalState["Minutes"] = GlobalState["Minutes"] + 1
		
		if GlobalState["Minutes"] >= 60 then
			GlobalState["Hours"] = GlobalState["Hours"] + 1
			GlobalState["Minutes"] = 0

			if GlobalState["Hours"] >= 24 then
				GlobalState["Hours"] = 0

				repeat
					randWeather = math.random(#weatherList)
				until GlobalState["Weather"] ~= weatherList[randWeather]

				GlobalState["Weather"] = weatherList[randWeather]
			end
		end

		Wait(10000)
	end
end)

RegisterCommand("timeset",function(source,args,rawCommand)
	local user_id = Utils.functions.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") then
			GlobalState["Hours"] = parseInt(args[1])
			GlobalState["Minutes"] = parseInt(args[2])
			if args[3] then
				GlobalState["Weather"] = args[3]
			end
		end
	end
end)

function src.updateNitro(vehPlate,nitroFuel)
	if GlobalState["Nitro"][vehPlate] then
		local Nitro = GlobalState["Nitro"]
		Nitro[vehPlate] = nitroFuel
		GlobalState["Nitro"] = Nitro
	end
end

RegisterCommand("updatefood", function(source)
	local user_id = Utils.functions.getUserId(source)
	local dataTable = vRP.userData(user_id,"Datatable") or vRP.getDatatable(user_id)

	TriggerClientEvent("hud:Hunger", source, dataTable["hunger"])
	TriggerClientEvent("hud:Thirst", source, dataTable["thirst"])
end)

function src.updateFoodsData(clientThirst,clientHunger)
	local source  = source 
	local user_id = Utils.functions.getUserId(source)
	if user_id then 
		local dataTable = vRP.query("playerdata/getUserdata", { user_id = user_id, key = "Datatable" })

		if dataTable[1] then
			dataTable = json.decode(dataTable[1].dvalue)
			dataTable["thirst"] = clientThirst
			dataTable["hunger"] = clientHunger 
		
			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(dataTable) })
		end
		
	end	
	return false 
end 

RegisterServerEvent("Wanted")
AddEventHandler("Wanted", function(source, user_id, seconds)
	if wantedTimers[user_id] then
		wantedTimers[user_id] = wantedTimers[user_id] + seconds
	else
		wantedTimers[user_id] = os.time() + seconds
	end

	local remaining = wantedTimers[user_id] - os.time()

	TriggerClientEvent("hud:wantedClient", source, remaining * 1000)
end)

RegisterServerEvent("Repose")
AddEventHandler("Repose",function(source,user_id,seconds)
	if reposeTimers[user_id] then
		reposeTimers[user_id] = reposeTimers[user_id] + seconds
	else
		reposeTimers[user_id] = os.time() + seconds
	end

	TriggerClientEvent("hud:reposeClient",source,reposeTimers[user_id] - os.time())
end)

exports("Wanted",function(user_id,source)
	local source = parseInt(source)
	local user_id = parseInt(user_id)

	if wantedTimers[user_id] then
		if wantedTimers[user_id] > os.time() then
			if callTimers[user_id] == nil then
				callTimers[user_id] = os.time()
			end

			if callTimers[user_id] <= os.time() and source > 0 then
				callTimers[user_id] = os.time() + 60

				TriggerClientEvent("Notify",source,"amarelo","Você foi denunciado, parece que suas digitais<br>estão no banco de dados do governo como procurado.",5000)

				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local policeResult = vRP.numPermission("Police")

				for k,v in pairs(policeResult) do
					async(function()
						TriggerClientEvent("NotifyPush",v,{ code = 20, title = "Digitais Encontrada", x = coords["x"], y = coords["y"], z = coords["z"], criminal = "Alerta de procurado", time = "Recebido às "..os.date("%H:%M"), blipColor = 16 })
					end)
				end
			end

			return true
		end
	end

	return false
end)

exports("Repose",function(user_id)
	local user_id = parseInt(user_id)

	if reposeTimers[user_id] then
		if reposeTimers[user_id] > os.time() then
			return true
		end
	end

	return false
end)

AddEventHandler("playerConnect",function(user_id,source)
	if wantedTimers[user_id] then
		if wantedTimers[user_id] > os.time() then
			TriggerClientEvent("hud:wantedClient",source,wantedTimers[user_id] - os.time())
		end
	end

	if reposeTimers[user_id] then
		if reposeTimers[user_id] > os.time() then
			TriggerClientEvent("hud:reposeClient",source,reposeTimers[user_id] - os.time())
		end
	end
end)

vRP.prepare("bspolice/getPatent", "SELECT patent FROM bspolice_members WHERE id = @user_id")

RegisterNetEvent("black:chatMessageEntered")
AddEventHandler("black:chatMessageEntered",function(message, messageType)
	local source = source 
	local user_id = Utils.functions.getUserId(source)
	local identity = Utils.functions.getUserIdentity(user_id)
	
	if user_id and identity then
		local playerName = identity["name"].." "..identity["name2"]

		local result = vRP.query("bspolice/getPatent", { user_id = user_id })
		if result and result[1] and result[1].patent then
			local patent = result[1].patent
			playerName = patent.." "..identity["name"]
		else
			playerName = identity["name"] 
		end
		
		if not messageType or messageType == "default" then
			local nearestPlayers = Utils.functions.nearestPlayers(source,10)
			
			TriggerClientEvent("black:addChatMessage",source, playerName, message, "default")
			
			for _,v in pairs(nearestPlayers) do
				TriggerClientEvent("black:addChatMessage",v[2], playerName, message, "default")
			end
		elseif messageType == "police" then
			if vRP.hasGroup(user_id, "Police") or vRP.hasGroup(user_id, "Dip") then
				local policeGroup = vRP.numPermission("Police") or {}
				local dipGroup = vRP.numPermission("Dip") or {}

				local recipients = {}
				local alreadySent = {}
		
				for _,v in pairs(policeGroup) do
					alreadySent[v] = true
					table.insert(recipients, v)
				end
		
				for _,v in pairs(dipGroup) do
					if not alreadySent[v] then
						table.insert(recipients, v)
					end
				end

				local result = vRP.query("bspolice/getPatent", { user_id = user_id })
				local formattedName = ""
				local color = "#ffffff"
		
				if vRP.hasGroup(user_id, "Police") then
					if result and result[1] and result[1].patent then
						formattedName = result[1].patent.." "..identity["name"]
					else
						formattedName = identity["name"]
					end
					color = "#007bff" 
				elseif vRP.hasGroup(user_id, "Dip") then
					formattedName = "Dip "..identity["name"]
					color = "#999999" 
				end
		
				for _,v in pairs(recipients) do
					TriggerClientEvent("black:addChatMessage", v, {
						name = formattedName,
						message = message,
						type = "police",
						color = color
					})
				end
			else
				TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para usar este chat.", 3000)
			end
		elseif messageType == "hospital" then
			if vRP.hasGroup(user_id,"Paramedic") then
				local medicMembers = vRP.numPermission("Paramedic")
				
				for k,v in pairs(medicMembers) do
					TriggerClientEvent("black:addChatMessage",v, playerName, message, "hospital")
				end
			else
				TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para usar este chat.",3000)
			end
		end
	end
end)

function src.getChannelsPermissions()
	local source = source
	local user_id = Utils.functions.getUserId(source)
		
	if user_id then
		if vRP.hasGroup(user_id,"Police") then
			return "Police"
		elseif vRP.hasGroup(user_id,"Dip") then
			return "Police"
		elseif vRP.hasGroup(user_id,"Paramedic") then
			return "Emergency"
		end
	end
	
	return "Default"
end

exports("statusChat",function(source)
	return clientAPI.statusChat(source)
end)
