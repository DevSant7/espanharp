Utils = {}

local baseURL = "https://cdn.blacknetwork.com.br/black_inventory/"

Utils.battlepass = {
    -- FREE
    { nome = "Garrafa de água", name = "water", quantity = 2, rescued = false, level = 1, premium = false },
    { nome = "Lanche", name = "sandwich", quantity = 2, rescued = false, level = 2, premium = false },
    { nome = "Dinheiro", name = "dollars", quantity = 2000, rescued = false, level = 3, premium = false },
    { nome = "Adrenalina", name = "adrenaline", quantity = 1, rescued = false, level = 4, premium = false },
    { nome = "Rádio", name = "radio", quantity = 1, rescued = false, level = 5, premium = false },
    { nome = "Celular", name = "cellphone", quantity = 1, rescued = false, level = 6, premium = false },
    { nome = "Kit Médico", name = "medkit", quantity = 2, rescued = false, level = 7, premium = false },
    { nome = "Taco de Baseball", name = "WEAPON_BAT", quantity = 1, rescued = false, level = 8, premium = false, image = "https://cdn.blacknetwork.com.br/black_inventory/bat.png" },
    { nome = "Mochila", name = "backpack", quantity = 1, rescued = false, level = 9, premium = false },
    { nome = "Analgésico", name = "analgesic", quantity = 2, rescued = false, level = 10, premium = false },
    { nome = "Dinheiro Sujo", name = "dollarsroll", quantity = 10000, rescued = false, level = 11, premium = false },
    { nome = "Kit de Reparo", name = "repairkit01", quantity = 2, rescued = false, level = 12, premium = false },
    { nome = "Diamante", name = "gemstone", quantity = 5, rescued = false, level = 13, premium = false, image = "nui://fortal_esc/web-side/build/diamond.png" },
    { nome = "Contrato de Desmanche", name = "dismantle", quantity = 2, rescued = false, level = 14, premium = false },
    { nome = "Ticket de Corrida", name = "credential", quantity = 3, rescued = false, level = 15, premium = false },
    { nome = "Garrafa de Vidro", name = "emptybottle", quantity = 20, rescued = false, level = 16, premium = false },
    { nome = "Garrafa Plástica", name = "plasticbottle", quantity = 20, rescued = false, level = 17, premium = false },
    { nome = "Dinheiro Sujo", name = "dollarsroll", quantity = 50000, rescued = false, level = 18, premium = false },
    { nome = "Moto Sanchez (15 dias)", name = "sanchez", quantity = 1, rescued = false, level = 19, premium = false, image = "nui://fortal_esc/web-side/build/sanchez.png" },
    { nome = "Pistola Fajuta", name = "WEAPON_SNSPISTOL", quantity = 1, rescued = false, level = 20, premium = false, image = "https://cdn.blacknetwork.com.br/black_inventory/amt380.png" },

    -- PREMIUM
    { nome = "Diamante", name = "gemstone", quantity = 20, rescued = false, level = 1, premium = true, image = "nui://fortal_esc/web-side/build/diamond.png" },
    { nome = "Moto África (15 dias)", name = "atwin2024", quantity = 1, rescued = false, level = 2, premium = true, image = "nui://fortal_esc/web-side/build/africa.png" },
    { nome = "Kit de Reparo", name = "repairkit01", quantity = 10, rescued = false, level = 3, premium = true },
    { nome = "Dinheiro Sujo", name = "dollarsroll", quantity = 40000, rescued = false, level = 4, premium = true },
    { nome = "Mochila", name = "backpack", quantity = 10, rescued = false, level = 5, premium = true },
    { nome = "Contrato de Desmanche", name = "dismantle", quantity = 8, rescued = false, level = 6, premium = true },
    { nome = "Cartão Épico", name = "card04", quantity = 4, rescued = false, level = 7, premium = true },
    { nome = "Pistola Five Seven", name = "WEAPON_PISTOL_MK2", quantity = 1, rescued = false, level = 8, premium = true, image = "https://cdn.blacknetwork.com.br/black_inventory/fiveseven.png" },
    { nome = "Lockpick", name = "lockpick", quantity = 10, rescued = false, level = 9, premium = true },
    { nome = "Dinheiro", name = "dollars", quantity = 70000, rescued = false, level = 10, premium = true },
    { nome = "Nitro", name = "nitro", quantity = 10, rescued = false, level = 11, premium = true },
    { nome = "Placa Premium", name = "premiumplate", quantity = 1, rescued = false, level = 12, premium = true, image = "nui://fortal_esc/web-side/build/platepremium.png" },
    { nome = "Fortify VIP (30 dias)", name = "spotify", quantity = 1, rescued = false, level = 13, premium = true, image = "nui://fortal_esc/web-side/build/fortalvip.png" },
    { nome = "Dinheiro Sujo", name = "dollarsroll", quantity = 130000, rescued = false, level = 14, premium = true },
    { nome = "Diamante", name = "gemstone", quantity = 25, rescued = false, level = 15, premium = true, image = "nui://fortal_esc/web-side/build/diamond.png" },
    { nome = "Lockpick de Cobre", name = "lockpick2", quantity = 10, rescued = false, level = 16, premium = true },
    { nome = "Nivus (20 dias)", name = "ftnivusv2", quantity = 1, rescued = false, level = 17, premium = true, image = "nui://fortal_esc/web-side/build/nivus.png" },
    { nome = "Tec-9", name = "WEAPON_MACHINEPISTOL", quantity = 1, rescued = false, level = 18, premium = true, image = "https://cdn.blacknetwork.com.br/black_inventory/tec9.png" },
    { nome = "Dinheiro", name = "dollars", quantity = 150000, rescued = false, level = 19, premium = true },
    { nome = "VIP Prata (30 dias)", name = "pratapremium", quantity = 1, rescued = false, level = 20, premium = true },
}

for k, v in pairs(Utils.battlepass) do
    if not v.image then
        v.image = baseURL .. v.name .. ".png"
    end
end

function refreshItensResgatados(items)
    for _, item in ipairs(items) do
        if server.itensResgatados(item) then
            item.rescued = true
        else
            item.rescued = false
        end
    end
end

local isInArena = false

Utils.functions = {
    openSkinshop = function()
        TriggerEvent("skinweapon:OpenClient")
    end,
    openOrgsPannel = function()
        ExecuteCommand("org")
    end,
    giveWeapons = function(arena)
        if Config.arenas[arena] and #Config.arenas[arena].weapons > 0 then 
            local ped = PlayerPedId()
            local weapon = GetHashKey(Config.arenas[arena].weapons[1])

            GiveWeaponToPed(ped, weapon, 0, false, true)
            SetPedInfiniteAmmo(ped, true, weapon)

            isInArena = true
            CreateThread(function()
                while isInArena do
                    RestorePlayerStamina(PlayerId(), 1.0)
                    Wait(100)
                end
            end)
        end 
    end,
    removeWeapons = function(arena)
        if Config.arenas[arena] and #Config.arenas[arena].weapons > 0 then 
            local ped = PlayerPedId()
            local weapon = GetHashKey(Config.arenas[arena].weapons[1])

            RemoveAllPedWeapons(ped, true)
            SetPedInfiniteAmmo(ped, false, weapon)

            isInArena = false
        end
    end,
    ressurrectPlayer = function()
        local ped = PlayerPedId()
        SetEntityHealth(ped,400)
	    SetEntityInvincible(ped,false)
    end 
}   

