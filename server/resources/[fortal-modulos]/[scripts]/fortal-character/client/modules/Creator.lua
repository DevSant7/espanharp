Creator = {
    inside = false,
    mainCamera = nil,
    isSwitchingCamera = false,

    appearance = Config.Creator.Default.Appearance,
    genetics = {
        name = "",
        surname = "",
        age = 0,
        gender = "m"
    },

    Open = function(self)
        DoScreenFadeOut(250)
        Wait(250)
        
        TriggerEvent("hud:actions", false)
        ShutdownLoadingScreenNui()
        ShutdownLoadingScreen()

        self.inside = true
        Utils.UI("creator")

        local playerPed = Utils.UpdateGender("m")
        local defaultClothes = {}

        for k,v in pairs(Config.Creator.Default.Clothes) do
            defaultClothes[k] = v["m"]
        end

        Utils.UpdateAppearance(playerPed, Config.Creator.Default.Appearance)
        Utils.UpdateClothes(playerPed, defaultClothes)

        SetEntityCollision(playerPed, true, true)
        SetEntityVisible(playerPed, true)
        SetEntityCoords(playerPed, Config.Creator.Coords.x, Config.Creator.Coords.y, Config.Creator.Coords.z - 1)
        SetEntityHeading(playerPed, Config.Creator.Coords.h)
        FreezeEntityPosition(playerPed, true)
                
        local cameraCoords = Config.Cameras["face"]
        local forwardCoords = Utils.GetForwardCoord(Config.Creator.Coords, Config.Creator.Coords.h, cameraCoords.distance)

        if Selector.mainCamera then
            DestroyCam(Selector.mainCamera)
            Selector.mainCamera = nil
        end

        self.mainCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(self.mainCamera, forwardCoords + vec3(0, 0, cameraCoords.height))
        PointCamAtEntity(self.mainCamera, playerPed, 0, 0, cameraCoords.pointOffSet)
        RenderScriptCams(true, false, 0, true, true)

        Wait(250)
        DoScreenFadeIn(250)

        if Config.Anim then
            Utils.PlayAnim(playerPed, Config.Anim.Dict, Config.Anim.Name)
        end
    end,

    ChangeGenetics = function(self, data)
        local playerPed = PlayerPedId()

        data.father = data.father + 1
        data.mother = data.mother + 1

        if data.gender ~= self.genetics.gender then
            local playerPed = Utils.UpdateGender(data.gender)
            local defaultClothes = {}

            for k,v in pairs(Config.Creator.Default.Clothes) do
                defaultClothes[k] = v[data.gender]
            end

            Utils.UpdateAppearance(playerPed, self.appearance)
            Utils.UpdateClothes(playerPed, defaultClothes)    
        end

        self.genetics = data
        self.appearance.skinColor = data.color
        self.appearance.shapeMix =  (data.paternity / 100) + .0
        self.appearance.fathersID = Config.Creator.Fathers[data.father].id
        self.appearance.mothersID = Config.Creator.Mothers[data.mother].id
    end,

    ChangeData = function(self, data)
        for k,v in pairs(data) do
            self.appearance[k] = v.value
        end
    end,

    Cutscene = function()
        local playerPed = PlayerPedId()
        local coords = {
            vec3(-1170.57, -1644.02, 4.38),
            vec3(-1638.71, -2738.75, 3.44),
            vec3(-1361.12, -2267.97, 3.44)
        }

        SetNuiFocus(true, true)
        DoScreenFadeOut(500)
        Wait(750)

        for _, v in ipairs(coords) do
            LoadScene(v.x, v.y, v.z)
            RequestCollisionAtCoord(v.x, v.y, v.z)

            while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
                Wait(10)
            end
        end

        RequestCutscene('mp_intro_concat',8)

        while not HasCutsceneLoaded() do
            Wait(10)
        end

        PrefetchSrl('GTAO_INTRO_MALE')
        PrefetchSrl('GTAO_INTRO_FEMALE')

        while not IsSrlLoaded() do
            Wait(10)
        end

        BeginSrl()
        SetCutsceneEntityStreamingFlags('MP_Female_Character', 0, 1)
        SetCutsceneEntityStreamingFlags('MP_Male_Character', 0, 0)
        RegisterEntityForCutscene(nil, 'MP_Male_Character', 3, 0, 64)
        RegisterEntityForCutscene(playerPed, 'MP_Female_Character', 0, 0, 64)

        for index = 7,1,-1 do
            SetCutsceneEntityStreamingFlags("MP_Plane_Passenger_"..index, 0, 1)
            RegisterEntityForCutscene(nil, 'MP_Plane_Passenger_'..index, 3, GetHashKey('mp_f_freemode_01'), 0)
            RegisterEntityForCutscene(nil, 'MP_Plane_Passenger_'..index, 3, GetHashKey('mp_m_freemode_01'), 0)
        end

        if HasCutsceneLoaded() then       
            StartCutscene(8) 
            
            Wait(500)
            DoScreenFadeIn(500)
            Wait(26500)

            DoScreenFadeOut(500)
            Wait(1000)

            StopCutsceneImmediately()

            SetNuiFocus(false, false)
            Wait(1000)
            DoScreenFadeIn(1000)

            EndSrl()
        end
    end,

    Spawn = function(self)
        local playerPed = PlayerPedId()
        local spawnCoords = Config.Creator.Spawn
                
        if Config.Creator.Cutscene then
            self:Cutscene()
        end

        SetEntityCollision(playerPed, true, true)
        SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z - 1)
        SetEntityHeading(playerPed, spawnCoords.h)
        SetEntityInvincible(playerPed, false)
        FreezeEntityPosition(playerPed, false)

        TriggerEvent("hud:actions", true)
    end
}

RegisterNUICallback("Creator:UpdatePedPreview", function(data, Callback)
    local playerPed = PlayerPedId()

    if data.section == "genetics" then
        Creator:ChangeGenetics(data.data)
    elseif data.section == "characteristics" or data.section == "appearance" or data.section == "hair" then
        Creator:ChangeData(data.data)
    end

    Utils.UpdateAppearance(playerPed, Creator.appearance)

    Callback(true)
end)

RegisterNUICallback("Creator:ChangeGender", function(data, Callback)
    local playerPed = Utils.UpdateGender(data.gender)
    local defaultClothes = {}

    for k,v in pairs(Config.Creator.Default.Clothes) do
        defaultClothes[k] = v[data.gender]
    end

    Utils.UpdateAppearance(playerPed, Config.Creator.Default.Appearance)
    Utils.UpdateClothes(playerPed, defaultClothes)    

    if Config.Anim then
        Utils.PlayAnim(playerPed, Config.Anim.Dict, Config.Anim.Name)
    end

    Callback(true)
end)

RegisterNUICallback("Creator:GetParents", function(data, Callback)
    local fathers = {}
    local mothers = {}

    for k,v in pairs(Config.Creator.Fathers) do
        local image = Config.AssetsUrl.."creator/fathers/"..v.name..".png"

        fathers[k] = v
        fathers[k].image = image
    end

    for k,v in pairs(Config.Creator.Mothers) do
        local image = Config.AssetsUrl.."creator/mothers/"..v.name..".png"

        mothers[k] = v
        mothers[k].image = image
    end

    Callback({
        fathers = fathers,
        mothers = mothers
    })
end)

RegisterNUICallback("Creator:GetData", function(data, Callback)
    local playerPed = PlayerPedId()
    local dictionary = {}

    for k,v in pairs(Config.Creator[data.section]) do
        dictionary[k] = v
        
        if k == "hair" then
            dictionary[k].max = GetNumberOfPedDrawableVariations(playerPed, 2)
        end

        dictionary[k].value = Creator.appearance[k]
    end

    Callback(dictionary)
end)

RegisterNUICallback("Creator:SaveCharacter", function(_, Callback)
    if tonumber(Creator.genetics.age) >= 18 and tonumber(Creator.genetics.age) <= 60 then
        if #Creator.genetics.name >= 4 and #Creator.genetics.surname >= 4 then
            Skinshop:Open()
            Wait(1000)
            if Creator.mainCamera then
                DestroyCam(Creator.mainCamera)
            end
        end
    end

    Callback(true)
end)

RegisterNetEvent("fortal-character:Client:Creator:Open", function(...) 
    Creator:Open(...) 
end)

RegisterNetEvent("fortal-character:Client:Creator:Spawn", function(...)
    Creator:Spawn(...)
end)