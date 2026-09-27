-----------------------------------------------------------------------------------------------------------------------------------------
-- SETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.setHealth(health)
	local ped = PlayerPedId()
	SetEntityHealth(ped,health)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.updateHealth(number)
	local ped = PlayerPedId()
	local health = GetEntityHealth(ped)
	if health > 100 then
		SetEntityHealth(ped,health + number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.downHealth(number)
	local ped = PlayerPedId()
	local health = GetEntityHealth(ped)

	SetEntityHealth(ped,health - number)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.applySkin(mHash)
	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		Wait(1)
	end

	if HasModelLoaded(mHash) then
		SetPlayerModel(PlayerId(),mHash)
		SetPedComponentVariation(PlayerPedId(),5,0,0,1)
		SetModelAsNoLongerNeeded(mHash)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETENTITYCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getEntityCoords()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local _,GroundZ = GetGroundZFor_3dCoord(coords["x"],coords["y"],coords["z"])

	return {
		["x"] = coords["x"],
		["y"] = coords["y"],
		["z"] = GroundZ
	}
end
-------------------------------------------------------------------------------------------------------------
-- GETPOSITIONS
-------------------------------------------------------------------------------------------------------------
function tvRP.getPositions()
    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
    return x,y,z
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDEATH (integração com Deathscreen)
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.checkDeath()
    return GetEntityHealth(PlayerPedId()) <= 101 or IsEntityDead(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWNPLAYER (chamado por /gg ou sistemas externos)
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.respawnPlayer()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
    SetEntityInvincible(ped, false)
    SetPlayerControl(PlayerId(), true, 0)
    ClearPedTasksImmediately(ped)
    SetEntityCoords(ped, 338.98, -1394.36, 32.51, false, false, false, false)
end