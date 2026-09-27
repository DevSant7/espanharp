local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
flxs = Tunnel.getInterface("fortal_prisao")
flx = Proxy.getInterface("vRP")

local Config = module("fortal_prisao", "shared/config")
local pendingSearchCallbacks = {}

local inSelect = 1
local inDeath = false
local inPrison = false
local inTimer = GetGameTimer()
local timeDeath = GetGameTimer()
local currentPrisonType = "normal"
local currentProp = nil 

local prisonPolyzone = {
    points = Config.PrisonAreas["normal"].points,
    name = "Prison"
}

local function isPointInPolyzone(point, polygon)
    local x, y = point.x, point.y
    local inside = false
    local j = #polygon
    
    for i = 1, #polygon do
        if (polygon[i].y < y and polygon[j].y >= y or polygon[j].y < y and polygon[i].y >= y) and
           (polygon[i].x <= x or polygon[j].x <= x) then
            if polygon[i].x + (y - polygon[i].y) / (polygon[j].y - polygon[i].y) * (polygon[j].x - polygon[i].x) < x then
                inside = not inside
            end
        end
        j = i
    end
    
    return inside
end

local function isPlayerInPrisonArea()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local point = vector2(coords.x, coords.y)
    
    local prisonArea = Config.PrisonAreas[currentPrisonType] or Config.PrisonAreas["normal"]
    return isPointInPolyzone(point, prisonArea.points)
end

local function teleportBackToPrison()
    local ped = PlayerPedId()
    local coords
    
    if currentPrisonType == "maxima" then
        coords = Config.PrisonCoords.maxima.internal
    else
        coords = Config.PrisonCoords.internal
    end
    
    SetEntityCoords(ped, coords[1], coords[2], coords[3], 1, 0, 0, 0)
    
    if currentPrisonType == "maxima" then
        TriggerEvent("Notify", "vermelho", "Você foi teleportado de volta para a Segurança Máxima!", 3000)
    else
        TriggerEvent("Notify", "vermelho", "Você foi teleportado de volta para a prisão!", 3000)
    end
end

local function drawPrisonArea()
    if Config.Debug then
        local prisonArea = Config.PrisonAreas[currentPrisonType] or Config.PrisonAreas["normal"]
        
        for i = 1, #prisonArea.points do
            local currentPoint = prisonArea.points[i]
            local nextPoint = prisonArea.points[i == #prisonArea.points and 1 or i + 1]
            
            DrawLine(
                currentPoint.x, currentPoint.y, 50.0,
                nextPoint.x, nextPoint.y, 50.0,
                255, 0, 0, 255
            )
        end
    end
end

local function toggleNuiFrame(shouldShow)
    SendReactMessage("setVisible", shouldShow)
end

function ShowPrisonUI(months, fine)

    local currentTime = {
        month = months or 0,
        fine = fine or 0
    }
    
    SendNUIMessage({
        action = "setVisibility",
        data = true
    })

    SendNUIMessage({
        action = "setTime",
        data = currentTime
    })

    SendNUIMessage({
        action = "setColor",
        data = Config.UI.colors.primary
    })
    
end

function HidePrisonUI()
    SendNUIMessage({
        action = "setVisibility",
        data = false
    })
end

RegisterNUICallback("hide", function(_, cb)
    HidePrisonUI()
    cb({})
end)

RegisterNUICallback("removeFocus", function(data, cb)
    HidePrisonUI()
    cb('ok')
end)

RegisterNUICallback("search", function(data, cb)
    if not data.id or data.id == "" then
        cb(false)
        return
    end
    
    local searchId = GetGameTimer() .. math.random(1000, 9999)
    pendingSearchCallbacks[searchId] = cb
    
    TriggerServerEvent("fortal_prisao:requestSearch", tonumber(data.id), searchId)
end)

RegisterNUICallback("prison", function(data, cb)
    local prisonType = data["tipo"] or "normal"
    local services = data["servicos"] or Config.PrisonTypes[prisonType].defaultTime
    local fines = data["multas"] or Config.FineTypes[prisonType].defaultAmount
    local text = data["texto"] or ""
    
    flxs.initPrison(data["passaport"], prisonType, services, fines, text)
    cb({})
end)

RegisterNUICallback("config", function(data, cb)
    local config = flxs.getConfig()
    cb({ config })
end)

RegisterNUICallback("takephoto", function(res, cb)
    toggleNuiFrame(false)
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    takePhoto = true
    Citizen.Wait(4)

    while takePhoto do
        Citizen.Wait(4)

        if IsControlJustPressed(1, 177) then -- CANCEL
            DestroyMobilePhone()
            CellCamActivate(false, false)
            cb(nil)
            takePhoto = false
            break
        elseif IsControlJustPressed(1, 176) then -- TAKE PIC
            exports["screenshot-basic"]:requestScreenshotUpload(
                Config.Logs.webhook,
                "files[]", function(data)
                local resp = json.decode(data)
                cb({ resp.attachments[1].proxy_url })
                flxs.savePhoto(res["id"], resp.attachments[1].proxy_url)
                DestroyMobilePhone()
                CellCamActivate(false, false)
            end)
            takePhoto = false
        end

        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(19)
        HideHudAndRadarThisFrame()
    end
    Citizen.Wait(800)
    toggleNuiFrame(true)
end)

-- Recebe a resposta da busca
RegisterNetEvent("fortal_prisao:searchResponse")
AddEventHandler("fortal_prisao:searchResponse", function(searchData, searchId)
    local callback = pendingSearchCallbacks[searchId]
    if callback then
        callback(searchData)
        pendingSearchCallbacks[searchId] = nil
    end
end)

-- Eventos para mostrar/esconder interface
RegisterNetEvent("fortal_prisao:show")
AddEventHandler("fortal_prisao:show", function(months, fine)
    ShowPrisonUI(months, fine)
end)

-- Evento para atualizar o tempo em tempo real
RegisterNetEvent("fortal_prisao:updateTime")
AddEventHandler("fortal_prisao:updateTime", function(remainingServices, fine)
    
    local currentTime = {
        month = remainingServices or 0,
        fine = fine or 0
    }
    
    SendNUIMessage({
        action = "setTime",
        data = currentTime
    })
end)

RegisterNetEvent("fortal_prisao:hide")
AddEventHandler("fortal_prisao:hide", function()
    HidePrisonUI()
end)

RegisterNetEvent("fortal_prisao:setPrisonType")
AddEventHandler("fortal_prisao:setPrisonType", function(prisonType)
    currentPrisonType = prisonType or "normal"
end)


RegisterNetEvent("fortal_prisao:teleportToPrison")
AddEventHandler("fortal_prisao:teleportToPrison", function()
   
    local ped = PlayerPedId()
    local coords

    if currentPrisonType == "maxima" then
        coords = Config.PrisonCoords.maxima.internal
    else
        coords = Config.PrisonCoords.internal
    end

    exports["pma-voice"]:removePlayerFromRadio()
    
    SetEntityCoords(ped, coords[1], coords[2], coords[3], 1, 0, 0, 0)
    
    inPrison = true
    
    local serviceLocations = currentPrisonType == "maxima" and Config.MaximaServiceLocations or Config.ServiceLocations
    inSelect = math.random(#serviceLocations)
    
    -- Iniciar cutscene de fotografia policial
    if Config.Cutscene.enabled then
        local playerName = GetPlayerName(PlayerId())
        StartPolicePhotoCutscene(playerName)
    end
 
    local prisonTypeText = currentPrisonType == "maxima" and "Segurança Máxima" or "prisão"
    TriggerEvent("Notify", "azul", "Você foi preso na " .. prisonTypeText .. "! Vá aos pontos de trabalho para reduzir seu tempo.", 5000)
end)

-- Evento para verificar status da prisão
RegisterNetEvent("fortal_prisao:checkPrisonStatus")
AddEventHandler("fortal_prisao:checkPrisonStatus", function()
    TriggerServerEvent("fortal_prisao:checkPrisonStatus")
end)

-- Evento para forçar sincronização
RegisterNetEvent("fortal_prisao:forceSync")
AddEventHandler("fortal_prisao:forceSync", function()
    TriggerServerEvent("fortal_prisao:forceSync")
end)



-- Evento para sincronizar prisão
RegisterNetEvent("fortal_prisao:syncPrison")
AddEventHandler("fortal_prisao:syncPrison", function(status, teleport)
 
    flx.syncPrison(status, teleport)
end)

-- Evento para atualizar serviços
RegisterNetEvent("fortal_prisao:asyncServices")
AddEventHandler("fortal_prisao:asyncServices", function()
    flx.asyncServices()
end)

function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
exports("checkPrison", function()
    return inPrison
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 999
        if inPrison then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            
            -- Obter locais de serviço baseados no tipo de prisão
            local serviceLocations = currentPrisonType == "maxima" and Config.MaximaServiceLocations or Config.ServiceLocations
            local distance = #(coords - vec3(serviceLocations[inSelect][1], serviceLocations[inSelect][2], serviceLocations[inSelect][3]))

            if distance <= 150 then
                timeDistance = 1
             
                -- Texto baseado no tipo de prisão
                local actionText = currentPrisonType == "maxima" and "TRABALHAR" or "VASCULHAR"
                DrawText3D(serviceLocations[inSelect][1], serviceLocations[inSelect][2], serviceLocations[inSelect][3], "~g~E~w~   " .. actionText)

                -- Explicitamente habilitar INPUT_CONTEXT (tecla E) para garantir que não esteja bloqueado
                EnableControlAction(0, 38, true) -- Grupo 0 (Gameplay), 38 (INPUT_CONTEXT)
                EnableControlAction(1, 38, true) -- Grupo 1 (Armas), 38 (INPUT_CONTEXT)
                EnableControlAction(2, 38, true) -- Grupo 2 (Veículos), 38 (INPUT_CONTEXT)

                if distance <= 1 and GetGameTimer() >= inTimer and IsControlJustPressed(1, 38) and not IsPedInAnyVehicle(ped) then
                  
                    
                    inTimer = GetGameTimer() + Config.Timers.cooldown

                    LocalPlayer["state"]["Cancel"] = true
                    LocalPlayer["state"]["Commands"] = true
                    SetEntityHeading(ped, serviceLocations[inSelect][4])
                    
                    -- Obter animação baseada no tipo de prisão
                    local animationConfig = Config.PrisonAnimations[currentPrisonType] or Config.PrisonAnimations["normal"]
                    flx.playAnim(false, { animationConfig.dict, animationConfig.anim }, true)
                    
                    -- Criar prop se necessário (para segurança máxima - britadeira)
                    if animationConfig.prop and animationConfig.mao then
                        currentProp = CreateObject(GetHashKey(animationConfig.prop), 0, 0, 0, true, true, true)
                        AttachEntityToEntity(currentProp, ped, GetPedBoneIndex(ped, animationConfig.mao), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                    end
                    
                    SetEntityCoords(ped, serviceLocations[inSelect][1], serviceLocations[inSelect][2], serviceLocations[inSelect][3] - 1, 1, 0, 0, 0)

                    -- Aguardar o tempo do serviço, verificando se o prop ainda existe
                    local startTime = GetGameTimer()
                    while GetGameTimer() - startTime < Config.Timers.serviceDuration do
                        Wait(100) -- Verificar a cada 100ms
                        
                        -- Se o prop foi removido externamente, recriar
                        if currentProp and not DoesEntityExist(currentProp) and animationConfig.prop and animationConfig.mao then
                            currentProp = CreateObject(GetHashKey(animationConfig.prop), 0, 0, 0, true, true, true)
                            AttachEntityToEntity(currentProp, ped, GetPedBoneIndex(ped, animationConfig.mao), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                        end
                    end

                    LocalPlayer["state"]["Commands"] = false
                    LocalPlayer["state"]["Cancel"] = false
                    
                    -- Remover prop se foi criado (ANTES de flx.removeObjects)
                    if currentProp and DoesEntityExist(currentProp) then
                        DeleteObject(currentProp)
                        currentProp = nil
                    end
                    
             
                    TriggerServerEvent("fortal_prisao:reducePrison")
                    flx.removeObjects()
                    
              
                    
                    -- Teste: notificar que o serviço foi feito
                    TriggerEvent("Notify", "verde", "Serviço concluído! Reduzindo tempo de prisão.", 3000)
                end
            end

            if GetEntityHealth(ped) <= 100 then
                if not inDeath then
                    timeDeath = GetGameTimer() + Config.Timers.deathTimeout
                    inDeath = true
                else
                    if GetGameTimer() >= timeDeath then
                        flx.revivePlayer(125)
                        inDeath = false
                    end
                end
            end
        end

        Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - RUNAWAY
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 999
        if inPrison then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local leaverCoords
            
            -- Obter coordenadas do ponto de fuga baseado no tipo
            if currentPrisonType == "maxima" then
                leaverCoords = Config.PrisonCoords.maxima.leaver
            else
                leaverCoords = Config.PrisonCoords.leaver
            end
            
            local distance = #(coords - vec3(leaverCoords[1], leaverCoords[2], leaverCoords[3]))

            if distance <= 1.5 then
                timeDistance = 1
                DrawText3D(leaverCoords[1], leaverCoords[2], leaverCoords[3], "~g~E~w~   FUGIR")

                if distance <= 1 and GetGameTimer() >= inTimer and IsControlJustPressed(1, 38) then
                    inTimer = GetGameTimer() + Config.Timers.cooldown

                    if flxs.checkKey() then
                        local rand = math.random(#Config.EscapePoints)
                        SetEntityCoords(ped, Config.EscapePoints[rand][1], Config.EscapePoints[rand][2], Config.EscapePoints[rand][3], 1, 0, 0, 0)
                    end
                end
            end
        end

        Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - PRISON AREA MONITOR
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 1000 -- Verificar a cada segundo
        
        if inPrison then
            -- Verificar se está dentro da área da prisão correta
            if not isPlayerInPrisonArea() then
                teleportBackToPrison()
                timeDistance = 100 -- Aguardar um pouco após teleporte
            end
        end
        
        Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - DEBUG VISUAL (OPCIONAL)
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 0
        
        if Config.Debug then
            drawPrisonArea()
            timeDistance = 0
        else
            timeDistance = 1000
        end
        
        Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - AUTO CHECK PRISON STATUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    Wait(5000)

    TriggerServerEvent("fortal_prisao:checkPrisonStatus")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD - PROP MONITOR
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local timeDistance = 1000
        
        -- Se há um prop ativo, verificar se ainda existe
        if currentProp and not DoesEntityExist(currentProp) then
            currentProp = nil
        end
        
        Wait(timeDistance)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function flx.syncPrison(status, teleport)
    -- Limpar prop se existir
    if currentProp and DoesEntityExist(currentProp) then
        DeleteObject(currentProp)
        currentProp = nil
    end
    
    if teleport then
        if status then
            local coords
            if currentPrisonType == "maxima" then
                coords = Config.PrisonCoords.maxima.internal
            else
                coords = Config.PrisonCoords.internal
            end
            SetEntityCoords(PlayerPedId(), coords[1], coords[2], coords[3], 1, 0, 0, 0)
        else
            local coords
            if currentPrisonType == "maxima" then
                coords = Config.PrisonCoords.maxima.external
            else
                coords = Config.PrisonCoords.external
            end
            SetEntityCoords(PlayerPedId(), coords[1], coords[2], coords[3], 1, 0, 0, 0)
        end
    end

    inPrison = status
    
    if status then
        local serviceLocations = currentPrisonType == "maxima" and Config.MaximaServiceLocations or Config.ServiceLocations
        inSelect = math.random(#serviceLocations)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNCSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function flx.asyncServices()
    local serviceLocations = currentPrisonType == "maxima" and Config.MaximaServiceLocations or Config.ServiceLocations
    inSelect = math.random(#serviceLocations)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)

    if onScreen then
        BeginTextCommandDisplayText("STRING")
        AddTextComponentSubstringKeyboardDisplay(text)
        SetTextColour(255, 255, 255, 150)
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextCentre(1)
        EndTextCommandDisplayText(_x, _y)

        local width = string.len(text) / 160 * 0.45
        DrawRect(_x, _y + 0.0125, width, 0.03, 15, 15, 15, 175)
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CUTSCENE SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
local cutsceneActive = false
local cutsceneCamera = nil
local cutsceneThread = nil

-- Função para iniciar a cutscene de fotografia policial
function StartPolicePhotoCutscene(playerName)
    if not Config.Cutscene.enabled or cutsceneActive then
        print("^3[FORTAL_PRISAO]^7 Cutscene desabilitada ou já ativa")
        return
    end
    
    print("^3[FORTAL_PRISAO]^7 Iniciando cutscene para: " .. (playerName or "Desconhecido"))
    
    cutsceneActive = true
    local ped = PlayerPedId()
    
    -- Aguardar um pouco para garantir que o jogador está estável
    Wait(1000)
    
    -- Teleportar jogador para posição da cutscene
    SetEntityCoords(ped, Config.Cutscene.player.pos[1], Config.Cutscene.player.pos[2], Config.Cutscene.player.pos[3], 1, 0, 0, 0)
    SetEntityHeading(ped, Config.Cutscene.player.heading)
    
    -- Carregar animação
    RequestAnimDict(Config.Cutscene.animation.dict)
    local timeout = 0
    while not HasAnimDictLoaded(Config.Cutscene.animation.dict) and timeout < 100 do
        Wait(100)
        timeout = timeout + 1
    end
    
    if HasAnimDictLoaded(Config.Cutscene.animation.dict) then
        -- Aplicar animação
        TaskPlayAnim(ped, Config.Cutscene.animation.dict, Config.Cutscene.animation.anim, 8.0, -8.0, -1, Config.Cutscene.animation.flag, 0, false, false, false)
        print("^3[FORTAL_PRISAO]^7 Animação aplicada")
    else
        print("^1[FORTAL_PRISAO]^7 Erro ao carregar animação")
    end
    
    -- Aguardar um pouco antes de criar a câmera
    Wait(500)
    
    -- Criar câmera
    cutsceneCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cutsceneCamera, Config.Cutscene.camera.pos[1], Config.Cutscene.camera.pos[2], Config.Cutscene.camera.pos[3])
    SetCamRot(cutsceneCamera, Config.Cutscene.camera.rot[1], Config.Cutscene.camera.rot[2], Config.Cutscene.camera.rot[3], 2)
    SetCamFov(cutsceneCamera, Config.Cutscene.camera.fov)
    SetCamActive(cutsceneCamera, true)
    RenderScriptCams(true, true, 1000, true, true)
    
    print("^3[FORTAL_PRISAO]^7 Câmera criada e ativada")
    
    -- Desabilitar controles
    LocalPlayer["state"]["Cancel"] = true
    LocalPlayer["state"]["Commands"] = true
    
    -- Iniciar thread da cutscene
    cutsceneThread = CreateThread(function()
        local startTime = GetGameTimer()
        local nameplateText = playerName or Config.Cutscene.nameplate.text
        
        print("^3[FORTAL_PRISAO]^7 Thread da cutscene iniciada")
        
        while cutsceneActive and GetGameTimer() - startTime < Config.Cutscene.duration do
            Wait(0)
            
            -- Desabilitar controles durante a cutscene
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
            
            -- Desenhar placa com nome
            if Config.Cutscene.nameplate.enabled then
                DrawNameplate(nameplateText)
            end
            
            -- Verificar se o jogador morreu ou saiu do jogo
            if not DoesEntityExist(ped) or GetEntityHealth(ped) <= 0 then
                print("^1[FORTAL_PRISAO]^7 Jogador morreu durante cutscene")
                break
            end
        end
        
        print("^3[FORTAL_PRISAO]^7 Cutscene finalizada")
        -- Finalizar cutscene
        EndPolicePhotoCutscene()
    end)
    
    -- Notificar início da cutscene
    TriggerEvent("Notify", "azul", "Fotografia policial em andamento...", 3000)
end

-- Função para finalizar a cutscene
function EndPolicePhotoCutscene()
    if not cutsceneActive then
        return
    end
    
    cutsceneActive = false
    
    -- Restaurar câmera
    if cutsceneCamera then
        RenderScriptCams(false, true, 1000, true, true)
        DestroyCam(cutsceneCamera, false)
        cutsceneCamera = nil
    end
    
    -- Restaurar controles
    LocalPlayer["state"]["Cancel"] = false
    LocalPlayer["state"]["Commands"] = false
    
    -- Parar animação
    local ped = PlayerPedId()
    ClearPedTasksImmediately(ped)
    
    -- Notificar fim da cutscene
    TriggerEvent("Notify", "verde", "Fotografia policial concluída!", 3000)
end

-- Função para desenhar a placa com nome
function DrawNameplate(text)
    local screenX, screenY = Config.Cutscene.nameplate.position[1], Config.Cutscene.nameplate.position[2]
    local color = Config.Cutscene.nameplate.color
    local scale = Config.Cutscene.nameplate.scale
    local font = Config.Cutscene.nameplate.font
    
    -- Calcular tamanho aproximado do texto
    local textWidth = GetTextScreenWidth(text, font, scale)
    local textHeight = 0.05 -- Altura fixa aproximada
    
    -- Desenhar fundo da placa (mais escuro e maior)
    DrawRect(screenX, screenY, textWidth + 0.05, textHeight + 0.02, 0, 0, 0, 200)
    
    -- Desenhar borda da placa (mais grossa)
    DrawRect(screenX, screenY - textHeight/2 - 0.01, textWidth + 0.05, 0.005, 255, 255, 255, 255) -- Borda superior
    DrawRect(screenX, screenY + textHeight/2 + 0.01, textWidth + 0.05, 0.005, 255, 255, 255, 255) -- Borda inferior
    DrawRect(screenX - (textWidth + 0.05) / 2, screenY, 0.005, textHeight + 0.02, 255, 255, 255, 255) -- Borda esquerda
    DrawRect(screenX + (textWidth + 0.05) / 2, screenY, 0.005, textHeight + 0.02, 255, 255, 255, 255) -- Borda direita
    
    -- Desenhar texto (mais visível)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(color[1], color[2], color[3], color[4])
    SetTextCentre(true)
    SetTextDropshadow(2, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 255)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(screenX, screenY)
    
    -- Debug: mostrar informações no console
    if Config.Debug then
        print("^3[FORTAL_PRISAO]^7 Desenhando placa: " .. text .. " em " .. screenX .. ", " .. screenY)
    end
end

-- Função para parar a cutscene manualmente (caso necessário)
function StopPolicePhotoCutscene()
    if cutsceneActive then
        EndPolicePhotoCutscene()
    end
end

-- Exportar funções para uso externo
exports("StartPolicePhotoCutscene", StartPolicePhotoCutscene)
exports("StopPolicePhotoCutscene", StopPolicePhotoCutscene)

-- Evento para iniciar cutscene externamente
RegisterNetEvent("fortal_prisao:startCutscene")
AddEventHandler("fortal_prisao:startCutscene", function(playerName)
    StartPolicePhotoCutscene(playerName)
end)

-- Comando para testar a cutscene (apenas para administradores)
RegisterCommand("testcutscene", function(source, args)
    local playerName = args[1] or GetPlayerName(PlayerId())
    print("^3[FORTAL_PRISAO]^7 Testando cutscene com nome: " .. playerName)
    print("^3[FORTAL_PRISAO]^7 Config.Cutscene.enabled: " .. tostring(Config.Cutscene.enabled))
    print("^3[FORTAL_PRISAO]^7 cutsceneActive: " .. tostring(cutsceneActive))
    StartPolicePhotoCutscene(playerName)
end, false)

-- Comando para parar a cutscene
RegisterCommand("stopcutscene", function()
    print("^3[FORTAL_PRISAO]^7 Parando cutscene...")
    StopPolicePhotoCutscene()
end, false)

-- Comando para verificar status da cutscene
RegisterCommand("cutscenestatus", function()
    print("^3[FORTAL_PRISAO]^7 Status da cutscene:")
    print("^3[FORTAL_PRISAO]^7 - Config.Cutscene.enabled: " .. tostring(Config.Cutscene.enabled))
    print("^3[FORTAL_PRISAO]^7 - cutsceneActive: " .. tostring(cutsceneActive))
    print("^3[FORTAL_PRISAO]^7 - cutsceneCamera: " .. tostring(cutsceneCamera ~= nil))
    print("^3[FORTAL_PRISAO]^7 - Duração: " .. Config.Cutscene.duration .. "ms")
end, false)

-- Comando para forçar cutscene (ignora se já está ativa)
RegisterCommand("forcecutscene", function(source, args)
    local playerName = args[1] or GetPlayerName(PlayerId())
    print("^3[FORTAL_PRISAO]^7 Forçando cutscene com nome: " .. playerName)
    
    -- Parar cutscene atual se estiver ativa
    if cutsceneActive then
        EndPolicePhotoCutscene()
        Wait(1000)
    end
    
    -- Iniciar nova cutscene
    StartPolicePhotoCutscene(playerName)
end, false)


