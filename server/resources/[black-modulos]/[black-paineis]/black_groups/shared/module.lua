Config = {}

Config.uploadServer = "https://discord.com/api/webhooks/1287466092272553984/_8oodPTS_cPQ2Xm5rbOr5Z6jiMa9vo--uwZEXLsWvRNtB7zpEZAdijwmE0274IgB6TQ4"

Config.panelCommand = "org"
Config.createOrgCommand = "criarorg"
Config.deleteOrgCommand = "delorg"
Config.adminOrgPanelCommand = "adminorg"
Config.panelCreateChestCommand = "criarchest"
Config.defaultChestWeight = 500

Config.removeBlacklistCommand = "removebl"
Config.blacklistTime = 3

Config.adminPermission = "Admin"


Config.orgs = {
    ["Barragem"] = {
        maxMembers = 50,
        permission = "Barragem",
        chestName = "Barragem",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Vineyard"] = {
        maxMembers = 50,
        permission = "Vineyard",
        chestName = "Vineyard",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["TDP"] = {
        maxMembers = 50,
        permission = "TDP",
        chestName = "TDP",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["God"] = {
        maxMembers = 50,
        permission = "God",
        chestName = "God",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Livic"] = {
        maxMembers = 50,
        permission = "Livic",
        chestName = "Livic",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Conselheiro",
            [4] = "Gerente",
            [5] = "Sub-Gerente",
            [6] = "Membro",
            [7] = "Morador"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Conselheiro",
            "Gerente",
            "Sub-Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Madrazzo"] = {
        maxMembers = 50,
        permission = "Madrazzo",
        chestName = "Madrazzo",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Conselheiro",
            [4] = "Gerente",
            [5] = "Sub-Gerente",
            [6] = "Membro",
            [7] = "Morador"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Families"] = {
        maxMembers = 50,
        permission = "Families",
        chestName = "Families",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Raijin"] = {
        maxMembers = 50,
        permission = "Raijin",
        chestName = "Raijin",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Tuners"] = {
        maxMembers = 50,
        permission = "Tuners",
        chestName = "Tuners",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Break"] = {
        maxMembers = 50,
        permission = "Break",
        chestName = "Break",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Malibu"] = {
        maxMembers = 50,
        permission = "Malibu",
        chestName = "Malibu",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Cassino"] = {
        maxMembers = 50,
        permission = "Cassino",
        chestName = "Cassino",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Bahamas"] = {
        maxMembers = 50,
        permission = "Bahamas",
        chestName = "Bahamas",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Burguer"] = {
        maxMembers = 50,
        permission = "Burguer",
        chestName = "Burguer",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Tokyo"] = {
        maxMembers = 50,
        permission = "Tokyo",
        chestName = "Tokyo",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Rodo"] = {
        maxMembers = 50,
        permission = "Rodo",
        chestName = "Rodo",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "sulfuric",
            "cokeseed"
        }
    },
    ["Colombia"] = {
        maxMembers = 50,
        permission = "Colombia",
        chestName = "Colombia",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "saline",
            "acetone"
        }
    },
    ["Penha"] = {
        maxMembers = 50,
        permission = "Penha",
        chestName = "Penha",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "saline",
            "acetone"
        }
    },
    ["Ballas"] = {
        maxMembers = 50,
        permission = "Ballas",
        chestName = "Ballas",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        }, 
        farmItems = {
            "lean",
            "dollarsroll"
        }
    },
    ["Duto"] = {
        maxMembers = 50,
        permission = "Duto",
        chestName = "Duto",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "codeine",
            "amphetamine"
        }
    },
    ["Baixada"] = {
        maxMembers = 50,
        permission = "Baixada",
        chestName = "Baixada",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "codeine",
            "amphetamine"
        }
    },
    ["KDQ"] = {
        maxMembers = 50,
        permission = "KDQ",
        chestName = "KDQ",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Vagos"] = {
        maxMembers = 50,
        permission = "Vagos",
        chestName = "Vagos",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "saline",
            "acetone"
        }
    },
    ["Vanilla"] = {
        maxMembers = 50,
        permission = "Vanilla",
        chestName = "Vanilla",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "cedulas"
        }
    },
    ["Chiliad"] = {
        maxMembers = 20,
        permission = "Chiliad",
        chestName = "Chiliad",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum"
        }
    },
    ["Roxos"] = {
        maxMembers = 50,
        permission = "Roxos",
        chestName = "Roxos",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "cedulas"
        }
    },
    ["Vinhedo"] = {
        maxMembers = 50,
        permission = "Vinhedo",
        chestName = "Vinhedo",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "peca",
            "cabo"
        }
    },
    ["Mafia"] = {
        maxMembers = 50,
        permission = "Mafia",
        chestName = "Mafia",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "bucket",
            "cannabisseed"
        }
    },
    ["Tequila"] = {
        maxMembers = 50,
        permission = "Tequila",
        chestName = "Tequila",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "gunpowder",
            "capsula"
        }
    },
    ["TheLost"] = {
        maxMembers = 50,
        permission = "TheLost",
        chestName = "TheLost",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Highways"] = {
        maxMembers = 50,
        permission = "Highways",
        chestName = "Highways",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Bennys"] = {
        maxMembers = 50,
        permission = "Bennys",
        chestName = "Bennys",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Mafia"] = {
        maxMembers = 50,
        permission = "Mafia",
        chestName = "Mafia",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "peca",
            "cabo"
        }
    },
    ["Vinhedo"] = {
        maxMembers = 50,
        permission = "Vinhedo",
        chestName = "Vinhedo",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "peca",
            "cabo"
        }
    },
    ["Mechanic"] = {
        maxMembers = 50,
        permission = "Mechanic",
        chestName = "Mechanic",
        initialGroup = "Estagiario",
        groups = {
            [1] = "Chefe",
            [2] = "Gerente",
            [3] = "Membro",
            [4] = "Estagiario"
        },
        managementPerms = {
            "Chefe",
            "Gerente",
            "Membro",
            "Estagiario"
        },
        farmItems = {
            "aluminum",
            "copper"
        }
    },
    ["Paramedic"] = {
        maxMembers = 50,
        permission = "Paramedic",
        chestName = "Paramedic",
        initialGroup = "Paramedico",
        groups = {
            [1] = "Diretor",
            [2] = "Vice-Diretor",
            [3] = "Doutor",
            [4] = "Medico",
            [5] = "Paramedico"
        },
        managementPerms = {
            "Diretor",
            "Vice-Diretor",
            "Doutor",
            "Medico",
            "Paramedico"
        },
        farmItems = {
            "anagelsic"
        }
    },

    ["Tequila"] = {
        maxMembers = 50,
        permission = "Tequila",
        chestName = "Tequila",
        initialGroup = "Membro",
        groups = {
            [1] = "Líder",
            [2] = "Sub-Líder",
            [3] = "Gerente",
            [4] = "Membro"
        },
        managementPerms = {
            "Líder",
            "Sub-Líder",
            "Gerente"
        },
        farmItems = {
            "gunpowder",
            "capsula"
        }
    },
}  

Config.messages = {
    ["not_permission"] = "Você não está em uma organização.",
    ["invite_request"] = "Alguém está te convidando para a organização %s deseja aceitar?",
    ["insuficient_money"] = "Você não possui dinheiro suficiente para depositar.",
    ["insuficient_balance"] = "A organização não possui dinheiro suficiente para sacar",
    ["invite_denied"] = "O jogador recusou seu convite.",
    ["insuficient_item"] = "Você não tem os itens necessários para finalizar a meta.",
    ["have_collected"] = "Você já coletou a bonificação dessa meta.",
    ["finished_task"] = "Você finalizou uma meta e recebeu %s de bonificação.",
    ["finish_task_denied"] = "Não foi possível finalizar a meta pois não há dinheiro disponível no banco da organização.",
    ["accept_request"] = "Você aceitou o convite da organização <b>%s<b>.",
    ["not_admin_permission"] = "Você não tem permissão para abrir este painel.",
    ["unknown_org"] = "Esta organização não está configurada no painel.",
    ["has_org"] = "Este jogador já está em uma organização.",
    ["new_org"] = "Nova organização criada: %s.",
    ["wait_seconds"] = "Aguarde alguns segundos.",
    ["create_chest"] = "Sucesso ao criar o baú: %s",
    ["not_has_org"] = "Você não está em um organização.",
    ["not_has_permission_in_org"] = "Você não tem cargo suficiente para isso.",
    ["has_org_or_blacklisted"] = "Este jogador está na blacklist por %s dias.",
    ["kicked_from_org"] = "Você foi expulso de uma organização.",
    ["request_delorg"] = "Você deseja deletar a organização %s?",
    ["del_org"] = "Você deletou a organização %s.",
    ["missing_args"] = "Há parâmetros faltando para executar este comando.",
    ["unknown_date_format"] = "Formato da data inserida não é valida, tente utilizar no formato 00/00/0000.",
    ["exceeded_date"] = "Data inserida ultrapassou o limite.",
}