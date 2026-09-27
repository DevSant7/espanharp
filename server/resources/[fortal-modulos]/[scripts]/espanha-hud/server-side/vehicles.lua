-- =====================================================
-- HUD SERVER — Veículos (nitro, rua atual, ejeção por cinto)
-- =====================================================

local NITRO_MAX_FUEL = 2000
local STREET_NAME_MAX_LENGTH = 100

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATENITRO
-----------------------------------------------------------------------------------------------------------------------------------------
-- O client (nitro.lua) chama isto ao soltar o botão de nitro. O valor precisa
-- chegar em DOIS lugares:
--   1. GlobalState["Nitro:"..Plate]  -> é o que o client-side/client.lua lê
--   2. GlobalState["Nitro"][Plate]   -> é o que o black_garages_v2 lê/grava
--
-- Sem o espelho na tabela clássica, o black_garages guarda o veículo com nitro
-- zerado mesmo quando o jogador tinha nitro cheio — e o próximo spawn perde o
-- combustível acumulado.
function HUD.UpdateNitro(Plate,Fuel)
    local source = source
    local Passport = vRP.Passport(source)
    if not Passport then
        return false
    end

    if type(Plate) ~= "string" or Plate == "" or #Plate > 12 then
        return false
    end

    local Ped = GetPlayerPed(source)
    local Vehicle = GetVehiclePedIsIn(Ped,false)
    if Vehicle == 0 then
        return false
    end

    local CurrentPlate = GetVehicleNumberPlateText(Vehicle):gsub("%s+","")
    if CurrentPlate ~= Plate:gsub("%s+","") then
        return false
    end

    local Value = math.max(0, math.min(parseInt(Fuel), NITRO_MAX_FUEL))

    -- Fonte do HUD novo (chave por placa, sem conflito de tabela)
    GlobalState["Nitro:"..Plate] = Value

    -- Compatibilidade com o HUD antigo e com o black_garages
    if GlobalState["Nitro"] == nil then
        GlobalState["Nitro"] = {}
    end
    local Nitro = GlobalState["Nitro"]
    Nitro[Plate] = Value
    GlobalState["Nitro"] = Nitro

    return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPLAYERSTREET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("updatePlayerStreet")
AddEventHandler("updatePlayerStreet",function(StreetName)
    local source = source
    local Passport = vRP.Passport(source)
    if not Passport then
        return
    end

    if type(StreetName) ~= "string" or StreetName == "" or #StreetName > STREET_NAME_MAX_LENGTH then
        return
    end

    Player(source).state.Street = StreetName
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEEJECT
-----------------------------------------------------------------------------------------------------------------------------------------
local EJECT_MAX_DAMAGE = 60
local EJECT_SPEED_DIVISOR = 3

RegisterServerEvent("hud:VehicleEject")
AddEventHandler("hud:VehicleEject",function(Velocity)
    local source = source
    local Passport = vRP.Passport(source)
    if not Passport or type(Velocity) ~= "vector3" then
        return
    end

    local Speed = #Velocity * 2.236936
    local Damage = math.min(math.floor(Speed / EJECT_SPEED_DIVISOR),EJECT_MAX_DAMAGE)
    if Damage <= 0 then
        return
    end

    local Ped = GetPlayerPed(source)
    if DoesEntityExist(Ped) then
        SetEntityHealth(Ped,math.max(GetEntityHealth(Ped) - Damage,0))
    end
end)