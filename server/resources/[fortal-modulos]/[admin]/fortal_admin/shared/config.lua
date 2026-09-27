Config = {}

Config.imagesProvider = {
    items = "https://cdn.blacknetwork.com.br/black_inventory/",
    vehicles = "https://cdn.blacknetwork.com.br/conce/"
}

-- Configurações de cache para otimização de performance
Config.cache = {
    organizations = {
        duration = 30000, -- 30 segundos em millisegundos
        enabled = true
    }
}

-- Configuração dos grupos de staff
Config.staffGroups = {
    ["Owner"] = {
        level = 4,
        name = "Owner",
        color = "#FFD700", -- Dourado
        bgColor = "#FFD70020",
        canPromote = true,
        canDemote = true,
        canManage = true
    },
    ["Admin"] = {
        level = 3,
        name = "Admin",
        color = "#FF4444", -- Vermelho
        bgColor = "#FF444420",
        canPromote = true,
        canDemote = true,
        canManage = true
    },
    ["Moderador"] = {
        level = 2,
        name = "Moderador",
        color = "#df5454", -- Azul
        bgColor = "#df545420",
        canPromote = false,
        canDemote = false,
        canManage = false
    },
    ["Suporte"] = {
        level = 1,
        name = "Suporte",
        color = "#10B981", -- Verde
        bgColor = "#10B98120",
        canPromote = false,
        canDemote = false,
        canManage = false
    }
}

-- Hierarquia de staff (ordem de promoção)
Config.staffHierarchy = {
    "Suporte",
    "Moderador", 
    "Admin",
    "Owner"
}