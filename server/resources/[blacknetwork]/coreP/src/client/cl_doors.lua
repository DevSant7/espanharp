-- VARIAVEIS GLOBAIS 
local Display = {}
local Portas = {} 

local CONTROLE_ATAQUE = 24 
local CONTROLE_MIRA = 25   
local CONTROLE_CORRER = 21  
local CONTROLE_INTERAGIR = 38 

--- FUNCOES AUXILIARES
-----------------------------------------------------------------------------------------------------------------------------------------
-- client.lua

local function AtualizarPorta(index, isLocked)
    if isLocked then
        DoorSystemSetOpenRatio(index, 0.0, true, true) 
        
        Citizen.Wait(50) 
        
        DoorSystemSetDoorState(index, 1, true) 
    else
        DoorSystemSetDoorState(index, 0, true) 
        DoorSystemSetAutomaticRate(index, 2.5, false, true) -- Permite a porta se mover automaticamente
    end
    Portas[index]["lock"] = isLocked 
end

function DrawText3D2(x, y, z, text) 
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    if not onScreen then return end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringKeyboardDisplay(text)
    SetTextColour(255, 255, 255, 150)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextCentre(1)
    EndTextCommandDisplayText(_x, _y)
end

--- EVENTOS DE REDE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("allDoors:unlock", function(Unlocked)
    for _, id in ipairs(Unlocked) do
        if Portas[id] then 
            AtualizarPorta(id, false) 
        end
    end
end)

RegisterNetEvent("doors:fullSync", function(Table)
    for Index, _ in pairs(Portas) do
        if IsDoorRegisteredWithSystem(Index) then
            RemoveDoorFromSystem(Index)
        end
    end
    Portas = {} 

    local countNewDoors = 0
    for Index, v in pairs(Table) do 
        if v.hash and GetHashKey(v.hash) ~= 0 then
            AddDoorToSystem(Index, v.hash, vec3(v.x, v.y, v.z), false, false, true)

            Portas[Index] = v 
            AtualizarPorta(Index, v.lock) 
            countNewDoors = countNewDoors + 1
        end
    end

end)


RegisterNetEvent("doors:updateState", function(Index, Lock, Table)
    local Porta = Portas[Index]

    if Table then 
        if not Porta or Table.hash ~= nil then 
            if IsDoorRegisteredWithSystem(Index) then
                RemoveDoorFromSystem(Index)
            end

            if Table["hash"] and GetHashKey(Table["hash"]) ~= 0 then
                AddDoorToSystem(Index, Table["hash"], vec3(Table.x, Table.y, Table.z), false, false, true)
                Portas[Index] = Table 
                AtualizarPorta(Index, Lock)
            end
        end
    else 
        if Porta then 
            AtualizarPorta(Index, Lock)
        end
    end
end)

RegisterNetEvent("doors:remove", function(doorId)
    if Portas[doorId] then
        if IsDoorRegisteredWithSystem(doorId) then
            RemoveDoorFromSystem(doorId)
        end
        Portas[doorId] = nil
        Display[doorId] = nil 
    end
end)


--- THREADS (LUPAS PRINCIPAIS)
-----------------------------------------------------------------------------------------------------------------------------------------
local modoExibirIds = false
RegisterCommand("verids", function(source, args, rawCommand)
    modoExibirIds = not modoExibirIds 
end)

CreateThread(function()
    while true do
        local DistanciaEsperada = 999
        local Ped = PlayerPedId()
        local Coords = GetEntityCoords(Ped)

        if next(Portas) then
            for Number, v in pairs(Portas) do
                if v and v.x and v.y and v.z and v.distance then
                    local doorCoords = vec3(v.x, v.y, v.z)
                    local displayCoords = doorCoords

                    if v.other and Portas[v.other] then
                        if Portas[v.other].x and Portas[v.other].y and Portas[v.other].z then
                            local otherDoorCoords = vec3(Portas[v.other].x, Portas[v.other].y, Portas[v.other].z)
                            displayCoords = (doorCoords + otherDoorCoords) / 2.0
                        end
                    end

                    if #(Coords - doorCoords) <= v.distance then
                        DistanciaEsperada = 1

                        if not Display[Number] then
                            Display[Number] = true
                        end

                        local sufId = modoExibirIds and " - ID:" .. Number or ""
                        local iconeEstadoPorta = v.lock and "🔒" .. sufId or "🔓" .. sufId
                        DrawText3D2(displayCoords.x, displayCoords.y, displayCoords.z, iconeEstadoPorta)

                        if IsControlJustPressed(1, CONTROLE_INTERAGIR) then 
                            TriggerServerEvent("serverAPI:toggleDoorLock", Number)
                        end
                    else
                        if Display[Number] then
                            Display[Number] = nil
                        end
                    end
                end
            end
        else
            DistanciaEsperada = 1000 
        end

        Wait(DistanciaEsperada)
    end
end)

--- RAYCAST PARA ADICIONAR NOVAS PORTAS (UTILITARIO)
-----------------------------------------------------------------------------------------------------------------------------------------
src.rayCastDoor = function()
    local isDoubleDoor = IsControlPressed(0, CONTROLE_CORRER)

    local rayCastCam = function(flags, ignore, distance)
        local coords, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)
        local destination = coords + normal * (distance or 10)
        local handle = StartShapeTestLosProbe(coords.x, coords.y, coords.z, destination.x, destination.y, destination.z, flags or 511, PlayerPedId(), ignore or 4)

        while true do
            Wait(0)
            local retval, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResultIncludingMaterial(handle)
            if retval ~= 1 then
                return hit, entityHit, endCoords, surfaceNormal, materialHash
            end
        end
    end

    local isAddingDoorlock = true
    local currentOutlineEntities = {}
    local tempData = {} 

    local function setOutline(entityId, state)
        if DoesEntityExist(entityId) then
            SetEntityDrawOutline(entityId, state)
        end
    end

    local function clearAllOutlines()
        for _, entityId in ipairs(currentOutlineEntities) do
            setOutline(entityId, false)
        end
        currentOutlineEntities = {}
    end

    function table.contains(t, val)
        for _, v in ipairs(t) do
            if v == val then return true end
        end
        return false
    end

    repeat
        DisablePlayerFiring(PlayerId(), true)
        DisableControlAction(0, CONTROLE_MIRA, true)

        local hit, entityHitByRay, coords = rayCastCam(1 | 16)

        if hit then
            DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 42, 24, 100, false, false, 0, true, false, false, false)
        end

        local entitiesToOutlineThisFrame = {}

        if hit and DoesEntityExist(entityHitByRay) and GetEntityType(entityHitByRay) == 3 then
            local isAlreadySelected = false
            for _, selectedData in ipairs(tempData) do
                if selectedData.entity == entityHitByRay then
                    isAlreadySelected = true
                    break
                end
            end

            if not isAlreadySelected then
                table.insert(entitiesToOutlineThisFrame, entityHitByRay)
            end
        end

        for _, selectedData in ipairs(tempData) do
            if DoesEntityExist(selectedData.entity) and not table.contains(entitiesToOutlineThisFrame, selectedData.entity) then
                table.insert(entitiesToOutlineThisFrame, selectedData.entity)
            end
        end

        local newOutlines = {}
        for _, entityId in ipairs(entitiesToOutlineThisFrame) do
            if not table.contains(currentOutlineEntities, entityId) then
                setOutline(entityId, true)
            end
            table.insert(newOutlines, entityId)
        end

        for _, entityId in ipairs(currentOutlineEntities) do
            if not table.contains(newOutlines, entityId) then
                setOutline(entityId, false)
            end
        end
        currentOutlineEntities = newOutlines

        if IsDisabledControlJustPressed(0, CONTROLE_ATAQUE) then
            if hit and DoesEntityExist(entityHitByRay) and GetEntityType(entityHitByRay) == 3 then
                local alreadySelected = false
                for i=1, #tempData do
                    if tempData[i].entity == entityHitByRay then
                        alreadySelected = true
                        break
                    end
                end

                if not alreadySelected then
                    local doorCoords = GetEntityCoords(entityHitByRay)
                    local data = {
                        entity = entityHitByRay,
                        coords = {
                            x = doorCoords.x,
                            y = doorCoords.y,
                            z = doorCoords.z,
                        },
                        hash = GetEntityModel(entityHitByRay)
                    }

                    table.insert(tempData, data)
                    TriggerEvent("chatMessage", "Sistema de Portas", {0, 200, 0}, "Porta selecionada: " .. #tempData .. " de " .. (isDoubleDoor and "2" or "1"))

                    if not isDoubleDoor then
                        isAddingDoorlock = false
                        clearAllOutlines()
                        return data
                    end

                    if isDoubleDoor and #tempData == 2 then
                        isAddingDoorlock = false
                        clearAllOutlines()
                        return {
                            doorA = {
                                coords = tempData[1].coords,
                                hash = tempData[1].hash,
                                entity = tempData[1].entity
                            },
                            doorB = {
                                coords = tempData[2].coords,
                                hash = tempData[2].hash,
                                entity = tempData[2].entity
                            }
                        }
                    end
                else
                    TriggerEvent("chatMessage", "Sistema de Portas", {255, 255, 0}, "Esta porta já foi selecionada!")
                end
            else
                TriggerEvent("chatMessage", "Sistema de Portas", {255, 255, 0}, "Mire em uma porta válida para selecionar!")
            end
        end

        if IsDisabledControlJustPressed(0, CONTROLE_MIRA) or IsDisabledControlJustPressed(0, 322) then
            clearAllOutlines()
            isAddingDoorlock = false
            return nil
        end
    until not isAddingDoorlock

    clearAllOutlines()
end

RegisterNetEvent("client:requestRayCastDoor", function()
    local resultadoRaycast = src.rayCastDoor()
    TriggerServerEvent("server:receiveRayCastDoorResult", resultadoRaycast)
end)

local hasSyncedOnInitialSpawn = false 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) 

        local playerPed = PlayerPedId()
        if DoesEntityExist(playerPed) and not IsEntityDead(playerPed) and GetGameTimer() > 10000 then 
            if not hasSyncedOnInitialSpawn then
                TriggerServerEvent('doors:requestSync')
                hasSyncedOnInitialSpawn = true 
            end
        end

        if not DoesEntityExist(playerPed) or IsEntityDead(playerPed) then
            if hasSyncedOnInitialSpawn then 
            end
            hasSyncedOnInitialSpawn = false
        end
    end
end)
