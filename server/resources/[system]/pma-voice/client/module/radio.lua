local radioChannel = 0
local radioNames = {}

function syncRadioData(radioTable,localPlyRadioName)
	radioData = radioTable

	for tgt,enabled in pairs(radioTable) do
		if tgt ~= playerServerId then
			toggleVoice(tgt,enabled,"radio")
		end
	end

	radioNames[playerServerId] = localPlyRadioName
end

RegisterNetEvent("pma-voice:syncRadioData",syncRadioData)

function setTalkingOnRadio(plySource,enabled)
	toggleVoice(plySource,enabled,"radio")
	radioData[plySource] = enabled
end

RegisterNetEvent("pma-voice:setTalkingOnRadio",setTalkingOnRadio)

function addPlayerToRadio(plySource,plyRadioName)
	radioData[plySource] = false
	radioNames[plySource] = plyRadioName
	if radioPressed then
		playerTargets(radioData,MumbleIsPlayerTalking(PlayerId()) and callData or {})
	end
end

RegisterNetEvent("pma-voice:addPlayerToRadio",addPlayerToRadio)

function removePlayerFromRadio(plySource)
	if plySource == playerServerId then
		for tgt,_ in pairs(radioData) do
			if tgt ~= playerServerId then
				toggleVoice(tgt,false,"radio")
			end
		end

		radioNames = {}
		radioData = {}
		playerTargets(MumbleIsPlayerTalking(PlayerId()) and callData or {})
	else
		toggleVoice(plySource,false)

		if radioPressed then
			playerTargets(radioData,MumbleIsPlayerTalking(PlayerId()) and callData or {})
		end

		radioData[plySource] = nil
		radioNames[plySource] = nil
	end
end

RegisterNetEvent("pma-voice:removePlayerFromRadio",removePlayerFromRadio)

function setRadioChannel(channel)
	radioEnabled = true
	type_check({ channel,"number" })
	TriggerServerEvent("pma-voice:setPlayerRadio",channel)
	radioChannel = channel

	sendUIMessage({ radioChannel = channel, radioEnabled = radioEnabled })
end

exports("setRadioChannel",setRadioChannel)
exports("SetRadioChannel",setRadioChannel)

exports("removePlayerFromRadio",function()
	radioEnabled = false
	setRadioChannel(0)
end)

exports("addPlayerToRadio",function(_radio)
	local radio = tonumber(_radio)
	if radio then
		setRadioChannel(radio)
	end
end)

local radioProp
local radioAnim = "2"

exports("changeMode",function(radioMode)
	radioAnim = radioMode
end)

RegisterCommand("+radiotalk",function(source,args,rawCommand)
	local ped = PlayerPedId()
	local radioModel = GetHashKey('prop_cs_hand_radio')
	if IsPedSwimming(ped) or LocalPlayer["state"]["Handcuff"] or IsPlayerFreeAiming(PlayerId()) or not MumbleIsConnected() then
		return
	end

	if not radioPressed and radioEnabled then
		if radioChannel > 0 then
			playerTargets(radioData,MumbleIsPlayerTalking(PlayerId()) and callData or {})
			TriggerServerEvent("pma-voice:setTalkingOnRadio",true)
			radioPressed = true
			playMicClicks(true)

			if radioProp and DoesEntityExist(radioProp) then
				DeleteEntity(radioProp)
			end
			
			Citizen.CreateThread(function()
				if radioAnim == "1" then
					RequestAnimDict("random@arrests")
					while not HasAnimDictLoaded("random@arrests") do
						Citizen.Wait(1)
					end

					TaskPlayAnim(ped,"random@arrests","generic_radio_chatter",8.0,0.0,-1,49,0,0,0,0)
				else
					RequestAnimDict("anim@male@holding_radio")
					while not HasAnimDictLoaded("anim@male@holding_radio") do
						Citizen.Wait(1)
					end
			
					TaskPlayAnim(ped,"anim@male@holding_radio","holding_radio_clip",8.0,0.0,-1,49,0,0,0,0)

					RequestModel(radioModel)
					while not HasModelLoaded(radioModel) do
						Wait(10)
					end

					radioProp = CreateObject(radioModel, 1.0,1.0,1.0, true, true, 0)
		
					AttachEntityToEntity(radioProp, ped, GetPedBoneIndex(ped, 28422), 0.0750, 0.0230, -0.0230, -90.0000, 0.0, -59.9999, 1, 0, 0, 0, 2, 1)
				end
			end)
			

			Citizen.CreateThread(function()
				TriggerEvent("pma-voice:radioActive",true)

				while radioPressed do
					SetControlNormal(0,249,1.0)
					SetControlNormal(1,249,1.0)
					SetControlNormal(2,249,1.0)
					DisableControlAction(0, 24, true)
					DisableControlAction(0,142,true)
					DisableControlAction(1,24,true)
					DisableControlAction(1,25,true)
					DisableControlAction(1,257,true)
					DisableControlAction(1,140,true)
					DisableControlAction(1,142,true)
					Citizen.Wait(0)
				end
			end)
		end
	end
end)

RegisterCommand("-radiotalk",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if IsPedSwimming(ped) or LocalPlayer["state"]["Handcuff"] or IsPlayerFreeAiming(PlayerId()) or not MumbleIsConnected() then
		return
	end

	if radioChannel > 0 or radioEnabled and radioPressed then
		radioPressed = false
		MumbleClearVoiceTargetPlayers(voiceTarget)
		playerTargets(MumbleIsPlayerTalking(PlayerId()) and callData or {})
		TriggerEvent("pma-voice:radioActive",false)
		playMicClicks(false)

		StopAnimTask(ped,"anim@male@holding_radio","holding_radio_clip",-4.0)

		if radioAnim == "1" then
			StopAnimTask(ped,"random@arrests","generic_radio_chatter",-4.0)

		else
			StopAnimTask(ped,"anim@male@holding_radio","holding_radio_clip",-4.0)

		end

		DeleteObject(radioProp)
		TriggerServerEvent("pma-voice:setTalkingOnRadio",false)
	end
end,false)

RegisterKeyMapping("+radiotalk","Dialogar no rádio.","keyboard","CAPITAL")


function syncRadio(_radioChannel)
	radioChannel = _radioChannel
end

RegisterNetEvent("pma-voice:clSetPlayerRadio",syncRadio)

local uiReady = promise.new()
function sendUIMessage(message)
	Citizen.Await(uiReady)
	SendNUIMessage(message)
end

RegisterNUICallback("uiReady",function(data,cb)
	uiReady:resolve(true)

	cb("ok")
end)