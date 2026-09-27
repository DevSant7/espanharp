-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("createInitial", [[
    CREATE TABLE IF NOT EXISTS `initial_streamer` (
        `id` INT NOT NULL,
        `isInitial` VARCHAR(50) NOT NULL,
        `expire_time` DATETIME NOT NULL
    )
]])

vRP.prepare("insertInitial", [[
    INSERT INTO initial_streamer (id, isInitial, expire_time)
    VALUES (@id, @isInitial, @expire_time)
]])

vRP.prepare("selectInitial", [[
    SELECT isInitial, expire_time FROM initial_streamer WHERE id=@id
]])

vRP.prepare("deleteExpiredInitials", [[
    DELETE FROM initial_streamer WHERE expire_time <= NOW()
]])

Citizen.CreateThread(function()
    vRP.execute("createInitial")
    
    while true do
        vRP.execute("deleteExpiredInitials")
        Wait(60 * 60 * 1000) 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("initial_streamer", Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.CheckInit()
    local source = source
    local Passport = vRP.getUserId(source)
    if Passport then
        local License = vRP.query("selectInitial", { id = Passport })
        if not License[1] then
            return true
        end
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Save(vehName)
    local source = source
    local Passport = vRP.getUserId(source)
    local Identity = vRP.userIdentity(Passport)
    if Passport then
        local vehicle = vRP.query("vehicles/selectVehicles", { user_id = Passport, vehicle = vehName })
        if vehicle[1] then
            TriggerClientEvent("Notify", source, "check", "Sucesso", "Já possui um <b>" .. vehName .. "</b>.", "verde", 3000)
            return
        else
            vRP.execute("vehicles/addVehicles", {
                user_id = Passport,
                vehicle = vehName,
                plate = vRP.generatePlate(),
                work = "false"
            })

            local expireTime = os.date("%Y-%m-%d %H:%M:%S", os.time() + (30 * 24 * 60 * 60)) -- 30 dias

            vRP.execute("insertInitial", {
                id = Passport,
                isInitial = true,
                expire_time = expireTime
            })

            if NotifyConfig then
                TriggerClientEvent("Notify", source, "check", "Sucesso",
                    "Nossa equipe da administração está muito feliz em ter você conosco... <br><br>Bem-vindo(a) " ..
                    Identity["name"] .. " " .. Identity["name2"], "verde", 10000)

                TriggerClientEvent("Notify", source, "check", "Sucesso",
                    "Veiculo <b>" .. vehName .. "</b> adicionado em sua garagem por 30 dias!", "verde", 10000)
            end
        end
    end
end