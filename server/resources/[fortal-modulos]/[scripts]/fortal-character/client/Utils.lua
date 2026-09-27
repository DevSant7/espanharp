Utils = {
    CopyTable = function(dictionary)
        local copy

        if type(dictionary) == 'table' then
            copy = {}
            for k,v in next, dictionary, nil do
                copy[Utils.CopyTable(k)] = Utils.CopyTable(v)
            end
            setmetatable(copy, Utils.CopyTable(getmetatable(dictionary)))
        else
            copy = dictionary
        end

        return copy
    end,

    ShuffleTable = function(dictionary)
        local n = #dictionary

        for i = n, 2, -1 do
            local j = math.random(1, i)
            dictionary[i], dictionary[j] = dictionary[j], dictionary[i]
        end

        return dictionary 
    end,

    PlayAnim = function(playerPed, dict, name, time)
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Wait(5)
        end

        TaskPlayAnim(playerPed, dict, name, 4.0, 4.0, time or -1, 1, 0, true, true, true)
    end,

    UpdateClothes = function(playerPed, clothesData)
        for k,v in pairs(clothesData) do
            local index = Config.Skinshop.Map[k].id
            local isProp = string.find(index, "p")
            local id = tonumber(isProp and string.sub(index, 2) or index)

            if isProp then
                SetPedPropIndex(playerPed, id, v.item or 1, v.texture or 0, true)
            else
                SetPedComponentVariation(playerPed, id, v.item or 1, v.texture or 0, 0)
            end        
        end
    end,

    UpdateAppearance = function(playerPed, appearanceData)
        SetPedHeadBlendData(playerPed, appearanceData.fathersID, appearanceData.mothersID, 0, appearanceData.skinColor, 0, 0, appearanceData.shapeMix, 0, 0, false)
        SetPedComponentVariation(playerPed, 2, appearanceData.hair, 0, 0)
        SetPedHairColor(playerPed, appearanceData.hairColor, appearanceData.hairSecondColor)
        SetPedHeadOverlay(playerPed, 2, appearanceData.eyebrow, 0.99)
        SetPedHeadOverlayColor(playerPed, 2, 1, appearanceData.eyebrowColor, appearanceData.eyebrowColor)
        SetPedHeadOverlay(playerPed, 1, appearanceData.beard, 0.99)
        SetPedHeadOverlayColor(playerPed, 1, 1, appearanceData.beardColor, appearanceData.beardColor)
        SetPedHeadOverlay(playerPed, 10, appearanceData.chest, 0.99)
        SetPedHeadOverlayColor(playerPed, 10, 1, appearanceData.chestColor, appearanceData.chestColor)
        SetPedHeadOverlay(playerPed, 5, appearanceData.blush, 0.99)
        SetPedHeadOverlayColor(playerPed, 5, 2, appearanceData.blushColor, appearanceData.blushColor)
        SetPedHeadOverlay(playerPed, 8, appearanceData.lipstick, 0.99)
        SetPedHeadOverlayColor(playerPed, 8, 2, appearanceData.lipstickColor, appearanceData.lipstickColor)
        SetPedHeadOverlay(playerPed, 0, appearanceData.blemishes, 0.99)
        SetPedHeadOverlayColor(playerPed, 0, 0, 0, 0)
        SetPedHeadOverlay(playerPed, 3, appearanceData.ageing, 0.99)
        SetPedHeadOverlayColor(playerPed, 3, 0, 0, 0)
        SetPedHeadOverlay(playerPed, 6, appearanceData.complexion, 0.99)
        SetPedHeadOverlayColor(playerPed, 6, 0, 0, 0)
        SetPedHeadOverlay(playerPed, 7, appearanceData.sundamage, 0.99)
        SetPedHeadOverlayColor(playerPed, 7, 0, 0, 0)
        SetPedHeadOverlay(playerPed, 9, appearanceData.freckles, 0.99)
        SetPedHeadOverlayColor(playerPed, 9, 0, 0, 0)
        SetPedHeadOverlay(playerPed, 4, appearanceData.makeup, 0.99)
        SetPedHeadOverlayColor(playerPed, 4, 0, 0, 0)
        SetPedEyeColor(playerPed, appearanceData.eyesColor)
        SetPedFaceFeature(playerPed, 0, appearanceData.noseWidth)
        SetPedFaceFeature(playerPed, 1, appearanceData.noseHeight)
        SetPedFaceFeature(playerPed, 2, appearanceData.noseLength)
        SetPedFaceFeature(playerPed, 3, appearanceData.noseBridge)
        SetPedFaceFeature(playerPed, 4, appearanceData.noseTip)
        SetPedFaceFeature(playerPed, 5, appearanceData.noseShift)
        SetPedFaceFeature(playerPed, 6, appearanceData.eyebrowsHeight)
        SetPedFaceFeature(playerPed, 7, appearanceData.eyebrowsWidth)
        SetPedFaceFeature(playerPed, 8, appearanceData.cheekboneHeight)
        SetPedFaceFeature(playerPed, 9, appearanceData.cheekboneWidth)
        SetPedFaceFeature(playerPed, 10, appearanceData.cheeksWidth)
        SetPedFaceFeature(playerPed, 11, appearanceData.eyesOpening)
        SetPedFaceFeature(playerPed, 12, appearanceData.lips)
        SetPedFaceFeature(playerPed, 13, appearanceData.jawWidth)
        SetPedFaceFeature(playerPed, 14, appearanceData.jawHeight)
        SetPedFaceFeature(playerPed, 15, appearanceData.chinLength)
        SetPedFaceFeature(playerPed, 16, appearanceData.chinPosition)
        SetPedFaceFeature(playerPed, 17, appearanceData.chinWidth)
        SetPedFaceFeature(playerPed, 18, appearanceData.chinShape)
        SetPedFaceFeature(playerPed, 19, appearanceData.neckWidth)
    end,

    UpdateTattoos = function(playerPed, tattoosData)
        ClearPedDecorations(playerPed)

        for overlay,collection in pairs(tattoosData) do
            AddPedDecorationFromHashes(playerPed, collection, overlay)
        end
    end,

    UpdateGender = function(gender)
        local playerId = PlayerId()
        local modelHash = GetHashKey("mp_"..gender.."_freemode_01")

        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(0)
        end

        SetPlayerModel(playerId, modelHash)

        Wait(500)

        local playerPed = PlayerPedId()

        SetEntityHealth(playerPed, 400)

        return playerPed
    end,

    GetForwardCoord = function(coords, heading, distance)        
        local x = coords.x + distance * math.sin(-heading * math.pi / 180.0)
        local y = coords.y + distance * math.cos(-heading * math.pi / 180.0)

        return vector3(x, y, coords.z)
    end,

    UI = function(route)
        local status = (route and route ~= "")

        SetNuiFocus(status, status)
        SendNUIMessage({
            action = "setVisibility",
            data = route or false
        })
    end
}