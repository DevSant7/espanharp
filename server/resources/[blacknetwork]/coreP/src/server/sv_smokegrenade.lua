AddEventHandler("explosionEvent", function(_, data)
	if data.explosionType == 20 then
		CancelEvent()

        TriggerClientEvent("smoke:Init", -1, {
            x = data.posX,
            y = data.posY,
            z = data.posZ
        })
    end
end)