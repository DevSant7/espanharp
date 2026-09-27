local isUIOpen = false
local tabletProp = nil

local tabletConfig = {
    dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base",
    anim = "base", 
    prop = "prop_cs_tablet",
    flag = 50,
    mao = 28422
}

function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function createObjects(dict, anim, prop, flag, mao)
    local ped = PlayerPedId()
    LoadAnimDict(dict)
    
    TaskPlayAnim(ped, dict, anim, 3.0, 3.0, -1, flag, 0, false, false, false)

    local coords = GetEntityCoords(ped)
    local object = CreateObject(GetHashKey(prop), coords.x, coords.y, coords.z + 0.2, true, true, true)
    
    AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, mao), 0.03, 0.002, -0.02, 10.0, 160.0, 0.0, true, true, false, true, 1, true)

    return object
end

function removeObjects(object)
    if object and DoesEntityExist(object) then
        DeleteEntity(object)
    end
end

function stopAnimation()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
end

function ToggleUI()
    isUIOpen = not isUIOpen
    SetNuiFocus(isUIOpen, isUIOpen)

    if isUIOpen then
        tabletProp = createObjects(tabletConfig.dict, tabletConfig.anim, tabletConfig.prop, tabletConfig.flag, tabletConfig.mao)
        
        SendNUIMessage({
            action = 'setVisibility',
            data = '/panel'
        })

        SendNUIMessage({
            action = 'setColor',
            data = '42, 82, 242'
        })
    else
        stopAnimation()
        removeObjects(tabletProp)
        tabletProp = nil
        
        SendNUIMessage({
            action = 'setVisibility',
            data = nil
        })
    end
end

RegisterNUICallback('checkPanelPermission', function(data, cb)
    TriggerServerEvent('fortal_dip:checkPanelPermission')

    local received = false
    local function onReceive(hasPermission)
        if not received then
            received = true
            cb({hasPermission = hasPermission})
        end
    end
    
    -- Registrar temporariamente para este callback
    RegisterNetEvent('fortal_dip:panelPermissionResult', onReceive)
    
    Citizen.SetTimeout(3000, function()
        if not received then
            received = true
            cb({hasPermission = false})
        end
    end)
end)

-- Evento para fechar o painel da polícia
RegisterNetEvent('fortal_dip:closePanel')
AddEventHandler('fortal_dip:closePanel', function()
    isUIOpen = false
    SetNuiFocus(false, false)
    
    if tabletProp then
        stopAnimation()
        removeObjects(tabletProp)
        tabletProp = nil
    end
    
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
end)

RegisterCommand(Config.Command, function()
    TriggerServerEvent('fortal_dip:checkPanelPermission')
    
    local received = false
    
    local function onReceive(hasPermission)
        if not received then
            received = true
         
            if hasPermission then
                ToggleUI()
            else
                TriggerEvent('Notify', 'negado', 'Você não tem permissão para acessar o painel do DIP!')
            end
        end
    end
    
    -- Registrar temporariamente para este comando
    RegisterNetEvent('fortal_dip:panelPermissionResult', onReceive)

    Citizen.SetTimeout(3000, function()
        if not received then
            received = true
            TriggerEvent('Notify', 'negado', 'Erro ao verificar permissão!')
        end
    end)
end)

-- Evento para abrir o painel via item
RegisterNetEvent('fortal_dip:openPanel')
AddEventHandler('fortal_dip:openPanel', function()
    TriggerServerEvent('fortal_dip:checkPanelPermission')
    
    local received = false
    
    local function onReceive(hasPermission)
        if not received then
            received = true
         
            if hasPermission then
                ToggleUI()
            else
                TriggerEvent('Notify', 'negado', 'Você não tem permissão para acessar o painel do DIP!')
            end
        end
    end
    
    -- Registrar temporariamente para este evento
    RegisterNetEvent('fortal_dip:panelPermissionResult', onReceive)

    Citizen.SetTimeout(3000, function()
        if not received then
            received = true
            TriggerEvent('Notify', 'negado', 'Erro ao verificar permissão!')
        end
    end)
end)



RegisterNUICallback('nuiReady', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('removeFocus', function(data, cb)
    isUIOpen = false
    SetNuiFocus(false, false)
    
    stopAnimation()
    removeObjects(tabletProp)
    tabletProp = nil
    
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
    cb('ok')
end)

RegisterNUICallback('getPlayers', function(data, cb)
    TriggerServerEvent('fortal_dip:getPlayers')
    
    local received = false
    
    local function onReceive(players)
        if not received then
            received = true
            cb(players or {})
        end
    end

    RegisterNetEvent('fortal_dip:receiveData:getPlayers', onReceive)
  
    Citizen.SetTimeout(15000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getPlayerData', function(data, cb)
    if data and data.playerId then
        TriggerServerEvent('fortal_dip:getPlayerData', data.playerId)

        local received = false
        
        local function onReceive(playerData)
            if not received then
                received = true
                cb(playerData or {})
            end
        end
        
        RegisterNetEvent('fortal_dip:receiveData:getPlayerData', onReceive)
        
        Citizen.SetTimeout(3000, function()
            if not received then
                received = true
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNUICallback('getWarns', function(data, cb)
    TriggerServerEvent('fortal_dip:getWarns')
    
    local received = false
    
    local function onReceive(warns)
        if not received then
            received = true
            cb(warns or {})
        end
    end
    
    RegisterNetEvent('fortal_dip:receiveData:getWarns', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getStatistics', function(data, cb)
    TriggerServerEvent('fortal_dip:getStatistics')

    local received = false
    
    local function onReceive(statistics)
        if not received then
            received = true
            cb(statistics or {})
        end
    end

    RegisterNetEvent('fortal_dip:receiveData:getStatistics', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(10000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('createAnnounce', function(data, cb)
    if data and data.title and data.message then
        TriggerServerEvent('fortal_dip:createAnnounce', data)
        
        local received = false
        
        local function onReceive(newWarn)
            if not received then
                received = true
                cb(newWarn or {})
            end
        end
        
        -- Registrar handler temporário
        RegisterNetEvent('fortal_dip:receiveData:createAnnounce', onReceive)
        
        Citizen.SetTimeout(5000, function()
            if not received then
                received = true
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNUICallback('getOptions', function(data, cb)
    TriggerServerEvent('fortal_dip:getOptions')
    
    local received = false
    
    local function onReceive(options)
        if not received then
            received = true
            cb(options or {suspect = {}, infractions = {}})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_dip:receiveData:getOptions', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({suspect = {}, infractions = {}})
        end
    end)
end)

RegisterNUICallback('getOptionsFine', function(data, cb)
    TriggerServerEvent('fortal_dip:getOptionsFine')
    
    local received = false
    
    local function onReceive(options)
        if not received then
            received = true
            cb(options or {suspect = {}, infractions = {}})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_dip:receiveData:getOptions', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({suspect = {}, infractions = {}})
        end
    end)
end)

RegisterNUICallback('getMembers', function(data, cb)
    TriggerServerEvent('fortal_dip:getMembers')
    
    local received = false
    
    local function onReceive(members)
        if not received then
            received = true
            cb(members or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_dip:receiveData:getMembers', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

-- Callbacks com dados mockados para evitar erros
RegisterNUICallback('getOptionsOccurrence', function(data, cb)
    TriggerServerEvent('fortal_dip:getOptionsOccurrence')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(options)
        if not received then
            received = true
            cb(options or {applicant = {}, suspects = {}})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_dip:receiveData:getOptionsOccurrence', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({applicant = {}, suspects = {}})
        end
    end)
end)

RegisterNUICallback('getOccurrences', function(data, cb)
    TriggerServerEvent('fortal_dip:getOccurrences')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(occurrences)
        if not received then
            received = true
            cb(occurrences or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_dip:receiveData:getOccurrences', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getWantedUsers', function(data, cb)
    TriggerServerEvent('fortal_dip:getWantedUsers')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(wantedUsers)
        if not received then
            received = true
            cb(wantedUsers or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_dip:receiveData:getWantedUsers', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getWantedVehicles', function(data, cb)
    TriggerServerEvent('fortal_dip:getWantedVehicles')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(wantedVehicles)
        if not received then
            received = true
            cb(wantedVehicles or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_dip:receiveData:getWantedVehicles', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

-- Callbacks de ação
RegisterNUICallback('confirmPrison', function(data, cb)
    if data and data.users then
        TriggerServerEvent('fortal_dip:confirmPrison', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'prison'
        })
        
        -- Limpar seleções
        SendNUIMessage({
            action = 'clearSelections',
            data = {
                suspects = {},
                infractions = {}
            }
        })
    end
    cb('ok')
end)

RegisterNUICallback('confirmFine', function(data, cb)
    if data and data.users then
        TriggerServerEvent('fortal_dip:confirmFine', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'fine'
        })
        
        -- Limpar seleções
        SendNUIMessage({
            action = 'clearSelections',
            data = {
                suspects = {},
                infractions = {}
            }
        })
    end
    cb('ok')
end)

RegisterNUICallback('applyFine', function(data, cb)
    if data and data.users then
        TriggerServerEvent('fortal_dip:applyFine', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'applyFine'
        })
        
        -- Limpar seleções
        SendNUIMessage({
            action = 'clearSelections',
            data = {
                suspects = {},
                infractions = {}
            }
        })
    end
    cb('ok')
end)

RegisterNUICallback('confirmOccurrence', function(data, cb)
    if data and data.type and data.description then
        TriggerServerEvent('fortal_dip:createOccurrence', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'occurrence'
        })
    end
    cb('ok')
end)

RegisterNUICallback('confirmWantedUser', function(data, cb)
    if data and data.name and data.description and data.lastSeen and data.location then
        TriggerServerEvent('fortal_dip:addWantedUser', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'wantedUser'
        })
    end
    cb('ok')
end)

RegisterNUICallback('addWantedUser', function(data, cb)
    if data and data.name and data.description and data.lastSeen and data.location then
        TriggerServerEvent('fortal_dip:addWantedUser', data)
    end
    cb('ok')
end)

RegisterNUICallback('confirmWantedVehicle', function(data, cb)
    if data and data.model and data.specifications and data.lastSeen and data.location then
        TriggerServerEvent('fortal_dip:addWantedVehicle', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'wantedVehicle'
        })
    end
    cb('ok')
end)

RegisterNUICallback('addWantedVehicle', function(data, cb)
    if data and data.model and data.specifications and data.lastSeen and data.location then
        TriggerServerEvent('fortal_dip:addWantedVehicle', data)
    end
    cb('ok')
end)

RegisterNUICallback('removeWantedUser', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_dip:removeWantedUser', data)
    end
    cb('ok')
end)

RegisterNUICallback('removeWantedVehicle', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_dip:removeWantedVehicle', data)
    end
    cb('ok')
end)

RegisterNUICallback('addMember', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_dip:addMember', data)
    end
    cb('ok')
end)

RegisterNUICallback('hireMember', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_dip:hireMember', data)
    end
    cb('ok')
end)

RegisterNUICallback('leaveOrg', function(data, cb)
    TriggerServerEvent('fortal_dip:leaveOrg')
    cb('ok')
end)

RegisterNUICallback('deleteWarn', function(data, cb)
    cb('ok')
end)

-- Callbacks adicionais
RegisterNUICallback('watchPlayer', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('promotePlayer', function(data, cb)
    if data and data.id and data.rank then
        TriggerServerEvent('fortal_dip:promotePlayer', data)
    end

    cb('ok')
end)

RegisterNUICallback('demotePlayer', function(data, cb)
    if data and data.id and data.rank then
        TriggerServerEvent('fortal_dip:demotePlayer', data)
    end

    cb('ok')
end)

RegisterNUICallback('removePlayer', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_dip:removePlayer', data)
    end
    cb('ok')
end)

RegisterNUICallback('removeHistory', function(data, cb)
    if data then
        TriggerServerEvent('fortal_dip:removeHistory', data)
    end
    cb('ok')
end)

RegisterNUICallback('deleteOccurrence', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_dip:deleteOccurrence', data)
    end
    cb('ok')
end)

RegisterNUICallback('checkTable', function(data, cb)
    TriggerServerEvent('fortal_dip:checkAndCreateTable')
    cb('ok')
end)

RegisterNUICallback('checkPagePermission', function(data, cb)
    if data and data.page then
        TriggerServerEvent('fortal_dip:checkPagePermission', data.page)
        
        local received = false
        
        local function onReceive(canAccess)
            if not received then
                received = true
                cb({canAccess = canAccess})
            end
        end
        
        RegisterNetEvent('fortal_dip:pagePermissionResult', onReceive)
        
        Citizen.SetTimeout(3000, function()
            if not received then
                received = true
                cb({canAccess = false})
            end
        end)
    else
        cb({canAccess = false})
    end
end)

RegisterNUICallback('getPlayerRankInfo', function(data, cb)
    TriggerServerEvent('fortal_dip:getPlayerRankInfo')

    local received = false
    
    local function onReceive(rankInfo)
        if not received then
            received = true
            cb(rankInfo or {})
        end
    end

    RegisterNetEvent('fortal_dip:playerRankInfo', onReceive)
    
    Citizen.SetTimeout(10000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getOfficerStats', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_dip:getOfficerStats', data.id)
        
        local received = false
        
        local function onReceive(stats)
            if not received then
                received = true
                cb(stats or {})
            end
        end
        
        RegisterNetEvent('fortal_dip:receiveData:getOfficerStats', onReceive)
        
        Citizen.SetTimeout(3000, function()
            if not received then
                received = true
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNetEvent('fortal_dip:receiveData:getPlayers')
RegisterNetEvent('fortal_dip:receiveData:getWarns')
RegisterNetEvent('fortal_dip:receiveData:createAnnounce')
RegisterNetEvent('fortal_dip:receiveData:getOptions')
RegisterNetEvent('fortal_dip:receiveData:getMembers')
RegisterNetEvent('fortal_dip:receiveData:getWantedUsers')
RegisterNetEvent('fortal_dip:receiveData:getWantedVehicles')
RegisterNetEvent('fortal_dip:receiveData:getOccurrences')

RegisterNetEvent('fortal_dip:updateStatistics')
AddEventHandler('fortal_dip:updateStatistics', function()
    SendNUIMessage({
        action = 'updateStatistics',
        data = {}
    })
end)

RegisterNetEvent('fortal_dip:updateWarns')
AddEventHandler('fortal_dip:updateWarns', function(warns)
    
    SendNUIMessage({
        action = 'updateWarns',
        data = warns
    })

end)

RegisterNetEvent('fortal_dip:newWarnNotification')
AddEventHandler('fortal_dip:newWarnNotification', function(data)
    if data and data.title and data.author then
        print('[CLIENT] Nova notificação de aviso:', data.title)
    end
end)

RegisterNetEvent('fortal_dip:updateWantedUsers')
AddEventHandler('fortal_dip:updateWantedUsers', function()
    TriggerServerEvent('fortal_dip:getWantedUsers')
end)

RegisterNetEvent('fortal_dip:updateWantedVehicles')
AddEventHandler('fortal_dip:updateWantedVehicles', function()
    TriggerServerEvent('fortal_dip:getWantedVehicles')
end)

RegisterNetEvent('fortal_dip:updateOccurrences')
AddEventHandler('fortal_dip:updateOccurrences', function()
    TriggerServerEvent('fortal_dip:getOccurrences')
end)

RegisterNetEvent('fortal_dip:updateMembers')
AddEventHandler('fortal_dip:updateMembers', function()
    TriggerServerEvent('fortal_dip:getMembers')
end)

RegisterNetEvent('fortal_dip:closeNUI')
AddEventHandler('fortal_dip:closeNUI', function()
    isUIOpen = false
    SetNuiFocus(false, false)
    
    stopAnimation()
    removeObjects(tabletProp)
    tabletProp = nil
    
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
end)

RegisterNetEvent('fortal_dip:showPrisonTime')
AddEventHandler('fortal_dip:showPrisonTime', function(months, fine)
    if months and fine then
        SendNUIMessage({
            action = 'setTime',
            data = {
                month = tostring(months),
                fine = fine
            }
        })
        
        SendNUIMessage({
            action = 'setVisibility',
            data = '/time'
        })
    end
end)

RegisterNetEvent('fortal_dip:showFineAmount')
AddEventHandler('fortal_dip:showFineAmount', function(amount)
    TriggerEvent('Notify', 'negado', 'Você foi multado em $' .. amount)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isUIOpen then
            if IsControlJustPressed(0, 322) then -- ESC
                isUIOpen = false
                SetNuiFocus(false, false)
                
                -- Parar animação e remover prop do tablet
                stopAnimation()
                removeObjects(tabletProp)
                tabletProp = nil
                
                SendNUIMessage({
                    action = 'setVisibility',
                    data = nil
                })
            end
        end
    end
end)

exports('IsUIOpen', function()
    return isUIOpen
end)

exports('ToggleUI', function()
    ToggleUI()
end)

RegisterNUICallback('closeNUI', function(data, cb)

    isUIOpen = false
    SetNuiFocus(false, false)
    
    -- Parar animação e remover prop do tablet
    stopAnimation()
    removeObjects(tabletProp)
    tabletProp = nil
    
    -- Enviar mensagem para esconder a interface
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })

    if cb then
        cb('ok')
    end
end)

-- Event para receber dados atualizados de procurados
RegisterNetEvent('fortal_dip:receiveData:getWantedUsers')
AddEventHandler('fortal_dip:receiveData:getWantedUsers', function(wantedUsers)
    SendNUIMessage({
        action = 'updateWantedUsers',
        data = wantedUsers or {}
    })
end)

-- Event para receber dados atualizados de veículos procurados
RegisterNetEvent('fortal_dip:receiveData:getWantedVehicles')
AddEventHandler('fortal_dip:receiveData:getWantedVehicles', function(wantedVehicles)
    SendNUIMessage({
        action = 'updateWantedVehicles',
        data = wantedVehicles or {}
    })
end)

-- Event para receber dados atualizados de B.O.s
RegisterNetEvent('fortal_dip:receiveData:getOccurrences')
AddEventHandler('fortal_dip:receiveData:getOccurrences', function(occurrences)
    SendNUIMessage({
        action = 'updateOccurrences',
        data = occurrences or {}
    })
end)

-- Event para receber dados atualizados de membros
RegisterNetEvent('fortal_dip:receiveData:getMembers')
AddEventHandler('fortal_dip:receiveData:getMembers', function(members)
    SendNUIMessage({
        action = 'updateMembers',
        data = members or {}
    })
end)

-- Event para atualizar permissões do jogador
RegisterNetEvent('fortal_dip:updatePermissions')
AddEventHandler('fortal_dip:updatePermissions', function()
    -- Forçar atualização das permissões no frontend
    SendNUIMessage({
        action = 'updatePermissions',
        data = {}
    })
    
    -- Fechar o painel se estiver aberto para forçar recarregamento
    if isUIOpen then
        isUIOpen = false
        SetNuiFocus(false, false)
        
        stopAnimation()
        removeObjects(tabletProp)
        tabletProp = nil
        
        SendNUIMessage({
            action = 'setVisibility',
            data = nil
        })
    end
end)

-- Event para atualizar histórico de jogador
RegisterNetEvent('fortal_dip:updatePlayerHistory')
AddEventHandler('fortal_dip:updatePlayerHistory', function(playerId)
    TriggerServerEvent('fortal_dip:getPlayerData', playerId)
    
    SendNUIMessage({
        action = 'updatePlayerHistory',
        data = { playerId = playerId }
    })
end)



