-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("crafting",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CRAFTLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local craftList = {
----------------------------------------------------------------------------------------------------------
-- FAVELAS
----------------------------------------------------------------------------------------------------------
	["Vinhedo"] = {
		["perm"] = "Vinhedo",
		["list"] = {
			["WEAPON_SPECIALCARBINE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 280,
					["cabo"] = 280
				}
			},
			["WEAPON_BULLPUPRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 250,
					["cabo"] = 250
				}
			},
			["WEAPON_ASSAULTRIFLE_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 200,
					["cabo"] = 200
				}
			},
			["WEAPON_ASSAULTRIFLE"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["peca"] = 180,
					["cabo"] = 180
				}
			}
		}
	},
	["TheLost2"] = {
		["perm"] = "TheLost",
		["level"] = 3,
		["list"] = {
			["WEAPON_REVOLVER"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 320,
					["copper"] = 320 
 				}
			},
		}
	},
	["TheLost3"] = {
		["perm"] = "TheLost",
		["list"] = {
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 100
				}
			},
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 80,
					["copper"] = 80
				}
			},
			["WEAPON_MACHINEPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 120,
					["copper"] = 120
				}
			},
			["WEAPON_ASSAULTSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 180,
					["copper"] = 180
				}
			}
		}
	},
	["Igreja"] = {
		["perm"] = "Igreja",
		["list"] = {
			["tablemeth"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			},
			["methsack"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["saquinho"] = 1,
					["meth"] = 1
				}
			}
		}
	},
	["Porto"] = {
		["perm"] = "Porto",
		["list"] = {
			["tableoxy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			}
		}
	},
	
----------------------------------------------------------------------------------------------------------
-- EXTRAS
----------------------------------------------------------------------------------------------------------
	["Burguer"] = {
		["perm"] = "Burguer",
		["list"] = {
			["hamburger2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1
				}
			},
			["hamburger3"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1
				}
			},
			["hamburger4"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1
				}
			},
			["hamburger5"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["tomato"] = 1,
					["bread"] = 1,
					["ketchup"] = 1,
					["carne"] = 1		
				}
			},
			["foodbox1"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["strawberryjuice"] = 3,
					["hamburger2"] = 3			
				}
			},
			["foodbox2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["strawberryjuice"] = 6,
					["hamburger2"] = 6			
					
				}
			},
			["foodbox3"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["strawberryjuice"] = 9,
					["hamburger2"] = 9		
					
				}
			}
		}
	},
	["BurguerJuice"] = {
		["perm"] = "Burguer",
		["list"] = {
			["orangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["orange"] = 1
				}
			},
			["grapejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["grape"] = 2
				}
			},
			["bananajuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["banana"] = 1
				}
			},
			["strawberryjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["strawberry"] = 1	
									}
			},
			["passionjuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["passion"] = 1	
				}
			},
			["tangejuice"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["emptybottle"] = 1,
					["tange"] = 1	
					


					
					

					
					
				}
			}
		}
	},
	["LavagemPUB"] = {
		["list"] = {
			["dollars"] = {
				["amount"] = 1000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 2000
				}
			}
		}
	},
	["Utilspub"] = {
		["list"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 12
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["plastic"] = 20,
					["copper"] = 20
				}
			},
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 14
				}
			}
		}
	},
	["Lockpick"] = {
		["list"] = {
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 10
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 10
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18

				}
			}
		}
	},
	["Cassino"] = {
		["perm"] = "Cassino",
		["list"] = {
			["dollars"] = {
				["amount"] = 100000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 100000,
					["cedulas"] = 100
				}
			}
		}
	}, 
	["Malibu"] = {
		["perm"] = "Malibu",
		["list"] = {
			["dollars"] = {
				["amount"] = 90000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 100000,
					["cedulas"] = 1000
				}
			}
		}
	},
	["Vanilla"] = {
		["perm"] = "Vanilla",
		["list"] = {
			-- ["c4"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["plastic"] = 10,
			-- 		["copper"] = 10
			-- 	}
			-- },
			["dollars"] = {
				["amount"] = 100000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 100000,
					["cedulas"] = 100
				}
			}
			-- ["attachsFlashlight"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["plastic"] = 12,
			-- 		["aluminum"] = 10
			-- 	}
			-- },
			-- ["attachsCrosshair"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["plastic"] = 12,
			-- 		["aluminum"] = 10
			-- 	}
			-- },
			-- ["attachsSilencer"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["plastic"] = 12,
			-- 		["aluminum"] = 10
			-- 	}
			-- },
			-- ["attachsGrip"] = {
			-- 	["amount"] = 1,
			-- 	["destroy"] = false,
			-- 	["require"] = {
			-- 		["plastic"] = 12,
			-- 		["aluminum"] = 10
			-- 	}
			-- }
		}
	},
	["Lixeiro"] = {
		["list"] = {
			["glass"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["glassbottle"] = 1
				}
			},
			["plastic"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plasticbottle"] = 1
				}
			},
			["rubber"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["elastic"] = 1
				}
			},
			["aluminum"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["metalcan"] = 1
				}
			},
			["copper"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["battery"] = 1
				}
			}
		}
	},
	["fuelShop"] = {
		["list"] = {
			["WEAPON_PETROLCAN"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 50
				}
			},
			["WEAPON_PETROLCAN_AMMO"] = {
				["amount"] = 4500,
				["destroy"] = false,
				["require"] = {
					["dollars"] = 200
				}
			}
		}
	},
----------------------------------------------------------------------------------------------------------
-- FACÇÕES
----------------------------------------------------------------------------------------------------------
	["Mafia"] = {
		["perm"] = "Mafia",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 8,
					["copper"] = 8
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 10
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 12
				}
			}
		}
	},
	["Highways"] = {
		["perm"] = "Highways",
		["list"] = {
			["lockpick2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 10
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 12
				}
			},
			["vest"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 16,
					["copper"] = 10
				}
			}
		}
	},
	["Break"] = {
		["perm"] = "Break",
		["list"] = {
			["dollars"] = {
				["amount"] = 100000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 110000,
					["cedulas"] = 1000
				}
			},
		}
	},
	["Tequila"] = {
		["perm"] = "Tequila",
		["list"] = {
			["WEAPON_PISTOL_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 8,
					["copper"] = 8
				}
			},
			["WEAPON_SMG_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 10
				}
			},
			["WEAPON_RIFLE_AMMO"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 12
				}
			}
		}
	},
	["Bennys"] = {
		["perm"] = "Bennys",
		["list"] = {
			["nitro"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 30,
					["copper"] = 30
				}
			},
			["credential"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 250
				}
			},
			["dismantle"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 500
				}
			},
			["plate"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 8
					
				}
			}
		}
	},
	["TDP"] = {
		["perm"] = "TDP",
		["list"] = {
			["tablelean"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			}
		}
	},
	["Barragem"] = {
		["perm"] = "Barragem",
		["list"] = {
			["tableweed"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			},
			["weedsack"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["saquinho"] = 1,
					["weed"] = 1
				}
			}
		}
	},
	["Families"] = {
		["perm"] = "Families",
		["list"] = {
			["blocksignal"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 12
				}
			},
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 12
				}
			},
			["c4"] = {
				["amount"] = 1,
				["destroy"] = true,
				["require"] = {
					["aluminum"] = 12,
					["copper"] = 12
				}
			}
		}
	},
	["Tuners"] = {
		["perm"] = "Tuners",
		["list"] = {
			["attachsFlashlight"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 12,
					["aluminum"] = 10
				}
			},
			["attachsCrosshair"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 12,
					["aluminum"] = 10
				}
			},
			["attachsSilencer"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 12,
					["aluminum"] = 10
				}
			},
			["attachsGrip"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 12,
					["aluminum"] = 10
				}
			}
		}
	},
	["Raijin"] = {
		["perm"] = "Raijin",
		["list"] = {
			["credential"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 200
				}
			},
			["blocksignal"] = {
				["amount"] = 10,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 10,
					["copper"] = 8
				}
			},
			["notebook"] = {
					["amount"] = 1,
					["destroy"] = false,
					["require"] = {
						["aluminum"] = 30,
						["rubber"] = 8
				}
			}
		}
	},
	["Madrazzo"] = {
		["perm"] = "Madrazzo",
		["list"] = {
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 40,
					["copper"] = 30
				}
			},
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 40,
					["copper"] = 30
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 80
				}
			},
		}
	},
	["KDQ"] = {
		["perm"] = "KDQ",
		["list"] = {
			["WEAPON_SNSPISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 40,
					["copper"] = 30
				}
			},
			["WEAPON_PISTOL"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 40,
					["copper"] = 30
				}
			},
			["WEAPON_MINISMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 80
				}
			},
			["WEAPON_PISTOL_MK2"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 100,
					["copper"] = 80
				}
			},
			["WEAPON_MICROSMG"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 120,
					["copper"] = 100
				}
			},
		}
	},
	["Ballas"] = {
		["perm"] = "Ballas",
		["list"] = {
			["vest"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 16,
					["copper"] = 10
				}
			},
			["handcuff"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 20,
					["copper"] = 18
				}
			},
			["hood"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["plastic"] = 20,
					["copper"] = 20
				}
			},
		}
	},
	["Roxos"] = {
		["perm"] = "Roxos",
		["list"] = {
			["lockpick"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 10
				}
			},
			["floppy"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["aluminum"] = 14,
					["copper"] = 10
				}
			}
		}
	},
	["Bahamas"] = {
		["perm"] = "Bahamas",
		["list"] = {
			["dollars"] = {
				["amount"] = 90000,
				["destroy"] = false,
				["require"] = {
					["dollarsroll"] = 100000,
					["cedulas"] = 100
				}
			},
		}
	},
	["God"] = {
		["perm"] = "God",
		["list"] = {
			["tablemeth"] = {
				["amount"] = 1,
				["destroy"] = false,
				["require"] = {
					["woodlog"] = 20,
					["glass"] = 25,
					["rubber"] = 15,
					["aluminum"] = 20,
					["copper"] = 15
				}
			}
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(craftType)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.getFines(user_id) > 0 then 
			TriggerClientEvent("Notify",source,"cancel","Negado","Multas pendentes encontradas.","vermelho",5000)
			return false
		end

		-- if exports["black_hud"]:Wanted(user_id) then
		-- 	return false
		-- end

		local craft = craftList[craftType]
		if craft and craft["perm"] then
			local group = craft["perm"]
			local level = craft["level"] -- pode ser nil

			if not vRP.hasGroup(user_id, group, level) then
				return false
			end
		end

		return true
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestCrafting(craftType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(craftList[craftType]["list"]) do
			local craftList = {}
			for k,v in pairs(v["require"]) do
				table.insert(craftList,{ name = itemName(k), amount = v })
			end

			table.insert(inventoryShop,{ name = itemName(k), index = itemIndex(k), key = k, peso = itemWeight(k), list = craftList, amount = parseInt(v["amount"]), desc = itemDescription(k) })
		end

		local inventoryUser = {}
		local inventory = vRP.userInventory(user_id)
		for k,v in pairs(inventory) do
			v["amount"] = parseInt(v["amount"])
			v["name"] = itemName(v["item"])
			v["peso"] = itemWeight(v["item"])
			v["index"] = itemIndex(v["item"])
			v["key"] = v["item"]
			v["slot"] = k

			local splitName = splitString(v["item"],"-")
			if splitName[2] ~= nil then
				if itemDurability(v["item"]) then
					v["durability"] = parseInt(os.time() - splitName[2])
					v["days"] = itemDurability(v["item"])
				else
					v["durability"] = 0
					v["days"] = 1
				end
			else
				v["durability"] = 0
				v["days"] = 1
			end

			inventoryUser[k] = v
		end
		local identity = vRP.userIdentity(user_id)

		return inventoryShop,inventoryUser,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),identity["name"].." "..identity["name2"],user_id
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONCRAFTING
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionCrafting(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end

		if craftList[shopType]["list"][shopItem] then
			if vRP.checkMaxItens(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount) then
				
				TriggerClientEvent("Notify",source,"important","Atenção","Limite atingido.","amarelo",3000)
				TriggerClientEvent("crafting:Update",source,"requestCrafting")
				return
			end

			if (vRP.inventoryWeight(user_id) + (itemWeight(shopItem) * parseInt(shopAmount))) <= vRP.getWeight(user_id) then
				if shopItem == "nails" then
					local Inventory = vRP.userInventory(user_id)
					if Inventory then
						for k,v in pairs(Inventory) do
							if string.sub(v["item"],1,5) == "badge" then
								vRP.removeInventoryItem(user_id,v["item"],1,false)
								vRP.generateItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount,false,slot)
								break
							end
						end
					end
				else
					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						local consultItem = vRP.getInventoryItemAmount(user_id,k)
						if consultItem[1] < parseInt(v * shopAmount) then
							return
						end

						if vRP.checkBroken(consultItem[2]) then
							TriggerClientEvent("Notify",source,"cancel","Negado","Item quebrado.","vermelho",3000)
							
							return
						end
					end

					for k,v in pairs(craftList[shopType]["list"][shopItem]["require"]) do
						local consultItem = vRP.getInventoryItemAmount(user_id,k)
						vRP.removeInventoryItem(user_id,consultItem[2],parseInt(v * shopAmount))
					end

					vRP.generateItem(user_id,shopItem,craftList[shopType]["list"][shopItem]["amount"] * shopAmount,false,slot)
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionDestroy(shopItem,shopType,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local splitName = splitString(shopItem,"-")

		if craftList[shopType]["list"][splitName[1]] then
			if craftList[shopType]["list"][splitName[1]]["destroy"] then
				if vRP.checkBroken(shopItem) then
					TriggerClientEvent("Notify",source,"vermelho","Itens quebrados reciclados.",5000)
					TriggerClientEvent("crafting:Update",source,"requestCrafting")
					return
				end

				if vRP.tryGetInventoryItem(user_id,shopItem,craftList[shopType]["list"][splitName[1]]["amount"]) then
					for k,v in pairs(craftList[shopType]["list"][splitName[1]]["require"]) do
						if parseInt(v) <= 1 then
							vRP.generateItem(user_id,k,1)
						else
							vRP.generateItem(user_id,k,v / 2)
						end
					end
				end
			end
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:populateSlot")
AddEventHandler("crafting:populateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
			vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			TriggerClientEvent("crafting:Update",source,"requestCrafting")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("crafting:updateSlot")
AddEventHandler("crafting:updateSlot",function(nameItem,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inventory = vRP.userInventory(user_id)
		if inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
			end
		else
			vRP.swapSlot(user_id,slot,target)
		end

		TriggerClientEvent("crafting:Update",source,"requestCrafting")
	end
end)


function cRP.modelPlayer()
	local source = source
	local ped = GetPlayerPed(source)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			return "mp_f_freemode_01"
	end

	return false
end