
local Tunnel = module("vrp","lib/Tunnel")
core = Tunnel.getInterface("coreP")

Config = {}

Config.Gymnasium = {
    ["Locations"] = {
        {
            ["Ped"] = {
                ["Price"] = 2000,
                ["Model"] = { GetHashKey("u_m_y_babyd"), "u_m_y_babyd" },
                ["Coords"] = { -1195.31, -1577.16, 4.6, 133.23 },
                ["anim"] = { "anim@heists@heist_corona@single_team", "single_team_loop_boss" }
            },
            ["Positions"] = {
                ["Bicicleta"] = {
                    vec4(-1209.54, -1563.00, 3.62, 124.9),
                    vec4(-1208.34, -1564.86, 3.62, 124.9),
                    vec4(-1195.89, -1570.25, 3.62, 304.7),
                    vec4(-1194.61, -1572.06, 3.62, 304.7),
                    vec4(-1199.14, -1578.77, 3.62, 34.02),
                    vec4(-1197.32, -1577.44, 3.62, 39.69),
                },
                ["Rosca Direta"] = {
                    vec4(-1203.07, -1564.99, 3.62, 223.94),
                    vec4(-1210.58, -1561.30, 3.62, 266.46),
                    vec4(-1196.69, -1573.31, 3.62, 25.52),
                    vec4(-1198.87, -1574.82, 3.62, 25.52),
                },
                ["Halters"] = {
                    vec4(-1209.49, -1559.09, 3.62, 48.19),
                    vec4(-1203.29, -1573.58, 3.62, 212.60),
                    vec4(-1197.57, -1564.58, 3.62, 212.60),
                },
                ["Supino"] = {
                    vec4(-1207.10, -1560.88, 3.62, 218.00),
                    vec4(-1200.58, -1562.07, 3.62, 126.49),
                    vec4(-1197.94, -1568.20, 3.62, 303.31),
                    vec4(-1201.27, -1575.07, 3.62, 218.75),
                },
                ["Barra Fixa"] = {
                    vec4(-1204.87, -1564.16, 3.62, 215.44),
                    vec4(-1199.82, -1571.30, 3.62, 34.37),
                },
                ["Abdominal"] = {
                    vec4(-1201.23, -1566.64, 3.62, 218.75),
                    vec4(-1203.28, -1567.93, 3.62, 218.75),
                    vec4(-1199.18, -1565.14, 3.62, 306.1),
                }
            }
        },
    },
    ["Anim"] = {
        ["Bicicleta"] = { "mouse@byc_crunch", "byc_crunch_clip" },
        ["Rosca Direta"] = { "amb@world_human_muscle_free_weights@male@barbell@base", "base", "prop_curl_bar_01" },
        ["Halters"] = { "amb@world_human_muscle_free_weights@male@barbell@base", "base", "prop_barbell_01" },
        ["Supino"] = { "amb@prop_human_seat_muscle_bench_press@idle_a", "idle_a", "prop_barbell_100kg" },
        ["Barra Fixa"] = { "amb@prop_human_muscle_chin_ups@male@base", "base" },
        ["Abdominal"] = { "mouse@situp", "situp_clip" },
    }
}

local tyreList = {
    ["wheel_lf"] = 0,
    ["wheel_rf"] = 1,
    ["wheel_lm"] = 2,
    ["wheel_rm"] = 3,
    ["wheel_lr"] = 4,
    ["wheel_rr"] = 5
}

local Exclusives = {
    { 943.23,   -1497.87, 30.11, "Desmanche" },
    { -1172.57, -2037.65, 13.75, "Desmanche" },
    { -574.2,   -1669.71, 19.23, "Desmanche" },
    { 1358.14,  -2095.41, 52.0,  "Desmanche" },
    { 602.47,   -437.82,  24.75, "Desmanche" },
    { -413.86,  -2179.29, 10.31, "Desmanche" },
    { 376.61,   -1612.39, 29.28, "Reboque" },
}

RegisterNetEvent("target:Dismantles")
AddEventHandler("target:Dismantles",function()
	for _,v in pairs(Exclusives) do
		if v[4] == "Desmanche" then
			TriggerEvent("NotifyPush",{ code = 20, title = "Localização do Desmanche", x = v[1], y = v[2], z = v[3], blipColor = 60 })
			break
		end
	end
end)

--[[
  event: nome do evento a ser executado 
  label: nome da opção na interface 
  tunnel: lado que o evento irá ser executado 
]]
Config.vehiclesOptions = function(entity, coords,entCoords, Selected)
    local Menu = {}
    local vehPlate = GetVehicleNumberPlateText(entity)
    if #(coords - entCoords) <= 1.5 and vehPlate ~= "PDMSPORT" then
        local vehNet      = nil
        local Combustivel = false
        local vehModel    = GetEntityModel(entity)

        SetEntityAsMissionEntity(entity, true, true)
        if NetworkGetEntityIsNetworked(entity) then
            vehNet = VehToNet(entity)
        end
        Selected = { vehPlate, vRP.vehicleModel(vehModel), entity, vehNet }

        local StatusQFuel = exports["black_combustivel"]:GetStatus()
        if StatusQFuel.name then
            table.insert(Menu,{ event = StatusQFuel.event, label = StatusQFuel.name, tunnel = "client", typefuel = true })
        end

        if not Combustivel then
            if GlobalState["vehPlates"][vehPlate] then
                if GetVehicleDoorLockStatus(entity) == 1 then
                    for k, Tyre in pairs(tyreList) do
                        local Wheel = GetEntityBoneIndexByName(entity, k)
                        if Wheel ~= -1 then
                            local cWheel = GetWorldPositionOfEntityBone(entity, Wheel)
                            local Distance = #(coords - cWheel)
                            if Distance <= 1.0 then
                                Selected[5] = Tyre
                                table.insert(Menu,{ event = "inventory:removeTyres", label = "Retirar Pneu", tunnel = "client" })
                            end
                        end
                    end
                    table.insert(Menu, { event = "trunkchest:openTrunk", label = "Abrir Porta-Malas", tunnel = "server" })
                end
                table.insert(Menu, { event = "black:vehicleKey", label = "Criar Chave Cópia", tunnel = "police" })
                table.insert(Menu, { event = "player:RollVehicle", label = "Desvirar", tunnel = "server" })
                table.insert(Menu, { event = "inventory:applyPlate", label = "Trocar Placa", tunnel = "server" })
            else
                if Selected[2] == "stockade" then
                    table.insert(Menu, { event = "inventory:checkStockade", label = "Vasculhar", tunnel = "police" })
                end
            end
            if not IsThisModelABike(vehModel) then
                if GetEntityBoneIndexByName(entity, "boot") ~= -1 then
                    local Trunk = GetEntityBoneIndexByName(entity, "boot")
                    local cTrunk = GetWorldPositionOfEntityBone(entity, Trunk)
                    local Distance = #(coords - cTrunk)
                    if Distance <= 1.75 then
                        if GetVehicleDoorLockStatus(entity) == 1 then
                            table.insert(Menu,{ event = "player:enterTrunk", label = "Entrar no Porta-Malas", tunnel = "client" })
                        end
                        table.insert(Menu,{ event = "inventory:stealTrunk", label = "Arrombar Porta-Malas", tunnel = "client" })
                    end
                end
            end
            if LocalPlayer["state"]["Police"] then
                table.insert(Menu, { event = "police:runPlate", label = "Verificar Placa", tunnel = "police" })
                table.insert(Menu, { event = "police:impound", label = "Registrar Veículo", tunnel = "police" })
                if GlobalState["vehPlates"][vehPlate] then
                    table.insert(Menu, { event = "police:runArrest", label = "Apreender Veículo", tunnel = "police" })
                end
            else
                for _, v in pairs(Exclusives) do
                    local distance = #(coords - vector3(v[1], v[2], v[3]))
                    if distance <= 10 then
                        if v[4] == "Desmanche" and vehPlate == "DISM" .. (1000 + LocalPlayer["state"]["Id"]) then
                            table.insert(Menu,{ event = "inventory:Desmanchar", label = "Desmanchar", tunnel = "police" })
                        elseif v[4] == "Reboque" then
                            table.insert(Menu, { event = "towdriver:Tow", label = "Rebocar", tunnel = "client" })
                            table.insert(Menu, { event = "impound:Check", label = "Impound", tunnel = "police" })
                        end
                    end
                end
            end
        else
            Selected[5] = false
        end
    end
    return Menu, Selected
end

--[[
  event: nome do evento a ser executado 
  label: nome da opção na interface 
  tunnel: lado que o evento irá ser executado 
]]
Config.playerOptions = function(entity, coords, entCoords,Selected)
    local Menu = {}
    if #(coords - entCoords) <= 2.0 then
        local index = NetworkGetPlayerIndexFromPed(entity)
        local source = GetPlayerServerId(index)
        Selected = { source }
        if LocalPlayer["state"]["Police"] then
			table.insert(Menu, { event = "police:runCheckIdentity", label = "Verificar Identidade", tunnel = "police" })
            table.insert(Menu, { event = "police:runInspect", label = "Revistar", tunnel = "police" })
            table.insert(Menu, { event = "police:prisonClothes", label = "Uniforme Presidiário", tunnel = "police" })
            table.insert(Menu, { event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
        elseif LocalPlayer["state"]["Paramedic"] then
            if GetEntityHealth(entity) <= 101 then
                table.insert(Menu, { event = "paramedic:Revive", label = "Reanimar", tunnel = "paramedic" })
            else
                table.insert(Menu, { event = "paramedic:Treatment", label = "Tratamento", tunnel = "paramedic" })
                table.insert(Menu, { event = "paramedic:Bandage", label = "Passar Ataduras", tunnel = "paramedic" })
                table.insert(Menu, { event = "paramedic:presetBurn", label = "Roupa de Queimadura", tunnel = "paramedic" })
                table.insert(Menu, { event = "paramedic:presetPlaster", label = "Colocar Gesso", tunnel = "paramedic" })
                table.insert(Menu, { event = "paramedic:extractBlood", label = "Extrair Sangue", tunnel = "paramedic" })
            end

            table.insert(Menu, { event = "paramedic:Diagnostic", label = "Informações", tunnel = "paramedic" })
            table.insert(Menu, { event = "paramedic:Bed", label = "Deitar Paciente", tunnel = "paramedic" })
        else
            table.insert(Menu, { event = "police:runInspect", label = "Revistar", tunnel = "police" })
            if not core.checkElogio() then
                table.insert(Menu, { event = "target:addElogio", label = "Elogiar", tunnel = "server" })
            end
            if not core.checkRelationship() then
                table.insert(Menu, { event = "player:tryRelationship", label = "Pedir em namoro", tunnel = "server" })
            else
                table.insert(Menu,{ event = "player:finishRelationship", label = "Terminar o namoro", tunnel = "server" })
            end
        end
    end
    return Menu,Selected
end

--[[
  event: nome do evento a ser executado 
  label: nome da opção na interface 
  tunnel: lado que o evento irá ser executado 
]]
-- Para adicionar zonas e interações com objetos
Config.initOptions = function()
	exports["target"]:AddCircleZone("jewelryHacker",vec3(-631.38,-230.24,38.05),0.75,{
		name = "jewelryHacker",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "robberys:initJewelry",
				label = "Hackear",
				tunnel = "server"
			}
		}
	})

	exports["target"]:AddCircleZone("makePaper",vec3(-533.18,5292.15,74.17),0.75,{
		name = "makePaper",
		heading = 3374176
	},{
		distance = 0.75,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Produzir",
				tunnel = "products",
				service = "paper"
			}
		}
	})

	exports["target"]:AddCircleZone("Conce",vec3(-57.2,-1097.38,26.42),212.6,{
		name = "Conce",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "black_conce:openNui",
				label = "Abrir",
				tunnel = "client"
			}
		}
	})

	

	exports["target"]:AddCircleZone("Yoga01",vec3(-492.83,-217.31,35.61),0.75,{
		name = "Yoga01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	exports["target"]:AddCircleZone("Yoga02",vec3(-492.87,-219.03,36.55),0.75,{
		name = "Yoga02",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	exports["target"]:AddCircleZone("Yoga03",vec3(-492.89,-220.68,36.51),0.75,{
		name = "Yoga03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	exports["target"]:AddCircleZone("Yoga04",vec3(-490.21,-220.91,36.51),0.75,{
		name = "Yoga04",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	exports["target"]:AddCircleZone("Yoga05",vec3(-490.18,-219.24,36.58),0.75,{
		name = "Yoga05",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	exports["target"]:AddCircleZone("Yoga06",vec3(-490.16,-217.33,36.63),0.75,{
		name = "Yoga06",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "player:Yoga",
				label = "Yoga",
				tunnel = "client"
			}
		}
	})

	exports["target"]:AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher",
				tunnel = "police",
				service = "emptybottle"
			},
			{
				event = "inventory:Drink",
				label = "Beber",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ 1631638868,2117668672,-1498379115,-1519439119,-289946279 },{
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			},
			{
				event = "target:Treatment",
				label = "Tratamento",
				tunnel = "client"

			},
		},
		distance = 1.0
	})

	exports["target"]:AddTargetModel({ -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	exports["target"]:AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:burgerMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ -272361894 },{
		options = {
			{
				event = "shops:Chihuahua",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ -832573324,-1430839454,1457690978,1682622302,402729631,-664053099,1794449327,307287994,-1323586730,111281960,-541762431,-745300483,-417505688 },{
		options = {
			{
				event = "inventory:Animals",
				label = "Esfolar",
				tunnel = "police"
			}
		},
		distance = 1.0
	})

	exports["target"]:AddTargetModel({ 684586828,577432224,-1587184881,-1426008804,-228596739,1437508529,-1096777189,-468629664,1143474856,-2096124444,-115771139,1329570871,-130812911 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			}
		},
		distance = 0.75
	})
	
	exports["target"]:AddTargetModel({ -206690185,666561306,218085040,-58485588,1511880420,682791951 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			},
			{
				event = "player:enterTrash",
				label = "Esconder",
				tunnel = "client"
			},
			{
				event = "player:checkTrash",
				label = "Verificar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	exports["target"]:AddTargetModel({ 1211559620,1363150739,-1186769817,261193082,-756152956,-1383056703,720581693,1287257122,917457845,-838860344 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Jornaleiro"
			}
		},
		distance = 0.75
	})

	
	exports["target"]:AddCircleZone("dollarsRoll01",vec3(-610.87,-1089.48,25.86),0.5,{
		name = "dollarsRoll01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})
	
	exports["target"]:AddCircleZone("dollarsRoll03",vec3(-1181.8,-888.09,19.97),0.5,{
		name = "dollarsRoll03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})
	
	exports["target"]:AddCircleZone("dollarsRoll03",vec3(825.87,-828.52,26.34),0.5,{
		name = "dollarsRoll03",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Empacotar 100 Rolos",
				tunnel = "police",
				service = "dollars100"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 500 Rolos",
				tunnel = "police",
				service = "dollars500"
			},{
				event = "inventory:makeProducts",
				label = "Empacotar 1000 Rolos",
				tunnel = "police",
				service = "dollars1000"
			}
		}
	})

	exports["target"]:AddCircleZone("foodJuice01",vec3(-1190.78,-904.23,13.99),0.5,{
		name = "foodJuice01",
		heading = 3374176
	},{
		distance = 1.25,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	exports["target"]:AddCircleZone("foodJuice02",vec3(-1190.12,-905.16,13.99),0.5,{
		name = "foodJuice02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	exports["target"]:AddCircleZone("foodJuice03",vec3(1585.82,6459.13,26.02),0.5,{
		name = "foodJuice03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	exports["target"]:AddCircleZone("foodJuice04",vec3(810.69,-764.42,26.77),0.5,{
		name = "foodJuice04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Encher Copo",
				tunnel = "police",
				service = "foodJuice"
			}
		}
	})

	exports["target"]:AddCircleZone("foodBurger01",vec3(-1197.38,-897.58,13.88),0.5,{ 
		name = "foodBurger01",
		heading = 34867
	},{
		distance = 1.0,
		options = {
			{
				event = "inventory:makeProducts",
				label = "Montar Lanche",
				tunnel = "police",
				service = "foodBurger"
			}
		}
	})

	exports["target"]:AddCircleZone("divingStore",vec3(1521.08,3780.19,34.46),0.5,{
		name = "divingStore",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "shops:divingSuit",
				label = "Comprar Traje",
				tunnel = "server"
			},{
				event = "hud:rechargeOxigen",
				label = "Reabastecer Oxigênio",
				tunnel = "client"
			}
		}
	})


	exports["target"]:AddCircleZone("cemiteryMan",vec3(-1745.57,-205.19,57.37),0.75,{
		name = "cemiteryMan",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "cemitery:initBody",
				label = "Conversar",
				tunnel = "client"
			}
		}
	})

	exports["target"]:AddCircleZone("CassinoWheel",vec3(1111.64,226.99,-49.64),0.5,{
		name = "CassinoWheel",
		heading = 3374176
	},{
		distance = 1.5,
		options = {
			{
				event = "luckywheel:Target",
				label = "Roda da Fortuna",
				tunnel = "client"
			}
		}
	})
end 