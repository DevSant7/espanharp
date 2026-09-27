Tattooshop = {
    inside = false,
    mainCamera = nil,
    isSwitchingCamera = false,
    currentTattoos = {},

    Open = function(self)
        local playerPed = PlayerPedId()
        local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"
        local playerCoords = GetEntityCoords(playerPed)
        local playerHeading = GetEntityHeading(playerPed)

        self.currentTattoos = Utils.CopyTable(Sync.tattoos)
        self.inside = true
        Character.cameraHeading = playerHeading

        Utils.UI("tattooshop")

        local cameraCoords = Config.Cameras["fullbody"]
        local forwardCoords = Utils.GetForwardCoord(playerCoords, playerHeading, cameraCoords.distance)

        self.mainCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(self.mainCamera, forwardCoords + vec3(0, 0, cameraCoords.height))
        PointCamAtEntity(self.mainCamera, playerPed, 0, 0, cameraCoords.pointOffSet)
        RenderScriptCams(true, false, 0, true, true)
        
        FreezeEntityPosition(playerPed, true)

        local clothes = {}

        for k,v in pairs(Config.Creator.Default.Clothes) do
            clothes[k] = v[playerModel]
        end

        Skinshop:SaveDefault()
        Utils.UpdateClothes(playerPed, clothes)

        if Config.Anim then
            Utils.PlayAnim(playerPed, Config.Anim.Dict, Config.Anim.Name)
        end

        TriggerEvent("hud:actions", false)
    end,

    Close = function(self)
        Utils.UI()
        self.inside = false
        self.currentTattoos = Utils.CopyTable(Sync.tattoos)

        if self.mainCamera then
            DestroyCam(self.mainCamera)
            RenderScriptCams(false, false, 0, true, true)

            self.mainCamera = nil
        end

        local playerPed = PlayerPedId()

        FreezeEntityPosition(playerPed, false)
        ClearPedTasks(playerPed)

        TriggerEvent("hud:actions", true)

        Utils.UpdateClothes(playerPed, Skinshop.defaultClothes)
        Utils.UpdateTattoos(playerPed, Sync.tattoos)
    end,

    GetData = function(self)
        local playerPed = PlayerPedId()
        local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"
        local dictionary = {}

        for k,v in pairs(Config.Tattooshop.Map[playerModel]) do
            if not dictionary[k] then
                dictionary[k] = {}
            end

            for b,c in pairs(v.List) do
                dictionary[k][b] = {
                    id = b,
                    collection = c.collection,
                    overlay = c.overlay,
                    image = Config.AssetsUrl.."tattooshop/"..playerModel.."/"..c.overlay..".webp",
                    price = v.Price,
                    active = self.currentTattoos[c.overlay],
                    camera = v.Camera
                }
            end
        end

        return dictionary
    end,

    GetPrice = function(self)
        local playerPed = PlayerPedId()
        local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"
        local price = 0

        for k,v in pairs(Config.Tattooshop.Map[playerModel]) do
            for b,c in pairs(v.List) do
                if not Sync.tattoos[c.overlay] and self.currentTattoos[c.overlay] ~= nil then
                    price = price + v.Price
                end
            end
        end
                
        return price
    end
}

RegisterNUICallback("Tattooshop:UpdateTattoos", function(data, Callback)
    local playerPed = PlayerPedId()

    if data.active then
        Tattooshop.currentTattoos[data.overlay] = data.collection
    else
        if Tattooshop.currentTattoos[data.overlay] then
            Tattooshop.currentTattoos[data.overlay] = nil
        end
    end

    Utils.UpdateTattoos(playerPed, Tattooshop.currentTattoos)

    Callback({ price = Tattooshop:GetPrice() })
end)

RegisterNUICallback("Tattoshop:ClearTattoos", function(_, Callback)
    local playerPed = PlayerPedId()

    Tattooshop.currentTattoos = {}

    Utils.UpdateTattoos(playerPed, Tattooshop.currentTattoos)

    Callback(true)
end)

RegisterNUICallback("Tattoshop:GetTattoos", function(_, Callback)
    Callback(Tattooshop:GetData())
end)

RegisterNUICallback("Tattooshop:SavePed", function(data, Callback)
    TriggerServerEvent("fortal-character:Server:Tattooshop:Finish", data.price, Tattooshop.currentTattoos)

    Callback(true)
end)

RegisterNetEvent("fortal-character:Client:Tattooshop:Open", function()
    Tattooshop:Open()
end)

RegisterNetEvent("fortal-character:Client:Tattooshop:Close", function()
    Tattooshop:Close()
end)