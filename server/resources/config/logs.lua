local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

WebHookColor = 2

Logs = {
    ["AddGroup"] = {
		link = "https://discord.com/api/webhooks/1343949067406807214/2shoxp84izaLXTo7621OclzjjfHhOrJ-eEU3DzOAA3E48xxOVNySxir-XmEaF8l_dP9K",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Adicionou um Grupo",
				description = "Esse administrador adicionou um grupo a um jogador ou a ele mesmo.",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Grupo",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["RemGroup"] = {
		link = "https://discord.com/api/webhooks/1343949202698404001/CQT2ghYAFaMulktQNApPnNiXf6gxG-y_RemPzo4h7lF_BGMk82yHf2ILQBpUVuxWkCi_",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Removeu um Grupo",
				description = "Esse administrador removeu um grupo a um jogador ou a ele mesmo.",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Grupo",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["VehicleAdd"] = {
		link = "https://discord.com/api/webhooks/1343950209520111710/9fL_vL2mM7ezVZUCkt9sEM_CUUs5hNCv2SW2B198HGtOjRbAM-XFzb63pPnqDtbrKqkI",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Adicionou um veículo",
				description = "Esse administrador adicionou um veículo a um player",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Veiculo",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["VehicleRemove"] = {
		link = "https://discord.com/api/webhooks/1343950302524608552/vF9_q-g3LOXVXhbMcu_LrlW9skLzMmr8YVJGWTeTsm4-Sgw2oUeQs5sYGqSpYxhzaCJg",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Removeu um veículo",
				description = "Esse administrador removeu um veículo a um player",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Veiculo",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["VehicleSpawn"] = {
		link = "https://discord.com/api/webhooks/1343950408564867153/Iu4FxxuNmx_2OrXkjzu9D5ZzA0zLIOn0wqM3SezAmV7P2nxUdy-6IGdLI2RO2lSZ2R8n",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Spawn um Veiculo",
				description = "O administrador spawn um veiculo",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Veiculo Spawn",
						value = "```" ..args["1"].. "```",
						inline = false
					},
					{
						name = "Coordenadas",
						value = "```" .. (args.Coords.x) .. "," .. (args.Coords.y) .. "," .. (args.Coords.z) .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["VehicleDelete"] = {
		link = "https://discord.com/api/webhooks/1343950539293200424/p4JTf0FwE0f0TtWQbhm6aVsI1G_ZL5cdGboaut5ob1HvyhdyuUNUH5jPQ7C_cmIVkcZV",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Deletou um Veiculo",
				description = "O administrador deletou um veiculo",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Veiculo Deletado",
						value = "```" ..args["1"].. "```",
						inline = false
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["VehicleFix"] = {
		link = "https://discord.com/api/webhooks/1343950651859927091/oD1ZFbLsKTnct-2Gn5-UC9Xdb193LcFcZR81sneUjiBKvua12aBFtGDX5E71Ujv5IysF",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Reparou um Veiculo",
				description = "O administrador reparou um veiculo",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Veiculo Reparado",
						value = "```" ..args["1"].. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["God"] = {
		link = "https://discord.com/api/webhooks/1343950862208204871/Hl-FtuDrc2_D-b0q8zl3DhgJF4sFsdjTTjRXib2wZoFPHF3gCcFQiDHVefZ1mS-kU6IW",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Reviveu um Jogador",
				description = "Esse administrador reviveu outro jogador ou ele mesmo.",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = false
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["Kill"] = {
		link = "https://discord.com/api/webhooks/1343950985898496124/dwfEj9-WprFprFCqtHwKVHGs03nnu6GM-O6Ot5-mzLN95RPbYykbz8JrboA5-xHZSrBY",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Executou um Jogador",
				description = "Esse administrador executou outro jogador ou ele mesmo.",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["Ban"] = {
		link = "https://discord.com/api/webhooks/1359975190590918778/cio9xWDFWBmYhVLDtExTYZj8wZ7NhSFZSMA54GQKsBQmEpKXec_2m0B6149874TDIoCo",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Baniu um jogador",
				description = "Esse Administrador baniu um jogador",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["Nc"] = {
		link = "https://discord.com/api/webhooks/1344337540643164170/Wjax79_xDjoV_Fx3bs6QJkxX6WuIYfchHBpxn4gre7Hgu6fQG9nn5-ULqrPihaOQ_ZrS",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Utilizou o NoClip",
				description = "Esse Administrador utilizou o NoClip",
				color = WebHookColor,
				fields = {
					{
						name = "Administrador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["TpWay"] = {
		link = "https://discord.com/api/webhooks/1344357605820334131/1JGfaBfckrd69sWI_uLayRRyl0Gfav9cm3byKsLfH2Wd4pdYpQ2BZTT-z38iyKD1eA3o",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Teleportou até um Waypoint",
				description = "Esse Staff teleportou até um waypoint",
				color = WebHookColor,
				fields = {
					{
						name = "Staff",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["Tptome"] = {
		link = "https://discord.com/api/webhooks/1344358320630403194/OSrm69skjjlbTGZpGfzaCllrPZwAczATdSN0znlPSZkyl1XZQJgH8pMHGyQUgdGIJFKi",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Teleportou um usuario até ele",
				description = "Esse Staff teleportou um usuario até ele",
				color = WebHookColor,
				fields = {
					{
						name = "Staff",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["TpCds"] = {
		link = "https://discord.com/api/webhooks/1344358763083202561/ATifgT3pK5Upxryv2eUELRFABPKMoMoo9XQSrmgJHAMuVy3ieNRjk59COksYNrXjDEHo",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Teleportou até uma cordenada",
				description = "Esse Staff teleportou até uma cordenada",
				color = WebHookColor,
				fields = {
					{
						name = "Staff",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords[1] .. "," .. args.Coords[2] .. "," .. args.Coords[3] .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["Tpto"] = {
		link = "https://discord.com/api/webhooks/1344359275182686249/e0kGtRCtSGYzAAdZd9LbbAfDifY424fYacoq-_3BgedL9eUmBw-CpMOQi_gBql5y2rbE",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Se Teleportou até um Jogador",
				description = "Esse Administrador se teleportou até um jogador",
				color = WebHookColor,
				fields = {
					{
						name = "Staff",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["WorkEnter"] = {
		link = "https://discord.com/api/webhooks/1344359617748009071/b527mSbv8NaGOzFzUKnz7ls6qleX2GXJ-rK-Ct3wAM05S5UOe-x65qjBXcVOxcCvx__h",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Entrou em serviço",
				description = "O Jogador entrou em serviço",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Emprego",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["WorkExit"] = {
		link = "https://discord.com/api/webhooks/1344359709678768230/rPKXB0TkkA5CP9u1ibnPQaebN4aJU-fWUS1EwA1gaxVtb2l_EYYuDaVuQGqSLuLei-jz",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Saiu de serviço",
				description = "O Jogador saiu de serviço",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Emprego",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["WorkReceived"] = {
		link = "https://discord.com/api/webhooks/1362852476700852504/gjBXRnVpl498ZBCXTj_0REJcgCWihwPUKsdXSLSoaJFAQ_FelVFitksauYVzXun_x8JA",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Recebeu o salário",
				description = "O Jogador recebeu seu salário",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Emprego",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["RouberyStart"] = {
		link = "https://discord.com/api/webhooks/1362841917074702567/WpDLr0XEOEp1XyMc-7-N7NPYZjYk80p2AHhRi6sJuVMSUj6mSXwiYfMtGM2lHFv7mQ0s",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Iniciou um roubo",
				description = "O Jogador iniciou um roubo",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Tipo do roubo",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["RouberyAmout"] = {
		link = "https://discord.com/api/webhooks/1362841608319533056/AKwcd0_NCtPZ7S1HFcMmkh7pYVg2dgVxwjuW9bQjT0igdMQyHzloCYS3eMz0Diecda1G",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Recebeu os itens do roubo",
				description = "O Jogador recebeu os itens do roubo",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Valor recebido",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["ParamedicTratament"] = {
		link = "https://discord.com/api/webhooks/1362840649518288986/4HDgNx5tc66R4HPQRcg5xo7Pia-fi1KvmC4TgoxD9iAyR12OKewkXA9bUlpWG82-9Qlg",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Realizou um tratamento",
				description = "O Paramedico realizou um tratamento",
				color = WebHookColor,
				fields = {
					{
						name = "Paramedico",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador Tratado",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["ParamedicRelive"] = {
		link = "https://discordapp.com/api/webhooks/1233492175124435014/LQGt_2EcdxT1tdTJK5kYlwAtvzgfZcLcMGxFeYVNb5iERHeh9spwWEdr04r9ECmQyDS7",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Reanimou",
				description = "O Paramedico realizou uma reanimação em um jogador",
				color = WebHookColor,
				fields = {
					{
						name = "Paramedico",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador Revivido",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["PlayerDeath"] = {
		link = "https://discord.com/api/webhooks/1362796415386124449/CYjoJpnvjke2eWS9C9avLQj44LnzY8mz7EwU60drnKoeerwhsOLITTYk5j-4-eajSE0L",
		embed = function(userKiller, userVictim, data)
			local suicide = data.suicide == true
			local description = suicide and "Jogador se suicidou ou morreu sozinho" or "Jogador foi morto por outro jogador"
		
			local fields = {
				{
					name = "Vítima",
					value = string.format("```%d - %s %s\nCds: %s```",
						userVictim.id, userVictim.name, userVictim.surname, data.victimCoords or "N/A"),
					inline = false
				}
			}
		
			if suicide then
				table.insert(fields, {
					name = "Motivo",
					value = string.format("```%s```", data.reason or "Desconhecido"),
					inline = false
				})
			else
				table.insert(fields, {
					name = "Assassino",
					value = string.format("```%d - %s %s\nCds: %s```",
						userKiller.id, userKiller.name, userKiller.surname, data.killerCoords or "N/A"),
					inline = false
				})
				table.insert(fields, {
					name = "Arma",
					value = string.format("```%s```", data.weapon or "Desconhecida"),
					inline = true
				})
			end
		
			table.insert(fields, {
				name = "Data e Hora",
				value = os.date("```%d/%m/%Y - %H:%M:%S```"),
				inline = false
			})
		
			return {
				title = "Log de Morte",
				description = description,
				color = WebHookColor,
				fields = fields
			}
		end
	},
	["PlayerEnter"] = {
		link = "https://discord.com/api/webhooks/1344361017983107142/ofNhAv9tdKK4MnJ_GiqioqKLDX8jzMjb4PHys7Fwsdx5RZ0T9NnZCOv04qKiZvUOcM1f",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Entrou no servidor",
				description = "O jogador entrou no servidor",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["PlayerExit"] = {
		link = "https://discord.com/api/webhooks/1344360526435713106/cj1TlhZIvfB2ttgJsgfknydefvPSxst-8EMzSo_PSHAmEnbVh2y2pI3tq6wUGBHpnq_m",
		embed = function(userPerformed, userSuffered, args)
			return {
				title = "Desconectou do servidor",
				description = "O jogador desconectou do servidor",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " | " .. (args["5"] or "Desconhecido") .. "```",
						inline = true
					},
					{
						name = "Motivo",
						value = "```" .. args["1"] .. "```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = string.format("```X: %.2f\nY: %.2f\nZ: %.2f```", args["2"] or 0.0, args["3"] or 0.0, args["4"] or 0.0),
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["BankDeposit"] = {
		link = "https://discord.com/api/webhooks/1362840194922975344/ARb1B4CLWLKUQ6EduYzNu1RvN6B49SNveYMHDSwEmhJTYkwxaOY_2JZxhypb-XGxn9vO",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Depositou",
				description = "O jogador depositou um valor em seu banco",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["1"].. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["BankWithdrawn"] = {
		link = "https://discord.com/api/webhooks/1362840363173150760/ptwDkMHZz39lcyw_ryyKxcF_xrBsHdt_3ApWey4C6h4MzoRsNETGc580fNyDKETyz77t",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Sacou",
				description = "O jogador sacou um valor em seu banco",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["1"].. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["ShopBuyItem"] = {
		link = "https://discord.com/api/webhooks/1362839855805235341/zC4pxN_IiaB6Y6iMfoEdedswWMoq5aNshrZtiDtLp89XdFMs2Orn_rpFb1JLOtqnHC5E",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Comprou um item",
				description = "O jogador comprou um item na loja",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```"..args["1"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```"..args["2"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["ShopSellItem"] = {
		link = "https://discord.com/api/webhooks/1362839935257808916/VHpytEIpziZWCSDtij20N-OjugV7in6tkickHLEt5xW_jSms8ieGYrPrygt2EbOIQgTe",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Vendeu um item",
				description = "O jogador vendeu um item na loja",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```"..args["1"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```"..args["2"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["GarageRemove"] = { -- Não Há
		link = "https://discord.com/api/webhooks/1362837655368503531/s_R53jDbV9FhhkVUNDMD_ZsAe3IasijZD9l9NBJSmtV0y01XQ04n-j8c1EbNSYVXdBuE",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Tirou um veiculo da garagem",
				description = "O jogador tirou um veiculo da garagem",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Carro",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["GaragePut"] = {-- Não Há
		link = "https://discord.com/api/webhooks/1362837799220281577/tVXyH31l3LoGtLn55rLu3g8A7E_UEd_tuAKzxtUuwuNm1I5Erm-1bllixIeAohwIZpOz",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Guardou um veiculo na garagem",
				description = "O jogador guardou um veiculo na garagem",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Carro",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeBuy"] = {
		link = "https://discord.com/api/webhooks/1362832213074383048/-WQiYyD4Mou-pKKxOntYl5M2hAU-VSvMEC0Pxxvr6PScpp_r5C-F-OLM323E2iJK2o85",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Comprou uma propriedade",
				description = "O jogador comprou uma propriedade",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeSell"] = {
		link = "https://discord.com/api/webhooks/1362832376199119159/RKduKcdjnTQZyxsGZY7f5Taz5SmUB8m-OFpvj_SZMtK18lJ4fHjouIUC-ldRbHS-ZtYH",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Vendeu uma propriedade",
				description = "O jogador vendeu uma propriedade",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeEnter"] = {
		link = "https://discord.com/api/webhooks/1362832646102712450/Sd8BLWD1BQ0U45L_gSM4vIXIxJinhXB1QJi0cdGIOD74CdFWhznjOytd0h6LxxllOhZh",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Entrou na propriedade",
				description = "O jogador entrou em uma propriedade",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeExit"] = {
		link = "https://discord.com/api/webhooks/1362832987149963578/zrQ_1ZeGOjtHnVd0yCLZduWqXdXYjdlUEBgE--C5E52o_2PFE7wQcyQlVaRzGlPzBUlH",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Saiu da propriedade",
				description = "O jogador saiu de uma propriedade",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeTakeChest"] = {
		link = "https://discord.com/api/webhooks/1362827865795596408/aVZJ4diC8YBawxcQdsEQWg3jp1kcVsIjLhtqijhWggHlwaIJ0IW5e1gKPJX94skN6JNC",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Retirou do Baú",
				description = "O jogador retirou um item do baú",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeTakeRefrigerator"] = {-- NÃO POSSUI
		link = "https://discordapp.com/api/webhooks/1233465621199585390/2Yyf9L-7balUdPCvLjso8b4VV63Xi76PJhamNACMLWis_yZ9w714T0W6dcFLnhB7MIjd",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Retirou da Geladeira",
				description = "O jogador retirou um item da geladeira",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomePutItChest"] = {
		link = "https://discord.com/api/webhooks/1362828011602448575/Rttx1Lrm0W7T6fGOKJ3HhUUWOzG6e_5yZ8x0WPlPPZkz8DCU2okRjDjAzf2O021fbf3J",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Colocou um item no baú",
				description = "O jogador retirou um item no baú",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomePutItRefrigerator"] = {-- NÃO POSSUI
		link = "https://discordapp.com/api/webhooks/1233465621199585390/2Yyf9L-7balUdPCvLjso8b4VV63Xi76PJhamNACMLWis_yZ9w714T0W6dcFLnhB7MIjd",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Colocou na Geladeira",
				description = "O jogador colocou um item na geladeira",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeRouberysEnter"] = {
		link = "https://discordapp.com/api/webhooks/1233467124694122517/rJmdXkNh3LBds0JvNQm0WLD6udNUQ15ho_5rh4alyec0mCXnC6lcEM9amu_FhEh-Mf5E",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Entrou na propriedade",
				description = "O jogador entrou em uma propriedade",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Casa",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["HomeRouberysPickUp"] = {
		link = "https://discord.com/api/webhooks/1362841382414450949/OlGn27qFYYEbHcE9Up3QIXqj7jPNbdakm02qZe0z8r1HgyDwJ7y35EySeB-6vuPJunF8",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Roubou um item",
				description = "O jogador roubou um item da propriedade",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["TrunkPickUp"] = {
		link = "https://discord.com/api/webhooks/1225187216632971435/hlsocsQ69VSYjgo6yDDQXTcn9Z-9n1p6hA8m8-l5G-O2vw1j4WgNXvMNXcATZu2pxY0f",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Colocou um item no porta-malas",
				description = "O jogador colocou um item no Porta-Malas",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Carro",
						value = "```" ..args["1"].."```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["TrunkSendItem"] = {
		link = "https://discord.com/api/webhooks/1225187216838492292/Dfr6H58qxz6StrN5_Jj1GuLM-fGs1iSPGoBDgCH8XS5kpOLuU9evBy7Qddd1dnNM_G_N",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Retirou um item do porta-malas",
				description = "O jogador retirou um item do Porta-Malas",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Carro",
						value = "```" ..args["1"].."```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["InvUse"] = {
		link = "https://discord.com/api/webhooks/1362830051988738348/UroRzacL3qol2b9fyzm3HZz5OpK-yVCYRaOSK1GciOboOPvsh2UCEduxz3SLeBnFZAdS",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Usou um item",
				description = "O jogador usou um item",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["InvGive"] = {
		link = "https://discord.com/api/webhooks/1362830191822639125/pbefS6UOrIymjhTbpLHqVA6E3wANN2znYpJ-mKnnaE4g4EmTnyELlxZudS9mLL2R84kG",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Enviou um item",
				description = "O jogador enviou um item",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador Receptor",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["InvPickUp"] = {
		link = "https://discord.com/api/webhooks/1362830337738276945/tH0MSvFTX4qrwZ3vN2u4IlzHBf4kGCRw_1OYqaZOLsp0TMl5B2iaxcNGq4-RqCcYhPwk",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Pegou um item",
				description = "O jogador pegou um item do chão",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = false
					},
					{
						name = "Item",
						value = "```" ..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```" ..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["InvDrop"] = {
		link = "https://discord.com/api/webhooks/1362830547482706124/ML4YQbmCK6US-esOtWdbTpZOvHG0ViS7f9Nx6MZqD4P97joSA4IOS7JSwKSu5Nvrb-Y7",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Jogou um item",
				description = "O jogador jogou um item do chão",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "Coordenadas",
						value = "```" .. args.Coords.x .. "," .. args.Coords.y .. "," .. args.Coords.z .. "```",
						inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["InvSpawn"] = {
		link = "https://discord.com/api/webhooks/1225187219866648770/OJhrjCsVzaVFCWVywH5doAXAxxwvGxfv9iRREDr0mYf5TqI1siIfMN5vQcvFnres8IxX",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Spawn um item",
				description = "Esse Staff spawnou um item",
				color = WebHookColor,
				fields = {
					{
						name = "Staff",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```"..args["1"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```"..args["2"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["InvClear"] = {
		link = "https://discord.com/api/webhooks/1343950750967005276/wVYR4j3R7vG4-fe9kobeIeRH7NwVy5xmLJSo1iHfvCNnaqCLFUAom1_8kDC-5R4_PeQn",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Limpou o inventario",
				description = "Esse Staff limpou um inventario de um jogador ou dele mesmo",
				color = WebHookColor,
				fields = {
					{
						name = "Staff",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["InvSpecific"] = {
		link = "https://discord.com/api/webhooks/1225187221687111791/ujKbe0Ps5C2NW0dfElpEax4Tfgr8JSkDUnsk2Q7UZv5opfE_KfVR0Li7gDV3WeWjFqxC",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Spawn um item",
				description = "Esse staff spawnou um item",
				color = WebHookColor,
				fields = {
					{
						name = "Staff",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["VehDismantle"] = {
		link = "https://discord.com/api/webhooks/1362826715348603032/eqEULT9_4lzCrcnLCOpvZIVtCpX6-JjivRK7NeQupox_9QhnZJ6Wh7kCBzA4pu-90rWm",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Desmanchou o veiculo",
				description = "O jogador desmanchou o veiculo",
				color = WebHookColor,
				fields = {
					{
					name = "Jogador",
					value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
					inline = true
					},
					{
					name = "Carro",
					value = "```" .. args["1"] .."```",
					inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}	
			}
		end
	},
	["VehRemove"] = {
		link = "https://discord.com/api/webhooks/1362826616798969856/hi2D74iqLBp73JnoVL4CaMw2VB3faa4uLGM3eWj_QkJcr9pEg_rf_6_O1fJ5XHQCxgxw",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Retirou o pneu do veiculo",
				description = "O jogador retirou o pneu do veiculo",
				color = WebHookColor,
				fields = {
					{
					name = "Jogador",
					value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
					inline = true
					},
					{
					name = "Carro",
					value = "```" .. args["1"] .. "```",
					inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}	
			}
		end
	},
	["EventsUpdate"] = {
		link = "https://discord.com/api/webhooks/1225197699272413336/5Ad01Oo_iiKG-qyXupdpg7L7qtLtbljso9ZDbg_fctfHXfl4NhzrsUQoNSeyVOhJAJZK",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Aumentou a mochila",
				description = "O jogador aumentou a mochila",
				color = WebHookColor,
				fields = {
					{
					name = "Jogador",
					value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
					inline = true
					},
					{
					name = "Quantidade",
					value = "```" .. args["1"] .. "```",
					inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}	
			}
		end
	},
	["ChatCommand"] = {
		link = "https://discord.com/api/webhooks/1225187219866648770/OJhrjCsVzaVFCWVywH5doAXAxxwvGxfv9iRREDr0mYf5TqI1siIfMN5vQcvFnres8IxX",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Realizou um comando",
				description = "O jogador realizou um comando no chat",
				color = WebHookColor,
				fields = {
					{
					name = "Jogador",
					value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
					inline = true
					},
					{
					name = "Comando",
					value = "```" .. args["1"] .. "```",
					inline = false
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}	
			}
		end
	},
	["ChestSend"] = {
		link = "https://discord.com/api/webhooks/1362828011602448575/Rttx1Lrm0W7T6fGOKJ3HhUUWOzG6e_5yZ8x0WPlPPZkz8DCU2okRjDjAzf2O021fbf3J",
		embed = function(userPerformed,userSuffered,args)	
			return {
				title = "Colocou no Baú",
				description = "O jogador colocou um item no baú",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Organização",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "Item",
						value = "```"..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```"..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["ChestTake"] = {
		link = "https://discord.com/api/webhooks/1362827865795596408/aVZJ4diC8YBawxcQdsEQWg3jp1kcVsIjLhtqijhWggHlwaIJ0IW5e1gKPJX94skN6JNC",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Retirou do Baú",
				description = "O jogador retirou um item do baú",
				color = WebHookColor,
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Organização",
						value = "```" ..args["1"].."```",
						inline = true
					},
					{
						name = "Item",
						value = "```"..args["2"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```"..args["3"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false
					}
				}
			}
		end
	},
	["SendItem"] = {
		link = "https://discord.com/api/webhooks/1359971459186823421/gIdnbEH3Flf7cLS1YOtVLfpTKPxKjlMMIfSgxKUZDFNfOcxjfgH5XOLgwix9TLQQk-Wh",
		embed = function(userPerformed,userSuffered,args)
			return {
				title = "Enviou um item",
				description = "O jogador retirou um item ou enviou um item a outro jogador",
				fields = {
					{
						name = "Jogador",
						value = "```" .. userPerformed.id .. " - " .. userPerformed.name .. " " .. userPerformed.surname .. "```",
						inline = true
					},
					{
						name = "Outro Jogador",
						value = "```" .. userSuffered.id .. " - " .. userSuffered.name .. " " .. userSuffered.surname .. "```",
						inline = true
					},
					{
						name = "Item",
						value = "```"..args["1"].."```",
						inline = true
					},
					{
						name = "Quantidade",
						value = "```"..args["2"].."```",
						inline = true
					},
					{
						name = "",
						value = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
						inline = false 
					}
				}
			}
		end	
	}
}

exports("SendLog",function(nameLog,userPerformedId,userSufferedId,args)
	if Logs[nameLog] then
        local userPerformed = vRP.userIdentity(tonumber(userPerformedId))
        if userPerformed then
			userPerformed = {
				name = userPerformed.name or " ",
				surname = userPerformed.name2 or " ",
				id = userPerformedId
			}
        else 
			userPerformed = {}
        	userPerformed.id = userPerformedId
		end
        local userSuffered = vRP.userIdentity(tonumber(userSufferedId))
        if userSuffered then
			userSuffered = {
				name = userSuffered.name or " ",
				surname = userSuffered.name2 or " ",
				id = userSufferedId
			}
        else
            userSuffered = {}
            userSuffered.id = userSufferedId
        end
		if userPerformed and not userPerformed.name then
			-- print('')
			-- print("^1LOG SYSTEM ERROR")
			-- print("^1REASON: ^7Configuração errada!")
			-- print("^1LOG:^7 "..nameLog)
			return false 
		end
		Wait(1000)
		PerformHttpRequest(Logs[nameLog].link, function (err, data)
			if err >= 200 and err <= 299 then
				PerformHttpRequest(Logs[nameLog].link, function(err, text, headers) return end, 'POST',
				json.encode({ embeds = {Logs[nameLog].embed(userPerformed,userSuffered,args)} }),
				{ ['Content-Type'] = 'application/json' })
				return true
			else
				-- print('')
				-- print("^1LOG SYSTEM ERROR")
				-- print("^1REASON: ^7Webhook invalida!")
				-- print("^1LOG:^7 "..nameLog)
				return false
			end
		end)
		return
    end
	-- print('')
	-- print("^1LOG SYSTEM ERROR")
	-- print("^1REASON: ^7A log ^2"..nameLog.." ^7não existe na configuração!")
	return false
end)