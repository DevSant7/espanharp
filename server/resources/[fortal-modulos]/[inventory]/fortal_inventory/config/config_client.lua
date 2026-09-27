-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPS = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
cRP = {}
Tunnel.bindInterface("inventory", cRP)
vGARAGE = Tunnel.getInterface("garages")
vSERVER = Tunnel.getInterface("inventory")

Config = {}

local fishingRodObjG = nil

local fishingConfig = {
    dict = "amb@world_human_stand_fishing@idle_a", 
    anim = "idle_c", 
    prop = "prop_fishing_rod_01",
    flag = 49,
    bone = 60309,
    pos = vector3(0.1, 0.03, 0.0),
    rot = vector3(-100.0, 0.0, 20.0)
}

function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

function startFishingAnim()
    local playerPed = PlayerPedId()

    LoadAnimDict(fishingConfig.dict)
    LoadModel(fishingConfig.prop)

    TaskPlayAnim(playerPed, fishingConfig.dict, fishingConfig.anim, 8.0, 8.0, -1, fishingConfig.flag, 0, false, false, false)

    local fishingRodObj = CreateObject(GetHashKey(fishingConfig.prop), 0, 0, 0, true, true, false)
    AttachEntityToEntity(
        fishingRodObj, playerPed, GetPedBoneIndex(playerPed, fishingConfig.bone),
        fishingConfig.pos.x, fishingConfig.pos.y, fishingConfig.pos.z,
        fishingConfig.rot.x, fishingConfig.rot.y, fishingConfig.rot.z,
        true, true, false, true, 1, true
    )

    fishingRodObjG = fishingRodObj
end

function stopFishingAnim()
    local playerPed = PlayerPedId()
    ClearPedTasks(playerPed)
    if DoesEntityExist(fishingRodObjG) then
        DeleteEntity(fishingRodObjG)
        fishingRodObjG = nil
    end
end

Config["imagesProvider"] = "https://127.0.0.1/fortal_inventory/"
Config["inventoryColor"] = "0,140,234"

Config["adrenalineCds"] = {
	{ 323.4,-590.28,43.3 },
	{ 306.74,-593.27,43.29 },
	{ -242.92,6326.04,32.42 }
}

Config["weaponAttachs"] = {
	["attachsFlashlight"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_FLSH_03",
		["WEAPON_PISTOL50"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_AT_PI_FLSH",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_FLSH",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_FLSH"
	},
	["attachsCrosshair"] = {
		["WEAPON_PISTOL_MK2"] = "COMPONENT_AT_PI_RAIL",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_AT_PI_RAIL_02",
		["WEAPON_MICROSMG"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["_BULLPUPRIFLE"] = "COMPONENT_AT_SCOPE_SMALL",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MACRO_02_MK2",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_SCOPE_MEDIUM",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SCOPE_SMALL_MK2",
		["WEAPON_SMG"] = "COMPONENT_AT_SCOPE_MACRO_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_SCOPE_MACRO",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_SCOPE_MEDIUM_MK2",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_SCOPE_MACRO"
	},
	["attachsMagazine"] = {
		["WEAPON_PISTOL"] = "COMPONENT_PISTOL_CLIP_02",
		["WEAPON_PISTOL_MK2"] = "COMPONENT_PISTOL_MK2_CLIP_02",
		["WEAPON_COMPACTRIFLE"] = "COMPONENT_COMPACTRIFLE_CLIP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_APPISTOL_CLIP_02",
		["WEAPON_HEAVYPISTOL"] = "COMPONENT_HEAVYPISTOL_CLIP_02",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_MACHINEPISTOL_CLIP_02",
		["WEAPON_MICROSMG"] = "COMPONENT_MICROSMG_CLIP_02",
		["WEAPON_MINISMG"] = "COMPONENT_MINISMG_CLIP_02",
		["WEAPON_SNSPISTOL"] = "COMPONENT_SNSPISTOL_CLIP_02",
		["WEAPON_SNSPISTOL_MK2"] = "COMPONENT_SNSPISTOL_MK2_CLIP_02",
		["WEAPON_VINTAGEPISTOL"] = "COMPONENT_VINTAGEPISTOL_CLIP_02",
		["WEAPON_PISTOL50"] = "COMPONENT_PISTOL50_CLIP_02",
		["WEAPON_COMBATPISTOL"] = "COMPONENT_COMBATPISTOL_CLIP_02",
		["WEAPON_CARBINERIFLE"] = "COMPONENT_CARBINERIFLE_CLIP_02",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
		["WEAPON_ADVANCEDRIFLE"] = "COMPONENT_ADVANCEDRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_BULLPUPRIFLE_CLIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_SPECIALCARBINE_CLIP_02",
		["WEAPON_SMG"] = "COMPONENT_SMG_CLIP_02",
		["WEAPON_SMG_MK2"] = "COMPONENT_SMG_MK2_CLIP_02",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_ASSAULTRIFLE_CLIP_02",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_ASSAULTSMG_CLIP_02",
		["WEAPON_GUSENBERG"] = "COMPONENT_GUSENBERG_CLIP_02"
	},
	["attachsSilencer"] = {
		["WEAPON_PISTOL"] = "COMPONENT_AT_PI_SUPP_02",
		["WEAPON_APPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_MACHINEPISTOL"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_BULLPUPRIFLE"] = "COMPONENT_AT_AR_SUPP",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_SR_SUPP_03",
		["WEAPON_SMG"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_PI_SUPP",
		["WEAPON_ASSAULTSMG"] = "COMPONENT_AT_AR_SUPP_02"
	},
	["attachsGrip"] = {
		["WEAPON_CARBINERIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_CARBINERIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02",
		["WEAPON_BULLPUPRIFLE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_SPECIALCARBINE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_SPECIALCARBINE_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_PUMPSHOTGUN_MK2"] = "COMPONENT_AT_MUZZLE_08",
		["WEAPON_SMG_MK2"] = "COMPONENT_AT_MUZZLE_01",
		["WEAPON_ASSAULTRIFLE"] = "COMPONENT_AT_AR_AFGRIP",
		["WEAPON_ASSAULTRIFLE_MK2"] = "COMPONENT_AT_AR_AFGRIP_02"
	}
}

Config["weaponAmmos"] = {
    ["WEAPON_PISTOL_AMMO"] = {
		"WEAPON_PISTOL",
		"WEAPON_PISTOL_MK2",
		"WEAPON_PISTOL50",
		"WEAPON_REVOLVER",
		"WEAPON_COMBATPISTOL",
		"WEAPON_APPISTOL",
		"WEAPON_HEAVYPISTOL",
		"WEAPON_SNSPISTOL",
		"WEAPON_SNSPISTOL_MK2",
		"WEAPON_VINTAGEPISTOL",
		"WEAPON_NAVYREVOLVER",
		"WEAPON_GADGETPISTOL",
		"WEAPON_DOUBLEACTION"
	},
	["WEAPON_NAIL_AMMO"] = {
		"WEAPON_NAILGUN"
	},
	["WEAPON_SMG_AMMO"] = {
		"WEAPON_MICROSMG",
		"WEAPON_MINISMG",
		"WEAPON_SMG",
		"WEAPON_SMG_MK2",
		"WEAPON_GUSENBERG",
		"WEAPON_MACHINEPISTOL",
		"WEAPON_MINIGUN"
	},
	["WEAPON_RIFLE_AMMO"] = {
		"WEAPON_COMPACTRIFLE",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_BULLPUPRIFLE",
		"WEAPON_BULLPUPRIFLE_MK2",
		"WEAPON_ADVANCEDRIFLE",
		'WEAPON_PARAFAL',
		'WEAPON_FNFAL',
		'WEAPON_COLTXM177',
		"WEAPON_ASSAULTRIFLE",
		"WEAPON_ASSAULTSMG",
		"WEAPON_ASSAULTRIFLE_MK2",
		"WEAPON_SPECIALCARBINE",
		"WEAPON_SPECIALCARBINE_MK2",
		"WEAPON_SNIPERRIFLE",
		"WEAPON_TACTICALRIFLE",
		"WEAPON_HEAVYRIFLE",
		"WEAPON_MILITARYRIFLE",
		"WEAPON_COMPACTRIFLE",
		"WEAPON_BULLPUPRIFLE_MK2",
		"WEAPON_SNIPERRIFLE",
		"WEAPON_HEAVYSNIPER_MK2",
		"WEAPON_MARKSMANRIFLE",
		"WEAPON_MARKSMANRIFLE_MK2",
		"WEAPON_PRECISIONRIFLE",
		"WEAPON_GUSENBERG",
		"WEAPON_COMBATMG_MK2",
		"WEAPON_COMBATMG",
		"WEAPON_MG"
	},
	["WEAPON_RPG_AMMO"] = {
		"WEAPON_RPG",
		"WEAPON_GRENADELAUNCHER",
		"WEAPON_HOMINGLAUNCHER"
	},
	["WEAPON_SHOTGUN_AMMO"] = {
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_PUMPSHOTGUN_MK2",
		"WEAPON_SAWNOFFSHOTGUN",
		"WEAPON_HEAVYSHOTGUN",
		"WEAPON_ASSAULTSHOTGUN",
		"WEAPON_COMBATSHOTGUN",
		"WEAPON_AUTOSHOTGUN"
	},
	["WEAPON_FLARE"] = {
		"WEAPON_FLAREGUN"
	},
	["WEAPON_MUSKET_AMMO"] = {
		"WEAPON_MUSKET"
	},
	["WEAPON_PETROLCAN_AMMO"] = {
		"WEAPON_PETROLCAN"
	}
}

Config["TalkNPCRequest"] = {
    [1] = "E aí, chefe, tô precisando daquele pó de ouro. Sabe onde arrumo?",
    [2] = "Vai vilão! Já vai passando essa droguinha hoje que o pai quer ficar louco.",
    [3] = "Oi meu bb, você tá solteiro? Me dá uma droguinha que a gente vai ali a´trás no escurinho.",
    [4] = "É... Eu já tô chapadão mesmo, um pouco mais não vai fazer diferença.",
    [5] = "Tô procurando um produto diferenciado. Rola de me ajudar?",
    [6] = "Diz aí, tem aquele tempero pra fechar meu corre?",
    [7] = "Olha, eu acho que ele está me traindo. Eu já tô ferrada mesmo... Me passa uma erva, assim eu fico doidona e esqueço ele.",
    [8] = "Sabe onde encontro um bagulho de qualidade? Tô no corre",
    [9] = "Ô chefe, ouvi dizer que você é o cara pra resolver isso. Verdade?",
    [10] = "Tô procurando um produto diferenciado. Rola de me ajudar?"
}

Config["wieldWeapon"] = function(ped, weaponName, weaponAmmo)
    if not IsPedInAnyVehicle(ped) then
        loadAnimDict("reaction@intimidation@1h")
		local rot = GetEntityHeading(ped)
        TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", GetEntityCoords(ped, true), 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)
        Citizen.Wait(200)
        GiveWeaponToPed(ped, weaponName, weaponAmmo, false, true)
        Citizen.Wait(300)
        ClearPedTasks(ped)
    else
        GiveWeaponToPed(ped, weaponName, weaponAmmo, false, true)
    end
end

Config["keepWeapon"] = function(ped, lastWeapon, weaponAmmo)
    if not IsPedInAnyVehicle(ped) then
        loadAnimDict("weapons@pistol@")

        TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)

        Citizen.Wait(450)

        ClearPedTasks(ped)
    end
end

RegisterNetEvent("target:RollVehicle")
AddEventHandler("target:RollVehicle", function(Network)
	if NetworkDoesNetworkIdExist(Network) then
		local Vehicle = NetToEnt(Network)

		if DoesEntityExist(Vehicle) then
			SetVehicleOnGroundProperly(Vehicle)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairVehicle")
AddEventHandler("inventory:repairVehicle", function(vehIndex, vehPlate)
    if NetworkDoesNetworkIdExist(vehIndex) then
        local Vehicle = NetToEnt(vehIndex)
        if DoesEntityExist(Vehicle) then
            if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				TriggerEvent("removeAirbag")
                SetVehicleDeformationFixed(Vehicle)  
                SetVehicleEngineHealth(Vehicle, 1000.0)
				SetVehicleBodyHealth(Vehicle, 1000.0)

				local vehTyres = {}

				for i = 0, 7 do
					local Status = false

					if i ~= Tyres then
						if GetTyreHealth(Vehicle, i) ~= 1000.0 then
							Status = true
						end
					end

					SetVehicleTyreFixed(Vehicle, i)

					vehTyres[i] = Status
				end

				SetVehicleFixed(Vehicle)

				for Tyre, Burst in pairs(vehTyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle, Tyre, true, 1000.0)
					end
				end
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REPAIRTYRE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairTyre")
AddEventHandler("inventory:repairTyre", function(Vehicle, Tyres, vehPlate)
	if NetworkDoesNetworkIdExist(Vehicle) then
		local Vehicle = NetToEnt(Vehicle)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				local vehTyres = {}

				for i = 0, 7 do
					local Status = false

					if i ~= Tyres then
						if GetTyreHealth(Vehicle, i) ~= 1000.0 then
							Status = true
						end
					end

					SetVehicleTyreFixed(Vehicle, i)

					vehTyres[i] = Status
				end

				for Tyre, Burst in pairs(vehTyres) do
					if Burst then
						SetVehicleTyreBurst(Vehicle, Tyre, true, 1000.0)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairPlayer")
AddEventHandler("inventory:repairPlayer", function(vehIndex, vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleEngineHealth(Vehicle, 1000.0)
				SetVehicleBodyHealth(Vehicle, 1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:repairAdmin")
AddEventHandler("inventory:repairAdmin", function(vehIndex, vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				TriggerEvent("removeAirbag")
				SetVehicleFixed(Vehicle)
				SetVehicleDeformationFixed(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEALARM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:vehicleAlarm")
AddEventHandler("inventory:vehicleAlarm", function(vehIndex, vehPlate)
	if NetworkDoesNetworkIdExist(vehIndex) then
		local Vehicle = NetToEnt(vehIndex)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleAlarm(Vehicle, true)
				StartVehicleAlarm(Vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local fishCoords = PolyZone:Create({
	vector2(2308.64, 3906.11),
	vector2(2180.13, 3885.29),
	vector2(2058.22, 3883.56),
	vector2(2024.97, 3942.53),
	vector2(1748.72, 3964.53),
	vector2(1655.65, 3886.34),
	vector2(1547.59, 3830.17),
	vector2(1540.73, 3826.94),
	vector2(1535.67, 3816.55),
	vector2(1456.35, 3756.87),
	vector2(1263.44, 3670.38),
	vector2(1172.99, 3648.83),
	vector2(967.98, 3653.54),
	vector2(840.55, 3679.16),
	vector2(633.13, 3600.70),
	vector2(361.73, 3626.24),
	vector2(310.58, 3571.61),
	vector2(266.92, 3493.13),
	vector2(173.49, 3421.45),
	vector2(128.16, 3442.66),
	vector2(143.41, 3743.49),
	vector2(-38.59, 3754.16),
	vector2(-132.62, 3716.80),
	vector2(-116.73, 3805.33),
	vector2(-157.23, 3838.81),
	vector2(-204.70, 3846.28),
	vector2(-208.28, 3873.08),
	vector2(-236.88, 4076.58),
	vector2(-184.11, 4231.52),
	vector2(-139.54, 4253.54),
	vector2(-45.38, 4344.43),
	vector2(-5.96, 4408.34),
	vector2(38.36, 4411.02),
	vector2(150.77, 4311.74),
	vector2(216.02, 4342.85),
	vector2(294.16, 4245.62),
	vector2(396.21, 4342.24),
	vector2(438.37, 4315.38),
	vector2(505.22, 4178.69),
	vector2(606.65, 4202.34),
	vector2(684.48, 4169.83),
	vector2(773.54, 4152.33),
	vector2(877.34, 4172.67),
	vector2(912.20, 4269.57),
	vector2(850.92, 4428.91),
	vector2(922.96, 4376.48),
	vector2(941.32, 4328.09),
	vector2(995.318, 4288.70),
	vector2(1050.33, 4215.29),
	vector2(1082.27, 4285.61),
	vector2(1060.97, 4365.31),
	vector2(1072.62, 4372.37),
	vector2(1119.24, 4317.53),
	vector2(1275.27, 4354.90),
	vector2(1360.96, 4285.09),
	vector2(1401.09, 4283.69),
	vector2(1422.33, 4339.60),
	vector2(1516.60, 4393.69),
	vector2(1597.58, 4455.65),
	vector2(1650.81, 4499.17),
	vector2(1781.12, 4525.83),
	vector2(1828.69, 4560.26),
	vector2(1866.59, 4554.49),
	vector2(2162.70, 4664.53),
	vector2(2279.31, 4660.26),
	vector2(2290.52, 4630.90),
	vector2(2418.64, 4613.91),
	vector2(2427.06, 4597.69),
	vector2(2449.86, 4438.97),
	vector2(2396.62, 4353.36),
	vector2(2383.66, 4160.74),
	vector2(2383.05, 4046.07),
	vector2(-1731.86, -1054.66),
	vector2(-1731.86, -1054.66)


}, { name = "Pescaria" })
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:getFishingCoords")
AddEventHandler("inventory:getFishingCoords", function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    local status = false
    

    if fishCoords:isPointInside(coords) then
        status = true

        startFishingAnim()
    end


    TriggerServerEvent("inventory:finishFishing", status)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENDINGFISHINGCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:endingFishingCoords")
AddEventHandler("inventory:endingFishingCoords", function()
    stopFishingAnim()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped, "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
		return true
	end

	return false
end