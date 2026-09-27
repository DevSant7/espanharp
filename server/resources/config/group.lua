-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
groups = {
    -- Groups
    ["Emergency"] = {
		["Parent"] = {
			["Police"] = true,
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Chefe" },
	},
	["Restaurants"] = {
		["Parent"] = {
			["Pearls"] = true
		},
		["Hierarchy"] = { "Chefe" },
	},
    -- Framework
	["Nc"] = {
		["Parent"] = {
			["Nc"] = true
		},
		["Hierarchy"] = { "Nc"},
	},
	["Admin"] = {
		["Parent"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador","Moderador","Suporte" },
	},
	["Owner"] = {
		["Parent"] = {
			["Owner"] = true
		},
		["Hierarchy"] = { "Owner", "Administrador","Moderador","Suporte" },
	},
	["Moderador"] = {
		["Parent"] = {
			["Moderador"] = true
		},
		["Hierarchy"] = { "Moderador", "Suporte" },
	},
	["Staff"] = {
		["Parent"] = {
			["Staff"] = true
		},
		["Hierarchy"] = { "Staff" },
	},
	["Premium"] = {
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Diamante","Ouro","Prata","Bronze" },
		["Salary"] = { 2500,1500,1000,500 },
	},
	["Verify"] = {
		["Parent"] = {
			["Verify"] = true
		},
		["Hierarchy"] = { "Verify" },
	},
	["Booster"] = {
		["Parent"] = {
			["Booster"] = true
		},
		["Hierarchy"] = { "Booster" },
		["Salary"] = { 2000 },
	},
	["Streamer"] = {
		["Parent"] = {
			["Streamer"] = true
		},
		["Hierarchy"] = { "Streamer" },
		["Salary"] = { 500 },
	},
	-- VIPS NOVOS
	["Pascoa"] = {
		["Parent"] = {
			["Pascoa"] = true
		},
		["Hierarchy"] = { "Pascoa" },
		["Salary"] = { 2000 },
	},
	["Espanha"] = {
		["Parent"] = {
			["Espanha"] = true
		},
		["Hierarchy"] = { "Espanha" },
		["Salary"] = { 4000 },
	},
	["Diamante"] = {
		["Parent"] = {
			["Diamante"] = true
		},
		["Hierarchy"] = { "Diamante" },
		["Salary"] = { 2500 },
	},
	["Ouro"] = {
		["Parent"] = {
			["Ouro"] = true
		},
		["Hierarchy"] = { "Ouro" },
		["Salary"] = { 1500 },
	},
	["Prata"] = {
		["Parent"] = {
			["Prata"] = true
		},
		["Hierarchy"] = { "Prata" },
		["Salary"] = { 1000 },
		
	},
	["Bronze"] = {
		["Parent"] = {
			["Bronze"] = true
		},
		["Hierarchy"] = { "Bronze" },
		["Salary"] = { 500 },
	},
    -- Public
    ["Paramedic"] = {
		["Parent"] = {
			["Paramedic"] = true
		},
		["Hierarchy"] = { "Diretor","ViceDiretor","Doutor","Medico","Paramedico" },
		["Salary"] = { 5000, 5000, 5000, 5000, 5000 },
		["Type"] = "Work"
	},
	["Direito"] = {
		["Parent"] = {
			["Direito"] = true
		},
		["Hierarchy"] = { "Desembargador","Promotor","Advogado" },
		["Salary"] = { 4000,2000,1500 },
		["Type"] = "Work"
	},
	["Dip"] = {
		["Parent"] = {
			["Dip"] = true
		},
		["Hierarchy"] = {"Delegado", "DelegadoAdjunto", "DelegadoPlantonista", "DiretorDecap","DiretorDeic", "DiretorGTM","ViceDiretor","Agenteespecial","Agente1","Agente2","Agente3","Estagiario"},
		["Salary"] = { 5000,4500,4000,3500,3000,2500,2000,2000 },
		["Type"] = "Work"
	},
	["Police"] = {
		["Parent"] = {
			["Police"] = true
		},
		["Hierarchy"] = { "Secretario", "Comandante","Coronel","TenenteCoronel","Major","Capitao","Tenente","2Tenente","SubTenente","1Sagt","2Sagt","3Sagt","Cabo","Soldado","Aluno"},
		["Salary"] = { 5000,4500,4000,3500,3000,2500,2000 },
		["Type"] = "Work"
	},
	["Spotify"] = {
		["Parent"] = {
			["Spotify"] = true
		},
		["Hierarchy"] = { "Spotify" },
		["Salary"] = {},
	},
	["Beta"] = {
		["Parent"] = {
			["Beta"] = true
		},
		["Hierarchy"] = { "Beta" },
		["Salary"] = {},
	},
	["waitParamedic"] = {
		["Parent"] = {
			["waitParamedic"] = true
		},
		["Hierarchy"] = { "Diretor","ViceDiretor","Doutor","Medico","Paramedico"  },
		["Salary"] = {},
		["Type"] = "Work"
	},
	["waitPolice"] = {
		["Parent"] = {
			["waitPolice"] = true
		},
		["Hierarchy"] = {  "Secretario", "Comandante","Coronel","TenenteCoronel","Major","Capitao","Tenente","2Tenente","SubTenente","1Sagt","2Sagt","3Sagt","Cabo","Soldado","Aluno"},
		["Salary"] = {},
		["Type"] = "Work"
	},
	["waitDip"] = {
		["Parent"] = {
			["waitDip"] = true
		},
		["Hierarchy"] = {"Delegado", "DelegadoAdjunto", "DelegadoPlantonista", "DiretorDecap","DiretorDeic", "DiretorGTM","ViceDiretor","Agenteespecial","Agente1","Agente2","Agente3","Estagiario"},
		["Salary"] = {},
		["Type"] = "Work"
	},
	["Mechanic"] = {
		["Parent"] = {
			["Mechanic"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro", "Estagiario" },
		["Salary"] = { 1500,1000,500 },
		["Type"] = "Work"
	},
	["Bennys"] = {
		["Parent"] = {
			["Bennys"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Type"] = "Work"
	},
    ["Raijin"] = {
		["Parent"] = {
			["Raijin"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Salary"] = {},
		["Type"] = "Work"
	},
    ["Porto"] = {
		["Parent"] = {
			["Porto"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Type"] = "Work"
	},
    -- Restaurants
	["Pearls"] = {
		["Parent"] = {
			["Pearls"] = true
		},
		["Hierarchy"] = { "Chefe","Gerente","Membro" },
		["Type"] = "Work"
	},
    -- Contraband
    ["Chiliad"] = {
		["Parent"] = {
			["Chiliad"] = true
		},
		["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
		["Type"] = "Work"
	},
	["Ballas"] = {
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
		["Type"] = "Work"
	},
	["Roxos"] = {
		["Parent"] = {
			["Roxos"] = true
		},
		["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
		["Type"] = "Work"
	},
    ["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
		["Type"] = "Work"
	},
	["Triads"] = {
		["Parent"] = {
			["Triads"] = true
		},
		["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
		["Type"] = "Work"
	},
    ["Highways"] = {
		["Parent"] = {
			["Highways"] = true
		},
		["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
		["Type"] = "Work"
	},
    ["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Lider", "Gerente","Membro" },
		["Type"] = "Work"
	},
	["Tuners"] = {
		["Parent"] = {
			["Tuners"] = true
		},
		["Hierarchy"] = { "Chefe","Sub-Lider", "Gerente","Membro" },
		["Type"] = "Work"
	},
    -- Favelas
	["Livic"] = {
        ["Parent"] = { ["Livic"] = true },
        ["Hierarchy"] = { "Chefe","Sub-líder", "Conselheiro","Gerente","Sub-Gerente", "Membro", "Morador" },
        ["Type"] = "Work"
    },
	["Burguer"] = {
        ["Parent"] = { ["Burguer"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
    ["Barragem"] = {
        ["Parent"] = { ["Barragem"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Yakuza"] = {
        ["Parent"] = { 
			["Yakuza"] = true 
		},
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
    ["Rodo"] = {
        ["Parent"] = { ["Rodo"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
    ["Penha"] = {
        ["Parent"] = { ["Penha"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Duto"] = {
        ["Parent"] = { ["Duto"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Corte8"] = {
        ["Parent"] = { ["Corte8"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["God"] = {
        ["Parent"] = { ["God"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["TDP"] = {
        ["Parent"] = { ["TDP"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
    ["Jamaica"] = {
        ["Parent"] = { ["Jamaica"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
    ["Baixada"] = {
        ["Parent"] = { ["Baixada"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Laranjas"] = {
        ["Parent"] = { ["Laranjas"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Bahamas"] = {
        ["Parent"] = { ["Bahamas"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
    ["Vanilla"] = {
        ["Parent"] = { ["Vanilla"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Tokyo"] = {
        ["Parent"] = { ["Tokyo"] = true },
        ["Hierarchy"] = { "Líder", "Sub-Líder", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
    ["Vinhedo"] = {
        ["Parent"] = { ["Vinhedo"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Cassino"] = {
        ["Parent"] = { ["Cassino"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
    ["Mafia"] = {
        ["Parent"] = { ["Mafia"] = true },
        ["Hierarchy"] = { "Chefe","SubLider", "Gerente","Membro" },
        ["Type"] = "Work"
    },
	["Helipa"] = {
        ["Parent"] = { ["Helipa"] = true },
        ["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
	["Colombia"] = {
        ["Parent"] = { ["Colombia"] = true },
        ["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
    ["Tequila"] = {
        ["Parent"] = { ["Tequila"] = true },
        ["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
    ["TheLost"] = {
        ["Parent"] = { ["TheLost"] = true },
        ["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
	["Malibu"] = {
        ["Parent"] = { ["Malibu"] = true },
        ["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
	["Praia"] = {
        ["Parent"] = { ["Praia"] = true },
        ["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
	["Lago"] = {
        ["Parent"] = { ["Lago"] = true },
        ["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
        ["Type"] = "Work"
    },
    ["Farol"] = {
		["Parent"] = {
			["Farol"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		["Type"] = "Work"
	},
    ["Parque"] = {
		["Parent"] = {
			["Parque"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
	["Break"] = {
		["Parent"] = {
			["Break"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Sandy"] = {
		["Parent"] = {
			["Sandy"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Petroleo"] = {
		["Parent"] = {
			["Petroleo"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Praia-1"] = {
		["Parent"] = {
			["Praia-1"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Praia-2"] = {
		["Parent"] = {
			["Praia-2"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Zancudo"] = {
		["Parent"] = {
			["Zancudo"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    -- Mafias
    ["Madrazzo"] = {
		["Parent"] = {
			["Madrazzo"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Playboy"] = {
		["Parent"] = {
			["Playboy"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["TheSouth"] = {
		["Parent"] = {
			["TheSouth"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Vineyard"] = {
		["Parent"] = {
			["Vineyard"] = true
		},
		["Hierarchy"] = { "Líder", "SubLider", "Gerente", "Membro" },
		
		["Type"] = "Work"
	},
    ["Verificado"] = {
		["Parent"] = {
			["Verificado"] = true
		},
		["Hierarchy"] = { "Verificado" },		
	},
	["Influencer"] = {
		["Parent"] = {
			["Influencer"] = true
		},
		["Hierarchy"] = { "Influencer" },		
	},
	["Rm"] = {
		["Parent"] = {
			["Rm"] = true
		},
		["Hierarchy"] = { "Rm" },
		["Salary"] = {},
	},
	["Nascimento"] = {
		["Parent"] = {
			["Nascimento"] = true
		},
		["Hierarchy"] = { "Nascimento" },
		["Salary"] = {},
	},
	["batlepass"] = {
		["Parent"] = {
			["batlepass"] = true
		},
		["Hierarchy"] = { "batlepass" },
		["Salary"] = {},
	},
	["Cam"] = {
		["Parent"] = {
			["Cam"] = true
		},
		["Hierarchy"] = { "Cam" },
		["Salary"] = {},
	},
	["Winnie"] = {
		["Parent"] = {
			["Winnie"] = true
		},
		["Hierarchy"] = { "Winnie" },
		["Salary"] = {},
	}
} 