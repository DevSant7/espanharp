-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------

local Meth = 0
local Drunk = 0
local Cocaine = 0
local Energetic = 0
local Residuals = nil
LocalPlayer["state"]["Tea"] = 3600
LocalPlayer["state"]["Handcuff"] = false
LocalPlayer["state"]["Commands"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:COMMANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Commands")
AddEventHandler("player:Commands", function(status)
	LocalPlayer["state"]["Commands"] = status
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- / COR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('changeWeaponColor')
AddEventHandler('changeWeaponColor', function(cor)
	local tinta = tonumber(cor)
	local ped = PlayerPedId()
	local arma = GetSelectedPedWeapon(ped)
	if tinta >= 0 then
		SetPedWeaponTintIndex(ped, arma, tinta)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PLAYERCARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local playerCarry = false
RegisterNetEvent("player:playerCarry")
AddEventHandler("player:playerCarry", function(entity, mode)
	if playerCarry then
		DetachEntity(PlayerPedId(), false, false)
		playerCarry = false
	else
		if mode == "handcuff" then
			AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(entity)), 11816, 0.0, 0.5, 0.0, 0.0,
				0.0, 0.0, false, false, false, false, 2, true)
		elseif mode == "uncuff" then 
			DetachEntity(PlayerPedId(), false, false)
			DetachEntity(GetPlayerPed(GetPlayerFromServerId(entity)), false, false)
		else
			AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(entity)), 11816, 0.6, 0.0, 0.0, 0.0,
				0.0, 0.0, false, false, false, false, 2, true)
		end

		playerCarry = true
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
RegisterNetEvent("toggleCarry")
AddEventHandler("toggleCarry", function(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		Citizen.InvokeNative(0x6B9BBD38AB0796DF, ped, GetPlayerPed(GetPlayerFromServerId(uCarry)), 4103, 11816, 0.48, 0.0,
			0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped, false, false)
			sCarry = false
		end
	end
end)

RegisterCommand("carryAdmin",function(source,args)
	serverAPI.carryAdmin()
end) 	

RegisterKeyMapping("carryAdmin","Segurar um jogador", "keyboard", "H")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROPECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local ropeCarry = false
RegisterNetEvent("player:ropeCarry")
AddEventHandler("player:ropeCarry", function(entity)
	ropeCarry = not ropeCarry

	if not ropeCarry then
		DetachEntity(PlayerPedId(), false, false)
		ropeCarry = false
	else
		AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(entity)), 0, 0.20, 0.12, 0.63, 0.5, 0.5,
			0.0, false, false, false, false, 2, false)
		ropeCarry = true
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local handcuff = false
function src.toggleHandcuff()
	if not handcuff then
		handcuff = true
		TriggerEvent("radio:outServers")
		Wait(4000)
	else
		handcuff = false
		vRP.stopAnim(false)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function src.removeHandcuff()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getHandcuff()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
function handcuffs()
	return handcuff
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
exports("handCuff", handcuffs)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetHandcuff")
AddEventHandler("resetHandcuff", function()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
	end
end)

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 100
		if handcuff then
			timeDistance = 1
			DisableControlAction(1, 18, true)
			DisableControlAction(1, 21, true)
			DisableControlAction(1, 55, true)
			DisableControlAction(1, 102, true)
			DisableControlAction(1, 179, true)
			DisableControlAction(1, 203, true)
			DisableControlAction(1, 76, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 24, true)
			DisableControlAction(1, 25, true)
			DisableControlAction(1, 68, true)
			DisableControlAction(1, 69, true)
			DisableControlAction(1, 70, true)
			DisableControlAction(1, 91, true)
			DisableControlAction(1, 92, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 143, true)
			DisableControlAction(1, 75, true)
			DisableControlAction(1, 22, true)
			DisableControlAction(1, 243, true)
			DisableControlAction(1, 257, true)
			DisableControlAction(1, 263, true)
			DisableControlAction(1, 311, true)
			DisablePlayerFiring(PlayerPedId(), true)
		end

		Citizen.Wait(timeDistance)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROPEANIM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		if ropeCarry then
			timeDistance = 1
			local ped = PlayerPedId()
			if not IsEntityPlayingAnim(ped, "nm", "firemans_carry", 3) then
				vRP.playAnim(false, { "nm", "firemans_carry" }, true)
			end

			DisableControlAction(1, 23, true)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARYAWAY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local awaySystem = {
		["coords"] = vec3(0.0, 0.0, 0.0),
		["time"] = 60 * 30
	}

	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		awaySystem["time"] = awaySystem["time"] - 1
		if GetEntityHealth(ped) > 100 and awaySystem["time"] <= 0 then
			awaySystem["coords"] = coords
			awaySystem["time"] = 60 * 30
			serverAPI.getSalary()
		end


		Wait(60 * 30)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 100

			if not GetPedConfigFlag(ped, 184, true) then
				SetPedConfigFlag(ped, 184, true)
			end

			local Vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(Vehicle, 0) == ped then
				if GetIsTaskActive(ped, 165) then
					SetPedIntoVehicle(ped, Vehicle, 0)
				end
			end
		else
			if GetPedConfigFlag(ped, 184, true) then
				SetPedConfigFlag(ped, 184, false)
			end
		end

		Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic", function(Timer, Number)
	Energetic = Energetic + Timer
	SetRunSprintMultiplierForPlayer(PlayerId(), Number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetEnergetic")
AddEventHandler("resetEnergetic", function()
	if Energetic > 0 then
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
		Energetic = 0
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Energetic > 0 then
			Energetic = Energetic - 1
			RestorePlayerStamina(PlayerId(), 1.0)

			if Energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 100 then
				SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
				Energetic = 0
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMETH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setMeth")
AddEventHandler("setMeth", function()
	Meth = Meth + 30

	if not GetScreenEffectIsActive("DMT_flight") then
		StartScreenEffect("DMT_flight", 0, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMETH
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Meth > 0 then
			Meth = Meth - 1

			if Meth <= 0 or GetEntityHealth(PlayerPedId()) <= 100 then
				Meth = 0

				if GetScreenEffectIsActive("DMT_flight") then
					StopScreenEffect("DMT_flight")
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCOCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setCocaine")
AddEventHandler("setCocaine", function()
	Cocaine = Cocaine + 30

	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn", 0, true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCOCAINE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Cocaine > 0 then
			Cocaine = Cocaine - 1

			if Cocaine <= 0 or GetEntityHealth(PlayerPedId()) <= 100 then
				Cocaine = 0

				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime", function(Timer)
	Drunk = Drunk + Timer

	LocalPlayer["state"]["Drunk"] = true
	RequestAnimSet("move_m@drunk@verydrunk")
	while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
		Wait(1)
	end

	SetPedMovementClipset(PlayerPedId(), "move_m@drunk@verydrunk", 0.25)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Drunk > 0 then
			Drunk = Drunk - 1

			if Drunk <= 0 or GetEntityHealth(PlayerPedId()) <= 100 then
				ResetPedMovementClipset(PlayerPedId(), 0.25)
				LocalPlayer["state"]["Drunk"] = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOODOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncHoodOptions")
AddEventHandler("player:syncHoodOptions", function(vehNet, Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle, 4, 0, 0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle, 4, 0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORSOPTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncDoorsOptions")
AddEventHandler("player:syncDoorsOptions", function(vehNet, Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if Active == "open" then
				SetVehicleDoorOpen(Vehicle, 5, 0, 0)
			elseif Active == "close" then
				SetVehicleDoorShut(Vehicle, 5, 0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:syncWins")
AddEventHandler("player:syncWins", function(vehNet, Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if Active == "1" then
				RollUpWindow(Vehicle, 0)
				RollUpWindow(Vehicle, 1)
				RollUpWindow(Vehicle, 2)
				RollUpWindow(Vehicle, 3)
			else
				RollDownWindow(Vehicle, 0)
				RollDownWindow(Vehicle, 1)
				RollDownWindow(Vehicle, 2)
				RollDownWindow(Vehicle, 3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doorStatus = { ["1"] = 0, ["2"] = 1, ["3"] = 2, ["4"] = 3, ["5"] = 5, ["6"] = 4 }
RegisterNetEvent("player:syncDoors")
AddEventHandler("player:syncDoors", function(vehNet, Active)
	if NetworkDoesNetworkIdExist(vehNet) then
		local v = NetToEnt(vehNet)

		if GetVehicleDoorLockStatus(v) == 2 then
			TriggerEvent("Notify", "important", "Seu veiculo está tracando", 10000)
			return
		end

		if DoesEntityExist(v) and GetVehicleDoorLockStatus(v) == 1 then
			if doorStatus[Active] then
				if GetVehicleDoorAngleRatio(v, doorStatus[Active]) == 0 then
					SetVehicleDoorOpen(v, doorStatus[Active], 0, 0)
				else
					SetVehicleDoorShut(v, doorStatus[Active], 0)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:seatPlayer")
AddEventHandler("player:seatPlayer", function(vehIndex)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)

		if vehIndex == "0" then
			if IsVehicleSeatFree(vehicle, -1) then
				SetPedIntoVehicle(ped, vehicle, -1)
			end
		else
			if IsVehicleSeatFree(vehicle, parseInt(vehIndex - 1)) then
				SetPedIntoVehicle(ped, vehicle, parseInt(vehIndex - 1))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 100
		if LocalPlayer["state"]["Handcuff"] or LocalPlayer["state"]["Target"] then
			timeDistance = 1
			DisableControlAction(1, 18, true)
			DisableControlAction(1, 21, true)
			DisableControlAction(1, 55, true)
			DisableControlAction(1, 102, true)
			DisableControlAction(1, 179, true)
			DisableControlAction(1, 203, true)
			DisableControlAction(1, 76, true)
			DisableControlAction(1, 23, true)
			DisableControlAction(1, 24, true)
			DisableControlAction(1, 25, true)
			DisableControlAction(1, 68, true)
			DisableControlAction(1, 69, true)
			DisableControlAction(1, 70, true)
			DisableControlAction(1, 91, true)
			DisableControlAction(1, 92, true)
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 143, true)
			DisableControlAction(1, 75, true)
			DisableControlAction(1, 22, true)
			DisableControlAction(1, 243, true)
			DisableControlAction(1, 257, true)
			DisableControlAction(1, 263, true)
			DisablePlayerFiring(PlayerPedId(), true)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()

		if handcuff then
			if not IsEntityPlayingAnim(ped, "mp_arresting", "idle", 3) or IsPedInAnyVehicle(ped, false) then
				RequestAnimDict("mp_arresting")
				while not HasAnimDictLoaded("mp_arresting") do
					Wait(1)
				end

				while IsPedInAnyVehicle(ped, false) do
					Wait(100)
				end

				TaskPlayAnim(ped, "mp_arresting", "idle", 8.0, -8.0, -1, 49, 0, false, false, false)
				timeDistance = 1
			end
		end

		Wait(timeDistance)
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADSHOTSFIRED
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- THREADSHOT
-- -----------------------------------------------------------------------------------------------------------------------------------------
local ShotDelay = GetGameTimer()
CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Route"] < 900000 then
			local Ped = PlayerPedId()
			if IsPedArmed(Ped, 6) then
				if (ShotDelay <= GetGameTimer()) then
					timeDistance = 1

					if IsPedShooting(Ped) and not LocalPlayer["state"]["Police"] and not LocalPlayer["state"]["Dip"] and not LocalPlayer["state"]["inArena"] then
						ShotDelay = GetGameTimer() + 5000
						TriggerEvent("player:Residuals", "Resíduo de Pólvora.")

						local Vehicle = false
						local Coords = GetEntityCoords(Ped)
						if not IsPedCurrentWeaponSilenced(Ped) then
							TriggerServerEvent("evidence:dropEvidence", "blue")

							if IsPedInAnyVehicle(Ped) then
								Vehicle = true
							end

							serverAPI.shotsFired(Vehicle)
						else
							TriggerServerEvent("evidence:dropEvidence", "blue")

							if IsPedInAnyVehicle(Ped) then
								Vehicle = true
							end

							serverAPI.shotsFired(Vehicle)
						end
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- SHAKESHOTTING
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) and IsPedArmed(Ped, 6) then
			timeDistance = 1

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if IsPedShooting(Ped) and (GetVehicleClass(Vehicle) ~= 15 and GetVehicleClass(Vehicle) ~= 16) then
				ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.05)
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSOAP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkSoap()
	return Residuals
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RESIDUALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Residuals")
AddEventHandler("player:Residuals", function(Informations)
	if Informations then
		if Residuals == nil then
			Residuals = {}
		end

		Residuals[Informations] = true
	else
		Residuals = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:inBennys")
AddEventHandler("player:inBennys", function(status)
	inBennys = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.removeVehicle()
	if not inBennys then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			TaskLeaveVehicle(ped, GetVehiclePedIsUsing(ped), 16)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.putVehicle(vehNet)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			local vehSeats = 10
			local ped = PlayerPedId()

			repeat
				vehSeats = vehSeats - 1

				if IsVehicleSeatFree(Vehicle, vehSeats) then
					ClearPedTasks(ped)
					ClearPedSecondaryTask(ped)
					SetPedIntoVehicle(ped, Vehicle, vehSeats)

					vehSeats = true
				end
			until vehSeats == true or vehSeats == 0
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CRUISER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cr", function(source, args, rawCommand)
	if exports["chat"]:statusChat() and MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local Vehicle = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(Vehicle, -1) == ped and not IsEntityInAir(Vehicle) then
				local speed = GetEntitySpeed(Vehicle) * 3.6

				if speed >= 10 then
					if args[1] == nil then
						SetEntityMaxSpeed(Vehicle, GetVehicleEstimatedMaxSpeed(Vehicle))
						TriggerEvent("Notify", "amarelo", "Controle de cruzeiro desativado.", 3000)
					else
						if parseInt(args[1]) > 10 then
							SetEntityMaxSpeed(Vehicle, 0.28 * args[1])
							TriggerEvent("Notify", "verde", "Controle de cruzeiro ativado.", 3000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponNames = {
    [GetHashKey("WEAPON_ASSAULTRIFLE")] = "AK-103",
    [GetHashKey("WEAPON_ASSAULTRIFLE_MK2")] = "AK-103 MK2",
    [GetHashKey("WEAPON_ASSAULTSHOTGUN")] = "Assault Shotgun",
    [GetHashKey("WEAPON_AUTOSHOTGUN")] = "Automatic Shotgun",
    [GetHashKey("WEAPON_BULLPUPRIFLE")] = "QBZ-97",
    [GetHashKey("WEAPON_BULLPUPRIFLE_MK2")] = "Bullpup Rifle Mk II",
    [GetHashKey("WEAPON_CARBINERIFLE")] = "M4A1",
    [GetHashKey("WEAPON_CARBINERIFLE_MK2")] = "M4A1 MK2",
    [GetHashKey("WEAPON_COMBATMG")] = "Metralhadora de Combate",
    [GetHashKey("WEAPON_COMBATMG_MK2")] = "Metralhadora de Combate MK2",
    [GetHashKey("WEAPON_COMBATPDW")] = "SIG MPX",
    [GetHashKey("WEAPON_COMBATSHOTGUN")] = "Combat Shotgun",
    [GetHashKey("WEAPON_COMPACTRIFLE")] = "Fuzil Compacto",
    [GetHashKey("WEAPON_DOUBLEACTION")] = "Double Action Revolver",
    [GetHashKey("WEAPON_FIREEXTINGUISHER")] = "Extintor de Incêndio",
    [GetHashKey("WEAPON_FIREWORK")] = "Lança Fogos",
    [GetHashKey("WEAPON_FLARE")] = "Sinalizador",
    [GetHashKey("WEAPON_FLAREGUN")] = "Flare Gun",
    [GetHashKey("WEAPON_GADGETPISTOL")] = "Gadget Pistol",
    [GetHashKey("WEAPON_GRENADE")] = "Granada",
    [GetHashKey("WEAPON_GRENADELAUNCHER")] = "Lança-Granadas",
    [GetHashKey("WEAPON_GUSENBERG")] = "Metralhadora Gusenberg",
    [GetHashKey("WEAPON_HEAVYRIFLE")] = "Fuzil Pesado",
    [GetHashKey("WEAPON_HEAVYSHOTGUN")] = "Heavy Shotgun",
    [GetHashKey("WEAPON_HEAVYSNIPER")] = "AWP",
    [GetHashKey("WEAPON_HEAVYSNIPER_MK2")] = "Heavy Sniper Mk II",
    [GetHashKey("WEAPON_HOMINGLAUNCHER")] = "Míssil Teleguiado",
    [GetHashKey("WEAPON_MG")] = "Metralhadora de Combate",
    [GetHashKey("WEAPON_MARKSMANRIFLE")] = "Marksman Rifle",
    [GetHashKey("WEAPON_MARKSMANRIFLE_MK2")] = "Marksman Rifle Mk II",
    [GetHashKey("WEAPON_MICROSMG")] = "Uzi",
    [GetHashKey("WEAPON_MINIGUN")] = "Minigun",
    [GetHashKey("WEAPON_MILITARYRIFLE")] = "Fuzil Militar",
    [GetHashKey("WEAPON_NAVYREVOLVER")] = "Navy Revolver",
    [GetHashKey("WEAPON_PRECISIONRIFLE")] = "Precision Rifle",
    [GetHashKey("WEAPON_PUMPSHOTGUN")] = "Mossberg 590",
    [GetHashKey("WEAPON_PUMPSHOTGUN_MK2")] = "Mossberg 590 MK2",
    [GetHashKey("WEAPON_RPG")] = "Lança-Foguetes",
    [GetHashKey("WEAPON_SAWNOFFSHOTGUN")] = "Shotgun Serrada",
    [GetHashKey("WEAPON_SMG")] = "SMG",
    [GetHashKey("WEAPON_SMG_MK2")] = "SMG MK2",
    [GetHashKey("WEAPON_SMOKEGRENADE")] = "Granada de Fumaça",
    [GetHashKey("WEAPON_SNIPERRIFLE")] = "Sniper Rifle",
    [GetHashKey("WEAPON_SPECIALCARBINE")] = "G36C",
    [GetHashKey("WEAPON_SPECIALCARBINE_MK2")] = "G36C MK2",
    [GetHashKey("WEAPON_STUNGUN")] = "Taser",
    [GetHashKey("WEAPON_TACTICALRIFLE")] = "Fuzil Tático",
    [GetHashKey("WEAPON_VINTAGEPISTOL")] = "Pistola Vintage",
    [GetHashKey("WEAPON_L85A2")] = "L85A2",
    [GetHashKey("WEAPON_SIGMCX")] = "SIG MCX",
    [GetHashKey("WEAPON_SIGSAUER")] = "SIG Sauer",
    [GetHashKey("WEAPON_M4A1")] = "M4A1",
    [GetHashKey("WEAPON_QBZ")] = "QBZ-97",
    [GetHashKey("WEAPON_MOSIN")] = "Mosin Nagant"
}


local function GetWeaponNameFromHash(hash)
    if weaponNames[hash] then
        return weaponNames[hash]
    else
        return "Desconhecida"
    end
end

AddEventHandler("gameEventTriggered", function(name, args)
    if name == "CEventNetworkEntityDamage" then
        local victimPed = args[1]
        local killerPed = args[2]

        if not IsPedAPlayer(victimPed) then return end

        local victimIndex = NetworkGetPlayerIndexFromPed(victimPed)
        local victimServerId = GetPlayerServerId(victimIndex)

        if victimIndex ~= PlayerId() then return end

        local killerIndex = IsPedAPlayer(killerPed) and NetworkGetPlayerIndexFromPed(killerPed) or -1
        local killerServerId = killerIndex ~= -1 and GetPlayerServerId(killerIndex) or nil

        local victimCoords = GetEntityCoords(victimPed)
        local killerCoords = killerPed and GetEntityCoords(killerPed) or vector3(0,0,0)

        local suicide = false
        local reason = nil

        if killerPed == victimPed or not IsPedAPlayer(killerPed) then
            suicide = true
            reason = "Queda, explosão ou dano próprio"
            killerServerId = nil
        end
        local weaponHash = GetPedCauseOfDeath(victimPed)
        local weaponName = GetWeaponNameFromHash(weaponHash)

        if GetEntityHealth(victimPed) <= 101 then
            TriggerServerEvent("player:deathLogs", {
                victimServerId = victimServerId,
                killerServerId = killerServerId,
                suicide = suicide,
                reason = reason,
                weapon = weaponName,
                victimCoords = string.format("%.2f, %.2f, %.2f", victimCoords.x, victimCoords.y, victimCoords.z),
                killerCoords = string.format("%.2f, %.2f, %.2f", killerCoords.x, killerCoords.y, killerCoords.z)
            })
        end
    end
end)

RegisterNetEvent('showKillConfirmEffect')
AddEventHandler('showKillConfirmEffect', function()
    StartScreenEffect("FocusOut", 1000, false)
	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
end)   
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrunk")
AddEventHandler("player:enterTrunk", function(Entity)
	if not inTrunk then
		LocalPlayer["state"]["Invisible"] = true
		LocalPlayer["state"]["Commands"] = true
		SetEntityVisible(PlayerPedId(), false, false)
		AttachEntityToEntity(PlayerPedId(), Entity[3], -1, 0.0, -2.2, 0.5, 0.0, 0.0, 0.0, false, false, false, false, 20,
			true)
		inTrunk = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrunk")
AddEventHandler("player:checkTrunk", function()
	if inTrunk then
		local ped = PlayerPedId()
		local Vehicle = GetEntityAttachedTo(ped)
		if DoesEntityExist(Vehicle) then
			inTrunk = false
			DetachEntity(ped, false, false)
			SetEntityVisible(ped, true, false)
			LocalPlayer["state"]["Commands"] = false
			LocalPlayer["state"]["Invisible"] = false
			SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.25, -0.25), false, false, false, false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 999

		if inTrunk then
			local ped = PlayerPedId()
			local Vehicle = GetEntityAttachedTo(ped)
			if DoesEntityExist(Vehicle) then
				timeDistance = 1

				DisablePlayerFiring(ped, true)

				if IsEntityVisible(ped) then
					LocalPlayer["state"]["Invisible"] = true
					SetEntityVisible(ped, false, false)
				end

				if IsControlJustPressed(1, 38) then
					inTrunk = false
					DetachEntity(ped, false, false)
					SetEntityVisible(ped, true, false)
					LocalPlayer["state"]["Commands"] = false
					LocalPlayer["state"]["Invisible"] = false
					SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.25, -0.25), false, false, false,
						false)
				end
			else
				inTrunk = false
				DetachEntity(ped, false, false)
				SetEntityVisible(ped, true, false)
				LocalPlayer["state"]["Commands"] = false
				LocalPlayer["state"]["Invisible"] = false
				SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, 0.0, -1.25, -0.25), false, false, false, false)
			end
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FPS
-----------------------------------------------------------------------------------------------------------------------------------------
local FpsCommands = false
RegisterCommand("fps", function(source, args, rawCommand)
	if FpsCommands then
		FpsCommands = false
		ClearTimecycleModifier()
	else
		FpsCommands = true
		SetTimecycleModifier("cinema")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesPoints = 0
local bikesTea = false
local bikeMaxPoints = 900
local bikesTimer = GetGameTimer()
local bikesTeaTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- BIKESMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
local bikesModel = {
	[1131912276] = true,
	[448402357] = true,
	[-836512833] = true,
	[-186537451] = true,
	[1127861609] = true,
	[-1233807380] = true,
	[-400295096] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:MUSHROOMTEA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:MushroomTea")
AddEventHandler("player:MushroomTea", function()
	bikesTea = true
	bikeMaxPoints = 600
	LocalPlayer["state"]["Tea"] = 3600
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKES
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local Vehicle = GetVehiclePedIsUsing(ped)
			local vehModel = GetEntityModel(Vehicle)
			local speed = GetEntitySpeed(Vehicle) * 3.6

			if bikesModel[vehModel] and GetGameTimer() >= bikesTimer and speed >= 10 then
				bikesTimer = GetGameTimer() + 1000
				bikesPoints = bikesPoints + 1

				if bikesPoints >= bikeMaxPoints then
					serverAPI.bikesBackpack()
					bikesPoints = 0
				end
			end
		end

		if commandFps then
			if IsPedSwimming(ped) then
				ClearTimecycleModifier()
				commandFps = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBIKETEA
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if bikesTea then
			if GetGameTimer() >= bikesTeaTimer then
				bikesTeaTimer = GetGameTimer() + 1000
				LocalPlayer["state"]["Tea"] = LocalPlayer["state"]["Tea"] - 1

				if LocalPlayer["state"]["Tea"] <= 0 then
					LocalPlayer["state"]["Tea"] = 3600
					bikeMaxPoints = 900
					bikesTea = false
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANCORAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ancorar", function(source, args, rawCommand)
	local ped = PlayerPedId()
	if IsPedInAnyBoat(ped) then
		local Vehicle = GetVehiclePedIsUsing(ped)
		if CanAnchorBoatHere(Vehicle) then
			TriggerEvent("Notify", "verde", "Embarcação desancorada.", 5000)
			SetBoatAnchor(Vehicle, false)
		else
			TriggerEvent("Notify", "verde", "Embarcação ancorada.", 5000)
			SetBoatAnchor(Vehicle, true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COWCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local cowCoords = {
	{ 2440.58, 4736.35, 34.29 },
	{ 2432.5,  4744.58, 34.31 },
	{ 2424.47, 4752.37, 34.31 },
	{ 2416.28, 4760.8,  34.31 },
	{ 2408.6,  4768.88, 34.31 },
	{ 2400.32, 4777.48, 34.53 },
	{ 2432.46, 4802.66, 34.83 },
	{ 2440.62, 4794.22, 34.66 },
	{ 2448.65, 4786.57, 34.64 },
	{ 2456.88, 4778.08, 34.49 },
	{ 2464.53, 4770.04, 34.37 },
	{ 2473.38, 4760.98, 34.31 },
	{ 2495.03, 4762.77, 34.37 },
	{ 2503.13, 4754.08, 34.31 },
	{ 2511.34, 4746.04, 34.31 },
	{ 2519.56, 4737.35, 34.29 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCOWS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for k, v in pairs(cowCoords) do
		exports["target"]:AddCircleZone("Cows:" .. k, vec3(v[1], v[2], v[3]), 0.75, {
			name = "Cows:" .. k,
			heading = 3374176
		}, {
			distance = 1.25,
			options = {
				{
					event = "inventory:makeProducts",
					label = "Retirar Leite",
					tunnel = "products",
					service = "milkBottle"
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrash = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ENTERTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:enterTrash")
AddEventHandler("player:enterTrash", function(entity)
	if not inTrash then
		LocalPlayer["state"]["Commands"] = true
		LocalPlayer["state"]["Invisible"] = true

		local ped = PlayerPedId()
		FreezeEntityPosition(ped, true)
		SetEntityVisible(ped, false, false)
		SetEntityCoords(ped, entity[4], false, false, false, false)

		inTrash = GetOffsetFromEntityInWorldCoords(entity[1], 0.0, -1.5, 0.0)

		while inTrash do
			Wait(1)

			if IsControlJustPressed(1, 38) then
				FreezeEntityPosition(ped, false)
				SetEntityVisible(ped, true, false)
				SetEntityCoords(ped, inTrash, false, false, false, false)
				LocalPlayer["state"]["Commands"] = false
				LocalPlayer["state"]["Invisible"] = false

				inTrash = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:CHECKTRASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:checkTrash")
AddEventHandler("player:checkTrash", function()
	if inTrash then
		local ped = PlayerPedId()
		FreezeEntityPosition(ped, false)
		SetEntityVisible(ped, true, false)
		SetEntityCoords(ped, inTrash, false, false, false, false)
		LocalPlayer["state"]["Commands"] = false
		LocalPlayer["state"]["Invisible"] = false

		inTrash = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- YOGABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Yoga = false
local YogaPoints = 0
local YogaTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:YOGA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Yoga")
AddEventHandler("player:Yoga", function()
	if not Yoga then
		Yoga = true
		YogaPoints = 0
		TriggerEvent("Notify", "amarelo", "Yoga iniciado, para finalizar pressione <b>E</b>.", 5000)

		while Yoga do
			if GetGameTimer() >= YogaTimer then
				YogaTimer = GetGameTimer() + 1000
				YogaPoints = YogaPoints + 1

				if YogaPoints >= 5 then
					TriggerServerEvent("player:Stress", 10)
					YogaPoints = 0
				end
			end

			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped, "amb@world_human_yoga@male@base", "base_a", 3) then
				vRP.playAnim(false, { "amb@world_human_yoga@male@base", "base_a" }, true)
			end

			if IsControlJustPressed(1, 38) then
				vRP.removeObjects()
				Yoga = false
				break
			end

			Wait(1)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
local Megaphone = false
RegisterNetEvent("player:Megaphone")
AddEventHandler("player:Megaphone", function()
	Megaphone = true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if Megaphone then
			local Ped = PlayerPedId()
			if not IsEntityPlayingAnim(Ped, "anim@random@shop_clothes@watches", "base", 3) then
				TriggerServerEvent("pma-voice:Megaphone", false)
				TriggerEvent("pma-voice:Megaphone", false)
				Megaphone = false
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DUIVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DuiTextures = {}
local InnerTexture = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DUITABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:DuiTable")
AddEventHandler("player:DuiTable", function(Table)
	DuiTextures = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMEGAPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		if not IsPedInAnyVehicle(Ped) then
			local Coords = GetEntityCoords(Ped)

			for Line, v in pairs(DuiTextures) do
				if #(Coords - v["Coords"]) <= 15 then
					if InnerTexture[Line] == nil then
						InnerTexture[Line] = true

						local Texture = CreateRuntimeTxd("Texture" .. Line)
						local TextureObject = CreateDui(v["Link"], v["Width"], v["Weight"])
						local TextureHandle = GetDuiHandle(TextureObject)

						CreateRuntimeTextureFromDuiHandle(Texture, "Back" .. Line, TextureHandle)
						AddReplaceTexture(v["Dict"], v["Texture"], "Texture" .. Line, "Back" .. Line)

						exports["target"]:AddCircleZone("Texture" .. Line, v["Coords"], v["Dimension"], {
							name = "Texture" .. Line,
							heading = 3374176
						}, {
							shop = Line,
							distance = v["Distance"],
							options = {
								{
									event = "player:Texture",
									label = v["Label"],
									tunnel = "shopserver"
								}
							}
						})
					end
				else
					if InnerTexture[Line] then
						exports["target"]:RemCircleZone("Texture" .. Line)
						RemoveReplaceTexture(v["Dict"], v["Texture"])
						InnerTexture[Line] = nil
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:DUIUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:DuiUpdate")
AddEventHandler("player:DuiUpdate", function(Name, Table)
	DuiTextures[Name] = Table

	local Ped = PlayerPedId()
	local Fast = DuiTextures[Name]
	local Coords = GetEntityCoords(Ped)
	if #(Coords - Fast["Coords"]) <= 15 then
		local Texture = CreateRuntimeTxd("Texture" .. Name)
		local TextureObject = CreateDui(Fast["Link"], Fast["Width"], Fast["Weight"])
		local TextureHandle = GetDuiHandle(TextureObject)

		CreateRuntimeTextureFromDuiHandle(Texture, "Back" .. Name, TextureHandle)
		AddReplaceTexture(Fast["Dict"], Fast["Texture"], "Texture" .. Name, "Back" .. Name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:RELATIONSHIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:Relationship")
AddEventHandler("player:Relationship", function(Group)
	if Group == "Roxos" then
		SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_BALLAS"))
	elseif Group == "Verdes" then
		SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_FAMILY"))
	elseif Group == "Amarelos" then
		SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_MEXICAN"))
	elseif Group == "TheLost" then
		SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey("PLAYER"))
		SetRelationshipBetweenGroups(1, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_LOST"))
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetVeh()
	local vehicles = {}
	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end
	return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i = 1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle, closestDistance
end

local First = vector3(0.0, 0.0, 0.0)
local Second = vector3(5.0, 5.0, 5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()
		local closestVehicle, Distance = GetClosestVeh()
		if Distance < 3.9 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle), First, Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(timeDistance)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if Vehicle.Vehicle ~= nil and GetVehicleDoorLockStatus(Vehicle.Vehicle) == 1 then
			local ped = PlayerPedId()

			if GetEntityHealth(ped) > 101 and IsVehicleSeatFree(Vehicle.Vehicle, -1) and not IsEntityInWater(ped) and not IsEntityInAir(ped) and not IsPedBeingStunned(ped) and not IsEntityAttachedToEntity(ped, Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				Citizen.Wait(1000)
				if IsControlPressed(0, 244) and IsInputDisabled(0) then
					RequestAnimDict('missfinale_c2ig_11')
					TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
					NetworkRequestControlOfEntity(Vehicle.Vehicle)

					if Vehicle.IsInFront then
						AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0,
							Vehicle.Dimensions.y * -1 + 0.1, Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 180.0, 0.0, false,
							false, true, false, true)
					else
						AttachEntityToEntity(ped, Vehicle.Vehicle, GetPedBoneIndex(6286), 0.0, Vehicle.Dimensions.y - 0.3,
							Vehicle.Dimensions.z + 1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, true)
					end

					while true do
						Citizen.Wait(5)
						if IsDisabledControlPressed(0, 34) then
							TaskVehicleTempAction(ped, Vehicle.Vehicle, 11, 100)
						end

						if IsDisabledControlPressed(0, 9) then
							TaskVehicleTempAction(ped, Vehicle.Vehicle, 10, 100)
						end

						if Vehicle.IsInFront then
							SetVehicleForwardSpeed(Vehicle.Vehicle, -1.0)
						else
							SetVehicleForwardSpeed(Vehicle.Vehicle, 1.0)
						end

						if not IsDisabledControlPressed(0, 244) then
							DetachEntity(ped, false, false)
							StopAnimTask(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0)
							break
						end
					end
				end
			end
		end
	end
end)
