
Selector = {
    mainCamera = nil,
    characters = {},
    runningCamera = false,

    Open = function(self, characters)
        DoScreenFadeOut(500)
        Wait(750)
        
        TriggerEvent("hud:actions", false)
        ShutdownLoadingScreenNui()
        ShutdownLoadingScreen()

        StopScreenEffect("MenuMGSelectionIn")
        StopScreenEffect("DeathFailNeutralIn")

        local playerPed = PlayerPedId()

        FreezeEntityPosition(playerPed, true)
        SetEntityVisible(playerPed, false)
        SetEntityCollision(playerPed, false, false)
        SetEntityCoords(playerPed, Config.Selector.Main)
        
        self.characters = characters
        self.runningCamera = true
        
        Utils.UI("selector")
        self:Peds()
        
        Wait(500)

        self:Camera()
    end,

    Close = function(self)        
        Utils.UI()
        DoScreenFadeOut(250)
        Wait(750)

        for _, character in pairs(self.characters) do
            if character.ped then
                DeleteEntity(character.ped)
            end
        end

        self.runningCamera = false
        self.characters = {}

        if self.mainCamera then
            DestroyCam(self.mainCamera)
            self.mainCamera = nil
        end

        Wait(750)
        DoScreenFadeIn(250)
    end,

    Peds = function(self)
        local spawnsData = Utils.ShuffleTable(Config.Selector.Spawns)
        for index, character in pairs(self.characters) do
            if character.type == "character" then
                local modelHash = GetHashKey("mp_"..character.gender.."_freemode_01")

                RequestModel(modelHash)
                while not HasModelLoaded(modelHash) do
                    Wait(10)
                end
                
                local playerCoords = spawnsData[index].Coords
                local animData = spawnsData[index].Anim

                character.ped = CreatePed(4, modelHash, playerCoords.x, playerCoords.y, (type(playerCoords.z) == "table" and playerCoords.z[character.gender] or playerCoords.z) - 1, playerCoords.h)
                 
                FreezeEntityPosition(character.ped, true)
                Wait(100)
                SetEntityCollision(character.ped, false, false)

                Utils.UpdateClothes(character.ped, character.clothes)
                Utils.UpdateAppearance(character.ped, character.appearance)
                Utils.UpdateTattoos(character.ped, character.tattoos)

                if animData then
                    Utils.PlayAnim(character.ped, animData.Dict, animData.Name)
                end
            end
        end
    end,

    RandomPeds = function(self)
        local spawnsData = Utils.ShuffleTable(Config.Selector.Spawns)

        for index, character in pairs(self.characters) do
            local playerCoords = spawnsData[index].Coords

            if character.ped then
                SetEntityCoords(character.ped, playerCoords.x, playerCoords.y, (type(playerCoords.z) == "table" and playerCoords.z[character.gender] or playerCoords.z) - 1, playerCoords.h)
                SetEntityHeading(character.ped, playerCoords.h)
    
                local animData = spawnsData[index].Anim
    
                if animData then
                    Utils.PlayAnim(character.ped, animData.Dict, animData.Name)
                end
            end
        end
    end,

    Camera = function(self)
        local playerPed = PlayerPedId()
        local camerasData = Utils.ShuffleTable(Config.Selector.Cameras)

        self.mainCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

        RenderScriptCams(true, false, 0, true, true)

        CreateThread(function()
            local currentData, currentIndex = 1, 1
            local dataChanged = false

            while self.runningCamera do
                local sequence = camerasData[currentData].List
                local from, to = sequence[currentIndex], sequence[currentIndex + 1]

                DoScreenFadeIn(1000)

                if not to then
                    currentIndex = 1
                    dataChanged = false
                else
                    local startTime = GetGameTimer()
                    local duration = camerasData[currentData].Duration
    
                    while (GetGameTimer() - startTime) < duration and self.runningCamera do
                        local now = GetGameTimer()
                        local alpha = (now - startTime) / duration
    
                        local function interpolate(a, b)
                            return a + (b - a) * alpha
                        end
    
                        local pos = {
                            x = interpolate(from.Coords.x, to.Coords.x),
                            y = interpolate(from.Coords.y, to.Coords.y),
                            z = interpolate(from.Coords.z, to.Coords.z),
                        }
    
                        local point = {
                            x = interpolate(from.Point.x, to.Point.x),
                            y = interpolate(from.Point.y, to.Point.y),
                            z = interpolate(from.Point.z, to.Point.z),
                        }
    
                        SetCamCoord(self.mainCamera, pos.x, pos.y, pos.z)
                        PointCamAtCoord(self.mainCamera, point.x, point.y, point.z)
                        SetEntityCoords(playerPed, pos.x, pos.y, pos.z)
    
                        if not dataChanged and (now - startTime) > (duration - 1500) and not sequence[currentIndex + 2] then
                            currentData = camerasData[currentData + 1] and currentData + 1 or 1
                            currentIndex = 1
                            dataChanged = true
                            DoScreenFadeOut(1000)
                        end
    
                        Wait(0)
                    end
    
                    currentIndex = currentIndex + 1
                end

                Wait(0)
            end
        end)
    end,

    PreviewCharacter = function(self, index)
        if self.characters[index] and self.characters[index].type == "character" then
            DoScreenFadeOut(250)
            Wait(500)

            self.runningCamera = false

            self:RandomPeds()
            
            local playerPed = PlayerPedId()
            local cameraData = Config.Selector.Spawns[index].Camera
    
            if self.mainCamera then
                DestroyCam(self.mainCamera)
            end

            self.mainCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            SetCamCoord(self.mainCamera, cameraData.Coords.x, cameraData.Coords.y, cameraData.Coords.z)
            PointCamAtCoord(self.mainCamera, cameraData.Point.x, cameraData.Point.y, cameraData.Point.z)
            SetEntityCoords(playerPed, cameraData.Point.x, cameraData.Point.y, cameraData.Point.z)
    
            Wait(500)
            DoScreenFadeIn(250)
        else
            if not self.runningCamera then
                DoScreenFadeOut(250)
                Wait(500)
    
                self:RandomPeds()

                if self.mainCamera then
                    DestroyCam(self.mainCamera)
                end
    
                self.runningCamera = true
    
                self:Camera()
            end
        end
    end,

    DeleteCharacter = function(self, data)
        self:PreviewCharacter(-1)

        for k,v in pairs(self.characters) do
            if v.id == data.id then
                DeleteEntity(v.ped)
                self.characters[k] = {
                    type = "slot",
                }

                TriggerServerEvent("fortal-character:Server:Selector:Delete", data)

                break
            end
        end
    end,

    Spawn = function(self, gender, coords, appearance, clothes, tattoos)
        local playerPed = Utils.UpdateGender(gender)

        Utils.UI()
        Utils.UpdateAppearance(playerPed, appearance)
        Utils.UpdateClothes(playerPed, clothes)

        SetEntityCoords(playerPed, coords.x, coords.y, coords.z - 1)
        SetEntityHeading(playerPed, coords.h)
        SetEntityVisible(playerPed, true)
        SetEntityCollision(playerPed, true, true)
        SetEntityInvincible(playerPed, false)
        FreezeEntityPosition(playerPed, false)

        RenderScriptCams(false, false, 0, true, true)
        TriggerEvent("hud:actions", true)
    end
}

RegisterNUICallback("Selector:GetData", function(_, Callback)
    Callback(Selector.characters)
end)

RegisterNUICallback("Selector:PreviewCharacter", function(data, Callback)
    Selector:PreviewCharacter(data.index)
    Callback(true)
end)

RegisterNUICallback("Selector:DeleteCharacter", function(data, Callback)
    Selector:DeleteCharacter(data)
    
    Callback(true)
end)

RegisterNUICallback("Selector:SelectCharacter", function(data, Callback)
    TriggerServerEvent("fortal-character:Server:Selector:SelectCharacter", data)
    Callback(true)
end)

RegisterNUICallback("Selector:CreateCharacter", function(data, Callback)
    Selector:Close()
    Creator:Open()

    Callback(true)
end)

RegisterNetEvent("fortal-character:Client:Selector:Open", function(...) 
    Selector:Open(...) 
end)

RegisterNetEvent("fortal-character:Client:Selector:Close", function(...) 
    Selector:Close(...) 
end)

RegisterNetEvent("fortal-character:Client:Selector:Spawn", function(...)
    Selector:Spawn(...)
end)