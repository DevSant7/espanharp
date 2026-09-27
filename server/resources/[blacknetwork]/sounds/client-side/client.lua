RegisterNetEvent("sounds:source")
AddEventHandler("sounds:source",function(sound,volume)
	SendNUIMessage({ transactionType = "playSound", transactionFile = sound, transactionVolume = volume })
end)

RegisterNetEvent("sounds:stop")
AddEventHandler("sounds:stop",function()
	SendNUIMessage({ transactionType = "stop" })
end)