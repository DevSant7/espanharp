Config = {}

-- Configurações gerais
Config.Command = 'dip' -- Comando para abrir o painel
Config.DefaultPermission = 'Dip' -- Permissão padrão para agentes do DIP

-- Configurações de patentes hierárquicas (do maior para o menor)
Config.Hierarchy = {
    [1] = { 
        name = "Delegado", 
        label = "Delegado",
        salary = 15000, -- Salário mensal
        restrictedPages = {}, -- Pode ver todas as páginas
        permissions = {
            canHire = true, -- Pode contratar
            canFire = true, -- Pode demitir
            canPromote = true, -- Pode promover
            canDemote = true, -- Pode rebaixar
            canAnnounce = true, -- Pode fazer anúncios
            canWanted = true, -- Pode colocar procurado
            canRemoveWanted = true, -- Pode remover procurado
            canViewHistory = true, -- Pode ver histórico
            canEditHistory = true, -- Pode editar histórico
            canViewStats = true, -- Pode ver estatísticas
            canViewMembers = true, -- Pode ver membros
            canEditMembers = true, -- Pode editar membros
            canPrison = true, -- Pode prender
            canFine = true, -- Pode multar
            canSearch = true, -- Pode buscar
            canLocked = true -- Pode ver presos
        }
    },
    [2] = { 
        name = "Delegadoadjunto", 
        label = "Delegado Adjunto",
        salary = 13000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = true,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [3] = { 
        name = "Escrivao", 
        label = "Escrivão",
        salary = 12000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = true,
            canDemote = true,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = true,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [4] = { 
        name = "InvestigadorChefe", 
        label = "Investigador Chefe",
        salary = 11000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = true,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [5] = { 
        name = "Investigador", 
        label = "Investigador",
        salary = 10000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = true,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [6] = { 
        name = "AgenteEspecial", 
        label = "Agente Especial",
        salary = 9000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = true,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [7] = { 
        name = "Agente", 
        label = "Agente",
        salary = 8000,
        restrictedPages = {},
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = true,
            canRemoveWanted = true,
            canViewHistory = true,
            canEditHistory = true,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = true,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    },
    [8] = { 
        name = "Estagiario", 
        label = "Estagiário",
        salary = 7000,
        restrictedPages = {
            "wanted", -- Não pode ver página de procurados
            "occurrence", -- Não pode ver página de B.O.s
            "members"
        },
        permissions = {
            canHire = false,
            canFire = false,
            canPromote = false,
            canDemote = false,
            canAnnounce = true,
            canWanted = false,
            canRemoveWanted = false,
            canViewHistory = true,
            canEditHistory = false,
            canViewStats = true,
            canViewMembers = true,
            canEditMembers = false,
            canPrison = true,
            canFine = true,
            canSearch = true,
            canLocked = true
        }
    }
}

-- Configurações de prisões
Config.Prison = {
    { art = 101, description = 'Excesso de velocidade', price = 500, months = 1 },
    { art = 102, description = 'Direção perigosa', price = 1000, months = 2 },
    { art = 103, description = 'Fuga de blitz', price = 2000, months = 5 },
    { art = 201, description = 'Porte ilegal de arma', price = 5000, months = 10 },
    { art = 202, description = 'Roubo', price = 3000, months = 8 },
    { art = 203, description = 'Homicídio', price = 10000, months = 20 },
    { art = 204, description = 'Tráfico de drogas', price = 8000, months = 15 },
    { art = 205, description = 'Sequestro', price = 12000, months = 25 },
    { art = 206, description = 'Assalto a banco', price = 15000, months = 30 },
    { art = 207, description = 'Tentativa de homicídio', price = 7000, months = 12 },
    { art = 208, description = 'Porte de arma sem autorização', price = 3000, months = 6 },
    { art = 209, description = 'Agressão física', price = 2000, months = 4 },
    { art = 210, description = 'Ameaça', price = 1500, months = 3 }
}

-- Configurações de multas
Config.Fines = {
    { art = 301, description = 'Estacionamento irregular', price = 200 },
    { art = 302, description = 'Ultrapassagem proibida', price = 400 },
    { art = 303, description = 'Sinal vermelho', price = 300 },
    { art = 304, description = 'Velocidade acima do permitido', price = 600 },
    { art = 305, description = 'Direção sem habilitação', price = 800 },
    { art = 401, description = 'Perturbação da ordem pública', price = 150 },
    { art = 402, description = 'Desacato à autoridade', price = 500 },
    { art = 403, description = 'Resistência à prisão', price = 1000 },
    { art = 404, description = 'Fuga de abordagem', price = 800 },
    { art = 405, description = 'Porte de objeto proibido', price = 300 },
    { art = 501, description = 'Poluição sonora', price = 250 },
    { art = 502, description = 'Descarte irregular de lixo', price = 200 },
    { art = 503, description = 'Danos ao patrimônio público', price = 400 },
    { art = 504, description = 'Pichação', price = 300 },
    { art = 505, description = 'Uso irregular de espaço público', price = 350 }
}

-- Configurações de tempo
Config.TimeMultiplier = 1000 -- 1 segundo real = 1000ms de prisão
