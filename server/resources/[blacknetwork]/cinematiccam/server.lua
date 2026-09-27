--------------------------------------------------
---- CINEMATIC CAM FOR FIVEM MADE BY KIMINAZE ----
--------------------------------------------------

--------------------------------------------------
---------------------- EVENTS --------------------
--------------------------------------------------

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local ResName = GetCurrentResourceName()
API = {}
Tunnel.bindInterface(ResName, API)

function API.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        if vRP.hasGroup(user_id, "Admin") or vRP.hasGroup(user_id, "Influencer") or vRP.hasGroup(user_id, "Cam") then
            return true
        end
    end
    
    return false
end


RegisterServerEvent('CinematicCam:requestPermissions')
AddEventHandler('CinematicCam:requestPermissions', function()
	local source = source
	local playerId = vRP.getUserId(source)
	local isWhitelisted = false

	if playerId then
		isWhitelisted = vRP.hasGroup(playerId, 'Admin') or vRP.hasGroup(playerId, 'Streamer') or vRP.hasGroup(playerId, 'Cam')
	end

	-- \/ -- permission check here (set "isWhitelisted") -- \/ --


	
	-- /\ -- permission check here (set "isWhitelisted") -- /\ --

	TriggerClientEvent('CinematicCam:receivePermissions', source, isWhitelisted)
end)
