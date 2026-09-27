-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("desmanche",cnVRP)
vDISM = Tunnel.getInterface("desmanche")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehListActived = {}
local userList = {}

local webhookdesmanche = "https://discord.com/api/webhooks/1362826715348603032/eqEULT9_4lzCrcnLCOpvZIVtCpX6-JjivRK7NeQupox_9QhnZJ6Wh7kCBzA4pu-90rWm"

local dismantleVeh = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

local desmancheVehiclePrices = {
    ["amarokBL"] = 177039,
    ["armoredgle"] = 185034,
    ["armordm3900c"] = 187714,
    ["armoredporschemacan"] = 171925,
    ["armordr55"] = 180356,
    ["armoredvelar"] = 174302,
    ["armoredx7m60i"] = 178075,
    ["dbxBL"] = 170779,
    ["mastersx6"] = 179098,
    ["PurosangueBL"] = 187536,
    ["ururs"] = 197539,
    ["X3RAMTRX21"] = 181790,
    ["evohycadegg"] = 147604,
    ["GNModsGTT34"] = 146627,
    ["lkx3gt3rs23"] = 140888,
    ["lp570"] = 143944,
    ["oyccsp300"] = 143272,
    ["fthiusv2"] = 158901,
    ["bnr34"] = 149189,
    ["rmodsupra"] = 144355,
    ["silvia"] = 132528,
    ["wrx15"] = 130601,
    ["404illegal_m2"] = 117654,
    ["BN86jdm"] = 112745,
    ["BNtypeR2024"] = 116868,
    ["gtr"] = 114179,
    ["lancerevolutionx"] = 122472,
    ["lc500wb"] = 110300,
    ["lfa2011"] = 127205,
    ["mk5amgain"] = 120720,
    ["nissanr33tbk"] = 128998,
    ["pgt3"] = 126042,
    ["playarickyc6"] = 120348,
    ["golf75r"] = 128413,
    ["golf118"] = 128423,
    ["rmodpassat"] = 112450,
    ["vwgolfgti"] = 118545,
    ["vwjetta"] = 129814,
    ["rx7asuka"] = 119003,
    ["22m4pak"] = 96327,
    ["765lt"] = 100154,
    ["a45"] = 109113,
    ["a18"] = 108581,
    ["brz"] = 102790,
    ["c8zr1"] = 93578,
    ["ftlzetorno"] = 102585,
    ["hellcat"] = 93076,
    ["maser"] = 106937,
    ["mercedesgt63"] = 108104,
    ["rev_autentica24"] = 94697,
    ["vc_c63darwinpro"] = 101198,
    ["350z"] = 106645,
    ["16GroverSC"] = 79107,
    ["20roma"] = 78543,
    ["488hrs"] = 75848,
    ["540i18md"] = 78528,
    ["alch25"] = 76510,
    ["m3900c"] = 89837,
    ["m330i21"] = 71766,
    ["mercedes633amg2022wb"] = 79259,
    ["plaid"] = 72640,
    ["eg6"] = 50432,
    ["gold"] = 58029,
    ["golgt12"] = 60054,
    ["mk3vr6"] = 65133,
    ["atwin2024"] = 53110,
    ["cbhornet750"] = 102556,
    ["hornet2014"] = 141973,
    ["R1200GS"] = 144080,
    ["r1250"] = 121274,
    ["s1000rr"] = 141495,
    ["tenere1200"] = 131673,
    ["xj6"] = 130235,
    ["corollacross20"] = 99906,
    ["diffhawk"] = 88458,
    ["durangocrb"] = 118189,
    ["GLE53"] = 80152,
    ["glsmansony850"] = 101370,
    -- Viaturas
    ["blum5"] = 74215,
    ["blum140"] = 65532,
    ["blugs350"] = 78340,
    ["blutesla"] = 69112,
    ["blum4c"] = 46890,
    ["blugt86"] = 51127,
    ["blutiger"] = 57761,
    ["blur1200"] = 79842,
    ["bluamorok"] = 48975,
    ["blutundra"] = 52963,
    ["bluquattroporte"] = 76488,
    ["blux6m"] = 61350,
    ["fkcavalcade3p"] = 41982,
    ["fkreblap"] = 56127,
    ["fkx7bp"] = 74654,
    ["fkcorollap"] = 50316
}

function getDesmancheVehiclePrice(vehName)
    local vehList = exports["config"]:vehList()

    for vehType, data in pairs(vehList) do 
        for vehSpawn, vehicleData in pairs(data) do 
            if vehSpawn == vehName and not desmancheVehiclePrices[vehSpawn] then
                if vehicleData and vehicleData.price then
                    return vehicleData.price
                end
            end
        end
    end

    if desmancheVehiclePrices[vehName] then
        return desmancheVehiclePrices[vehName]
    end

    local basePrice = vehiclePrice(vehName)
    if basePrice then
        return basePrice
    end

    return 0
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVEHLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkVehlist()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local vehicle,vehNet,vehPlate,vehName = vRPclient.vehList(source,11)
        if vehicle then            
            local plateId = vRP.userPlate(vehPlate)

            if plateId then
                if dismantleVeh[vehPlate] == nil then
                    dismantleVeh[vehPlate] = true 
                    SetTimeout(60000,function()
                        dismantleVeh[vehPlate] = nil 
                    end)

                    vRP.tryGetInventoryItem(user_id, "lockpick", 1, true)
                    return true,vehicle
                end
            else
                TriggerClientEvent("Notify",source,"vermelho","Este veículo é protegido pela seguradora.",5000)
            end
        end

        return false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentMethod()
    local source = source
    local user_id = vRP.getUserId(source)
    local vehicle,vehNet,vehPlate,vehName,vehBlock,vehHealth = vRPclient.vehList(source,3)
    local plateUser = vRP.userPlate(vehPlate)

    if user_id and vehicle then
        local reward = 0
        local price = 0

        local vehNameLower = string.lower(vehName)

        if desmancheVehiclePrices[vehNameLower] then

            reward = desmancheVehiclePrices[vehNameLower]
            price = desmancheVehiclePrices[vehNameLower]
        else
            local basePrice = vehiclePrice(vehName) or 0
            reward = basePrice * 0.4  -- antes 0.2
            price = basePrice * 0.20  -- antes 0.10
        end

        vRP.giveInventoryItem(user_id, "dollarsroll", parseInt(reward), true)

        if plateUser and plateUser["user_id"] then
            local fineAmount = reward * 0.10
            vRP.addFines(plateUser["user_id"], fineAmount)
        end
        
        local identity = vRP.userIdentity(user_id)
        local identitynu = vRP.userIdentity(plateUser and plateUser["user_id"] or 0)
        SendWebhookMessage(webhookdesmanche,
            "```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.name2..
            " \n[DESMANCHOU]: "..vehName..
            "\n[PROPRIETARIO]: "..(plateUser and plateUser["user_id"] or "N/A").." "..(identitynu.name or "").." "..(identitynu.name2 or "")..
            os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```"
        )

        TriggerClientEvent("Notify", source, "verde", "Desmanche concluído com sucesso.", 8000)
        TriggerEvent("garages:deleteVehicle", vehNet, vehPlate)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK PERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if user_id then
			
			if vRP.hasPermission(user_id, "Families") or vRP.hasPermission(user_id, "Admin") then	
				return true
			end

			TriggerClientEvent("Notify",source,"vermelho","Sem permissão.",5000)
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkItem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id,"lockpick")
		if consultItem[1] <= 0 then
			TriggerClientEvent("Notify",source,"amarelo","Necessário possuir uma <b>Lockpick</b>.",5000)
			return false
		else
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if userList[user_id] then
		userList[user_id] = nil
	end
end)

