Lib = {}

Lib.drawMarker = function(x,y,z)
    DrawMarker(36,x,y,z - 0.45, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.25, 1.75, 1.50, 30,144,255, 100,0, 0, 0, 10)
end

Lib.applyMods = function(vehicle,vehModel, vehNet, vehEngine, vehCustom, vehWindows, vehTyres, vehName, vehPlate)
	if vehName then
		TriggerEvent('lscustoms:applyMods',vehNet,vehCustom)
	end
end

Lib.searchBlips = function(searchBlip,vehCoords)
	if DoesBlipExist(searchBlip) then
		RemoveBlip(searchBlip)
		searchBlip = nil
	end

	searchBlip = AddBlipForCoord(vehCoords.x, vehCoords.y, vehCoords.z)
	SetBlipSprite(searchBlip, 225)
	SetBlipColour(searchBlip, 2)
	SetBlipScale(searchBlip, 0.6)
	SetBlipAsShortRange(searchBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Veículo")
	EndTextCommandSetBlipName(searchBlip)

	SetTimeout(30000, function()
		RemoveBlip(searchBlip)
		searchBlip = nil
	end)
end

Lib.breakCarWindows = true
Lib.explodeTyres = true

Lib.notify = function(message)
    return TriggerEvent("Notify","aviso",message,5000)
end

RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound", function()
	if not menuOpen then
		local Impound = vSERVER.Impound()
		if parseInt(#Impound) > 0 then
			exports["dynamic"]:SubMenu("Retirar", "lista de veículos apreendidos.", "vehicles")

			for k, v in pairs(Impound) do
				exports["dynamic"]:AddButton(v["name"], "Clique para iniciar a liberação.", "garages:Impound", v["model"],
					false, true)
			end

			exports["dynamic"]:openMenu()
		else
			TriggerEvent("Notify", "amarelo", "Não possui veículos apreendidos.", 5000)
		end
	end
end)