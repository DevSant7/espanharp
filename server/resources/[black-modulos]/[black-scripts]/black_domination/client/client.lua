------------------------------------------------------------------------
-----------------------------[ LIB VRP ]--------------------------------
------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP")
Felp = {} -- adiciona em uma table
Tunnel.bindInterface("black_domination", Felp) -- IRÁ CRIAR UM TUNNEL COM O SERVIDOR
Proxy.addInterface("black_domination", Felp) -- É UM DEPEDENCIA DO TUNNEL
FelpServer = Tunnel.getInterface("black_domination")
------------------------------------------------------------------------
---------------------------[ VARIAVEIS ]--------------------------------
------------------------------------------------------------------------
local DominatedLoc = {}
local blipsCreated = {}
local active = {}
local Fonts = {}
local PLAYER_NAME_HEAP = {}
local SprayScaleSelect = {}
local SPRAYS = {}
local FORBIDDEN_MATERIALS = {[1913209870] = true,[-1595148316] = true,[510490462] = true,[909950165] = true,[-1907520769] = true,[-1136057692] = true,[509508168] = true,[1288448767] = true,[-786060715] = true,[-1931024423] = true,[-1937569590] = true,[-878560889] = true,[1619704960] = true,[1550304810] = true,[951832588] = true,[2128369009] = true,[-356706482] = true,[1925605558] = true,[-1885547121] = true,[-1942898710] = true,[312396330] = true,[1635937914] = true,[-273490167] = true,[1109728704] = true,[223086562] = true,[1584636462] = true,[-461750719] = true,[1333033863] = true,[-1286696947] = true,[-1833527165] = true,[581794674] = true,[-913351839] = true,[-2041329971] = true,[-309121453] = true,[-1915425863] = true,[1429989756] = true,[673696729] = true,[244521486] = true,[435688960] = true,[-634481305] = true,[-1634184340] = true}
local SprayText = ''
local FormattedSprayText = ''
local SprayScaleMin = 60
local SprayScaleMax = 200
local SprayColor = nil
local IsSpraying = false
local IsCancelled = false
local rotCam = nil
local wantedSprayLocation = nil
local wantedSprayRotation = nil
local currentSprayRotation = nil
local currentComputedRotation = vector3(0,0,0)
local lastFormattedText = nil
local LastRayStart = nil
local LastComputedRayEndCoords = nil
local LastComputedRayNormal = nil
local LastError = nil
local Hour = 12
local InAnimation = false
local WaitingToFinish = false
local WaitingToRemove = false -- Nova variável para controlar remoção
local CapRotCamIsRunning = false
local sprayLocation = nil
local TempoParaFinalizar = Config.Global["TimeToDominate"]
local TempoParaRemover = 0 -- Nova variável para tempo de remoção
------------------------------------------------------------------------
-------------------[ REMOVEDOR DE PICHAÇÃO ]----------------------------
------------------------------------------------------------------------
function Felp.tryRemoveSpray()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    if active[ped] then
        return false 
    end
    local CloseDomination = false
    for k, v in pairs(DominatedLoc) do
        local distance = Vdist(coords,DominatedLoc[k]["x"],DominatedLoc[k]["y"],DominatedLoc[k]["z"])
        if distance <= Config.Blips["sizeBlip"] then
            CloseDomination = k
        end
    end
    if not CloseDomination then
        TriggerEvent("Notify", "important","DOMINAÇÃO","Você não está proximo de nenhum lugar de dominação.", "amarelo", 5000)
        return false
    end
    RemoveClosestSpray(CloseDomination)
    return true 
end
------------------------------------------------------------------------
---------------------------[ PICHAR PAREDE ]----------------------------
------------------------------------------------------------------------
function Felp.tryStartDomination()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    if active[ped] then
        return false 
    end

    local DominationLocale = ThisCloseToDomination()

    if not DominationLocale then
        TriggerEvent("Notify", "important","DOMINAÇÃO","Você não pode dominar aqui!", "amarelo", 5000)
        return false 
    end

    if not FelpServer.AlreadyDominated(DominationLocale) then
        TriggerEvent("Notify", "cancel","DOMINAÇÃO","Você precisa utilizar 1x tiner para retirar a dominação desta área.", "vermelho", 5000)
        return false 
    end

    local startHour = Config.Global.Clock.start
    local endHour = Config.Global.Clock.finish
    local gameClock = GetClockHours()

    local isValidTime = false

    if startHour < endHour then
        isValidTime = gameClock >= startHour and gameClock < endHour
    else
        isValidTime = gameClock >= startHour or gameClock < endHour
    end

    if not isValidTime then
        TriggerEvent("Notify", "cancel", "DOMINAÇÃO", "Você só pode dominar entre "..startHour..":00 - "..endHour..":00", "vermelho", 5000)
        return
    end

    local group = FelpServer.GetGroupByUserId()
    if group then
        rotCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        SprayText = group
        ResetFormattedText()
        SprayColor = Config.ColorsGroup[group]["GC"]
        IsSpraying = true

        local canPos = vector3(0.072, 0.041, -0.06)
        local canRot = vector3(33.0, 38.0, 0.0)
        canObj = CreateObject(`ng_proc_spraycan01b`, 0.0, 0.0, 0.0, true, false, false)
        AttachEntityToEntity(canObj, ped, GetPedBoneIndex(ped, 57005), canPos.x, canPos.y, canPos.z, canRot.x, canRot.y, canRot.z, true, true, false, true, 1, true)

        playAnim('anim@scripted@freemode@postertag@graffiti_spray@male@', 'shake_can_male')
        return true 
    end
    TriggerEvent("Notify", "cancel", "Negado", "Voce não esta filiado a nenhuma facção","vermelho", 5000)
end
------------------------------------------------------------------------
----------------[ SISTEMA DE ATUALIZAÇÃO DE BLIPS ]---------------------
------------------------------------------------------------------------
RegisterNetEvent("domination:locs")
AddEventHandler("domination:locs", function(Markes)
    RemoveAllBlips()
    DominatedLoc = Markes
    for key,v in pairs(DominatedLoc) do
        local blip = AddBlipForRadius(tonumber(DominatedLoc[key]["x"]),tonumber(DominatedLoc[key]["y"]),tonumber(DominatedLoc[key]["z"]), Config.Blips["sizeBlip"])
        SetBlipColour(blip, parseInt(DominatedLoc[key]["Color"]))
        SetBlipAlpha(blip, 150)
        blipsCreated[DominatedLoc[key]["Locale"]] = blip
    end
end)
------------------------------------------------------------------------
---------------[ SISTEMA DE ATUALIZAÇÃO DE SPRAYS ]---------------------
------------------------------------------------------------------------
RegisterNetEvent('felp_spray:setSprays')
AddEventHandler('felp_spray:setSprays', function(s)
    SPRAYS = s
    SetSprayTimeCorrectColor()
end)
------------------------------------------------------------------------
-----------------[ DELETAR TODOS OS BLIPS DO MAPA ]---------------------
------------------------------------------------------------------------
function RemoveAllBlips()
    for k,v in pairs(blipsCreated) do
        if DoesBlipExist(v) then
            RemoveBlip(v)
            v = nil
        end
    end
end
------------------------------------------------------------------------
--------------------------[ PISCAR BLIP ]-------------------------------
------------------------------------------------------------------------

local toAlert = false

function BlipAlertInMap(CloseDomination)
    Citizen.CreateThread(function()
        if not blipsCreated[CloseDomination] then
            return
        end
        
        SetBlipColour(blipsCreated[CloseDomination], 1)
        Wait(1000)
        local count = 0
        toAlert = true

        while toAlert do
            if blipsCreated[CloseDomination] then
                count = count + 1
                if (count % 2 == 0) then
                    SetBlipAlpha(blipsCreated[CloseDomination], 180)
                else
                    SetBlipAlpha(blipsCreated[CloseDomination], 100)
                end
            else
                break
            end
            Wait(1000)
        end
        
        -- Restaurar blip ao estado normal
        if blipsCreated[CloseDomination] then
            SetBlipAlpha(blipsCreated[CloseDomination], 150)
            -- Restaurar cor original baseada no status da área
            if DominatedLoc[CloseDomination] then
                SetBlipColour(blipsCreated[CloseDomination], parseInt(DominatedLoc[CloseDomination]["Color"]))
            else
                SetBlipColour(blipsCreated[CloseDomination], Config.Blips["colorNeutral"])
            end
        end
    end) 
end
------------------------------------------------------------------------
-----------------[ OBTER O ID DA ÁREA MAIS PROXIMA ]--------------------
------------------------------------------------------------------------
function ThisCloseToDomination()
    for key, value in pairs(Config.Locales) do
        local x,y,z = table.unpack(value)
        local distance = Vdist(x,y,z,GetEntityCoords(PlayerPedId()))
        if distance <= Config.Blips["sizeBlip"] then
            return key
        end
    end 
    return false
end
------------------------------------------------------------------------
-----------------------[ CARREGAR ANIMAÇÃO ]----------------------------
------------------------------------------------------------------------
function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(100)
    end
end
------------------------------------------------------------------------
------------------------[ FUNÇAO DE ANIMAÇÃO ]--------------------------
------------------------------------------------------------------------
function playAnim(animDict, animName)
    local ped = PlayerPedId()
    LoadAnimDict(animDict)
    TaskPlayAnim(ped, animDict, animName, 5.0, 5.0, -1, 51, 0, false, false, false)
end

function CancellableProgress(time, animDict, animName, flag, finish, cancel, opts)
    print(time)
    InAnimation = true
    IsCancelled = false
    local ped = PlayerPedId()

    if not opts then opts = {} end

    if animDict then
        LoadAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animName, opts.speedIn or 1.0, opts.speedOut or 1.0, -1, 1, 0, 0, 0, 0)
    end
    active[ped] = true


    local timeLeft = time

    while true do
        Wait(0)
        timeLeft = timeLeft - (GetFrameTime() * 1000)

        if timeLeft <= 0 then
            InAnimation = false
            break
        end

        if GetEntityHealth(PlayerPedId()) <= Config.Global["MinimumLife"] then
            IsCancelled = true
            InAnimation = false
            TriggerEvent("Notify", "cancel","DOMINAÇÃO","A dominação foi cancelada!", "vermelho", 5000)
        end

        DisableControlAction(0, Config.Grafite.Keys.CANCEL.code, true)

        if IsControlPressed(0, Config.Grafite.Keys.CANCEL.code) or IsDisabledControlPressed(0, Config.Grafite.Keys.CANCEL.code) then
            IsCancelled = true
            InAnimation = false
        end

        if IsCancelled then
            if animDict then
                ClearPedTasks(ped)
            end

            if cancel then
                cancel()
                return
            end
        end
    end
    
    if animDict then
        StopAnimTask(ped, animDict, animName, 1.0)
    end

    if finish then
        finish()
    end
end
------------------------------------------------------------------------
----------------------------[ SPRAY PREVIEW ]---------------------------
------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeloop = 1500
        local ClosesDomination = ThisCloseToDomination()
        if ClosesDomination then
            timeloop = 0
        end
        local scaleformHandleIdx = 1 
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for _, spray in pairs(SPRAYS) do
            if spray.color and #(coords - spray.location) < 100.0 then
                DrawSpray(PLAYER_NAME_HEAP[scaleformHandleIdx], spray)

                scaleformHandleIdx = scaleformHandleIdx + 1

                if scaleformHandleIdx >= 12 then
                    break
                end
            end
        end
        if WaitingToFinish then
            local minutos, segundosRestantes = segundosParaMinutos(TempoParaFinalizar)
            local TempoLabel = minutos > 0 and (minutos.." minuto(s)") or (segundosRestantes.." segundo(s)")
            
            local drawTxtString = ""
            if minutos > 0 then
                drawTxtString = "Faltam ~b~"..minutos.." ~w~minuto(s) e ~b~"..segundosRestantes.." ~w~segundo(s) para finalizar a dominação."
            else
                drawTxtString = "Faltam ~b~"..segundosRestantes.." ~w~segundo(s) para finalizar a dominação."
            end
            drawTxt(drawTxtString, 0.215,0.94)
        end
        
        -- Cronômetro para remoção com tiner
        if WaitingToRemove then
            local minutos, segundosRestantes = segundosParaMinutos(TempoParaRemover)
            local TempoLabel = minutos > 0 and (minutos.." minuto(s)") or (segundosRestantes.." segundo(s)")
            
            local drawTxtString = ""
            if minutos > 0 then
                drawTxtString = "Faltam ~r~"..minutos.." ~w~minuto(s) e ~r~"..segundosRestantes.." ~w~segundo(s) para remover a dominação."
            else
                drawTxtString = "Faltam ~r~"..segundosRestantes.." ~w~segundo(s) para remover a dominação."
            end
            drawTxt(drawTxtString, 0.215,0.94)
        end
        
        if IsSpraying then
            if not CapRotCamIsRunning then
                InitCapRotCam()
            end
            if not ClosesDomination then
                TriggerEvent("Notify", "important","DOMINAÇÃO","Você se afastou demais da zona permitida!", "amarelo", 5000)
                IsSpraying = false
                SetBlipColour(blipsCreated[ClosesDomination], Config.Blips["colorNeutral"])
            end
            ShowNotification(
            "Pressione ~INPUT_PICKUP~ " .. Config.Grafite.Keys.PICK.Text ..
            "\nPressione F6 " .. Config.Grafite.Keys.CANCEL.Text
            )

            DisableControlAction(0, Config.Grafite.Keys.CANCEL.code, true)

            if IsControlPressed(0, Config.Grafite.Keys.CANCEL.code) or IsDisabledControlPressed(0, Config.Grafite.Keys.CANCEL.code) then
                TriggerEvent("sounds:stop")
                DeleteEntity(canObj)
                IsSpraying = false
            end

            DisableControlAction(0, Config.Grafite.Keys.PICK.code, true)

            if IsControlPressed(0, Config.Grafite.Keys.PICK.code) or IsDisabledControlPressed(0, Config.Grafite.Keys.PICK.code) then
                TriggerEvent("sounds:stop")
                DeleteEntity(canObj)
                PersistSpray()
                IsSpraying = false
                SprayText = ''
            end

            local rayEndCoords, rayNormal, fwdVector = FindRaycastedSprayCoords()
            if rayEndCoords and rayNormal then
                local cIndex = 'color'
                local sprayCoords = rayEndCoords + fwdVector * 0.035

                local isInterior = GetInteriorFromEntity(PlayerPedId()) > 0

                if not isInterior then
                    cIndex = GetTimeColorName()
                end

                print(SprayColor,cIndex)
                DrawSpray(PLAYER_NAME_HEAP[12], {
                    location = sprayCoords,
                    rotation = rayNormal, 
                    scale = (SprayScaleSelect[Config.Grafite.SPRAY_SCALE] / 10.0) * FONTS[Config.Grafite.SPRAY_FONT].sizeMult,
                    text = FormattedSprayText,
                    font = FONTS[Config.Grafite.SPRAY_FONT].font,
                    color = COLORS[SprayColor][cIndex].hex,
                })
            end
        end
        Wait(timeloop)
    end
end)

CreateThread(function()
    while true do 
        local timeDistance = 1000 

        if IsSpraying then
            timeDistance = 9000

            TriggerEvent("sounds:source","balancando",0.5)
        end

        Wait(timeDistance)
    end 
end) 

function segundosParaMinutos(segundos)
    local minutos = math.floor(segundos / 60)
    local segundosRestantes = segundos % 60
    return minutos, segundosRestantes
end
 
function WaitingToFinishDomination() 
    Citizen.CreateThread(function()
        local minutos, segundosRestantes = segundosParaMinutos(TempoParaFinalizar)
        local TempoLabel = minutos > 0 and (minutos.." minuto(s)") or (segundosRestantes.." segundo(s)")
        
        TriggerEvent("Notify", "important", "DOMINAÇÃO", "Você iniciou a invasão, para dominar o local, fique "..TempoLabel.." sem se evadir do local.", "amarelo", 15000)

        while WaitingToFinish do
            local ClosesDomination = ThisCloseToDomination()
            if not ClosesDomination then
                ClearPedTasks(PlayerPedId())
                DeleteObject(canObj)
                isCancelled = true
                TriggerEvent("Notify", "important","DOMINAÇÃO","Você se afastou demais, com isso a dominação foi cancelada!", "amarelo", 5000)
                WaitingToFinish = false
                -- Parar o blip de piscar para todos
                if lastBlipKey then
                    FelpServer.StopBlipAlert(lastBlipKey)
                    lastBlipKey = nil
                end
                break
            end
            
            if GetEntityHealth(PlayerPedId()) <= Config.Global["MinimumLife"] then
                IsCancelled = true
                InAnimation = false
                ClearPedTasks(PlayerPedId())
                DeleteObject(canObj)
                isCancelled = true
                TriggerEvent("Notify", "cancel","DOMINAÇÃO","A dominação foi cancelada devido a danos!", "vermelho", 5000)
                WaitingToFinish = false
                -- Parar o blip de piscar para todos
                if ClosesDomination then
                    FelpServer.StopBlipAlert(ClosesDomination)
                end
                break
            end
            
            TempoParaFinalizar = TempoParaFinalizar - 1
            if TempoParaFinalizar <= 0 then
                local ClosesDomination = ThisCloseToDomination()
                if ClosesDomination then
                    WaitingToFinish = false
                    TempoParaFinalizar = Config.Global["TimeToDominate"]
                    FelpServer.InitDomination(ClosesDomination,{
                        location = sprayLocation,
                        realRotation = currentComputedRotation,
                        scale = (SprayScaleSelect[Config.Grafite.SPRAY_SCALE] / 10.0) * FONTS[Config.Grafite.SPRAY_FONT].sizeMult,
                        text = FormattedSprayText,
                        font = FONTS[Config.Grafite.SPRAY_FONT].font,
                        originalColor = SprayColor,
                        interior = GetInteriorFromEntity(PlayerPedId()) > 0
                    })
                    ClearPedTasks(PlayerPedId())
                    DeleteObject(canObj)
                    isCancelled = true
                    TriggerEvent("Notify", "important","DOMINAÇÃO","A dominação foi concluída, já pode sair dessa área!", "amarelo", 5000)
                    -- Parar o blip de piscar para todos
                    FelpServer.StopBlipAlert(ClosesDomination)
                end
            end
            Wait(1000)
        end
    end)
end

------------------------------------------------------------------------
-------------------[ CRONÔMETRO PARA REMOÇÃO ]--------------------------
------------------------------------------------------------------------
function WaitingToFinishRemoval(CloseDomination) 
    Citizen.CreateThread(function()
        local minutos, segundosRestantes = segundosParaMinutos(TempoParaRemover)
        local TempoLabel = minutos > 0 and (minutos.." minuto(s)") or (segundosRestantes.." segundo(s)")
        
        TriggerEvent("Notify", "important", "REMOÇÃO", "Você iniciou a remoção, para remover a dominação, fique "..TempoLabel.." sem se evadir do local.", "amarelo", 15000)

        while WaitingToRemove do
            local ClosesDomination = ThisCloseToDomination()
            if not ClosesDomination then
                ClearPedTasks(PlayerPedId())
                isCancelled = true
                TriggerEvent("Notify", "important","REMOÇÃO","Você se afastou demais, com isso a remoção foi cancelada!", "amarelo", 5000)
                WaitingToRemove = false
                -- Parar o blip de piscar para todos
                FelpServer.StopBlipAlert(CloseDomination)
                break
            end
            
            if GetEntityHealth(PlayerPedId()) <= Config.Global["MinimumLife"] then
                IsCancelled = true
                InAnimation = false
                ClearPedTasks(PlayerPedId())
                isCancelled = true
                TriggerEvent("Notify", "cancel","REMOÇÃO","A remoção foi cancelada devido a danos!", "vermelho", 5000)
                WaitingToRemove = false
                -- Parar o blip de piscar para todos
                FelpServer.StopBlipAlert(CloseDomination)
                break
            end
            
            TempoParaRemover = TempoParaRemover - 1
            if TempoParaRemover <= 0 then
                WaitingToRemove = false
                TempoParaRemover = 0
                -- A remoção será finalizada pela função CancellableProgress
                break
            end
            Wait(1000)
        end
    end)
end

------------------------------------------------------------------------
-------------------[ CAPTURA DE ROTAÇÃO DA CAMERA ]---------------------
------------------------------------------------------------------------
function InitCapRotCam()
    Citizen.CreateThread(function()
        local ttl = 30
        CapRotCamIsRunning = true
        while true do
            if wantedSprayLocation and wantedSprayRotation and IsSpraying then
                if ttl >= 0 then
                    ttl = ttl - 1
                end
                
                if not currentSprayRotation or currentSprayRotation ~= wantedSprayRotation or ttl < 0 then
                    ttl = 30
                    local wantedSprayRotationFixed = vector3(wantedSprayRotation.x, wantedSprayRotation.y, wantedSprayRotation.z + 0.03)
    
                    local camRot = GetRotationThruCamera(wantedSprayLocation, wantedSprayRotationFixed)
                    currentSprayRotation = wantedSprayRotation
                    currentComputedRotation = camRot
                end
            else
                CapRotCamIsRunning = false
                break
            end
            Wait(0)
        end
    end)
end

function GetRotationThruCamera(location, normal)
    local camLookPosition = location - normal * 10
    SetCamCoord(rotCam,  location.x, location.y, location.z)
    
    PointCamAtCoord(rotCam, camLookPosition.x, camLookPosition.y, camLookPosition.z)
    
    SetCamActive(rotCam, true)
    Wait(0)
    local rot =  GetCamRot(rotCam, 2)
    SetCamActive(rotCam, false)
    return rot
end
------------------------------------------------------------------------
--------------------[ DESENHAR PICHAÇÃO NA PAREDE ]---------------------
------------------------------------------------------------------------
function DrawSpray(scaleformHandle, sprayData, meth)
    if scaleformHandle and HasScaleformMovieLoaded(scaleformHandle) then
        if not IsPauseMenuActive() then
            PushScaleformMovieFunction(scaleformHandle, "SET_PLAYER_NAME")
            PushScaleformMovieFunctionParameterString("<FONT color='#" .. sprayData.color .. "' FACE='" .. sprayData.font .. "'>" .. sprayData.text)
            PopScaleformMovieFunctionVoid()

            if not sprayData.realRotation then
                wantedSprayLocation = sprayData.location
                wantedSprayRotation = sprayData.rotation
            end

            DrawScaleformMovie_3dNonAdditive(scaleformHandle,sprayData.location, sprayData.realRotation or currentComputedRotation, 1.0, 1.0, 1.0, sprayData.scale, sprayData.scale, 1.0, 2 )
        end
    end
end
------------------------------------------------------------------------
--------------------[ CARREGAR PICHAÇÃO NA PAREDE ]---------------------
------------------------------------------------------------------------
function LoadAllSprayScaleforms()
    for i = 1, 12 do
        Wait(0)
        local paddedI = i

        if paddedI < 10 then
            paddedI = "0" .. paddedI
        end

        if not PLAYER_NAME_HEAP[i] or not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i]) then
            PLAYER_NAME_HEAP[i] = RequestScaleformMovieInteractive("PLAYER_NAME_" .. paddedI)
            while not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i]) do Wait(0) end
        end
    end
end

for idx, f in pairs(FONTS) do
    Fonts[idx] = f.label
end

for i = SprayScaleMin, SprayScaleMax, 5 do
    table.insert(SprayScaleSelect, i)
end
------------------------------------------------------------------------
---------------------[ FORMATAR TEXTO DA PICHAÇÃO ]---------------------
------------------------------------------------------------------------
function ResetFormattedText()
    local tmp = SprayText

    if tmp ~= lastFormattedText then
        lastFormattedText = tmp
        if FONTS[Config.Grafite.SPRAY_FONT].forceUppercase then
            tmp = tmp:upper()
        end

        FormattedSprayText = RemoveDisallowedCharacters(tmp, FONTS[Config.Grafite.SPRAY_FONT].allowedInverse)
    end
end
------------------------------------------------------------------------
--------------------------[ PICHAR PAREDE ]-----------------------------
------------------------------------------------------------------------
function PersistSpray()
    IsSpraying = false
        
    local rayEndCoords, rayNormal, sprayFwdVector = FindRaycastedSprayCoords()
    if rayEndCoords and rayNormal then
        sprayLocation = rayEndCoords + sprayFwdVector * 0.035
        local ped = PlayerPedId()
        local x, y, z = table.unpack(sprayLocation)

        ClearPedTasks(ped)

        local canPos = vector3(0.072, 0.041, -0.06)
        local canRot = vector3(33.0, 38.0, 0.0)
    
        canObj = CreateObject(`ng_proc_spraycan01b`, 0.0, 0.0, 0.0, true, false, false)
        AttachEntityToEntity(canObj, ped, GetPedBoneIndex(ped, 57005), canPos.x, canPos.y, canPos.z, canRot.x, canRot.y, canRot.z, true, true, false, true, 1, true)
        local isCancelled = false

        Citizen.CreateThread(function()
            Wait(2000)
            while not isCancelled do
                SprayEffects()
                Wait(5000)
            end
        end)
        TriggerEvent("sounds:source","pixando",0.5)
        
        -- Notificar o servidor que começou a pichar para fazer o blip piscar para todos
        local ClosesDomination = ThisCloseToDomination()
        if ClosesDomination then
            FelpServer.StartBlipAlert(ClosesDomination)
        end
        
        CancellableProgress(
            Config.Grafite.SPRAY_PROGRESSBAR_DURATION, 
            'anim@scripted@freemode@postertag@graffiti_spray@male@', 
            'spray_can_var_01_male', 
            16,
            function() -- Se tudo der certo
                DeleteObject(canObj)
                local ClosesDomination = ThisCloseToDomination()
                if ClosesDomination then
                    isCancelled = true 
                    WaitingToFinish = true
                    lastBlipKey = ClosesDomination
                    WaitingToFinishDomination()
                end
                InAnimation = false
                active[ped] = nil
            end,
            function() -- Se for cancelado no meio da animação
                ClearPedTasks(ped)
                DeleteObject(canObj)
                isCancelled = true
                InAnimation = false
                active[ped] = nil
                -- Parar o blip de piscar para todos se cancelar
                local ClosesDomination = ThisCloseToDomination()
                if ClosesDomination then
                    FelpServer.StopBlipAlert(ClosesDomination)
                end
            end
        )
    end
end
------------------------------------------------------------------------
------------------------[ EFEITO DE "FUMAÇA" ]--------------------------
------------------------------------------------------------------------
function SprayEffects()
    local dict = "scr_recartheft"
    local name = "scr_wheel_burnout"
    
    local ped = PlayerPedId()
    local fwd = GetEntityForwardVector(ped)
    local coords = GetEntityCoords(ped) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)

	RequestNamedPtfxAsset(dict)
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
	end

	local pointers = {}
    
    local color = COLORS[SprayColor]['color'].rgb

    local heading = GetEntityHeading(ped)

    UseParticleFxAssetNextCall(dict)
    SetParticleFxNonLoopedColour(color[1] / 255, color[2] / 255, color[3] / 255)
    SetParticleFxNonLoopedAlpha(1.0)
    local ptr = StartNetworkedParticleFxNonLoopedAtCoord(name, coords.x, coords.y, coords.z + 2.0, 0.0, 0.0, heading, 0.7, 0.0, 0.0, 0.0)
    RemoveNamedPtfxAsset(dict)
end

function RemoveDisallowedCharacters(str, inverse)
    local replaced, _ = str:gsub(inverse, '')

    return replaced
end

function scale(v, s)
    return vector3(v.x * s, v.y * s, v.z * s)
end

-- Johnson–Trotter permutations generator
_JT={}
function JT(dim)
  local n={ values={}, positions={}, directions={}, sign=1 }
  setmetatable(n,{__index=_JT})
  for i=1,dim do
    n.values[i]=i
    n.positions[i]=i
    n.directions[i]=-1
  end
  return n
end
 
function _JT:largestMobile()
  for i=#self.values,1,-1 do
    local loc=self.positions[i]+self.directions[i]
    if loc >= 1 and loc <= #self.values and self.values[loc] < i then
      return i
    end
  end
  return 0
end
 
function _JT:next()
  local r=self:largestMobile()
  if r==0 then return false end
  local rloc=self.positions[r]
  local lloc=rloc+self.directions[r]
  local l=self.values[lloc]
  self.values[lloc],self.values[rloc] = self.values[rloc],self.values[lloc]
  self.positions[l],self.positions[r] = self.positions[r],self.positions[l]
  self.sign=-self.sign
  for i=r+1,#self.directions do self.directions[i]=-self.directions[i] end
  return true
end  
 
-- matrix class
 
_MTX={}
function MTX(matrix)
  setmetatable(matrix,{__index=_MTX})
  matrix.rows=#matrix
  matrix.cols=#matrix[1]
  return matrix
end
 
function _MTX:dump()
  for _,r in ipairs(self) do
    print(unpack(r))
  end
end
 
function _MTX:perm() return self:det(1) end
function _MTX:det(perm)
  local det=0
  local jt=JT(self.cols)
  repeat
    local pi=perm or jt.sign
    for i,v in ipairs(jt.values) do
      pi=pi*self[i][v]
    end
    det=det+pi
  until not jt:next()
  return det
end
 
function IsOnPlane(a,b,c,d,e,f)
  local det1 = MTX{
      {a.x, b.x, c.x, d.x},
      {a.y, b.y, c.y, d.y},
      {a.z, b.z, c.z, d.z},
      {1  , 1  , 1  , 1  , 1  },
  }
  
  local det2 = MTX{
      {a.x, c.x, e.x, f.x},
      {a.y, c.y, e.y, f.y},
      {a.z, c.z, e.z, f.z},
      {1  , 1  , 1  , 1  , 1  },
  }
  

  return math.abs(det1:det()) < 0.1 and math.abs(det2:det()) < 0.1
end

-- Evento para fazer o blip piscar para todos os jogadores
RegisterNetEvent("domination:startBlipAlert")
AddEventHandler("domination:startBlipAlert", function(dominationArea)
    if blipsCreated[dominationArea] then
        toAlert = true
        BlipAlertInMap(dominationArea)
    end
end)

-- Evento para parar o blip de piscar para todos os jogadores
RegisterNetEvent("domination:stopBlipAlert")
AddEventHandler("domination:stopBlipAlert", function(dominationArea)
    toAlert = false
end)

Citizen.CreateThread(function()
    Wait(100)

    for _, fontData in pairs(FONTS) do
        RegisterFontFile(fontData.font)
        RegisterFontId(fontData.font)
    end
end)


function FindRaycastedSprayCoords()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)

    local rayStart = cameraCoord
    local rayDirection = direction

    if not LastRayStart or not LastRayDirection or ((not LastComputedRayEndCoords or not LastComputedRayNormal) and not LastError) or rayStart ~= LastRayStart or rayDirection ~= LastRayDirection then
        LastRayStart = rayStart
        LastRayDirection = rayDirection

        local result, error, rayEndCoords, rayNormal = FindRaycastedSprayCoordsNotCached(ped, coords, rayStart, rayDirection)
        if result then
            if LastSubtitleText then
                LastSubtitleText = nil
                ClearPrints()
            end

            LastComputedRayEndCoords = rayEndCoords
            LastComputedRayNormal = rayNormal
            LastError = nil

            return LastComputedRayEndCoords, LastComputedRayNormal, LastComputedRayNormal
        else
            LastComputedRayEndCoords = nil
            LastComputedRayNormal = nil
            LastError = error
            DrawSubtitleText(error)
            Wait(1000)
        end
    else
        return LastComputedRayEndCoords, LastComputedRayNormal, LastComputedRayNormal
    end
end


function FindRaycastedSprayCoordsNotCached(ped, coords, rayStart, rayDirection)
    local rayHit, rayEndCoords, rayNormal, materialHash = CheckRay(ped, rayStart, rayDirection)
    local ray2Hit, ray2EndCoords, ray2Normal, _ = CheckRay(ped, rayStart + vector3(0.0, 0.0, 0.2), rayDirection)
    local ray3Hit, ray3EndCoords, ray3Normal, _ = CheckRay(ped, rayStart + vector3(1.0, 0.0, 0.0), rayDirection)
    local ray4Hit, ray4EndCoords, ray4Normal, _ = CheckRay(ped, rayStart + vector3(-1.0, 0.0, 0.0), rayDirection)
    local ray5Hit, ray5EndCoords, ray5Normal, _ = CheckRay(ped, rayStart + vector3(0.0, 1.0, 0.0), rayDirection)
    local ray6Hit, ray6EndCoords, ray6Normal, _ = CheckRay(ped, rayStart + vector3(0.0, -1.0, 0.0), rayDirection)

    local isOnGround = ray2Normal.z > 0.9

    if not isOnGround and rayHit and ray2Hit and ray3Hit and ray4Hit and ray5Hit and ray6Hit then
        if not FORBIDDEN_MATERIALS[materialHash] then
            if #(coords - rayEndCoords) < Config.Grafite.DISTANCE_AT_WALL then
                if (IsNormalSame(rayNormal, ray2Normal)
                and IsNormalSame(rayNormal, ray3Normal)
                and IsNormalSame(rayNormal, ray4Normal)
                and IsNormalSame(rayNormal, ray5Normal)
                and IsNormalSame(rayNormal, ray6Normal)
                and IsOnPlane(rayEndCoords, ray2EndCoords, ray3EndCoords, ray4EndCoords, ray5EndCoords, ray6EndCoords)) then
                    return true, '', rayEndCoords, rayNormal, rayNormal
                else
                    return false, Config.Grafite.Text.SPRAY_ERRORS.NOT_FLAT
                end
            else 
                return false, Config.Grafite.Text.SPRAY_ERRORS.TOO_FAR
            end
        else
            return false, Config.Grafite.Text.SPRAY_ERRORS.INVALID_SURFACE
        end
    else
        return false, Config.Grafite.Text.SPRAY_ERRORS.AIM
    end
end

LastSubtitleText = nil
function DrawSubtitleText(text)
    if text ~= LastSubtitleText then
        LastSubtitleText = text
        TriggerEvent("Notify", "cancel","DOMINAÇÃO",text, "vermelho", 5000)
    end
end

function RotationToDirection(rotation)
    local adjustedRotation = { x = (math.pi / 180) * rotation.x, y = (math.pi / 180) * rotation.y, z = (math.pi / 180) * rotation.z }
    return vector3(-math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), math.sin(adjustedRotation.x))
end


function CheckRay(ped, coords, direction)
    local rayEndPoint = coords + direction * 1000.0

    local rayHandle = StartShapeTestRay(coords.x, coords.y, coords.z, rayEndPoint.x, rayEndPoint.y, rayEndPoint.z, 1, ped)

    local retval, hit, endCoords, surfaceNormal, materialHash,entityHit = GetShapeTestResultEx(rayHandle)

    return hit == 1, endCoords, surfaceNormal, materialHash
end

function IsNormalSame(norm1, norm2)
    local xDist = math.abs(norm1.x - norm2.x)
    local yDist = math.abs(norm1.y - norm2.y)
    local zDist = math.abs(norm1.z - norm2.z)

    return xDist < 0.01 and yDist < 0.01 and zDist < 0.01
end

function RemoveClosestSpray(CloseDomination)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local closestSprayLoc = nil
    local closestSprayDist = nil

    local dist = 'timetable@maid@cleaning_window@idle_a'
    local name = 'idle_a'

    for _, spray in pairs(SPRAYS) do
        local sprayPos = spray.location
        local dist = #(sprayPos - coords)

        if dist < 3.0 and (not closestSprayDist or closestSprayDist > dist) then
            closestSprayLoc = sprayPos
            closestSprayDist = dist
        end
    end

    if closestSprayLoc then
        -- Fazer o blip piscar para todos quando usar tiner
        FelpServer.StartBlipAlert(CloseDomination)
        FelpServer.notifyDomination(CloseDomination,"Seu território está sendo dominado pela facção inimiga.")

        local x, y, z = table.unpack(closestSprayLoc)

        local dstCheck = GetDistanceBetweenCoords(GetEntityCoords(ped), x, y, z, true)

        local wait = dstCheck * 1000

        TaskWanderInArea(ped, x, y, z, 0.0, 0.0, 1.0)
        Wait(wait+50)
        ClearPedTasks(ped)
        local ragProp = CreateSprayRemoveProp(ped)
        
        -- Definir tempo de remoção e iniciar cronômetro
        TempoParaRemover = math.floor(Config.Grafite.SPRAY_REMOVE_DURATION / 1000) -- Converter de ms para segundos
        WaitingToRemove = true
        WaitingToFinishRemoval(CloseDomination)
        
        CancellableProgress(
            Config.Grafite.SPRAY_REMOVE_DURATION, 
            dist, 
            name, 
            1,
            function() -- Se tudo der certo
                DominatedLoc[CloseDomination] = {}
                RemoveSprayRemoveProp(ragProp)
                FelpServer.ResetDominationArea(CloseDomination)
                FelpServer.notifyDomination(CloseDomination,"Seu território foi dominado.")
                isCancelled = true
                InAnimation = false
                WaitingToRemove = false
                Wait(50)
                active[ped] = nil
                -- Parar o blip de piscar para todos
                FelpServer.StopBlipAlert(CloseDomination)
            end, 
            function() -- Se for cancelado no meio da animação
                ClearPedTasks(ped)
                RemoveSprayRemoveProp(ragProp)
                isCancelled = true
                InAnimation = false
                WaitingToRemove = false
                active[ped] = nil
                -- Parar o blip de piscar para todos se cancelar
                FelpServer.StopBlipAlert(CloseDomination)
            end
        )
    else
        TriggerEvent("Notify", "cancel","DOMINAÇÃO",Config.Grafite.Text.NO_SPRAY_NEARBY, "vermelho", 5000)
    end
end


function CreateSprayRemoveProp(ped)
    local ragProp = CreateObject(`p_loose_rag_01_s`, 0.0, 0.0, 0.0,true, false, false)

    AttachEntityToEntity(ragProp, ped, GetPedBoneIndex(ped, 28422), x, y, z, ax, ay, az, true, true, false, true, 1, true)
    return ragProp
end

function RemoveSprayRemoveProp(ent)
    DeleteEntity(ent)
end

function GetTimeColorName()
    if Hour <= 5 or Hour >= 21 then
        return 'colorDarkest'
    end

    if Hour <= 7 or Hour >= 19 then
        return 'colorDarker'
    end

    return 'color'
end

function SetSprayTimeCorrectColor()
    for _, spray in pairs(SPRAYS) do

        local cIndex = 'color'

        if not spray.interior then
            cIndex = GetTimeColorName()
        end
        if spray.originalColor ~= 0 then
            spray.color = COLORS[spray.originalColor][cIndex].hex
        end
        Wait(0)
    end
end

Citizen.CreateThread(function()
    while true do
        Hour = GetClockHours()
        SetSprayTimeCorrectColor()
        LoadAllSprayScaleforms()
		Wait(5000)
    end
end)

function ShowNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, 50)
end

function drawTxt(text,x,y)
	local res_x, res_y = GetActiveScreenResolution()
	SetTextFont(4)
	SetTextScale(0.5,0.5)
	SetTextColour(255,255,255,255)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	if res_x >= 2000 then
		DrawText(x+0.076,y)
	else
		DrawText(x,y)
	end
end
