local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
vPLAYER = Tunnel.getInterface("coreP")
Utils = {}

Utils.database = "vehicles"

Utils.functions = {
    prepare = function(...)
        vRP.prepare(...)
    end,
    query = function(...)
        return vRP.query(...)
    end,    
    execute = function(...)
        return vRP.execute(...)
    end,
    getUserId = function(source)
        return vRP.getUserId(source)
    end,    
    hasPermission = function(user_id,perm)
        return vRP.hasPermission(user_id,perm)
    end,
    getUserIdentity = function(user_id)
        return vRP.userIdentity(user_id)
    end,
    getUserName = function(user_id)
        return Utils.functions.getUserIdentity(user_id).name 
    end,
    getUserSource = function(user_id)
        return vRP.userSource(user_id)
    end,    
    notify = function(source,message,icon)
        return TriggerClientEvent("Notify",source,icon or "aviso",message,5000)
    end,
    request = function(source,message)
        return vRP.request(source,message,5000)
    end,
    getUserByPlate = function(vehPlate)
        return vRP.userPlate(vehPlate)
    end,
    generatePlate = function()
        return vRP.generatePlate()
    end,
    playerHasFines = function(user_id)
        return vRP.getFines(user_id) > 0 
    end,
    isPlayerWanted = function(user_id)
        return false
    end,   
    getVehicleName = function(vehSpawn)
        return vehicleName(vehSpawn)
    end,
    getVehicleTrunk = function(user_id,vehName)
        local result = vRP.getSrvdata("vehChest:"..user_id..":"..vehName)
        return vRP.chestWeight(result) 
    end,
    getVehiclePrice = function(vehName)
        return vehiclePrice(vehName)
    end,
    paymentFunction = function(user_id,price)
        return vRP.paymentFull(user_id,price)
    end,
    request = function(source,message,delay)
        return vRP.request(source,message,delay)
    end,
    isUserPremium = function(user_id)
        local premiumGroups = {
            "Prata",
            "Bronze",
            "Ouro",
            "Diamante"
        }
    
        for _, group in ipairs(premiumGroups) do
            if vRP.hasPermission(user_id, group) then
                return true
            end
        end
    
        return false
    end,
    getVehicleMods = function(user_id,vehName)
        local custom = vRP.query("entitydata/getData", { dkey = "custom:" .. user_id .. ":" .. vehName })
        if parseInt(#custom) > 0 then
            return true,custom[1]["dvalue"]
        end
    end,
    syncVehicleFuel = function(vehPlate,value)
        TriggerEvent("engine:tryFuel", vehPlate, value)
    end,
    playAnim = function(source,bool,anim,walk)
        return vRPC.playAnim(source,bool,anim,walk)
    end,
    stopAnim = function(source)
        return vRPC.stopAnim(source)
    end,
    lockSound = function(source)
        TriggerClientEvent("sounds:source", source, "locked", 0.4)
    end,
    unlockSound = function(source)
        TriggerClientEvent("sounds:source", source, "unlocked", 0.4)
    end,
    getNearestVehicles = function(source,dist)
        return vRPC.nearVehicle(source,dist)
    end,
    generateItem = function(user_id,itemName,amount)
        return vRP.generateItem(user_id,itemName,amount,true)
    end,
    isHandcuffed = function(source)
        return vPLAYER.getHandcuff(source)
    end    
}

Utils.functions.prepare("black/getUserVehicles", "SELECT * FROM "..Utils.database.." WHERE user_id = @user_id")
Utils.functions.prepare("black/selectVehicle","SELECT * FROM "..Utils.database.." WHERE user_id = @user_id AND vehicle = @vehicle")
Utils.functions.prepare("black/updateVehicle","UPDATE "..Utils.database.." SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, nitro = @nitro WHERE user_id = @user_id AND vehicle = @vehicle")
Utils.functions.prepare("black/addVehicles","INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
Utils.functions.prepare("black/updateVehiclesTax","UPDATE vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")

RegisterNetEvent("plateRobberys")
AddEventHandler("plateRobberys", function(vehPlate, vehName)
    if vehPlate ~= nil and vehName ~= nil then
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
            if GlobalState["vehPlates"][vehPlate] ~= user_id then
                local vehPlates = GlobalState["vehPlates"]
                vehPlates[vehPlate] = user_id
                GlobalState["vehPlates"] = vehPlates
            end

            vRP.generateItem(user_id, "vehkey-" .. vehPlate, 1, true, false)

            if math.random(100) >= 50 then
                local ped = GetPlayerPed(source)
                local coords = GetEntityCoords(ped)

                local policeResult = vRP.numPermission("Police")
                for k, v in pairs(policeResult) do
                    async(function()
                        TriggerClientEvent("NotifyPush", v,{ code = 31, title = "Roubo de Veículo", x = coords["x"], y = coords["y"], z = coords["z"], vehicle = vehicleName(vehName) .. " - " .. vehPlate, time = "Recebido às " .. os.date("%H:%M"), blipColor = 44 })
                    end)
                end
            end
        end
    end
end)

function src.impound()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local myVehicle = {}
        local vehicle = vRP.query("black/getUserVehicles", { user_id = user_id })

        for k, v in ipairs(vehicle) do
            if v["arrest"] >= os.time() then
                table.insert(myVehicle,
                    { ["model"] = vehicle[k]["vehicle"], ["name"] = vehicleName(vehicle[k]["vehicle"]) })
            end
        end

        return myVehicle
    end
end

RegisterNetEvent("garages:Impound")
AddEventHandler("garages:Impound", function(vehName)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local vehPrice = vehiclePrice(vehName)
        TriggerClientEvent("dynamic:closeSystem", source)

        if vRP.request(source, "A liberação do veículo tem o custo de <b>$" .. parseFormat(vehPrice * 0.25) .. "</b> dólares, deseja prosseguir com a liberação do mesmo?") then
            if vRP.paymentFull(user_id, vehPrice * 0.25) then
                vRP.execute("vehicles/paymentArrest", { user_id = user_id, vehicle = vehName })
                TriggerClientEvent("Notify", source, "verde", "Veículo liberado.", 5000)
            else
                TriggerClientEvent("Notify", source, "vermelho", "<b>Dólares</b> insuficientes.", 5000)
            end
        end
    end
end)

RegisterCommand("car",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasGroup(user_id,"Admin") and args[1] then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local heading = GetEntityHeading(ped)
			local vehPlate = "VEH"..math.random(10000,99999)
			local netExist,netVeh,mHash,myVeh = src.serverVehicle(args[1],coords["x"],coords["y"],coords["z"],heading,vehPlate,200,nil,1000)
			if not netExist then
				return
			end

			clientAPI.createVehicle(-1,mHash,netVeh,1000,nil,false,false,vehName,vehPlate)
            src.insertSpawnedVehicle(vehPlate,{ user_id,vehName,netVeh })
			TriggerEvent("engine:tryFuel",vehPlate,100)
			SetPedIntoVehicle(ped,myVeh,-1)

			local vehPlates = GlobalState["vehPlates"]
			vehPlates[vehPlate] = user_id
			GlobalState["vehPlates"] = vehPlates

            exports["config"]:SendLog("VehicleSpawn",user_id,nil,{
                ["1"] = args[1],
                Coords = coords
            })
		end
	end
end)

RegisterCommand("dv",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasGroup(user_id, "Admin") then
            local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
            local vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,5)
			if vehicle then
                TriggerEvent("garages:deleteVehicle",vehNet,vehPlate)
                exports["config"]:SendLog("VehicleDelete",user_id,nil,{
                    ["1"] = vehName,
                    Coords = coords 
                })
            end
        end
    end
end)