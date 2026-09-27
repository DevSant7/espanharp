local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

vRP.prepare("vRP/get_userdata", "SELECT dvalue FROM playerdata WHERE user_id = @user_id AND dkey = @key")

RegisterNetEvent("copiar_skin:requestData")
AddEventHandler("copiar_skin:requestData", function(targetUserId, genderArg)
    local src = source
    local user_id = vRP.getUserId(src)
    
    if not vRP.hasGroup(user_id, "Rm") then
        TriggerClientEvent("Notify", src, "negado", "Você não tem permissão para usar este comando.")
        return
    end

    local clothings = vRP.query("vRP/get_userdata", { user_id = targetUserId, key = "Clothings" })
    local clothingsData = clothings and clothings[1] and json.decode(clothings[1].dvalue) or {}

    local modelName = clothingsData.model
    if not modelName then
        modelName = (genderArg == "f" and "mp_f_freemode_01") or "mp_m_freemode_01"
    end
    clothingsData.model = modelName

    local faceData = nil
    local face = vRP.query("vRP/get_userdata", { user_id = targetUserId, key = "Character" })
    if face and face[1] then
        faceData = json.decode(face[1].dvalue)
    end

    local tattoosData = nil
    local tattoos = vRP.query("vRP/get_userdata", { user_id = targetUserId, key = "Tattoos" })
    if tattoos and tattoos[1] then
        tattoosData = json.decode(tattoos[1].dvalue)
    end

    local dataToSend = {
        model = modelName,
        clothings = clothingsData,
        face = faceData,
        tattoos = tattoosData
    }

    -- ✅ Envia dados ao cliente
    TriggerClientEvent("copiar_skin:applyCustomization", src, dataToSend)
end)
