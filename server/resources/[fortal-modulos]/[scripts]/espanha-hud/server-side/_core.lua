-- =====================================================
-- HUD SERVER — Bootstrap
-- =====================================================

local Tunnel = module("vrp","lib/Tunnel")
local Proxy  = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

HUD = {}
Tunnel.bindInterface("hud",HUD)

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPATIBILIDADE COM black_garages_v2
-----------------------------------------------------------------------------------------------------------------------------------------
-- O black_garages_v2 (server-side/server.lua, linhas 135 e 267) acessa
-- `GlobalState["Nitro"]` diretamente como uma TABELA:
--     local Nitro = GlobalState["Nitro"]
--     Nitro[plate] = valor
-- Sem essa tabela inicializada, o resource explode com:
--     "attempt to index a nil value (field 'Nitro')"
--
-- O HUD novo usa `GlobalState["Nitro:"..plate]` (chave por placa), que é mais
-- eficiente mas incompatível com o black_garages. As duas tabelas convivem:
-- a clássica serve só para o black_garages ler/escrever sem quebrar; a do HUD
-- novo continua sendo a fonte do client-side/client.lua.
if GlobalState["Nitro"] == nil then
    GlobalState["Nitro"] = {}
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETUSERID
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("CharacterChosen",function(Passport,source)
    if not Passport or not source then
        return
    end

    TriggerClientEvent("hud:setUserId",source,parseInt(Passport))
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- FETCHBINDS
-----------------------------------------------------------------------------------------------------------------------------------------
function HUD.fetchBinds()
    local source = source
    local Passport = vRP.Passport(source)
    if not Passport then
        return {}
    end

    return vRP.Inventory(Passport)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERNAME
-----------------------------------------------------------------------------------------------------------------------------------------
function HUD.getUserName(TargetSource)
    local TargetPassport = vRP.Passport(tonumber(TargetSource))
    if not TargetPassport then
        return { id = 0, name = "Desconhecido" }
    end

    return { id = TargetPassport, name = vRP.FullName(TargetPassport) }
end