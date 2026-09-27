hudConfig = {
    getLifeCalculate = function(ped)
        return math.ceil((100 * ((GetEntityHealth(ped) - 100) / (GetEntityMaxHealth(ped) - 100))))
    end, -- Calculo de vida de sua base, se ela for algo maior ou menos do que o padrão

    getPedArmour = function(ped)
        return GetPedArmour(ped)
    end, -- Verificação de colete do player

    getSpeedVehicle = function(vehicle)
        return math.ceil(GetEntitySpeed(vehicle) * 3.605936)
    end, -- Calculo de velocidade se por acaso desejar manipula-lo de alguma forma

    getPlayerStamina = function(player)
        return math.floor(GetPlayerStamina(player))
    end,

    hungerThirst = true,
    hungerValue = 100,
    thirstValue = 100,

    pinTheMinimap = true,  --  Se deseja que o MiniMapa fique fixo mesmo fora do veículo
    setMiniMapBelt = false, -- Só aparecer o minimap se colocar o cinto

    itemsUrl = 'https://cdn.europacity.com.br/AmericaImages/',
    armoryUrl = 'https://cdn.europacity.com.br/AmericaImages/',

    debugStreets = false,
    modifyStreetNames = true,
    modifyStreets = {
        ['West Drive'] = "Rua Dos Santos",
        ['Mirror Park Boulevard'] = "Rua Abadom",
        ['East Drive'] = "Rua Chico Batera",
    },

    ------ [ CHAT CONFIGS ] --------
    offensiveWord = {
        'puta', 
        'viado', 
        'merda', 
        'bosta', 
        'filho da puta',
        ' lixo',
        'zap',
    },

    chats = {
        ["global"] = {
            permissions = {}
        },
        ["local"] = {
            permissions = {}
        },
        ["adm"] = {
            color = '#ff0000',
            permissions = {
               "Admin"
            }
        },
        ["policia"] = {
            color = '#3b82f6',
            permissions = {
                "Policia", "DIC", "BOPE", "PRF", "Exercito",
                "COT", "Core", "PoliciaNorte", "Federal",
                "Choque", "Civil", "Judiciario"
            }
        }
    },

    logoUrl = 'https://cdn.europacity.com.br/infos/america/logohud.png',
}
