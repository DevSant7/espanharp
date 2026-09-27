Spawn = {
    mainCamera = nil,

    Open = function(self, gender, coords, appearance, clothes, tattoos)      
        if Selector.mainCamera then
            DestroyCam(Selector.mainCamera)
            Selector.mainCamera = nil
        end

        self.mainCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(self.mainCamera, coords.x, coords.y, coords.z + 1500.0)
        PointCamAtCoord(self.mainCamera, coords.x, coords.y, coords.z)
        RenderScriptCams(true, false, 0, true, true)
        StartScreenEffect("MenuMGSelectionIn", 0, true)

        Wait(500)
        
        Utils.UI("spawn")

        local playerPed = Utils.UpdateGender(gender)
        
        Wait(500)

        Utils.UpdateAppearance(playerPed, appearance)
        Utils.UpdateClothes(playerPed, clothes)

        SetEntityCoords(playerPed, coords.x, coords.y, coords.z - 1)
        SetEntityHeading(playerPed, coords.h)
        FreezeEntityPosition(playerPed, true)
        SetEntityCollision(playerPed, false, false)
        SetEntityVisible(playerPed, false)
        SetEntityInvincible(playerPed, true)
    end,

    Camera = function(self, coords)
        if self.mainCamera then
            PointCamAtCoord(self.mainCamera, coords)
    
            for _, height in pairs(Config.Spawn.CamHeights) do
                SetCamCoord(self.mainCamera, coords + vec3(0,0,height))
                StartScreenEffect("DeathFailNeutralIn", 0, true)
                Wait(1000)
            end
            Wait(2000)
    
            DestroyCam(self.mainCamera)
            self.mainCamera = nil
            RenderScriptCams(false, false, 0, true, true)
        end
    end,

    Location = function(self, coords)
        local playerPed = PlayerPedId()

        Utils.UI()

        StopScreenEffect("MenuMGSelectionIn")
        StartScreenEffect("DeathFailNeutralIn",0,true)
        SetEntityCoords(playerPed, coords + vec3(0,0,-1))

        self:Camera(coords)

        SetEntityCollision(playerPed, true, true)
        SetEntityInvincible(playerPed, false)
        SetEntityVisible(playerPed, true)
        FreezeEntityPosition(playerPed, false)
        ClearPedTasks(playerPed)
        StopScreenEffect("DeathFailNeutralIn")

        TriggerEvent("hud:actions",true)
    end
}

RegisterNUICallback("Spawn:GetLocations", function(_, Callback)
    local dictionary = {}

    for index, data in pairs(Config.Spawn.Locations) do
        dictionary[index] = data
        dictionary[index].image = Config.AssetsUrl.."spawn/"..data.id..".png"
    end

    Callback(dictionary)
end)

RegisterNUICallback("Spawn:Location", function(data, Callback)
    local coords = nil

    for _,v in pairs(Config.Spawn.Locations) do
        if v.id == data.id then
            coords = vec3(v.coords.x, v.coords.y, v.coords.z)
        end
    end

    if coords then
        Spawn:Location(coords)
    end
    

    Callback(true)
end)

RegisterNUICallback("Spawn:LastLocation", function(data, Callback)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    Spawn:Location(playerCoords)

    Callback(true)
end)

RegisterNetEvent("fortal-character:Client:Spawn:Open", function(...)
    Spawn:Open(...)
end)