function CanGoLive(source, username)

    return true

end

function CanCreateStory(source, username)

    return true

end

if not Config.Item.Unique then

    Wait(100)

    if CreateUsableItem and Config.Item.Name then

        CreateUsableItem(Config.Item.Name, function(src)

            TriggerClientEvent("phone:toggleOpen", src, true)

        end)

    elseif CreateUsableItem and Config.Item.Names then

        for i = 1, #Config.Item.Names do

            CreateUsableItem(Config.Item.Names[i].name, function(src)

                TriggerClientEvent("phone:usedPhoneVariation", src, i)

            end)

        end

    end

end
