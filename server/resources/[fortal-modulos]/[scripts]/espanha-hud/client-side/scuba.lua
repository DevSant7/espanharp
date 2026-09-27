-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Mask = nil
local Tank = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SCUBAREMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:ScubaRemove")
AddEventHandler("hud:ScubaRemove",function()
	if Mask and DoesEntityExist(Mask) then
		TriggerServerEvent("DeleteObject",ObjToNet(Mask))
		Mask = nil
	end

	if Tank and DoesEntityExist(Tank) then
		TriggerServerEvent("DeleteObject",ObjToNet(Tank))
		Tank = nil
	end

	local ped = PlayerPedId()
	SetEnableScuba(ped,false)
	SetPedMaxTimeUnderwater(ped,10.0)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD:SCUBA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hud:Scuba")
AddEventHandler("hud:Scuba",function()
	if Mask or Tank then
		TriggerEvent("hud:ScubaRemove")
	else
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		local Progression,Handle = vRP.CreateObject("p_s_scuba_tank_s",Coords["x"],Coords["y"],Coords["z"])
		if Progression and Handle then
			Tank = Handle
			AttachEntityToEntity(Tank,Ped,GetPedBoneIndex(Ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,true,true,false,true,2,true)
		end

		local Progression,Handle = vRP.CreateObject("p_s_scuba_mask_s",Coords["x"],Coords["y"],Coords["z"])
		if Progression and Handle then
			Mask = Handle
			AttachEntityToEntity(Mask,Ped,GetPedBoneIndex(Ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,true,true,false,true,2,true)
		end

		SetEnableScuba(Ped,true)
		SetPedMaxTimeUnderwater(Ped,9999.0)
	end
end)

function LoadNetwork(Network)
	local Cooldown = 100
	local Object = NetworkGetEntityFromNetworkId(Network)
	while not DoesEntityExist(Object) and Cooldown > 0 do
		Cooldown = Cooldown - 1
		Object = NetworkGetEntityFromNetworkId(Network)

		Wait(1)
	end

	if DoesEntityExist(Object) then
		NetworkRequestControlOfEntity(Object)
		while not NetworkHasControlOfEntity(Object) do
			Wait(1)
		end

		SetEntityAsMissionEntity(Object,true,true)
		while not IsEntityAMissionEntity(Object) do
			Wait(1)
		end

		return Object
	end

	return false
end