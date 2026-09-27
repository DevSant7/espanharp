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
vSERVER = Tunnel.getInterface("radio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local voiceIndicatorActive = false
local currentRadioUsers = {}
local activeRadio = false
local activeFrequencys = 0
local timeCheck = GetGameTimer()
local isPlayerTalking = false
local myCharacterName = nil 
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIOCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("radioClose",function()
	SetNuiFocus(false,false)
	vRP.removeObjects("one")
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:openSystem")
AddEventHandler("radio:openSystem",function()
	if exports["fortal_prisao"]:checkPrison() then
        return false
    end
	
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })

	if not IsPedInAnyVehicle(PlayerPedId()) then
		vRP.createObjects("cellphone@","cellphone_text_in","prop_cs_hand_radio",50,28422)
	end

	if myCharacterName == nil then
		vSERVER.getMyCharacterName()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SET MY CHARACTER NAME
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.setMyCharacterName(name)
	myCharacterName = name
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("activeFrequency",function(data)
	if parseInt(data["freq"]) >= 1 and parseInt(data["freq"]) <= 999 then
		vSERVER.activeFrequency(data["freq"])
	end
end)

RegisterKeyMapping("+upRadio", "Up radio frequency", "keyboard", "PAGEUP")
RegisterKeyMapping("+downRadio", "Down radio frequency", "keyboard", "PAGEDOWN")

RegisterCommand("+upRadio", function()
	if activeFrequencys < 999 then
		vSERVER.activeFrequency(activeFrequencys + 1)
	end
end)

RegisterCommand("+downRadio", function()
	if activeFrequencys > 1 then
		vSERVER.activeFrequency(activeFrequencys - 1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INATIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inativeFrequency",function()
	TriggerEvent("radio:outServers")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startFrequency(frequency)
	if activeFrequencys ~= 0 then
		exports["pma-voice"]:removePlayerFromRadio()
	end

	exports["pma-voice"]:setRadioChannel(frequency)
	activeFrequencys = frequency
	activeRadio = true

	updateVoiceIndicator(frequency)

	if myCharacterName == nil then
		vSERVER.getMyCharacterName()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
	if activeFrequencys ~= 0 then
		TriggerEvent("Notify","amarelo","Rádio desativado.",5000)
		exports["pma-voice"]:removePlayerFromRadio()
		TriggerEvent("hud:Radio",0)
		hideVoiceIndicator()
		activeFrequencys = 0
		activeRadio = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RADIO:THREADCHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		if GetGameTimer() >= timeCheck and activeRadio and LocalPlayer["state"]["Route"] < 900000 then
			timeCheck = GetGameTimer() + 60000

			local ped = PlayerPedId()
			if vSERVER.checkRadio() or IsPedSwimming(ped) then
				TriggerEvent("radio:outServers")
			end
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VOICE INDICATOR FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function updateVoiceIndicator(frequency)
	if frequency and frequency > 0 then
		SendNUIMessage({
			action = "updateFrequency",
			frequency = frequency
		})
	end
end

function showVoiceIndicator(playerName, frequency)
	voiceIndicatorActive = true
	SendNUIMessage({
		action = "showVoiceIndicator",
		playerName = playerName or "Desconhecido",
		frequency = frequency or activeFrequencys
	})
end

function hideVoiceIndicator()
	if voiceIndicatorActive then
		voiceIndicatorActive = false
		SendNUIMessage({
			action = "hideVoiceIndicator"
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PMA-VOICE INTEGRATION CORRIGIDA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('pma-voice:radioActive', function(radioActive)
	if activeRadio and activeFrequencys > 0 then
		local playerName = myCharacterName or GetPlayerName(PlayerId())

		if radioActive then
			isPlayerTalking = true
			showVoiceIndicator(playerName, activeFrequencys)
			SendNUIMessage({ action = "voiceStart", playerName = playerName })
			vSERVER.playerStartedTalking(activeFrequencys)
		else
			isPlayerTalking = false
			SendNUIMessage({ action = "voiceStop" })
			vSERVER.playerStoppedTalking(activeFrequencys)
		end
	end
end)

RegisterNetEvent('radio:playerTalking')
AddEventHandler('radio:playerTalking', function(playerName, frequency, talking)
	if activeRadio and activeFrequencys == frequency then
		if talking then
			showVoiceIndicator(playerName, frequency)
			SendNUIMessage({ action = "voiceStart", playerName = playerName })
		else
			if not isPlayerTalking then
				SendNUIMessage({ action = "voiceStop" })
			end
		end
	end
end)
