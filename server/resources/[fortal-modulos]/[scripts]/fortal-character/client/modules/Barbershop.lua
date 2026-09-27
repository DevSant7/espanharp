Barbershop = {
    inside = false,
    mainCamera = nil,
    isSwitchingCamera = false,
    currentAppearance = {},

    Open = function(self)
        local playerPed = PlayerPedId()
        local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"
        local playerCoords = GetEntityCoords(playerPed)
        local playerHeading = GetEntityHeading(playerPed)

        self.inside = true
        self.currentAppearance = Utils.CopyTable(Sync.appearance)
        Character.cameraHeading = playerHeading
        Utils.UI("barbershop")

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
        self.inside = false
        self.currentAppearance = Utils.CopyTable(Sync.appearance)
        Utils.UI()

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
        Utils.UpdateAppearance(playerPed, Sync.appearance)
    end,

    GetData = function(self, filter)
        local playerPed = PlayerPedId()
        local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"
        local dictionary = {
            Options = {}
        }

        for k,v in pairs(Config.Barbershop.Map[filter]) do
            dictionary.Options[k] = v
            dictionary.Options[k].value = self.currentAppearance[k]
        end

        if filter == "hair" then
            dictionary.Hairstyles = {}
            dictionary.CurrentHair = GetPedDrawableVariation(playerPed, 2)

            for index=0,(GetNumberOfPedDrawableVariations(playerPed, 2) - 2) do
                table.insert(dictionary.Hairstyles, Config.AssetsUrl.."barbershop/"..playerModel.."/"..index..".webp")
            end
        end

        return dictionary
    end,

    GetPrice = function(self)
        local price = 0
        
        for _, filter in pairs({ "hair", "makeup" }) do
            local currentData = self:GetData(filter)
            
            for k,v in pairs(currentData.Options) do
                if v.value ~= Sync.appearance[k] then
                    price = price + Config.Barbershop.Map[filter][k].price
                end
            end
            
            if filter == "hair" and currentData.CurrentHair ~= Sync.appearance["hair"] then
                price = price + Config.Barbershop.Map[filter]["hair"].price
            end
        end
        

        return price
    end
}

RegisterNUICallback("Barbershop:UpdateAppearance", function(data, Callback)
    local playerPed = PlayerPedId()

    Barbershop.currentAppearance[data.id] = data.value

    Utils.UpdateAppearance(playerPed, Barbershop.currentAppearance)

    Callback({ price = Barbershop:GetPrice() })
end)

RegisterNUICallback("Barbershop:GetData", function(data, Callback)
    Callback(Barbershop:GetData(data.filter))
end)

RegisterNUICallback("Barbershop:SavePed", function(data, Callback)
    TriggerServerEvent("fortal-character:Server:Barbershop:Finish", data.price, Barbershop.currentAppearance)

    Callback(true)
end)

RegisterNetEvent("fortal-character:Client:Barbershop:Open", function()
    Barbershop:Open()
end)

RegisterNetEvent("fortal-character:Client:Barbershop:Close", function()
    Barbershop:Close()
end)