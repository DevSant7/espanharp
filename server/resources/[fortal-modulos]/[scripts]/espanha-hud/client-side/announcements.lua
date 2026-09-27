local function resolvePreset(author)
    return hudConfig.announcePresets[author] or hudConfig.announcePresets["default"]
end

local function mergeStyle(preset, override)
    if not override then return preset end
    return {
        color = override.color or preset.color,
        icon  = override.icon  or preset.icon,
        title = override.title or preset.title,
    }
end

RegisterNetEvent("hud:anuncio")
AddEventHandler("hud:anuncio", function(message, time, user_id, author, osdate, style, scope)
    if time < 20000 then time = 20000 end
    if not user_id then user_id = 0 end

    local preset        = resolvePreset(author)
    local resolvedStyle = mergeStyle(preset, style)

    SendNUIMessage({
        action = 'notify:alert',
        data = {
            message = message,
            author = {
                id   = user_id,
                name = author,
            },
            timeout = time,
            time    = osdate,
            style   = resolvedStyle,
            scope   = scope,
        }
    })
end)
