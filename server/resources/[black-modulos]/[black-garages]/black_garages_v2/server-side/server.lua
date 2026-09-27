local vehSpawn = {}
local vehSignal = {}
local searchTimers = {}
local inGarage = {}
garageCoords = {}
garagesData = {}
workGarages = {}
databaseGarages = {}
GlobalState["vehPlates"] = {}

Utils.functions.prepare("black/getGarages", "SELECT * FROM `black-garages`")
Utils.functions.prepare("black/insertGarage",
    "INSERT IGNORE INTO `black-garages` (name,perm,coords,vehicles,payment) VALUES (@name,@perm,@cds,@vehicles,@payment) ")
Utils.functions.prepare("black/deleteGarage", "DELETE FROM `black-garages` WHERE name = @name")

local function getGarages()
    garageCoords = Config.garageCoords
    garagesData  = Config.garageData
    workGarages  = Config.workGarages

    local query  = Utils.functions.query("black/getGarages")
    if #query > 0 then
        for a, d in pairs(query) do
            local garageTable = json.decode(d.coords)
            for k, v in pairs(garageTable) do
                garageCoords[k] = {
                    blip = v.blip,
                    spaces = v.spaces
                }

                garagesData[k] = {
                    name = d.name,
                    perm = d.perm or false,
                    payment = d.payment,
                    type = "normal"
                }

                if #d.vehicles > 0 and d.vehicles ~= "[]" then
                    if not workGarages[d.name] then
                        workGarages[d.name] = {}
                    end

                    local vehsTable = json.decode(d.vehicles)
                    for _, c in pairs(vehsTable) do
                        workGarages[d.name][#workGarages[d.name] + 1] = c
                    end
                end

                databaseGarages[a] = d
            end
        end
    end

    local configFile = LoadResourceFile("logsystem", "garageConfig.json")
    local configTable = json.decode(configFile)
    if configTable then
        for k, v in pairs(configTable) do
            garagesData[k] = v
        end
    end

    local locatesFile = LoadResourceFile("logsystem", "garageLocates.json")
    local locatesTable = json.decode(locatesFile)
    for k, v in pairs(locatesTable) do
        if not v.blip then 
            garageCoords[k] = {
                blip = {
                    x = v.x,
                    y = v.y,
                    z = v.z
                },
                spaces = {
                    ["1"] = {
                        v["1"][1],
                        v["1"][2],
                        v["1"][3],
                        v["1"][4]
                    }
                }
            }
        else
            garageCoords[k] = v
        end
    end
end

CreateThread(function()
    getGarages()
    Wait(1000)
    TriggerClientEvent("garages:allLocs", -1, garageCoords)
end)

local function getGarageNameById(garageId)
    local r = async()
    for k, v in pairs(garagesData) do
        if k == tostring(garageId) then
            r(v.name)
            return r:wait()
        end
    end
    r(nil)
    return r:wait()
end

local function isVehicleAllowedOnGarage(garageType, vehicleName)
    local r = async()
    for k, v in pairs(Config.garageTypesConfig[garageType]) do
        if v == vehicleName then
            r(true)
            return r:wait()
        end
    end
    r(nil)
    return r:wait()
end

local function getGaragesMaxIndex()
    local highestIndex = 0
    for index, _ in pairs(Config.garageCoords) do
        local numIndex = tonumber(index)
        if numIndex and numIndex > highestIndex then
            highestIndex = numIndex
        end
    end
    return highestIndex
end

local function deleteVehicle(vehNet, vehPlate)
    if GlobalState["vehPlates"][vehPlate] then
        local vehPlates = GlobalState["vehPlates"]
        vehPlates[vehPlate] = nil
        GlobalState["vehPlates"] = vehPlates
    end

    if GlobalState["Nitro"][vehPlate] then
        local Nitro = GlobalState["Nitro"]
        Nitro[vehPlate] = nil
        GlobalState["Nitro"] = Nitro
    end

    if vehSignal[vehPlate] then
        vehSignal[vehPlate] = nil
    end

    if vehSpawn[vehPlate] then
        vehSpawn[vehPlate] = nil
    end

    local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
    if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
        if GetVehicleNumberPlateText(idNetwork) == vehPlate then
            DeleteEntity(idNetwork)
        end
    end
end

local function syncPlates(vehPlate, user_id)
    local platesController = GlobalState["vehPlates"]
    platesController[vehPlate] = user_id
    GlobalState["vehPlates"] = platesController
end

local function isGarageExist(garageName)
    local r = async()
    for k, v in pairs(databaseGarages) do
        if v.name == garageName then
            r(true, k)
            return r:wait()
        end
    end
    r(false)
    return r:wait()
end

local function updateGarages(garageDBIndex)
    local garageTable = json.decode(databaseGarages[garageDBIndex].coords)

    for k, _ in pairs(garageTable) do
        garageCoords[k] = nil
        garagesData[k] = nil
    end

    table.remove(databaseGarages, garageDBIndex)

    TriggerClientEvent("garages:allLocs", -1, garageCoords)
end

function src.getGarageCoords()
    return garageCoords
end

function src.getDatabaseGarages()
    local r = async()
    local arr = {}
    for k, v in pairs(databaseGarages) do
        arr[#arr + 1] = {
            id   = k,
            name = v.name
        }
    end
    r(arr)
    return r:wait()
end

function src.checkVehicle(vehName)
    if not vehName or vehName == "" then return end

    return Utils.functions.getVehicleName(vehName) ~= nil
end

function src.deleteGarage(garageName)
    if not garageName or garageName == "" then return end

    local exist, index = isGarageExist(garageName)
    if exist then
        Utils.functions.execute("black/deleteGarage", { name = garageName })
        updateGarages(index)
    end
end

function src.checkAdminPermission()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        return Utils.functions.hasPermission(user_id, Config.adminPermission)
    end
end

function src.serverVehicle(model, x, y, z, heading, vehPlate, nitroFuel, vehDoors, vehBody)
    local spawnVehicle = 0
    local mHash = GetHashKey(model)
    local myVeh = CreateVehicle(mHash, x, y, z, heading, true, true)

    while not DoesEntityExist(myVeh) and spawnVehicle <= 1000 do
        spawnVehicle = spawnVehicle + 1
        Wait(100)
    end

    if DoesEntityExist(myVeh) then
        if vehPlate ~= nil then
            SetVehicleNumberPlateText(myVeh, vehPlate)
        else
            vehPlate = Utils.functions.generatePlate()
            SetVehicleNumberPlateText(myVeh, vehPlate)
        end

        SetVehicleBodyHealth(myVeh, ((vehBody - 0.1) + 0.1))

        if vehDoors then
            local vehDoors = json.decode(vehDoors)
            if vehDoors ~= nil then
                for k, v in pairs(vehDoors) do
                    if v then
                        SetVehicleDoorBroken(myVeh, parseInt(k), true)
                    end
                end
            end
        end

        local netVeh = NetworkGetNetworkIdFromEntity(myVeh)

        if model ~= "wheelchair" then
            local idNetwork = NetworkGetEntityFromNetworkId(netVeh)
            SetVehicleDoorsLocked(idNetwork, 2)

            local Nitro = GlobalState["Nitro"]
            Nitro[vehPlate] = nitroFuel or 0
            GlobalState["Nitro"] = Nitro
        end

        return true, netVeh, mHash, myVeh
    end

    return false
end

local function parseFormat(number)
    local left, num, right = string.match(parseInt(number), "^([^%d]*%d)(%d*)(.-)$")
    return left .. (num:reverse():gsub("(%d%d%d)", "%1."):reverse()) .. right
end

local function spawnVehicle(source, user_id, vehName, garageName)
    local spaceCoords = clientAPI.spawnPosition(source, garageName)
    local vehicle = Utils.functions.query("black/selectVehicle", { user_id = user_id, vehicle = vehName })
    local vehPlate = vehicle[1].plate
    if spaceCoords then
        local vehMods = nil
        local hasMods, vehicleMods = Utils.functions.getVehicleMods(user_id, vehName)
        if hasMods then
            vehMods = vehicleMods
        end
        if garagesData[garageName]["payment"] ~= "false" then
            if Utils.functions.isUserPremium(user_id) then
                if Utils.functions.request(source, Config.messages["remove_request"]) then
                    local netExist, netVeh, mHash = src.serverVehicle(vehName, spaceCoords[1], spaceCoords[2],
                        spaceCoords[3], spaceCoords[4], vehPlate, vehicle[1]["nitro"], vehicle[1]["doors"],
                        vehicle[1]["body"])
                    if netExist then
                        clientAPI.createVehicle(-1, mHash, netVeh, vehicle[1]["engine"], vehMods, vehicle[1]["windows"],
                            vehicle[1]["tyres"], vehName, vehPlate)
                        Utils.functions.syncVehicleFuel(vehPlate, vehicle[1]["fuel"])
                        vehSpawn[vehPlate] = { user_id, vehName, netVeh }
                        syncPlates(vehPlate, user_id)
                    end
                end
            else
                local vehPrice = vehiclePrice(vehName) * 0.01
                if inGarage[vehPlate] then
                    return
                end
                inGarage[vehPlate] = true
                if Utils.functions.request(source, string.format(Config.messages["garage_payment_request"], vehPrice)) then
                    if not vehSpawn[vehPlate] then
                        if parseInt(vehPrice * 0.01) <= 0 or Utils.functions.paymentFunction(user_id, vehPrice) then
                            local netExist, netVeh, mHash = src.serverVehicle(vehName, spaceCoords[1], spaceCoords[2],
                                spaceCoords[3], spaceCoords[4], vehPlate, vehicle[1]["nitro"], vehicle[1]["doors"],
                                vehicle[1]["body"])
                            if netExist then
                                clientAPI.createVehicle(-1, mHash, netVeh, vehicle[1]["engine"], vehMods,
                                    vehicle[1]["windows"], vehicle[1]["tyres"], vehName, vehPlate)
                                Utils.functions.syncVehicleFuel(vehPlate, vehicle[1]["fuel"])
                                vehSpawn[vehPlate] = { user_id, vehName, netVeh }
                                syncPlates(vehPlate, user_id)
                            end
                        else
                            Utils.functions.notify(source, Config.messages["insuficient_money"])
                        end
                    else
                        Utils.functions.notify(source, Config.messages["vehicle_exists"])
                    end
                end
                inGarage[vehPlate] = false
            end
        else
            if Utils.functions.request(source, Config.messages["remove_request"]) then
                local netExist, netVeh, mHash = src.serverVehicle(vehName, spaceCoords[1], spaceCoords[2], spaceCoords
                [3], spaceCoords[4], vehPlate, vehicle[1]["nitro"], vehicle[1]["doors"], vehicle[1]["body"])
                if netExist then
                    clientAPI.createVehicle(-1, mHash, netVeh, vehicle[1]["engine"], vehMods, vehicle[1]["windows"],
                        vehicle[1]["tyres"], vehName, vehPlate)
                    Utils.functions.syncVehicleFuel(vehPlate, vehicle[1]["fuel"])
                    vehSpawn[vehPlate] = { user_id, vehName, netVeh }
                    syncPlates(vehPlate, user_id)
                end
            end
            inGarage[vehPlate] = false
        end
    end
end

function src.tryDelete(vehNet, vehEngine, vehBody, vehFuel, vehDoors, vehWindows, vehTyres, vehPlate)
    if vehSpawn[vehPlate] then
        local user_id = vehSpawn[vehPlate][1]
        local vehName = vehSpawn[vehPlate][2]

        if parseInt(vehEngine) <= 100 then
            vehEngine = 100
        end

        if parseInt(vehBody) <= 100 then
            vehBody = 100
        end

        if parseInt(vehFuel) >= 100 then
            vehFuel = 100
        end

        if parseInt(vehFuel) <= 0 then
            vehFuel = 0
        end

        local vehicle = Utils.functions.query("black/selectVehicle", { user_id = user_id, vehicle = vehName })
        if vehicle[1] ~= nil then
            Utils.functions.execute("black/updateVehicle",
                { user_id = user_id, vehicle = vehName, nitro = GlobalState["Nitro"][vehPlate] or 0, engine = parseInt(
                vehEngine), body = parseInt(vehBody), fuel = parseInt(vehFuel), doors = json.encode(vehDoors), windows =
                json.encode(vehWindows), tyres = json.encode(vehTyres) })
        end
    end
    deleteVehicle(vehNet, vehPlate)
end

function src.insertSpawnedVehicle(vehPlate, vehData)
    vehSpawn[vehPlate] = vehData
end

function src.getGarageVehicles(garageId)
    local source = source
    local r = async()
    local user_id = Utils.functions.getUserId(source)
    local arr = {}
    local userVehicles = Utils.functions.query("black/getUserVehicles", { user_id = user_id })
    local garageName = getGarageNameById(garageId)
    if user_id then
        if Utils.functions.playerHasFines(user_id) then
            Utils.functions.notify(source, Config.messages["has_fines"])
            return false
        end

        if Utils.functions.isPlayerWanted(user_id) then
            Utils.functions.notify(source, Config.messages["player_wanted"])
            return false
        end

        if garagesData[garageId]["perm"] ~= nil and garagesData[garageId]["perm"] ~= "" then
            if not Utils.functions.hasPermission(user_id, garagesData[garageId]["perm"]) then
                return false
            end
        end

        for _, v in pairs(userVehicles) do
            if v.work == "true" then
                if workGarages[garageName] then
                    arr[#arr + 1] = {
                        title = Utils.functions.getVehicleName(v.vehicle),
                        vehicle = v.vehicle,
                        maxSpeed = 50,
                        braking = 50,
                        traction = 50,
                        acceleration = 50,
                        stats = {
                            {
                                type = "Motor",
                                value = parseInt(v.engine / 10)
                            },
                            {
                                type = "Lataria",
                                value = parseInt(v.body / 10)
                            },
                            {
                                type = "Gasolina",
                                value = v.fuel
                            },
                            {
                                type = "Porta-Malas",
                                value = Utils.functions.getVehicleTrunk(user_id, v.vehicle)
                            }
                        }
                    }
                end
            else
                if garagesData[garageId]["type"] ~= "normal" and Config.garageTypesConfig[garagesData[garageId]["type"]] then
                    if isVehicleAllowedOnGarage(garagesData[garageId]["type"], v.vehicle) then
                        arr[#arr + 1] = {
                            title = Utils.functions.getVehicleName(v.vehicle),
                            vehicle = v.vehicle,
                            maxSpeed = 50,
                            braking = 50,
                            traction = 50,
                            acceleration = 50,
                            stats = {
                                {
                                    type = "Motor",
                                    value = parseInt(v.engine / 10)
                                },
                                {
                                    type = "Lataria",
                                    value = parseInt(v.body / 10)
                                },
                                {
                                    type = "Gasolina",
                                    value = v.fuel
                                },
                                {
                                    type = "Porta-Malas",
                                    value = Utils.functions.getVehicleTrunk(user_id, v.vehicle)
                                }
                            }
                        }
                    end
                else
                    arr[#arr + 1] = {
                        title = Utils.functions.getVehicleName(v.vehicle),
                        vehicle = v.vehicle,
                        maxSpeed = 50,
                        braking = 50,
                        traction = 50,
                        acceleration = 50,
                        stats = {
                            {
                                type = "Motor",
                                value = parseInt(v.engine / 10)
                            },
                            {
                                type = "Lataria",
                                value = parseInt(v.body / 10)
                            },
                            {
                                type = "Gasolina",
                                value = v.fuel
                            },
                            {
                                type = "Porta-Malas",
                                value = Utils.functions.getVehicleTrunk(user_id, v.vehicle)
                            }
                        }
                    }
                end
            end
        end

        if workGarages[garageName] then
            arr = {}
            for _, v in pairs(workGarages[garageName]) do
                arr[#arr + 1] = {
                    title = Utils.functions.getVehicleName(v),
                    vehicle = v,
                    maxSpeed = 50,
                    braking = 50,
                    traction = 50,
                    acceleration = 50,
                    stats = {
                        {
                            type = "Motor",
                            value = 100
                        },
                        {
                            type = "Lataria",
                            value = 100
                        },
                        {
                            type = "Gasolina",
                            value = 100
                        },
                        {
                            type = "Porta-Malas",
                            value = Utils.functions.getVehicleTrunk(user_id, v)
                        }
                    }
                }
            end
        end

        for k, v in pairs(arr) do
            for _, c in pairs(Config.garageTypesConfig["heli"]) do
                if garagesData[garageId]["type"] ~= "heli" then
                    if c == v.vehicle then
                        arr[k] = nil
                    end
                end
            end
        end

        r(arr)
        return r:wait()
    end

    r(false)
    return r:wait()
end

function src.getVehicleByOwner(vehName)
    local source = source
    local r = async()
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        for k, v in pairs(vehSpawn) do
            if v[1] == user_id and v[2] == vehName then
                r(v[3])
                return r:wait()
            end
        end
    end
    r(nil)
    return r:wait()
end

function src.saveGarage(name, type, permission, blipCoords, spaceCoords, vehicles)
    local index = tostring(getGaragesMaxIndex() + 1)
    local garageData = {}
    if not Config.garageCoords[index] then
        garageData[index] = {
            blip = {
                x = blipCoords[1],
                y = blipCoords[2],
                z = blipCoords[3]
            },
            spaces = {}
        }
    end

    local currentCount = 0 
    for _, v in ipairs(spaceCoords) do
        currentCount = currentCount + 1
        local spaceIndex = tostring(currentCount) 
        garageData[index].spaces[spaceIndex] = { v[1], v[2], v[3], v[4] }
    end

    Utils.functions.execute("black/insertGarage", {
        name = name,
        perm = permission,
        cds = json.encode(garageData),
        vehicles = json.encode(vehicles) or nil,
        payment = tostring(false)
    })
    getGarages()
    TriggerClientEvent("garages:allLocs", -1, garageCoords)
end

function src.spawnVehicle(vehName, garageName)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        local hasVehicle = Utils.functions.query("black/selectVehicle", { user_id = user_id, vehicle = vehName })[1]

        if hasVehicle == nil then 
            Utils.functions.execute("black/addVehicles",{ user_id = user_id, vehicle = vehName, plate = vRP.generatePlate(), work = "true" })
        end
        
        Wait(200)
        local query = Utils.functions.query("black/selectVehicle", { user_id = user_id, vehicle = vehName })
        local platesController = GlobalState["vehPlates"]
        local vehPlate = query[1].plate

        if vehSpawn[vehPlate] then
            if vehSignal[vehPlate] == nil then
                if searchTimers[user_id] == nil then
                    searchTimers[user_id] = os.time()
                end

                if os.time() >= parseInt(searchTimers[user_id]) then
                    searchTimers[user_id] = os.time() + 60

                    local vehNet = vehSpawn[vehPlate][3]
                    local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
                    local vehCoords = GetEntityCoords(idNetwork)
                    if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 and vehSpawn[vehPlate] then
                        clientAPI.searchBlip(source, vehCoords)
                        Utils.functions.notify(source, Config.messages["tracker_activated"])
                        return
                    end

                    if vehSpawn[vehPlate] then
                        vehSpawn[vehPlate] = nil
                    end

                    if platesController[vehPlate] then
                        platesController[vehPlate] = nil
                        GlobalState["vehPlates"] = platesController
                    end

                    Utils.functions.notify(source, Config.messages["rescue_succes"])
                else
                    Utils.functions.notify(source, Config.messages["tracker_warning"])
                end
            else
                Utils.functions.notify(source, Config.messages["tracker_false"])
            end
        else
            if query[1].rental ~= 0 then
                if query[1].rental <= os.time() then
                    Utils.functions.notify(source, Config.messages["rental_expired"])
                    return
                end
            end

            if query[1].tax <= os.time() then
                local vehiclePrice = parseInt(Utils.functions.getVehiclePrice(vehName) * 0.04)
                if not exports["fleeca-bank"]:existImpostCar(user_id,"Taxa de veículo:"..vehName.." atrasada.",vehiclePrice) then 
                    TriggerEvent("bank:create-imposts-car",source,"Taxa de veículo:"..vehName.." atrasada.",vehiclePrice,"cars",vehName,user_id)
                end
                
                if Config.paymentTax then
                    if Utils.functions.request(source, string.format(Config.messages["request_tax"], vehiclePrice), 5000) then
                        if Utils.functions.paymentFunction(user_id, vehiclePrice) then
                            Utils.functions.execute("black/updateVehiclesTax", {
                                user_id = user_id,
                                vehicle = vehName
                            })
                            TriggerEvent("bank:delete-impost-car",user_id,"Taxa de veículo:"..vehName.." atrasada.",vehiclePrice)
                            spawnVehicle(source, user_id, vehName, garageName)
                        else
                            Utils.functions.notify(source, Config.messages["insuficient_money"])
                        end
                    end
                else
                    Utils.functions.notify(source, Config.messages["expired_tax"])
                end
            else
                spawnVehicle(source, user_id, vehName, garageName)
            end
        end
    end
end

RegisterNetEvent("black:lockVehicle")
AddEventHandler("black:lockVehicle", function(vehNet, vehPlate)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if GlobalState["vehPlates"][vehPlate] == user_id then
            TriggerEvent("black:keyVehicle", source, vehNet)
        end
    end
end)

RegisterNetEvent("black:keyVehicle")
AddEventHandler("black:keyVehicle", function(source, vehNet)
    if Utils.functions.isHandcuffed(source) then
        Utils.functions.notify(source, "Você está algemado e não pode usar as chaves do veículo.", "vermelho")
        return
    end

    local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
    local doorStatus = GetVehicleDoorLockStatus(idNetwork)

    if parseInt(doorStatus) <= 1 then
        Utils.functions.notify(source, Config.messages["lock_vehicle"], "verde")
        Utils.functions.lockSound(source)
        SetVehicleDoorsLocked(idNetwork, 2)
    else
        Utils.functions.notify(source, Config.messages["unlock_vehicle"], "vermelho")
        Utils.functions.unlockSound(source)
        SetVehicleDoorsLocked(idNetwork, 1)
    end

    if not clientAPI.IsPedInVehicle(source) then
        Utils.functions.playAnim(source, true, { "anim@mp_player_intmenu@key_fob@", "fob_click" }, false)
        Wait(400)
        Utils.functions.stopAnim(source)
    end
end)


RegisterNetEvent("black:vehicleKey")
AddEventHandler("black:vehicleKey", function(entity)
    local source = source
    local vehPlate = entity[1]
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        if GlobalState["vehPlates"][vehPlate] == user_id then
            Utils.functions.generateItem(user_id, "vehkey-" .. vehPlate, 1)
        end
    end
end)

RegisterNetEvent("signalRemove")
AddEventHandler("signalRemove", function(vehPlate)
    vehSignal[vehPlate] = true
end)

RegisterNetEvent("plateReveryone")
AddEventHandler("plateReveryone", function(vehPlate)
    if GlobalState["vehPlates"][vehPlate] then
        local vehPlates = GlobalState["vehPlates"]
        vehPlates[vehPlate] = nil
        GlobalState["vehPlates"] = vehPlates
    end
end)

RegisterNetEvent("plateEveryone")
AddEventHandler("plateEveryone", function(vehPlate)
    local vehPlates = GlobalState["vehPlates"]
    vehPlates[vehPlate] = true
    GlobalState["vehPlates"] = vehPlates
    TriggerClientEvent("updateVehPlateState", -1, vehPlate, GlobalState["vehPlates"])
end)

RegisterNetEvent("checkVehiclePlate")
AddEventHandler("checkVehiclePlate", function(platext)
    local source = source
    local state = GlobalState["vehPlates"] and GlobalState["vehPlates"][platext] or false
    TriggerClientEvent("updateVehPlateState", source, platext, state)
end)

RegisterNetEvent("platePlayers")
AddEventHandler("platePlayers", function(vehPlate, user_id)
    local userPlate = Utils.functions.getUserByPlate(vehPlate)
    if not userPlate then
        local vehPlates = GlobalState["vehPlates"]
        vehPlates[vehPlate] = user_id
        GlobalState["vehPlates"] = vehPlates
    end
end)

RegisterNetEvent("garages:deleteVehicleAdmin")
AddEventHandler("garages:deleteVehicleAdmin", function(entity)
    deleteVehicle(entity[1], entity[2])
end)

RegisterNetEvent("garages:deleteVehicle")
AddEventHandler("garages:deleteVehicle", function(vehNet, vehPlate)
    deleteVehicle(vehNet, vehPlate)
end)

RegisterNetEvent("garages:updateGarages")
AddEventHandler("garages:updateGarages", function(homeName, homeInfos)
    local formattedHomeInfos = {
        blip = {
            x = homeInfos.x, 
            y = homeInfos.y, 
            z = homeInfos.z 
        },
        spaces = { ["1"] = homeInfos["1"] }
    }
    garagesData[homeName] = { ["name"] = homeName, ["payment"] = false,type = "normal" }

    local configFile = LoadResourceFile("logsystem", "garageConfig.json")
    local configTable = json.decode(configFile)
    configTable[homeName] = { ["name"] = homeName, ["payment"] = false,type = "normal" }
    SaveResourceFile("logsystem", "garageConfig.json", json.encode(configTable), -1)

    local locatesFile = LoadResourceFile("logsystem", "garageLocates.json")

    local locatesTable = json.decode(locatesFile)
    locatesTable[homeName] = formattedHomeInfos
    SaveResourceFile("logsystem", "garageLocates.json", json.encode(locatesTable), -1)

    TriggerClientEvent("garages:updateLocs", -1, homeName, formattedHomeInfos)
end)

RegisterNetEvent("garages:removeGarages")
AddEventHandler("garages:removeGarages", function(homeName)
    if garagesData[homeName] then
        garagesData[homeName] = nil

        local configFile = LoadResourceFile("logsystem", "garageConfig.json")
        local configTable = json.decode(configFile)
        if configTable[homeName] then
            configTable[homeName] = nil
            SaveResourceFile("logsystem", "garageConfig.json", json.encode(configTable), -1)
        end

        local locatesFile = LoadResourceFile("logsystem", "garageLocates.json")
        local locatesTable = json.decode(locatesFile)
        if locatesTable[homeName] then
            locatesTable[homeName] = nil
            SaveResourceFile("logsystem", "garageLocates.json", json.encode(locatesTable), -1)
        end

        TriggerClientEvent("garages:updateRemove", -1, homeName)
    end
end)

AddEventHandler("playerConnect", function(user_id, source)
    TriggerClientEvent("garages:allLocs", source, garageCoords)
end)

AddEventHandler("playerDisconnect", function(user_id)
    if searchTimers[user_id] then
        searchTimers[user_id] = nil
    end
end)

exports("vehSignal", function(vehPlate)
    return vehSignal[vehPlate]
end)

RegisterServerEvent("garage:hasSignalBlocker")
AddEventHandler("garage:hasSignalBlocker", function(plate)
    local src = source
    local hasSignalBlocker = exports["black_garages_v2"]:vehSignal(plate) ~= nil

    TriggerClientEvent("garage:returnSignalBlocker", src, hasSignalBlocker)
end)