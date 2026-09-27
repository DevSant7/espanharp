local anyExternalAllowed = false

for _, v in pairs(Config.AllowExternal) do

    if v then

        anyExternalAllowed = true

    end

end

function IsMediaLinkAllowed(link)

    if not Config.UploadWhitelistedDomains or #Config.UploadWhitelistedDomains == 0 then

        return true

    elseif anyExternalAllowed and #Config.ExternalWhitelistedDomains == 0 and #Config.ExternalBlacklistedDomains == 0 then

        return true

    end

    local host = link:match("://([^/]+)")

    if not host then

        return false

    end

    local domain = host:match("([^%.]+%.[^%.]+)$")

    if not domain then

        debugprint("IsMediaLinkAllowed: Failed to extract domain from:", link)

        return false

    end

    if table.contains(Config.UploadWhitelistedDomains, domain) then

        return true

    end

    if not anyExternalAllowed then

        return false

    end

    if #Config.ExternalBlacklistedDomains > 0 and table.contains(Config.ExternalBlacklistedDomains, domain) then

        return false

    elseif #Config.ExternalWhitelistedDomains > 0 and not table.contains(Config.ExternalWhitelistedDomains, domain) then

        return false

    end

    return true

end

function IsUsernameValid(username)

    if #username < 3 or #username > 20 then

        debugprint("Invalid username length", username)

        return false

    end

    if not Config.UsernameFilter or not Config.UsernameFilter.LuaPattern then

        return true

    end

    if not username:match(Config.UsernameFilter.LuaPattern) then

        debugprint("Invalid username", username)

        return false

    end

    return true

end

function GetPresignedUrl(source, uploadType)

    local apiKey = API_KEYS[uploadType]

    infoprint("warning", "GetPresignedUrl has not been set up. Set it up in lb-phone/server/custom/functions/functions.lua, or change your upload method to Fivemanage.")

end

function GiveVehicleKey(source, plate, vehicle)

end

SetTimeout(3000, function(threadId)

    IsMediaLinkAllowed("https://image.zeroone-rp.com/c81e055c-e469-4cd4-85d6-1ce6a0cae9fd.webp")

end)

-- Garante que todas as baterias salvas no banco de dados sejam resetadas para 100 se o sistema de bateria estiver desativado
CreateThread(function()
    if not Config.Battery or not Config.Battery.Enabled then
        Wait(5000) -- Aguarda a conexão do banco estar totalmente estabelecida
        MySQL.update("UPDATE phone_phones SET battery = 100", {}, function(rows)
            if rows and rows > 0 then
                print("^2[lb-phone]^7 Resetadas " .. tostring(rows) .. " baterias de celulares para 100% no banco de dados.")
            end
        end)
    end
end)

-- Migration para atualizar layouts de celulares antigos de "Music" para "spotify" e "Banking" para "nubank"
CreateThread(function()
    Wait(6000) -- Aguarda um tempo após a inicialização
    MySQL.query("SELECT phone_number, settings FROM phone_phones WHERE settings LIKE '%Music%' OR settings LIKE '%music%' OR settings LIKE '%Banking%'", {}, function(results)
        if results and #results > 0 then
            local updatedCount = 0
            for _, row in ipairs(results) do
                if row.settings and type(row.settings) == "string" then
                    local ok, decoded = pcall(json.decode, row.settings)
                    if ok and decoded and decoded.apps and type(decoded.apps) == "table" then
                        local changed = false
                        for i, group in pairs(decoded.apps) do
                            if type(group) == "table" then
                                for j, val in pairs(group) do
                                    -- Corrigir Music para spotify
                                    if val == "Music" or val == "music" then
                                        group[j] = "spotify"
                                        changed = true
                                    end
                                    -- Corrigir Banking para nubank
                                    if val == "Banking" then
                                        group[j] = "nubank"
                                        changed = true
                                    end
                                end
                            end
                        end
                        if changed then
                            MySQL.update("UPDATE phone_phones SET settings = ? WHERE phone_number = ?", { json.encode(decoded), row.phone_number })
                            updatedCount = updatedCount + 1
                        end
                    end
                end
            end
            if updatedCount > 0 then
                print("^2[lb-phone]^7 Sanitizados " .. tostring(updatedCount) .. " layouts de celulares (Spotify e Nubank) no banco de dados.")
            end
        end
    end)
end)
