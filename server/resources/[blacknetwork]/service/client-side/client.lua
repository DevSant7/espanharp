-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local serviceList = {
	{ 2507.66,-347.32,94.09,"Police-1",5.0,18 },
	{ 441.22,-982.06,30.68,"Police-2",5.0,18 },
	{ 380.96,-1595.38,30.04,"Dip-1",5.0,18 },
	{ 310.73,-597.13,43.29,"Paramedic-1",1.0,6 },
	{ -1430.55,-453.82,35.91,"Mechanic-1",1.0,0 },
	{ 2742.68,3488.1,55.25,"Mechanic-2",1.0,0 }
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(serviceList) do
		exports["target"]:AddCircleZone("service:"..v[4], vector3(v[1],v[2],v[3]), 0.75, {
			name = "service:"..v[4],
			heading = 3374176
		},{
			shop = k,
			distance = v[5],
			options = {
				{
					label = "Entrar em Serviço",
					event = "service:Toggle",
					tunnel = "shop"
				}
			}
		})
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:TOGGLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Toggle")
AddEventHandler("service:Toggle",function(ServiceIndex)
	local serviceName = serviceList[ServiceIndex][4]
	local serviceColor = serviceList[ServiceIndex][6]

	TriggerServerEvent("service:Toggle", serviceName, serviceColor)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SERVICE:LABEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("service:Label")
AddEventHandler("service:Label",function(Service,Text)
	if Service == "Police" then
		exports["target"]:LabelText("service:Police-1",Text)
		exports["target"]:LabelText("service:Police-2",Text)
	elseif Service == "Paramedic" then
		exports["target"]:LabelText("service:Paramedic-1",Text)
		exports["target"]:LabelText("service:Paramedic-2",Text)
		exports["target"]:LabelText("service:Paramedic-3",Text)
	elseif Service == "Dip" then
		exports["target"]:LabelText("service:Dip-1",Text)
	else
		exports["target"]:LabelText("service:"..Service,Text)
	end
end)
