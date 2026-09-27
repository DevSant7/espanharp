local idRequest = 0
--------------------------------------------------------
-- NOTIFY MESSAGE
--------------------------------------------------------
function getNotificationType(typeNotify)
    local typeMapping = {
        sucesso = 'success',
        verde = 'success',
        success = 'success',
        aviso = 'warn',
        importante = 'warn',
        info = 'warn',
        amarelo = 'warn',
        negado = 'error',
        vermelho = 'error',
        error = 'error',
        azul = 'success',
    }

    return typeMapping[string.lower(typeNotify)] or 'warn'
end

RegisterNetEvent("Notify")
AddEventHandler("Notify", function(typeNotify, message, timeout, OldTimeout)
    timeout = timeout or 5000
    if type(timeout) ~= "number" then
        if OldTimeout then
            timeout = OldTimeout
        else
            timeout = 5000
        end
    end
    if timeout < 5000 then
        timeout = 5000
    end

    if not typeNotify then typeNotify = 'error' end

    local normalizedType = getNotificationType(typeNotify)
    SendNUIMessage({
        action = 'notify:message',
        data = {
            type = normalizedType, -- 'success', 'error', 'warn'
            message = message,
            timeout = timeout
        },
    })
end)
--------------------------------------------------------
-- NOTIFY REQUEST
--------------------------------------------------------
RegisterNetEvent("DS:genRequest")
AddEventHandler("DS:genRequest", function(id, message, time, title)
    idRequest = id
    local title = title or 'Aceitar ou Recusar'
    SendNUIMessage({
        action = 'notify:request',
        data = {
            title = title,
            acceptKey = 'Y',
            refuseKey = 'U',
            user = false,
            message = tostring(message),
            timeout = time
        }
    })
end)

RegisterKeyMapping("DS:keyBindAccept", "Requisição: Confirmar", "keyboard", "y")
RegisterCommand("DS:keyBindAccept", function(source, args)
    TriggerServerEvent("DS:reciveRequest", tonumber(idRequest), true)
    closeRequest()
end)

RegisterKeyMapping("DS:keyBindRefuse", "Requisição: Negar", "keyboard", "u")
RegisterCommand("DS:keyBindRefuse", function(source, args)
    TriggerServerEvent("DS:reciveRequest", tonumber(idRequest), false)
    closeRequest()
end)

function closeRequest()
    SendNUIMessage({
        action = 'notify:request',
        data = false
    })
    idRequest = 0
end

--------------------------------------------------------
-- NOTIFY ITEM
--------------------------------------------------------
RegisterNetEvent('NotifyItens')
AddEventHandler("NotifyItens", function(Data)
    local typee = 'remove'

    if Data[1] == '+' then
        typee = 'add'
    end
    
    local index = itemIndex(Data[2])
    local name = itemName(Data[2])
    
    SendNUIMessage({
        action = 'notify:item',
        data = {
            action = typee, -- 'remove', 'add'
            index = index,
            name = name,
            amount = Data[3]
        }
    })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zone = {}
local Select = {}
local Active = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
    return math.floor((x + 8192) / 128)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
    return (v["x"] << 8) | v["y"]
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x, y)
    local gridChunk = vector2(gridChunk(x), gridChunk(y))
    return toChannel(gridChunk)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local TimeDistance = 1000

        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)

        if not Active then
            local gridZone = getGridzone(Coords["x"], Coords["y"])

            if Zone[gridZone] then
                for _, Table in pairs(Zone[gridZone]) do
                    if #(Coords - Table["Coords"]) < Table["Distance"] then
                        SendNUIMessage({
                            action = 'notify:action',
                            data = {
                                key = Table['key'],
                                name = Table['title'],
                            }
                            -- PARA ESCONDER MANDE "false" NO DATA
                        }) -- tecla da ação ou false pra tirar da tela

                        Select = Table
                        Active = true
                    end
                end
            else
                TimeDistance = 2000
            end
        else
            if #(Coords - Select["Coords"]) > Select["Distance"] then
                SendNUIMessage({ action = 'notify:action', data = false })
                TimeDistance = 100
                Active = false
            end
        end
        Wait(TimeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOVERFY:INSERT
-----------------------------------------------------------------------------------------------------------------------------------------
-- Formato real de quem dispara este evento (barbershop, tattooshop, skinshop, creative e o
-- próprio resource "hoverfy"): { Coords (vec3), Distance, Key, Title, Legend } -- um vetor
-- na posição 1, não x/y/z separados. A versão anterior assumia x,y,z soltos nas posições
-- 1/2/3 e quebrava (`math.floor` recebendo um vector) toda vez que qualquer um desses
-- resources publicava um ponto de interação.
RegisterNetEvent("hoverfy:Insert")
AddEventHandler("hoverfy:Insert", function(Tables)
    for Number = 1, #Tables do
        local Entry = Tables[Number]
        local EntryCoords = Entry[1]
        if type(EntryCoords) == "vector3" then
            local Grid = getGridzone(EntryCoords.x, EntryCoords.y)

            if not Zone[Grid] then
                Zone[Grid] = {}
            end
            Zone[Grid][#Zone[Grid] + 1] = {
                ["Coords"] = EntryCoords,
                ["Distance"] = Entry[2],
                ["key"] = Entry[3],
                ["title"] = Entry[4],
                ["legend"] = Entry[5]
            }
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROGRESS:VIEW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Progress")
AddEventHandler("Progress", function(title,time)
    if type(time) ~= "number" then
        time = 10000
    end
    if not title then
        title = "Aguarde..."
    end

    SendNUIMessage({
        action = 'notify:progress',
        data = {
            message = title,
            timeout = time -- milissegundos
        }
    })
end)

local function cancelProgress()
    SendNUIMessage({ action = 'notify:progress', data = false })
end

RegisterNetEvent("Progress:cancel")
AddEventHandler("Progress:cancel", cancelProgress)

exports('cancelProgress', cancelProgress)


local notifyEventTimeout = 0
local notifyEventKeyControls = {
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["E"]  = 51,
    ["G"]  = 47,
    ["H"]  = 74,
}

--- Está dentro de uma zona de dominação?
--- Statebag replicado pelo servidor do mirtin_dominacao: plyEnterZone marca true,
--- plyLeaveZone e cancelDomination limpam. Vem nil quando o jogador não está em
--- dominação (ou o resource não está de pé), e nil não bloqueia nada.
---@return boolean
local function isInDomination()
    return LocalPlayer.state.inDomination == true
end

RegisterNetEvent("NotifyEvent")
AddEventHandler("NotifyEvent", function(data)
    -- Card de evento não entra na tela de quem está brigando na dominação.
    if isInDomination() then return end

    local payload = data

    SendNUIMessage({
        action = 'notify:event',
        data = {
            title = data.title,
            message = data.message,
            time = data.time,
            footer = data.footer,
            -- Quem assina o card. A NUI já lia este campo; quem não manda continua
            -- saindo como "Prefeitura America", que é o padrão de lá.
            author = data.author,
            -- Foto opcional em faixa no topo (a rifa manda a do prêmio). Este repasse é o
            -- ponto do contrato que faltava: campo que não é copiado aqui NÃO chega à NUI,
            -- por mais que o servidor o mande. Quem não usar continua com o card de sempre.
            -- ⚠️ A URL é do servidor, mas a NUI ainda a filtra por host (`safeImageUrl`) —
            -- host novo precisa entrar naquela lista, senão a foto some sem erro.
            image = data.image,
            timeout = data.finish_at * 1000
        }
    })

    notifyEventTimeout = tonumber(data.finish_at)

    local footerKey = data.footer and data.footer.key or "F3"
    local control = notifyEventKeyControls[footerKey] or 170

    CreateThread(function()
        local delayTimer = GetGameTimer()
        while notifyEventTimeout > 0 do
            if GetGameTimer() > delayTimer then
                notifyEventTimeout = notifyEventTimeout - 1
                delayTimer = GetGameTimer() + 1000

                -- Entrou na zona com o card já na tela: tira e encerra a thread,
                -- senão a tecla continuaria valendo com o card invisível.
                if isInDomination() then
                    TriggerEvent("remove:NotifyEvent")
                    break
                end
            end

            if IsControlJustPressed(0, control) then
                local actionType = payload.actionType or "teleport"

                if actionType == "event" and payload.eventName then
                    TriggerEvent(payload.eventName, payload.eventData or payload)
                elseif actionType == "server_event" and payload.eventName then
                    TriggerServerEvent(payload.eventName, payload.eventData or payload)
                elseif actionType == "teleport" then
                    if payload.coords then
                        TriggerEvent("Notify", "verde", "Você foi teleportado para o evento.", 8000)
                        SetEntityCoords(PlayerPedId(), payload.coords.x, payload.coords.y, payload.coords.z)
                    end
                end

                TriggerEvent("remove:NotifyEvent")
                break
            end
            Wait(0)
        end
    end)
end)

RegisterNetEvent("remove:NotifyEvent")
AddEventHandler("remove:NotifyEvent", function(Number)
    SendNUIMessage({action = 'remove:notify:event'})
end)

--------------------------------------------------------
-- HOVERFY
--------------------------------------------------------
-- Suporta MÚLTIPLOS hoverfys ao mesmo tempo, identificados por `id` (empilhados na NUI).
-- Retrocompatível: callers que NÃO passam `id` são agrupados pelo recurso invocador
-- (1 hoverfy por recurso, como antes). Para mostrar 2 do MESMO recurso, passe ids distintos.
local hoverfys = {}              -- lista ordenada: { { id, data, owner, nui }, ... }
local hoverfyPressedState = false

local hoverfyKeyBindings = {
    ["E"]  = { cmd = "hoverfy:key:E",  kb = "e" },
    ["F1"] = { cmd = "hoverfy:key:F1", kb = "f1" },
    ["F2"] = { cmd = "hoverfy:key:F2", kb = "f2" },
    ["F3"] = { cmd = "hoverfy:key:F3", kb = "f3" },
    ["F5"] = { cmd = "hoverfy:key:F5", kb = "f5" },
    ["F6"] = { cmd = "hoverfy:key:F6", kb = "f6" },
    ["F7"] = { cmd = "hoverfy:key:F7", kb = "f7" },
    ["G"]  = { cmd = "hoverfy:key:G",  kb = "g" },
    ["H"]  = { cmd = "hoverfy:key:H",  kb = "h" },
}

--- Resolve um id estável: id explícito → recurso invocador → "default".
local function resolveHoverfyId(id)
    if type(id) == "string" and #id > 0 then return id end
    local owner = GetInvokingResource()
    if owner then return "res:" .. owner end
    return "default"
end

local function indexOfHoverfy(id)
    for i = 1, #hoverfys do
        if hoverfys[i].id == id then return i end
    end
    return nil
end

--- Envia a lista atual (só campos não-função) para a NUI.
local function pushHoverfys()
    local list = {}
    for i = 1, #hoverfys do
        list[i] = hoverfys[i].nui
    end
    SendNUIMessage({ action = "set:notify:hoverfy", data = list })
end

function hideHoverfy(id)
    id = resolveHoverfyId(id)
    local i = indexOfHoverfy(id)
    if not i then return end
    table.remove(hoverfys, i)
    pushHoverfys()
end

for key, bind in pairs(hoverfyKeyBindings) do
    RegisterKeyMapping(bind.cmd, "Hoverfy: " .. key, "keyboard", bind.kb)
    RegisterCommand(bind.cmd, function()
        -- Dispara o hoverfy ativo (mais recente) com esta tecla e com onPress.
        for i = #hoverfys, 1, -1 do
            local e = hoverfys[i]
            if e.data.key == key and e.data.onPress then
                hoverfyPressedState = true
                local cb = e.data.onPress
                hideHoverfy(e.id)
                cb()
                return
            end
        end
    end, false)
end

local function showHoverfy(data)
    if type(data) ~= "table" then return end

    local id = resolveHoverfyId(data.id)
    local owner = GetInvokingResource() or nil
    hoverfyPressedState = false

    local nui = {}
    for k, v in pairs(data) do
        if type(v) ~= "function" then nui[k] = v end
    end
    nui.id = id

    local entry = { id = id, data = data, owner = owner, nui = nui }
    local i = indexOfHoverfy(id)
    if i then hoverfys[i] = entry else hoverfys[#hoverfys + 1] = entry end
    pushHoverfys()

    -- Auto-esconde ao pressionar a tecla, para hoverfys SEM onPress (comportamento antigo).
    if not data.onPress then
        local control = notifyEventKeyControls[data.key]
        if not control then return end

        CreateThread(function()
            while true do
                local idx = indexOfHoverfy(id)
                if not idx or hoverfys[idx].data ~= data then break end
                if IsControlJustPressed(0, control) then
                    hoverfyPressedState = true
                    hideHoverfy(id)
                    break
                end
                Wait(0)
            end
        end)
    end
end

local function isHoverfyPressed()
    if hoverfyPressedState then
        hoverfyPressedState = false
        return true
    end
    return false
end

RegisterNetEvent("hud:showHoverfy")
AddEventHandler("hud:showHoverfy", function(data)
    showHoverfy(data)
end)

RegisterNetEvent("hud:hideHoverfy")
AddEventHandler("hud:hideHoverfy", function(id)
    hideHoverfy(id)
end)

exports('showHoverfy', showHoverfy)
exports('hideHoverfy', hideHoverfy)
exports('isHoverfyPressed', isHoverfyPressed)

AddEventHandler('onResourceStop', function(resourceName)
    local changed = false
    for i = #hoverfys, 1, -1 do
        if hoverfys[i].owner == resourceName then
            table.remove(hoverfys, i)
            changed = true
        end
    end
    if changed then pushHoverfys() end
end)

--------------------------------------------------------
-- NOTIFY VOTE (Votação)
--------------------------------------------------------
local activeVote = false
local voteHasVoted = false

local voteKeyBindings = {
    { key = "F1", control = 288 },
    { key = "F2", control = 289 },
    { key = "F3", control = 170 },
    { key = "F5", control = 166 },
    { key = "F6", control = 167 },
    { key = "F7", control = 168 },
}

RegisterNetEvent("NotifyVote")
AddEventHandler("NotifyVote", function(data)
    if activeVote then return end
    activeVote = true
    voteHasVoted = false

    local optionCount = #data.options

    local keys = {}
    for i = 1, optionCount do
        if voteKeyBindings[i] then
            keys[i] = voteKeyBindings[i].key
        end
    end

    SendNUIMessage({
        action = 'notify:vote',
        data = {
            title = data.title,
            message = data.message,
            timeout = data.finish_at * 1000,
            author = data.author,
            options = data.options,
            keys = keys,
        }
    })

    CreateThread(function()
        local timeout = data.finish_at
        local delayTimer = GetGameTimer()
        while activeVote and timeout > 0 do
            if GetGameTimer() > delayTimer then
                timeout = timeout - 1
                delayTimer = GetGameTimer() + 1000
            end

            if not voteHasVoted then
                for i = 1, optionCount do
                    local bind = voteKeyBindings[i]
                    if bind and IsControlJustPressed(0, bind.control) then
                        voteHasVoted = true
                        TriggerServerEvent("hud:vote:submit", i - 1)
                        SendNUIMessage({
                            action = 'vote:local',
                            data = { option = i - 1 }
                        })
                        break
                    end
                end
            end
            Wait(0)
        end
        activeVote = false
    end)
end)

RegisterNUICallback("vote:submit", function(body, cb)
    if not activeVote or voteHasVoted then
        cb("ok")
        return
    end

    local option = body.option
    if type(option) == "number" then
        voteHasVoted = true
        TriggerServerEvent("hud:vote:submit", option)
    end

    cb("ok")
end)

RegisterNetEvent("vote:results")
AddEventHandler("vote:results", function(results)
    SendNUIMessage({
        action = 'vote:results',
        data = { results = results }
    })
end)

RegisterNetEvent("remove:NotifyVote")
AddEventHandler("remove:NotifyVote", function()
    activeVote = false
    SendNUIMessage({ action = 'remove:notify:vote' })
end)