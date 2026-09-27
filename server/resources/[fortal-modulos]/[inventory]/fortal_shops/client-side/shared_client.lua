CreateThread(function()
	SetNuiFocus(false, false)

	for k, v in pairs(Config["shopList"]) do
		exports["target"]:AddCircleZone("Shops:" .. k, vector3(v[1], v[2], v[3]), 0.75, {
			name = "Shops:" .. k,
			heading = 3374176
		}, {
			shop = k,
			distance = 1.75,
			options = Informations(v[4])
		})
	end
end)