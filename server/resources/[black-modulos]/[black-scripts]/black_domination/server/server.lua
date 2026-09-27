------------------------------------------------------------------------
-----------------------------[ LIB VRP ]--------------------------------
------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
Felp = {} -- adiciona em uma table
Tunnel.bindInterface("black_domination",Felp) -- IRÁ CRIAR UM TUNNEL COM O CLIENT
Proxy.addInterface("black_domination",Felp) -- É UM DEPEDENCIA DO TUNNEL
FelpClient = Tunnel.getInterface("black_domination")
------------------------------------------------------------------------
---------------------------[ VARIAVEIS ]--------------------------------
------------------------------------------------------------------------
local dominatedAreas = {}
local Areas = {}
local SPRAYS = {}
------------------------------------------------------------------------
---------------------------[ PREPARE'S ]--------------------------------
------------------------------------------------------------------------
vRP.prepare("CREATE_TABLE_IN_DATABASE", [[
    CREATE TABLE IF NOT EXISTS `dominations` (
	`id` INT(11) NOT NULL,
	`group` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`colororg` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
    `x` float(8,4) NOT NULL,
    `y` float(8,4) NOT NULL,
    `z` float(8,4) NOT NULL,
    `rx` float(8,4) NOT NULL,
    `ry` float(8,4) NOT NULL,
    `rz` float(8,4) NOT NULL,
    `scale` float(8,4) NOT NULL,
    `text` varchar(32) NOT NULL,
    `font` varchar(32) NOT NULL,
    `color` int(3) NOT NULL,
    `interior` int(3) NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE
)
]])

vRP.prepare("INSERT_TABLE_IN_DATABASE",[[INSERT IGNORE INTO dominations (id,`group`,colororg) VALUES (@id,@group,@color)]])
vRP.prepare("DELETE_ID", [[DELETE  FROM dominations WHERE id= @id]])
vRP.prepare("SELECT_DOMINATIONS", [[SELECT * FROM dominations ]])
vRP.prepare("SELECT_DOMINATIONS_BY_ID", [[SELECT * FROM dominations WHERE id=@id]])
vRP.prepare("UPDATE_DOMINATIONS", [[UPDATE dominations SET `group` = @group, colororg = @colorblip, x = @x,y = @y, z = @z,rx = @rx,ry=@ry,rz = @rz,scale = @scale,text = @text, font = @font,color = @color,interior= @interior  WHERE id=@id ]])

------------------------------------------------------------------------
-----------------[ OBTER COR | GRUPO PELO USER ID ]---------------------
------------------------------------------------------------------------
function Felp.getFaction(user_id)
    for k, v in pairs(Config.ColorsGroup) do
        if vRP.hasPermission(user_id,k) then
            return k, v["CB"]
        end
    end
end
------------------------------------------------------------------------
-----------------[ OBTER COR | GRUPO PELO USER ID ]---------------------
------------------------------------------------------------------------
function Felp.GetGroupByUserId()
    local source = source
    local user_id = vRP.getUserId(source)
    local group, color = Felp.getFaction(user_id)
    if group then
        return group
    end
    return false
end


function Felp.InitDomination(id,data)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and id then
        local group, color = Felp.getFaction(user_id)
        local i = 1
        while true do
            if not SPRAYS[i] then
                SPRAYS[i] = data
                break
            else
                i = i + 1
            end
        end
        
        vRP._execute("black/addDominations",{
            orgName = group 
        })
        
        TriggerEvent('felp_sprays:addSpray', source, data.text, data.location)
        TriggerClientEvent('felp_spray:setSprays', -1, SPRAYS)
        dominatedAreas[id]["Locale"] = id
        dominatedAreas[id]["Color"] = color
        vRP._execute("UPDATE_DOMINATIONS",{group = group,colorblip = color, id = id,x = data.location.x,
        y = data.location.y,z = data.location.z,rx = data.realRotation.x,rz = data.realRotation.z,scale = data.scale,
        text = data.text,font = data.font, color = data.originalColor,interior = data.interior})
        TriggerClientEvent("domination:locs", -1, dominatedAreas)
        
        -- Parar o blip de piscar quando a dominação for concluída
        Felp.StopBlipAlert(id)
    end
end

function Felp.AlreadyDominated(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and id then
        local GroupQuery = vRP.query("SELECT_DOMINATIONS_BY_ID",{id = id})[1]["group"]
        if GroupQuery ~= 'Neutral' then
            return false
        end
        return true
    end
end

-- NOTIFICAÇÃO AO GRUPO
function Felp.notifyDomination(id, message,typeGroup)
    if typeGroup then
        typeGroup = vRP.getUsersByPermission(typeGroup)
        if #typeGroup > 0 then
            for _, value in pairs(typeGroup) do 
                TriggerClientEvent("Notify", vRP.getUserSource(value), "important","SUA AREA!",message, "amarelo", 5000)
            end
        end
        return
    end
    local faction = vRP.query("SELECT_DOMINATIONS_BY_ID",{id = id})[1]["group"]
    faction = vRP.getUsersByPermission(faction)
    if #faction > 0 then
        for _, value in pairs(faction) do 
            TriggerClientEvent("Notify", vRP.getUserSource(value), "important","SUA AREA!",message, "amarelo", 5000)
        end
    end
end

-- Função para fazer o blip piscar para todos os jogadores
function Felp.StartBlipAlert(dominationArea)
    TriggerClientEvent("domination:startBlipAlert", -1, dominationArea)
end

-- Função para parar o blip de piscar para todos os jogadores  
function Felp.StopBlipAlert(dominationArea)
    TriggerClientEvent("domination:stopBlipAlert", -1, dominationArea)
end

-- ENVIA AO MAPA DO JOGO TODAS AS AREAS DOMINADAS

Citizen.CreateThread(function()
    RefreshSprays()
end)

function RefreshSprays(IsManual)
    if not IsManual then
        vRP._execute("CREATE_TABLE_IN_DATABASE")
    end
    local query = vRP.query("SELECT_DOMINATIONS")
    local results = vRP.query("SELECT_DOMINATIONS")
    SPRAYS = {}

    for _, s in pairs(results) do
        table.insert(SPRAYS, {
            location = vector3(s.x + 0.0, s.y + 0.0, s.z + 0.0),
            realRotation = vector3(s.rx + 0.0, s.ry + 0.0, s.rz + 0.0),
            scale = tonumber(s.scale) + 0.0,
            text = s.text,
            font = s.font,
            originalColor = s.color,
            interior = (s.interior == 1) and true or false,
        })
    end

    for k,v in pairs(query) do
        Areas[""..v.id..""] = {["colororg"] = v.colororg,["group"] = v.group,["id"] = v.id}
        if not Config.Locales[""..v.id..""] and not IsManual then
            print("^1[-] ^7ID "..v.id.." foi removido do banco de dados pois não foi encontrado na config.lua")
            vRP._execute("DELETE_ID",{id = v.id})
            Areas[""..v.id..""] = nil
        end
    end

    for k,v in pairs(Config.Locales) do
        if not Areas[""..k..""] and not IsManual then 
            print("^2[+] ^7ID "..k.." foi adicionado ao banco de dados pois só continha na config.lua")
            vRP._execute("INSERT_TABLE_IN_DATABASE",{id = k,group = 'Neutral',color = Config.Blips["colorNeutral"]})
            dominatedAreas[k] = {
                ["Locale"] = k,
                ["Color"] = Config.Blips["colorNeutral"],
                ["x"] = Config.Locales[""..k..""][1],
                ["y"] = Config.Locales[""..k..""][2],
                ["z"] = Config.Locales[""..k..""][3]
            }
            goto pular
        end
        dominatedAreas[k] = {
            ["Locale"] = k,
            ["Color"] = Areas[""..k..""]["colororg"] or Config.Blips["colorNeutral"],
            ["x"] = v[1],
            ["y"] = v[2],
            ["z"] = v[3]
        }
        ::pular::
    end
    if not IsManual then
        print("^2[+] ^7Configuração feita com sucesso!")
    end
    Wait(1500)
    TriggerClientEvent("domination:locs", -1, dominatedAreas)
    TriggerClientEvent('felp_spray:setSprays', -1, SPRAYS)
end

function Felp.getUsersByPermission(...)
    return vRP.getUsersByPermission(...)
end

function Felp.ResetDominationArea(id)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and id then 
        
        vRP._execute("UPDATE_DOMINATIONS",{group = 'Neutral',colorblip = Config.Blips["colorNeutral"], id = id})

        dominatedAreas[id] = nil

        Wait(100) 

        RefreshSprays(true)
        TriggerClientEvent("domination:locs", -1, dominatedAreas)
        
        -- Parar o blip de piscar quando a área for resetada
        Felp.StopBlipAlert(id)
    end
end

function GetPlayerCurrentArea(source)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)

    for areaId, areaData in pairs(dominatedAreas) do
        local areaPos = vector3(areaData.x, areaData.y, areaData.z)
        if #(coords - areaPos) < 50.0 then 
            return areaId
        end
    end

    return nil
end


exports("UserHasDominatedArea", function(source)
    local user_id = vRP.getUserId(source)
    if not user_id then return false end

    local areaId = GetPlayerCurrentArea(source)
    if not areaId then
        return false
    end

    local areaData = Areas[tostring(areaId)]
    if not areaData or areaData.group == "Neutral" then
        return false
    end

    local playerGroup = Felp.getFaction(user_id)

    if playerGroup and playerGroup == areaData.group then
        return true, Config.Global["BoostDrugs"]
    end

    return false
end)

--------------------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	Wait(1000)
    TriggerClientEvent('felp_spray:setSprays', source, SPRAYS)
    TriggerClientEvent("domination:locs", source, dominatedAreas)
end)
