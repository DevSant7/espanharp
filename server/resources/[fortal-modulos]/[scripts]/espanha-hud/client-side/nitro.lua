-----------------------------------------------------------------------------------------------------------------------------------------
-- PURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
local PurgeSprays = {}
local PurgeParticles = {}
local PurgeActive = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRO
-----------------------------------------------------------------------------------------------------------------------------------------
NitroFlame = false
local NitroButton = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIGHTTRAILS
-----------------------------------------------------------------------------------------------------------------------------------------
local LightTrails = {}
local LightParticles = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- NITROENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function NitroEnable()
	if GetGameTimer() >= NitroButton and not IsPauseMenuActive() then
		local Ped = PlayerPedId()
		if IsPedInAnyVehicle(Ped) then
			NitroButton = GetGameTimer() + 1000

			local Vehicle = GetVehiclePedIsUsing(Ped)
			if GetPedInVehicleSeat(Vehicle, -1) == Ped then
				if GetVehicleTopSpeedModifier(Vehicle) < 50.0 then
					local Plate = GetVehicleNumberPlateText(Vehicle)
					NitroFuel = GlobalState["Nitro:" .. Plate] or 0

					if NitroFuel >= 1 then
						if GetIsVehicleEngineRunning(Vehicle) then
							local Speed = GetEntitySpeed(Vehicle) * 3.6
							if Speed > 10 then
								LocalPlayer["state"]["Nitro"] = true

								while LocalPlayer["state"]["Nitro"] do
									if NitroFuel >= 1 then
										NitroFuel = NitroFuel - 1

										if not NitroFlame then
											SetVehicleRocketBoostActive(Vehicle, true)
											SetVehicleNitroEnabled(Vehicle, true)
											SetVehicleBoostActive(Vehicle, true)
											ModifyVehicleTopSpeed(Vehicle, 50.0)
											SetLightTrail(Vehicle, true)
											NitroFlame = Plate
										end
									else
										if NitroFlame then
											SetVehicleRocketBoostActive(Vehicle, false)
											vSERVER.UpdateNitro(NitroFlame, NitroFuel)
											SetVehicleNitroEnabled(Vehicle, false)
											SetVehicleBoostActive(Vehicle, false)
											ModifyVehicleTopSpeed(Vehicle, 0.0)
											SetLightTrail(Vehicle, false)
											NitroFlame = false

											LocalPlayer["state"]["Nitro"] = nil
										end
									end

									Wait(1)
								end
							else
								SetPurgeSprays(Vehicle, true)
								PurgeActive = true
							end
						else
							SetPurgeSprays(Vehicle, true)
							PurgeActive = true
						end
					end
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NITRODISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function NitroDisable()
	local Vehicle = GetLastDrivenVehicle()

	if NitroFlame then
		SetVehicleRocketBoostActive(Vehicle, false)
		vSERVER.UpdateNitro(NitroFlame, NitroFuel)
		SetVehicleNitroEnabled(Vehicle, false)
		SetVehicleBoostActive(Vehicle, false)
		ModifyVehicleTopSpeed(Vehicle, 0.0)
		SetLightTrail(Vehicle, false)
		Nitro = NitroFuel
		NitroFlame = false

		LocalPlayer["state"]["Nitro"] = nil
	end

	if PurgeActive then
		SetPurgeSprays(Vehicle, false)
		PurgeActive = false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+activeNitro", NitroEnable)
RegisterCommand("-activeNitro", NitroDisable)
RegisterKeyMapping("+activeNitro", "Ativação do nitro.", "keyboard", "LMENU")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function SetLightTrail(Vehicle, Enable)
	if LightTrails[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local LeftTrail = CreateLightTrail(Vehicle, GetEntityBoneIndexByName(Vehicle, "taillight_l"))
		local RightTrail = CreateLightTrail(Vehicle, GetEntityBoneIndexByName(Vehicle, "taillight_r"))

		Particles[#Particles + 1] = LeftTrail
		Particles[#Particles + 1] = RightTrail

		LightTrails[Vehicle] = true
		LightParticles[Vehicle] = Particles
	else
		if LightParticles[Vehicle] and #LightParticles[Vehicle] > 0 then
			for _, v in ipairs(LightParticles[Vehicle]) do
				StopLightTrail(v)
			end
		end

		LightTrails[Vehicle] = nil
		LightParticles[Vehicle] = nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATELIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function CreateLightTrail(Vehicle, Bone)
	UseParticleFxAssetNextCall("core")
	local Particle = StartParticleFxLoopedOnEntityBone("veh_light_red_trail", Vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Bone,
		1.0, false, false, false)
	SetParticleFxLoopedEvolution(Particle, "speed", 1.0, false)

	return Particle
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPLIGHTTRAIL
-----------------------------------------------------------------------------------------------------------------------------------------
function StopLightTrail(Particle)
	CreateThread(function()
		local endTime = GetGameTimer() + 500
		while GetGameTimer() < endTime do
			Wait(0)
			local now = GetGameTimer()
			local Scale = (endTime - now) / 500
			SetParticleFxLoopedScale(Particle, Scale)
			SetParticleFxLoopedAlpha(Particle, Scale)
		end

		StopParticleFxLooped(Particle)
	end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function SetPurgeSprays(Vehicle, Enable)
	if PurgeSprays[Vehicle] == Enable then
		return
	end

	if Enable then
		local Particles = {}
		local Bone = GetEntityBoneIndexByName(Vehicle, "bonnet")
		local Position = GetWorldPositionOfEntityBone(Vehicle, Bone)
		local Offset = GetOffsetFromEntityGivenWorldCoords(Vehicle, Position["x"], Position["y"], Position["z"])

		for i = 0, 3 do
			local LeftPurge = CreatePurgeSprays(Vehicle, Offset["x"] - 0.5, Offset["y"] + 0.05, Offset["z"], 40.0, -20.0,
				0.0, 0.5)
			local RightPurge = CreatePurgeSprays(Vehicle, Offset["x"] + 0.5, Offset["y"] + 0.05, Offset["z"], 40.0, 20.0,
				0.0, 0.5)

			Particles[#Particles + 1] = LeftPurge
			Particles[#Particles + 1] = RightPurge
		end

		PurgeSprays[Vehicle] = true
		PurgeParticles[Vehicle] = Particles
	else
		if PurgeParticles[Vehicle] then
			RemoveParticleFxFromEntity(Vehicle)
		end

		PurgeSprays[Vehicle] = nil
		PurgeParticles[Vehicle] = nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPURGESPRAYS
-----------------------------------------------------------------------------------------------------------------------------------------
function CreatePurgeSprays(Vehicle, xOffset, yOffset, zOffset, xRot, yRot)
	UseParticleFxAssetNextCall("core")
	return StartNetworkedParticleFxNonLoopedOnEntity("ent_sht_steam", Vehicle, xOffset, yOffset, zOffset, xRot, yRot, 0.0,
		0.5, false, false, false)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADPTFXASSET
-----------------------------------------------------------------------------------------------------------------------------------------
function LoadPtfxAsset(Library)
	RequestNamedPtfxAsset(Library)
	while not HasNamedPtfxAssetLoaded(Library) do
		RequestNamedPtfxAsset(Library)
		Wait(1)
	end
	return true
end
