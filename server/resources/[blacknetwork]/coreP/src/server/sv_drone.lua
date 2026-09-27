RegisterServerEvent("Drones:Disconnect")
AddEventHandler('Drones:Disconnect', function(drone, drone_data, pos)
    TriggerClientEvent('Drones:DropDrone', source, drone, drone_data, pos)
end)

RegisterServerEvent("Drones:Back")
AddEventHandler('Drones:Back', function(drone_data)
	local source = source
	local Passport = vRP.getUserId(source)
    if Passport then
        vRP.generateItem(Passport,drone_data.name,1,true)
    end
end)
