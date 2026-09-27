local pauseMenu     = false
local isDead        = false
local has_been_dead = false
local userKills     = 0 
local isDead        = false 
local previousCoords = nil
local skinShopCoords = vector3(9.75, -1106.65, 29.79)

local function closeMenu()
    pauseMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "setVisible", data = false })
    SendNUIMessage({ action = "setLevel", data = 7 })
end

local function getSourceByPed(id)
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if (ped == id) then
            return player
        end
    end
    return nil
end

RegisterNUICallback("getUserInformations", function(data, cb)
    local infos = server.getInfos() or {}
    cb(infos)
end)

RegisterNUICallback("saveProfile", function(data, cb)
    server.saveProfile(data)
    closeMenu()
    cb({success = true})
end)

RegisterNUICallback("painelOrg", function(data, cb)
    Utils.functions.openOrgsPannel()
    closeMenu()
    cb({success = true})
end)

RegisterNUICallback("mapa", function(data, cb)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_SP_PAUSE'), true)
    closeMenu()
    cb({success = true})
end)

RegisterNUICallback("config", function(data, cb)
    ActivateFrontendMenu(GetHashKey('FE_MENU_VERSION_LANDING_MENU'), true)
    closeMenu()
    cb({success = true})
end)

RegisterNUICallback("removeFocus", function(data, cb)
    closeMenu()
    cb({success = true})
end)

RegisterNUICallback("openSkinShop", function(data, cb)
    local ped = PlayerPedId()
    previousCoords = GetEntityCoords(ped)

    SetEntityCoords(ped, skinShopCoords.x, skinShopCoords.y, skinShopCoords.z, false, false, false, false)

    closeMenu()
    Utils.functions.openSkinshop()

    StartSkinshopMonitor()

    cb({success = true})
end)

function StartSkinshopMonitor()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()

        SetEntityVisible(ped, false)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)

        while true do
            Citizen.Wait(500)
            local hasFocus = IsNuiFocused()

            if not hasFocus then
                DoScreenFadeOut(500)
                while not IsScreenFadedOut() do
                    Citizen.Wait(10)
                end

                if previousCoords then
                    local groundZ = previousCoords.z
                    local success, z = GetGroundZFor_3dCoord(previousCoords.x, previousCoords.y, previousCoords.z, 0)

                    if success then
                        groundZ = z + 0.5 
                    end

                    SetEntityCoordsNoOffset(ped, previousCoords.x, previousCoords.y, groundZ, false, false, false)
                    previousCoords = nil
                end

                Citizen.Wait(200)

                SetEntityVisible(ped, true)
                SetEntityInvincible(ped, false)
                FreezeEntityPosition(ped, false)

                DoScreenFadeIn(500)
                break
            end
        end
    end)
end

RegisterNUICallback("resgateItem", function(data,cb)
    local success = server.resgateItem(data) or false
    if success then
        closeMenu() 
    end
    cb(success)
end)

RegisterNUICallback("getLevelDay", function(data,cb)
    local level = server.getLevelDay() or 0
    cb(level)
end)

AddEventHandler('gameEventTriggered', function(event, args)
    if event == 'CEventNetworkEntityDamage' then
        local nped = tonumber(args[2]) 
        local ped = PlayerPedId()
        local damage = args[3] or 0 

        if GetEntityHealth(ped) <= 101 then 
            local killer = GetPlayerServerId(getSourceByPed(nped))
            local coords = GetEntityCoords(ped)

            server.AddKill(killer)

            if LocalPlayer and LocalPlayer.state and LocalPlayer.state.inArena then 
                TriggerServerEvent("black_esc:arenas:registerKill", killer)
            end 
            Wait(1000)
            CreateThread(function()
                while isDead do
                    local ped = PlayerPedId()
                    if GetEntityHealth(ped) > 101 then
                        isDead = false
                    end
                    Wait(0)
                end
            end)
        end
    end
end)

function src.sendUiMessage(data)
    SendNUIMessage(data)
end	

function src.countKills()
    userKills = userKills + 1 
    SendNUIMessage({ action = "getPlayersKills", data = userKills })
end

function src.setPlayerHealth(number)
    local ped = PlayerPedId()
    
    SetEntityHealth(ped,number)
end

function src.giveArenaNeeds(arena)
    Utils.functions.giveWeapons(arena)
end 

function src.remArenaNeeds(arena)
    Utils.functions.removeWeapons(arena)
end

src.ressurectPlayer = Utils.functions.ressurrectPlayer

CreateThread(function()
    while true do
        if LocalPlayer.state.inArena and Config.arenas[LocalPlayer.state.currentArena]["polyzone"] then
            timeDistance = 100 
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)

            if not Config.arenas[LocalPlayer.state.currentArena]["polyzone"]:isPointInside(pedCoords) then
                local spawn     = math.random(1,#Config.arenas[LocalPlayer.state.currentArena].spawnpoints)
                local spawnData = Config.arenas[LocalPlayer.state.currentArena].spawnpoints[spawn]
                SetEntityCoords(ped,spawnData.x,spawnData.y,spawnData.z)

                if LocalPlayer.state.currentArena == "pista" then 
                    server.respawnVehicle()
                end
            end
        end

        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.inArena and Config.arenas[LocalPlayer.state.currentArena] then
            local ped 		= PlayerPedId()
            local pedHealth = GetEntityHealth(ped)

            if pedHealth <= 101 then 
                if LocalPlayer.state.currentArena ~= "1x1" then 
                    local spawn     = math.random(1,#Config.arenas[LocalPlayer.state.currentArena].spawnpoints)
                    local spawnData = Config.arenas[LocalPlayer.state.currentArena].spawnpoints[spawn]

                    if LocalPlayer.state.currentArena == "pista" then 
                        Utils.functions.ressurrectPlayer()
                        SetEntityCoords(ped,spawnData.x,spawnData.y,spawnData.z)
                        Utils.functions.giveWeapons(LocalPlayer.state.currentArena)
                        server.respawnVehicle()
                    else
                        Utils.functions.ressurrectPlayer()
                        SetEntityCoords(ped,spawnData.x,spawnData.y,spawnData.z)
                        Utils.functions.giveWeapons(LocalPlayer.state.currentArena)
                    end 
                end
            end 
        end

        Wait(1000)
    end
end) 

CreateThread(function()
    while true do
        Wait(0)
        DisableControlAction(0, 200, true)
    end
end)

RegisterNUICallback("setItemPass", function(data, cb)
    cb(Utils.battlepass)
end)

RegisterNUICallback("setRanking", function(data, cb)
    local myServerId = GetPlayerServerId(PlayerId())
    local rankingData = server.getRanking(myServerId) or {users = {}, usersWeek = {}, myRanking = {}}
    local rankingGems = server.getRankingGems(myServerId) or {users = {}, usersWeek = {}, myRanking = {}}
    local rankingKills = server.getRankingKills(myServerId) or {users = {}, usersWeek = {}, myRanking = {}}
    local rankingElogio = server.getRankingElogios(myServerId) or {users = {}, usersWeek = {}, myRanking = {}}
 
    cb({
        {
            page = "Horas de Jogo",
            users = rankingData.users or {},
            usersWeek = rankingData.usersWeek or {},
            myRanking = rankingData.myRanking or {}
        },
        {
            page = "Diamantes",
            users = rankingGems.users or {},
            usersWeek = rankingGems.usersWeek or {},
            myRanking = rankingGems.myRanking or {}
        },
        {
            page = "Arena",
            users = rankingKills.users or {},
            usersWeek = rankingKills.usersWeek or {},
            myRanking = rankingKills.myRanking or {}
        },
        {
            page = "Elogios",
            users = rankingElogio.users or {},
            usersWeek = rankingElogio.usersWeek or {},
            myRanking = rankingElogio.myRanking or {}
        }
    })
end)

RegisterCommand('open_menu', function(source, args)
    -- Verifica se o jogador está em uma arena antes de abrir o menu
    if LocalPlayer.state.inArena then
        return -- Não abre o menu normal se estiver na arena
    end
    
    if not pauseMenu and not IsPauseMenuActive() then
        SendNUIMessage({ action = "setVisible", data = "/" })
        SendNUIMessage({ action = "setColor", data = "60, 142, 220"})
        SetNuiFocus(true, true)
        server.verifyProfile()
        refreshItensResgatados(Utils.battlepass)

        SendNUIMessage({ action = "setProgress", data = server.getLevelDay()})
        SendNUIMessage({ action = "setPremium", data = server.getvip() })

        SendNUIMessage({
            action = "setPanel",
            data = {
                shop = "https://fortalcityrp.centralcart.com.br",
                discord = "https://discord.gg/fortalrp",
                instagram = "https://www.instagram.com/",
                tiktok = "https://www.instagram.com/"
            }
        })
    end
end)

RegisterCommand("exitArena",function()
    if LocalPlayer.state.inArena and Config.arenas[LocalPlayer.state.currentArena] then 
        TriggerServerEvent("black:exitArena",LocalPlayer.state.currentArena)
    end 
end) 	

RegisterKeyMapping("open_menu", "Abrir Esc Menu", "keyboard", "ESCAPE")
RegisterKeyMapping("exitArena","Sair da arena.","keyboard","F7")

Citizen.CreateThread(function()
    SetNuiFocus(false, false)

    local coords = vector3(-1048.06, -472.76, 36.65) 

    exports["target"]:AddCircleZone("ArenaSystem", coords, 1.0, {
        name = "ArenaSystem",
        heading = 3374176
    }, {
        distance = 1.5,
        options = {
            {
                event = "black:enterPista",
                label = "Entrar na Arena",
                tunnel = "server"
            },
            {
                event = "black:enterFFA",
                label = "Entrar no FFA",
                tunnel = "server"
            },
            {
                event = "black:enter1x1",
                label = "Entrar no X1",
                tunnel = "server"
            }
        }
    })
end)

RegisterNetEvent("startProposeAnimation")
AddEventHandler("startProposeAnimation", function()
    if not exports["bsEmotes"] then return end
    exports["bsEmotes"]:EmoteCommandStart("propose3")
end)
