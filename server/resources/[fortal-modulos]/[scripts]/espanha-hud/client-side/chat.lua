local timeOpenned = GetGameTimer()
local chatInvisible = false
RegisterKeyMapping("openChat","Abrir chat","keyboard","t")
RegisterCommand("openChat",function()
    if not LocalPlayer["state"]["Active"] then return end

    -- HUD DESLIGADA = partida da arena, evento, FFA. O input do chat vive na MESMA página
    -- da HUD, e o `hud:Active false` esconde a página inteira (opacity-0) — mas o
    -- componente continua montado. Sem esta trava, o T abria o campo de verdade: foco de
    -- NUI tomado, cursor na tela e NADA visível para escrever nem para clicar. Era esse o
    -- "mouse travado no começo do round".
    --
    -- Comparação com `false` de propósito, e não `if not HudVisible`: quem publica a flag
    -- é o `client.lua` deste resource, e se ele falhasse antes disso a flag seria `nil` —
    -- com `not`, o chat do servidor inteiro morreria junto. Só bloqueia quando alguém
    -- disse explicitamente que a HUD está escondida.
    if HudVisible == false then return end

    if chatInvisible then
        chatInvisible = false
        TriggerEvent('Notify','negado','Chat ativado novamente.',5000)
    end

    SetNuiFocus(true,true)
    SendNUIMessage({
        action = 'chat:inputfocus',
        data = true
    })
end)

function chatMessage(context, content, title, highlight, color, css, emoji)
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if hours <= 9 then
        hours = "0"..hours
    end

    if minutes <= 9 then
        minutes = "0"..minutes
    end

    if not context then context = 'global' end
    css = css or {}

    if not chatInvisible then
        SendNUIMessage({
            action = 'chat:message',
            data = {
                context = context,
                title = title,
                author = css.author or nil,
                authorID = css.authorID or nil,
                content = content,
                time = hours .. ":" .. minutes,
                type = css.chatType or nil,
                highlight = highlight,
                color = color,
                typeStyles = css.type,
                containerStyles = css.container,
                emoji = css.emoji or emoji
            }
        })
    end
end

function isOffensive(text)
    for _, v in pairs(hudConfig['offensiveWord']) do
        if string.find(text, v) then
            TriggerEvent('Notify', 'negado', 'Uma palavra proibida foi encontrada no seu texto.', 5000)
            return true
        end
    end
    return false
end
exports('isOffensive', isOffensive)

RegisterNetEvent('chat:ClientMessage')
AddEventHandler('chat:ClientMessage',function(context, content, title, highlight, color, css, emoji) -- Recebe a mensagem do servidor
    if not highlight then highlight = false end

    -- if isOffensive(content) then
    --     return
    -- end

    if not title then title = content end

    if not chatInvisible then
        chatMessage(context or 'global', content, title, highlight, color, css or {}, emoji)
    end
end)


local chatCategories = {}

RegisterNUICallback("getChatCategories", function(data, cb)
    if chatCategories.timestamp and GetGameTimer() < chatCategories.timestamp + 60000 then
        return cb(chatCategories.chats)
    end
    
    local response = vSERVER.getChats()

    chatCategories = {
        timestamp = GetGameTimer(),
        chats = response
    }

    cb(response)
end)

RegisterNUICallback('sendChatMessage', function(data, cb)
    local message = data['message']
    local context = data.context
    SetNuiFocus(false,false)
    if GetGameTimer() >= timeOpenned then
        timeOpenned = GetGameTimer() + 1000
        if message then
            if message:sub(1,1) == "/" then
                ExecuteCommand(message:sub(2))
            else
                TriggerServerEvent('sendGlobalMessage',message,context)
            end
        end
    else
        TriggerEvent('Notify','negado','Aguarde e tente novamente',5000)
    end

    cb(true)
end)

RegisterNUICallback('setChatFocus', function(data, cb)
    SetNuiFocus(false, false)

    cb(true)
end)