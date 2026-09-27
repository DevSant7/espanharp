Sync = {
    status = false,
    appearance = {},
    tattoos = {}
}

CreateThread(function()
	while true do
		local timestamp = 1000

		if Sync.status and not Creator.inside and not (Skinshop and Skinshop.inside) and not (Barbershop and Barbershop.inside) and not (Tattooshop and Tattooshop.inside) then
            local playerPed = PlayerPedId()
            local playerModel = GetEntityModel(playerPed)

			if (playerModel == GetHashKey("mp_m_freemode_01")) or (playerModel == GetHashKey("mp_f_freemode_01")) then
                Utils.UpdateAppearance(playerPed, Sync.appearance)
                Utils.UpdateTattoos(playerPed, Sync.tattoos)
            end
		end

		Wait(timestamp)
	end
end)

RegisterNetEvent("fortal-character:Client:Sync:Start", function(data)
    Sync.status = true

    if data then
        for k,v in pairs(data) do
            Sync[k] = v
        end
    end
end)
