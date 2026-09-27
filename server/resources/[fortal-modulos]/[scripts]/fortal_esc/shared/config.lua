Config = {}

Config.instagram = "https://www.instagram.com/blacknetworkfivem/"
Config.discord = "https://discord.gg/aFcwpvyj95"
Config.passPremium = "Admin" -- PERM DO PASSE PREMIUM

Config.jobs = { -- [perm] = titulo 
    ["Police"] = "Policia",
	["Paramedic"] = "Hospital"
}

Config.vips = { -- [perm] = titulo 
    ["Bronze"] = "VIP BRONZE",
	["Prata"] = "VIP PRATA",
	["Ouro"] = "VIP OURO",
	["Diamante"] = "VIP DIAMANTE"
}

Config.premium = { -- [perm] = titulo 
    ["batlepass"] = "batlepass"
}

Config.arenas = {
    maxHealth = 200,
    armour    = true, 
    ["ffa"] = {
        weapons = {"WEAPON_PISTOL_MK2",300},
        bucket = 345,
        polyzone = PolyZone:Create({
			vector2(-971.53, -451.67),
			vector2(-944.80, -503.36),
			vector2(-987.69, -526.77),
			vector2(-1004.47, -541.25),
			vector2(-1025.26, -550.27),
			vector2(-1046.18, -557.81),
			vector2(-1066.37, -564.35),
			vector2(-1086.81, -573.03),
			vector2(-1111.39, -586.49),
			vector2(-1130.33, -596.72),
			vector2(-1149.24, -606.29),
			vector2(-1170.63, -623.22),
			vector2(-1269.28, -509.64),
			vector2(-1269.45, -500.99),
			vector2(-1206.05, -443.68),
			vector2(-1191.57, -436.54),
			vector2(-1164.05, -429.95),
			vector2(-1125.46, -425.34),
			vector2(-1109.49, -420.75),
			vector2(-1098.19, -416.18),
			vector2(-1077.92, -453.98),
			vector2(-1072.64, -461.31),
			vector2(-1061.59, -471.09),
			vector2(-1060.40, -469.96),
			vector2(-1049.98, -475.18),
			vector2(-1042.00, -482.13),
			vector2(-1043.93, -483.11),
			vector2(-1035.33, -482.96),
			vector2(-1025.11, -479.39)
		}, { name = "Arena-FFA" }),
        spawnpoints = {
            vector3(-1058.21, -513.09, 36.04),
			vector3(-1023.25, -491.27, 36.97),
			vector3(-999.92,  -532.48, 36.73),
			vector3(-1069.01, -551.77, 35.0),
			vector3(-1119.32, -578.29, 31.42),
			vector3(-1149.25, -572.01, 30.19),
			vector3(-1184.33, -565.33, 28.32),
			vector3(-1219.62, -563.6,  27.77),
			vector3(-1257.89, -517.26, 31.8),
			vector3(-1226.66, -501.09, 30.89),
			vector3(-1183.08, -458.22, 33.95),
			vector3(-1138.99, -462.87, 35.25),
			vector3(-1132.5,  -433.93, 36.04),
			vector3(-1108.99, -445.2,  35.22),
			vector3(-1081.1,  -463.67, 36.58),
			vector3(-1098.47, -496.21, 35.77)
        }
    },
    ["pista"] = {
        bucket = 554,
		vehicle = "akuma",
        weapons = {"WEAPON_PISTOL_MK2",300},
        polyzone = PolyZone:Create({
			vector2(-190.18,-869.35),
			vector2(-280.83,-837.73),
			vector2(-500.24,-823.35),
			vector2(-552.27,-959.57),
			vector2(-548.95,-1098.38),
			vector2(-406.36,-1137.67),
			vector2(-259.33,-1160.59),
			vector2(-211.55,-1006.73),
			vector2(-163.71,-876.42),
		}, { name = "Arena-PISTA" }),
        spawnpoints = {
			vector3(-265.06,-1149.04,23.08),
			vector3(-287.64,-1149.98,22.98),
			vector3(-370.44,-1140.48,29.37),
			vector3(-416.88,-1131.17,29.54),
			vector3(-482.47,-1112.74,26.4),
			vector3(-543.61,-1096.8,22.41),
			vector3(-534.52,-1075.43,22.43),
			vector3(-548.45,-1032.58,22.71),
			vector3(-550.15,-996.51,23.24),
			vector3(-541.23,-963.09,23.49),
			vector3(-505.72,-993.28,23.54),
			vector3(-513.0,-967.52,23.57),
			vector3(-495.23,-945.86,23.96),
			vector3(-524.22,-912.9,25.07),
			vector3(-516.61,-874.49,28.86),
			vector3(-499.64,-829.66,30.5),
			vector3(-460.72,-829.43,30.53),
			vector3(-362.88,-834.89,31.53),
			vector3(-359.56,-880.35,31.07),
			vector3(-277.09,-898.45,31.07),
			vector3(-285.96,-918.87,31.07),
			vector3(-323.68,-943.05,31.07),
			vector3(-299.16,-988.41,31.07),
			vector3(-261.12,-992.91,30.16),
			vector3(-262.65,-1002.81,27.52),
			vector3(-266.55,-1032.13,28.26),
			vector3(-283.37,-1084.48,24.15),
			vector3(-302.45,-1107.62,23.02),
			vector3(-178.06,-884.54,29.35),
		}
    },
    ["1x1"] = {
		rounds  = 5,
		weapons = {"WEAPON_PISTOL_MK2",300},
        polyzone = PolyZone:Create({
			vector2(81.788238525391, -848.61975097656),
			vector2(131.84765625, -866.81390380859),
			vector2(121.84936523438, -893.8076171875),
			vector2(71.66813659668, -876.66149902344)
		  }, {
			name = "Arena-1x1",
		}),
        spawnpoints = {
			[1] = {
				cds     = vector3(123.67,-879.33,134.76),
				heading = 68.04,
				using    = false 
			},
			[2] = {
				cds     = vector3(80.26,-864.17,134.76),
				heading = 252.29,
				using    = false 
			}
		}
    }
}

Config.orgs = {
	"Police",
	"Ballas",
	"Bahamas",
	"Vanilla",
	"Mafia"
}

Config.messages = {
	["prompt"]             = "QUAL O ID DO PLAYER QUE VOCÊ DESEJA CONVIDAR PARA O 1X1?",
	["request"]            = "O jogador %s está te convidando para uma arena 1x1. Deseja aceitar?",
	["invite_denied"]      = "O jogador que você convidou recusou seu convite.",
	["unknown_user"]       = "Id do jogador inválido.",
	["1x1_finish"]         = "O jogador %s venceu a arena 1x1 com %d pontos!",
	["starting_nextround"] = "Próximo round iniciando! Round: %d",
	["add_compliment"] = "Você elogiou %s!",
	["compliment_received"] = "%s te elogiou!",
	["try_relationship_request"] = "%s quer iniciar um relacionamento com você. Aceitar?",
    ["relationship_accepted"] = "Relacionamento iniciado com sucesso!",
    ["relationship_accepted2"] = "Você e %s agora estão em um relacionamento.",
    ["warning_relationship"] = "%s e %s agora estão em um relacionamento!",
    ["in_relationship"] = "Você já está em um relacionamento.",
    ["in_relationship2"] = "A outra pessoa já está em um relacionamento.",
    ["try_finish_relationship"] = "Não foi possível encerrar o relacionamento. Confirme se vocês realmente são um casal.",
    ["finish_relationship_request"] = "Você deseja encerrar seu relacionamento?",
    ["relationship_finished"] = "Relacionamento encerrado com sucesso.",
    ["relationship_finished2"] = "Seu relacionamento foi encerrado.",
    ["warning_relationship2"] = "%s e %s encerraram o relacionamento."
}