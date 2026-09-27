print('^0Autenticado!')
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

if not (ProviderDatabase) then
    ProviderDatabase = "summerz_vehicles"
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------


vRP.prepare("createInital", [[
        CREATE TABLE IF NOT EXISTS`initial_black` (
        `id` INT NOT NULL,
        `isInitial` VARCHAR(50) NOT NULL
    )

]])
vRP.prepare("insertInitial",[[
    INSERT INTO initial_black (id, isInitial) VALUES (@id,@isInitial);
]])

vRP.prepare("selectInitial",[[
    SELECT isInitial FROM initial_black WHERE id=@id;
]])

Citizen.CreateThread(function()

    vRP.execute("createInital")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("initial", Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckInit()
    local source = source
    local Passport = vRP.getUserId(source)
    local License = vRP.query("selectInitial",{id = Passport})
    if Passport then
        if not License[1] then
            return true
        end
    end
    return false
end
vRP.prepare("vehicles/selectVehiclesInital","SELECT * FROM "..ProviderDatabase or 'summerz_vehicles'.." WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Save(vehName)
    local source = source
    local Passport = vRP.getUserId(source)
    local Identity = vRP.userIdentity(Passport)
    if Passport then
        local vehicle = vRP.execute("vehicles/selectVehiclesInital", { user_id = Passport, vehicle = vehName })
        if vehicle[1] and vehicle[1]["user_id"] == Passport and vehicle[1]["vehicle"] ==  vehName then
            TriggerClientEvent("Notify", source, "check", "Sucesso", "Já possui um <b>" .. vehName .. "</b>.",
                "verde", 3000)
            return
        else
            vRP.execute("vehicles/addVehicles",
                { user_id = Passport, vehicle = vehName, plate = vRP.generatePlate(), work = "false" })
                vRP.execute("insertInitial",{id = Passport,isInitial = true})
            if NotifyConfig then
                TriggerClientEvent("Notify", source, "check", "Sucesso",
                    "Nossa equipe da administração está muito feliz em ter você conosco, trabalhamos incansavelmente para desenvolver o melhor ambiente para sua diversão, conte conosco e saiba que o nosso discord está aberto para dúvidas, sugestões e afins. <br><br>Tenha uma ótima estadia e um bom jogo.<br>Divirta-se! Bem-vindo(a) " ..
                    Identity["name"] .. " " .. Identity["name2"], "verde", 10000)
                TriggerClientEvent("Notify", source, "check", "Sucesso", "Veiculo " .. vehName ..
                    " adicionado em sua garagem!!!", "verde", 10000)
            end
        end
    end
end
