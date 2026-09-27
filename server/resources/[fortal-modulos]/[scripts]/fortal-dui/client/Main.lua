local Duis = {}

function Draw(data)
    CreateThread(function()
        local type, id = string.match(data.id, "(.-)_(.+)")

        if not Duis[data.id] then
            -- Adiciona a cor da configuração aos dados
            local dataWithColor = {
                id = data.id,
                coords = data.coords,
                close = data.close,
                title = data.title,
                color = Config.Color
            }
            
            local duiUrl = 'nui://fortal-dui/client/nui/index.html?'..type..'='..json.encode(dataWithColor)
            local duiHandle = CreateDui(duiUrl, 300, 300)

            CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd(type), type, GetDuiHandle(duiHandle))

            Duis[data.id] = {
                handle = duiHandle,
                type = type, 
                coords = data.coords,
                close = data.close,
                created = false
            }
        else
            if data.close ~= Duis[data.id].close then
                Duis[data.id].close = data.close
                
                SendDuiMessage(Duis[data.id].handle, json.encode({
                    action = "inClose",
                    payload = {
                        id = data.id,
                        close = data.close
                    }
                }))
            end
        end
    end)
end

function Delete(id)
    if Duis[id] then
        DestroyDui(Duis[id].handle)

        Duis[id] = nil
    end
end

function Get(id)
    if Duis[id] then
        return true
    end

    return false
end

CreateThread(function()
    while true do
        for k,v in pairs(Duis) do
            if v.created then
                SetDrawOrigin(v.coords.x, v.coords.y, v.coords.z)
                DrawSprite(v.type,v.type,0.0,0.0,0.157,0.280,0,255,255,255,255)
                ClearDrawOrigin()
            else
                v.created = true
            end
        end

        Wait(0)
    end
end)

-- Função para alterar cor dinamicamente
function SetColor(r, g, b)
    Config.Color.r = r
    Config.Color.g = g
    Config.Color.b = b
end

exports("Draw", Draw)
exports("Delete", Delete)
exports("Get", Get)
exports("SetColor", SetColor)