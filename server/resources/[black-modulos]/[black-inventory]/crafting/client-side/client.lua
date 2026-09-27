-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("crafting")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideNUI" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCrafting",function(data,cb)
	local inventoryCraft,inventoryUser,invPeso,invMaxpeso,playerName,playerId = vSERVER.requestCrafting(data["craft"])
	if inventoryCraft then
		cb({ inventoryCraft = inventoryCraft, inventario = inventoryUser, invPeso = invPeso, invMaxpeso = invMaxpeso,name = playerName,id = playerId })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionCraft",function(data)
	if MumbleIsConnected() then
		vSERVER.functionCrafting(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("functionDestroy",function(data)
	if MumbleIsConnected() then
		vSERVER.functionDestroy(data["index"],data["craft"],data["amount"],data["slot"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:populateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("crafting:updateSlot",data["item"],data["slot"],data["target"],data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Update")
AddEventHandler("crafting:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local List = {
	-----------------------------------------------------------------------------------------------------------------------------------------
	-- CRAFT'S PÚBLICOS
	-----------------------------------------------------------------------------------------------------------------------------------------
	["1"] = { 82.45,-1553.26,29.59,"Lixeiro" }, -- Troca de material
	["2"] = { 287.36,2843.6,44.7,"Lixeiro" }, -- Troca de material
	["3"] = { -413.68,6171.99,31.48,"Lixeiro" }, -- Troca de material
	["4"] = {48.8,-1594.57,29.59,"Utilspub"}, -- Utilitários
	["5"] = {-1051.81,-232.21,44.01,"LavagemPUB"}, -- Lavagem Pública
	["6"] = {-1194.44,-896.05,13.88,"Burguer"}, -- BurguerShot
	["7"] = {-1191.09,-898.29,13.88,"BurguerJuice"}, -- BurguerShot

--	["12"] = {1536.15,-807.63,108.01,"Livic"}, -- -- 
	["13"] = {1271.45,-160.15,98.54,"KDQ"}, -- --  Armas
   ["14"] = {-1769.2,-116.12,89.1,"Livic"}, -- Livic Cocaína
--	["15"] = {1680.27,984.32,142.31,"Jamaica"}, -- -- Desmanche
	["16"] = {-1792.41,422.97,125.68,"Ballas"}, -- Vinhedo

	["18"] = {1002.68,-127.99,74.05,"TheLost"}, -- Munição, colete

--	["19"] = {-571.41,290.04,79.18,"Tequila"}, -- Munição, colete
	-- ["20"] = { -106.44,979.19,240.88,"Mafia" }, -- Armas
	["21"] = {-1866.05,2061.18,135.44,"Vinhedo"}, -- Armas
	["22"] = {-1369.71,-626.83,29.86, "Bahamas"}, -- Lavagem, attachs
	["23"] = {-561.89,184.13,72.99,"Vanilla"}, --  Attachs
	["24"] = {951.41,-967.17,39.75,"Families"}, -- Disquete
	["25"] = {-134.78,-1609.47,35.03,"Groove"}, -- Capuz, algema
	["26"] = {1350.47,4315.06,38.4,"AKPUB"},
	["27"] = {997.57,52.88,75.07,"Cassino"},
--	["28"] = {-3233.45,813.17,14.07,"Malibu"},
	["29"] = {-104.92,979.71,240.88,"Break"},
	-- ["30"] = {-1813.89,-47.43,95.86,"Livic"},
	["31"] = {728.14,-1069.01,28.31,"Raijin"},
--	["32"] = {-798.31,185.6,72.61,"Tuners"},
	["33"] = {1405.85,1138.03,109.74,"Mafia"},
	["34"] = {-194.9,-1315.8,31.29,"Bennys"},
	["35"] = {-799.6,177.16,72.82,"Highways"},
	["36"] = {256.54,6668.1,29.96,"TheLost2"},

	


--	["37"] = {722.7,380.63,139.16,"God"},
	["38"] = {-1431.2,2306.42,30.82,"TDP"},

--	["39"] = {289.28,6662.95,29.96,"TheLost"}, -- Munição, colete
	["40"] = {107.95,3611.56,40.51,"TheLost3"},
	["41"] = {110.63,-1980.93,20.96,"Roxos"},
	["42"] = {1234.21,-192.76,85.9,"Bahamas"}
	
	}
	
	local LixeiroTraje = {
		["mp_m_freemode_01"] = {
			["hat"] = { item = 0, texture = 0 },
			["pants"] = { item = 36, texture = 0 },
			["vest"] = { item = -1, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 27, texture = 0 },
			["tshirt"] = { item = 59, texture = 0 },
			["torso"] = { item = 56, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 0, texture = 0 },
			["glass"] = { item = 0, texture = 0 },
			["ear"] = { item = -1, texture = 0 },
		},
		["mp_f_freemode_01"] = {
			["hat"] = { item = -1, texture = 0 },
			["pants"] = { item = 35, texture = 0 },
			["vest"] = { item = 0, texture = 0 },
			["bracelet"] = { item = -1, texture = 0 },
			["backpack"] = { item = 0, texture = 0 },
			["decals"] = { item = 0, texture = 0 },
			["mask"] = { item = 0, texture = 0 },
			["shoes"] = { item = 24, texture = 0 },
			["tshirt"] = { item = 36, texture = 0 },
			["torso"] = { item = 73, texture = 0 },
			["accessory"] = { item = 0, texture = 0 },
			["watch"] = { item = -1, texture = 0 },
			["arms"] = { item = 223, texture = 0 },
			["glass"] = { item = 13, texture = 0 },
			["ear"] = { item = -1, texture = 0 }
		}
	}
	
	RegisterNetEvent("setTrajeLixeiro",function()
		local model = vSERVER.modelPlayer()
		if model == "mp_m_freemode_01" or "mp_f_freemode_01" then
			TriggerEvent("updateRoupas", LixeiroTraje[model])
		end
	end)
	
	Citizen.CreateThread(function()
		SetNuiFocus(false,false)
	
		for k,v in pairs(List) do
			if v[4] == "Lixeiro" then 
				exports["target"]:AddCircleZone("Crafting:"..k,vector3(v[1],v[2],v[3]),1.0,{
					name = "Crafting:"..k,
					heading = 3374176
				},{
					shop = k,
					distance = 1.0,
					options = {
						{
							event = "crafting:openSystem",
							label = "Abrir",
							tunnel = "shop"
						},
						{
							event = "setTrajeLixeiro",
							label = "Traje",
							tunnel = "client"
						}
					}
				})
			else
				exports["target"]:AddCircleZone("Crafting:"..k,vector3(v[1],v[2],v[3]),1.0,{
					name = "Crafting:"..k,
					heading = 3374176
				},{
					shop = k,
					distance = 1.0,
					options = {
						{
							event = "crafting:openSystem",
							label = "Abrir",
							tunnel = "shop"
						},
					}
				})
			end
		end
	end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:openSystem",function(shopId)
	if vSERVER.requestPerm(List[shopId][4]) then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showNUI", name = List[shopId][4] })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:FUELSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("crafting:fuelShop",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "fuelShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:OPENSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:openSource")
AddEventHandler("crafting:openSource",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "craftShop" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTING:AMMUNATION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:Ammunation")
AddEventHandler("crafting:Ammunation",function()
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showNUI", name = "ammuShop" })
end)


-- function cRP.modelPlayer()
--     local source = source
--     local ped = GetPlayerPed(source)
--     if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
--         return "mp_m_freemode_01"
--     elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
--         return "mp_f_freemode_01"
--     end

--     return false
-- end