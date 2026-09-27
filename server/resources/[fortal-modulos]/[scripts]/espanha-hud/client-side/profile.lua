-- ================================================================
-- NUI CALLBACKS
-- ================================================================

local profileVisible = false
local Entity = false

local function SetProfileVisible(visible)
    profileVisible = visible
    SetNuiFocus(visible, visible)
    SendNUIMessage({ action = "set:profile:visible", data = visible })
end

RegisterNUICallback("get:profile:data", function(_, cb)
    local data = vSERVER.GetProfileData(Entity)

    cb(data)
end)


RegisterNUICallback("post:profile:changeAvatar", function(payload, cb)
    local avatar = payload.avatar
    if not avatar or type(avatar) ~= "string" or avatar == "" then
        cb({ success = false, error = "Invalid avatar URL" })
        return
    end

    local result = vSERVER.UpdateProfileData('avatar', avatar)
    cb({ success = result })
end)

RegisterNUICallback("post:profile:changeBanner", function(payload, cb)
    local banner = payload.banner
    if not banner or type(banner) ~= "string" or banner == "" then
        cb({ success = false, error = "Invalid banner URL" })
        return
    end

    local result = vSERVER.UpdateProfileData('banner', banner)
    cb({ success = result })
end)

RegisterNUICallback("post:profile:changeDiscord", function(payload, cb)
    local discord = payload.discord
    if not discord or type(discord) ~= "string" then
        cb({ success = false, error = "Invalid Discord handle" })
        return
    end

    local result = vSERVER.UpdateProfileData('discord', discord)
    cb({ success = result })
end)

RegisterNUICallback("post:profile:changeInstagram", function(payload, cb)
    local instagram = payload.instagram
    if not instagram or type(instagram) ~= "string" then
        cb({ success = false, error = "Invalid Instagram handle" })
        return
    end

    local result = vSERVER.UpdateProfileData('instagram', instagram)
    cb({ success = result })
end)

RegisterNUICallback("post:profile:changeDescription", function(payload, cb)
    local description = payload.description
    if not description or type(description) ~= "string" then
        cb({ success = false, error = "Invalid description" })
        return
    end

    local result = vSERVER.UpdateProfileData('description', description)
    cb({ success = result })
end)

RegisterNUICallback("post:profile:relate", function(payload, cb)
    local result = vSERVER.RelatePlayer(payload.id)
    cb({ success = result })
end)

RegisterNUICallback("hideFrame", function(data, cb)
    SetProfileVisible(false)
    Entity = false
    profileVisible = false
    cb(true)
end)

RegisterCommand('+toggleProfile', function()
    Entity = false
    SetProfileVisible(not profileVisible)
end)

RegisterCommand('-toggleProfile', function()
end)

-- Registra a keybind F11
CreateThread(function ()
    RegisterKeyMapping('+toggleProfile', 'Toggle Profile', 'keyboard', 'F11')
end)

-- Event handler para abrir perfil de outro jogador
AddEventHandler("hud:set:profile.visible", function(src)
    if src and src[1] then
        Entity = src[1]
        SetProfileVisible(true)
    end
end)