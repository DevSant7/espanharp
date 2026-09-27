Skinshop = {
    inside = false,
    mainCamera = nil,
    isSwitchingCamera = false,
    defaultClothes = {},

    Open = function(self)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local playerHeading = GetEntityHeading(playerPed)

        self.inside = true
        self:SaveDefault()
        Character.cameraHeading = playerHeading
        Utils.UI("skinshop")

        local cameraCoords = Config.Cameras["fullbody"]
        local forwardCoords = Utils.GetForwardCoord(playerCoords, Creator.inside and Config.Creator.Coords.h or playerHeading, cameraCoords.distance)

        self.mainCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(self.mainCamera, forwardCoords + vec3(0, 0, cameraCoords.height))
        PointCamAtEntity(self.mainCamera, playerPed, 0, 0, cameraCoords.pointOffSet)
        RenderScriptCams(true, false, 0, true, true)
        
        FreezeEntityPosition(playerPed, true)
        
        if Config.Anim then
            Utils.PlayAnim(playerPed, Config.Anim.Dict, Config.Anim.Name)
        end
        
        TriggerEvent("hud:actions", false)
    end,

    Close = function(self)
        local playerPed = PlayerPedId()
        local insideCreator = Creator.inside

        Utils.UI()

        if Creator.inside then
            DoScreenFadeOut(250)
            Wait(500)
        end
        
        self.inside = false

        if self.mainCamera then
            DestroyCam(self.mainCamera)
            RenderScriptCams(false, false, 0, true, true)

            self.mainCamera = nil
        end

        if insideCreator then
            Creator.inside = false
            Creator.appearance = Config.Creator.Default.Appearance
            Creator.genetics = {
                name = "",
                surname = "",
                age = 0,
                gender = "m"
            }
        else
            FreezeEntityPosition(playerPed, false)
            ClearPedTasks(playerPed)

            TriggerEvent("hud:actions", true)
        end
        
        Utils.UpdateClothes(playerPed, self.defaultClothes)
    end,

    SaveDefault = function(self)
        local playerPed = PlayerPedId()
        local clothesData = self:GetData()

        self.defaultClothes = clothesData
    end,

    GetData = function(self)
        local playerPed = PlayerPedId()
        local dictionary = {}

        for section, data in pairs(Config.Skinshop.Map) do
            local isProp = string.find(data.id, "p")
            local id = tonumber(isProp and string.sub(data.id, 2) or data.id)

            local item = (isProp and GetPedPropIndex or GetPedDrawableVariation)(playerPed, id)
            local texture = (isProp and GetPedPropTextureIndex or GetPedTextureVariation)(playerPed, id)

            dictionary[section] = {
                item = item,
                texture = texture
            }
        end

        return dictionary
    end,

    GetPrice = function(self)
        local currentData = self:GetData()
        local price = 0

        for section, data in pairs(self.defaultClothes) do
            if data.item ~= currentData[section].item then     
                price = price + Config.Skinshop.Map[section].price
            end
        end

        return price
    end
}

RegisterNUICallback("Skinshop:UpdateClothes", function(data, Callback)
    local playerPed = PlayerPedId()
    local clothesData = Skinshop:GetData()

    if data.section and data.item then
        clothesData[data.section] = data
    
        Utils.UpdateClothes(playerPed, clothesData)
    end
    
    Callback({ price = Skinshop:GetPrice() })
end)

RegisterNUICallback("Skinshop:GetClothes", function(_, Callback)
    local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"
    local dictionary = {}

    for section, data in pairs(Config.Skinshop.Map) do
        if not dictionary[section] then
            dictionary[section] = {}
        end

        local isProp = string.find(data.id, "p")
        local id = tonumber(isProp and string.sub(data.id, 2) or data.id)
        
        local item = (isProp and GetPedPropIndex or GetPedDrawableVariation)(playerPed, id)
        local texture = (isProp and GetPedPropTextureIndex or GetPedTextureVariation)(playerPed, id)

        local maxItems = (isProp and GetNumberOfPedPropDrawableVariations or GetNumberOfPedDrawableVariations)(playerPed, id) - 1

        for index = 0, maxItems do
            local maxTextures = (isProp and GetNumberOfPedPropTextureVariations or GetNumberOfPedTextureVariations)(playerPed, id, index)
            
            table.insert(dictionary[section], {
                id = index,
                image = Config.AssetsUrl.."skinshop/"..section.."/"..playerModel.."/"..index..".webp",
                price = Creator.inside and 0 or data.price,
                active = (index == item),
                camera = data.camera,
                texture = {
                    selected = texture,
                    options = maxTextures - 1,
                },
            })
        end
    end

    Callback(dictionary)
end)

RegisterNUICallback("Skinshop:SavePed", function(data, Callback)
    local price = tonumber(data.price)
    if not price then 
        return Callback(false) 
    end
    
    local clothesData = Skinshop:GetData()

    if Creator.inside then
        TriggerServerEvent("fortal-character:Server:Creator:Finish", Creator.genetics, Creator.appearance, clothesData)
    else
        TriggerServerEvent("fortal-character:Server:Skinshop:Finish", data.price, clothesData)
    end

    Callback(true)
end)

RegisterNUICallback("Skinshop:GetInCreator", function(_, Callback)
    Callback(Creator.inside)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:Open", function(...) 
    Skinshop:Open(...) 
end)

RegisterNetEvent("fortal-character:Client:Skinshop:Close", function() 
    Skinshop:Close()
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SaveDefault", function(data)
    local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Skinshop.defaultClothes = data
    Utils.UpdateClothes(playerPed, data)
end)       

RegisterNetEvent("fortal-character:Client:Skinshop:SetMask", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

	Utils.PlayAnim(playerPed, "missfbi4","takeoff_mask", 1000)

	SetTimeout(1000, function()
		if GetPedDrawableVariation(playerPed,1) == Skinshop.defaultClothes["mask"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["mask"][playerModel]["item"]
			SetPedComponentVariation(playerPed,1,defaultItem,0,1)
		else
			SetPedComponentVariation(playerPed,1,Skinshop.defaultClothes["mask"]["item"],Skinshop.defaultClothes["mask"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetHat", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

	Utils.PlayAnim(playerPed, "veh@common@fp_helmet@","take_off_helmet_stand", 1000)

	SetTimeout(1000, function()
		if GetPedPropIndex(playerPed,0) == Skinshop.defaultClothes["hat"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["hat"][playerModel]["item"]
            SetPedPropIndex(playerPed,0,defaultItem,0,1)
		else
			SetPedPropIndex(playerPed,0,Skinshop.defaultClothes["hat"]["item"],Skinshop.defaultClothes["hat"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetGlasses", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Utils.PlayAnim(playerPed, "mini@ears_defenders","takeoff_earsdefenders_idle", 1000)

	SetTimeout(1000, function()
		if GetPedPropIndex(playerPed,1) == Skinshop.defaultClothes["glass"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["glass"][playerModel]["item"]
            SetPedPropIndex(playerPed,1,defaultItem,0,1)
		else
			SetPedPropIndex(playerPed,1,Skinshop.defaultClothes["glass"]["item"],Skinshop.defaultClothes["glass"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetArms", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Utils.PlayAnim(playerPed, "clothingshirt","try_shirt_positive_d", 2500)

    SetTimeout(2500, function()
		if GetPedDrawableVariation(playerPed,3) == Skinshop.defaultClothes["arms"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["arms"][playerModel]["item"]
			SetPedComponentVariation(playerPed,3,defaultItem,0,1)
		else
			SetPedComponentVariation(playerPed,3,Skinshop.defaultClothes["arms"]["item"],Skinshop.defaultClothes["arms"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetShoes", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Utils.PlayAnim(playerPed, "clothingshoes","try_shoes_positive_d", 2500)

	SetTimeout(2500, function()
		if GetPedDrawableVariation(playerPed,6) == Skinshop.defaultClothes["shoes"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["shoes"][playerModel]["item"]
			SetPedComponentVariation(playerPed,6,defaultItem,0,1)
		else
			SetPedComponentVariation(playerPed,6,Skinshop.defaultClothes["shoes"]["item"],Skinshop.defaultClothes["shoes"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetPants", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Utils.PlayAnim(playerPed, "clothingtrousers","try_trousers_neutral_c", 2500)

	SetTimeout(2500, function()
		if GetPedDrawableVariation(playerPed,4) == Skinshop.defaultClothes["pants"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["pants"][playerModel]["item"]
            SetPedComponentVariation(playerPed,4,defaultItem,0,1)
		else
			SetPedComponentVariation(playerPed,4,Skinshop.defaultClothes["pants"]["item"],Skinshop.defaultClothes["pants"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetShirt", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Utils.PlayAnim(playerPed, "clothingshirt","try_shirt_positive_d", 2500)

	SetTimeout(2500, function()
		if GetPedDrawableVariation(playerPed,8) == Skinshop.defaultClothes["tshirt"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["tshirt"][playerModel]["item"]
            SetPedComponentVariation(playerPed,8,defaultItem,0,1)
		else
			SetPedComponentVariation(playerPed,8,Skinshop.defaultClothes["tshirt"]["item"],Skinshop.defaultClothes["tshirt"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetJacket", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Utils.PlayAnim(playerPed, "clothingshirt","try_shirt_positive_d", 2500)

	SetTimeout(2500, function()
		if GetPedDrawableVariation(playerPed,11) == Skinshop.defaultClothes["torso"]["item"] then
            local defaultItem = Config.Creator.Default.Clothes["torso"][playerModel]["item"]
            local defaultArms = Config.Creator.Default.Clothes["arms"][playerModel]["item"]

            SetPedComponentVariation(playerPed,11,defaultItem,0,1)
            SetPedComponentVariation(playerPed,3,defaultArms,0,1)
		else
			SetPedComponentVariation(playerPed,11,Skinshop.defaultClothes["torso"]["item"],Skinshop.defaultClothes["torso"]["texture"],1)
		end
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:SetVest", function()
	local playerPed = PlayerPedId()
    local playerModel = (GetEntityModel(playerPed) == GetHashKey("mp_m_freemode_01")) and "m" or "f"

    Utils.PlayAnim(playerPed, "clothingshirt","try_shirt_positive_d", 2500)

    SetTimeout(2500, function()
        local defaultItem = Config.Creator.Default.Clothes["vest"][playerModel]["item"]
        SetPedComponentVariation(playerPed,9,defaultItem,0,1)
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:ToggleBackpack", function(numBack)
    local playerPed = PlayerPedId()

    Utils.PlayAnim(playerPed, "missmic4","michael_tux_fidget", 2000)

	SetTimeout(2500, function()
		if Skinshop.defaultClothes["backpack"]["item"] == tonumber(numBack) then
			Skinshop.defaultClothes["backpack"]["item"] = 0
			Skinshop.defaultClothes["backpack"]["texture"] = 0
		else
			Skinshop.defaultClothes["backpack"]["texture"] = 0
			Skinshop.defaultClothes["backpack"]["item"] = tonumber(numBack)
		end

		SetPedComponentVariation(playerPed,5,Skinshop.defaultClothes["backpack"]["item"],Skinshop.defaultClothes["backpack"]["texture"],1)

        TriggerServerEvent("fortal-character:Server:Skinshop:Save", nil, Skinshop.defaultClothes)
	end)
end)

RegisterNetEvent("fortal-character:Client:Skinshop:RemoveBackpack", function(numBack)
    local playerPed = PlayerPedId()

    Utils.PlayAnim(playerPed, "missmic4","michael_tux_fidget", 2000)

	SetTimeout(2500, function()
		if Skinshop.defaultClothes["backpack"]["item"] == tonumber(numBack) then
			Skinshop.defaultClothes["backpack"]["item"] = 0
			Skinshop.defaultClothes["backpack"]["texture"] = 0
			SetPedComponentVariation(playerPed,5,0,0,1)

			TriggerServerEvent("fortal-character:Server:Skinshop:Save", nil, Skinshop.defaultClothes)
		end
	end)
end)

vFunc.getCustomization = function()
	return Skinshop.defaultClothes
end 

vFunc.checkBackpack = function()
    return Skinshop.defaultClothes["backpack"]["item"] > 0 
end
