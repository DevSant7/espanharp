-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("radio",cRP)
vCLIENT = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local playersInRadio = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			if parseInt(freq) >= 911 and parseInt(freq) <= 920 then
				if vRP.hasGroup(user_id,"Police") then
					vCLIENT.startFrequency(source,parseInt(freq))
					TriggerClientEvent("hud:Radio",source,parseInt(freq))
					TriggerClientEvent("Notify",source,"verde","<b>"..parseInt(freq)..".0Mhz</b>",5000)
					
					addPlayerToRadioControl(user_id, parseInt(freq))
				end
			elseif parseInt(freq) >= 112 and parseInt(freq) <= 114 then
				if vRP.hasGroup(user_id,"Paramedic") then
					vCLIENT.startFrequency(source,parseInt(freq))
					TriggerClientEvent("hud:Radio",source,parseInt(freq))
					TriggerClientEvent("Notify",source,"verde","<b>"..parseInt(freq)..".0Mhz</b>",5000)
					
					addPlayerToRadioControl(user_id, parseInt(freq))
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("hud:Radio",source,parseInt(freq))
				TriggerClientEvent("Notify",source,"verde","<b>"..parseInt(freq)..".0Mhz</b>",5000)
				
				addPlayerToRadioControl(user_id, parseInt(freq))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,"radio")
		
		if consultItem[1] <= 0 then
			removePlayerFromRadioControl(user_id)
			return true
		end

		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GET MY CHARACTER NAME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getMyCharacterName()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.userIdentity(user_id)
		local playerName = "Jogador " .. user_id
		if identity then
			playerName = identity.name.." "..identity.name2
		end
		
		vCLIENT.setMyCharacterName(source, playerName)
		return playerName
	end
	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER STARTED/STOPPED TALKING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.playerStartedTalking(frequency)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		if playersInRadio[user_id] then
			playersInRadio[user_id].talking = true
		end
		

		local identity = vRP.userIdentity(user_id)
		local playerName = "Jogador " .. user_id
		if identity then
			playerName = identity.name.." "..identity.name2
		end

		notifyPlayersInFrequency(frequency, playerName, true, user_id)
	end
end

function cRP.playerStoppedTalking(frequency)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		
		if playersInRadio[user_id] then
			playersInRadio[user_id].talking = false
		end
		
		local identity = vRP.userIdentity(user_id)
		local playerName = "Jogador " .. user_id
		if identity then
			playerName = identity.name.." "..identity.name2
		end
		
		notifyPlayersInFrequency(frequency, playerName, false, user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HELPER FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function addPlayerToRadioControl(user_id, frequency)
	local identity = vRP.userIdentity(user_id)
	local playerName = "Jogador " .. user_id
	if identity then
		playerName = identity.name.." "..identity.name2
	end
	
	playersInRadio[user_id] = {
		frequency = frequency,
		talking = false,
		name = playerName
	}
end

function removePlayerFromRadioControl(user_id)
	if playersInRadio[user_id] then
		playersInRadio[user_id] = nil
	end
end

function notifyPlayersInFrequency(frequency, playerName, talking, excludeUserId)
	
	for user_id, data in pairs(playersInRadio) do
		if data.frequency == frequency and user_id ~= excludeUserId then
			local player = vRP.getUserSource(user_id)
			if player then
				TriggerClientEvent('radio:playerTalking', player, playerName, frequency, talking)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:HACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("admin:Hacker")
AddEventHandler("admin:Hacker",function(message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Hackers","Passaporte **"..user_id.."** "..message..".",3092790)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT HANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave", function(user_id, source)
	removePlayerFromRadioControl(user_id)
end)
