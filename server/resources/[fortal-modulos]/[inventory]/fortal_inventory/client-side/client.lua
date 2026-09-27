-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("fortal-inventory",cRP)
vSERVER = Tunnel.getInterface("fortal-inventory")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Drops = {}
local Weapon = ""
local Backpack = false
local weaponActive = false
local putWeaponHands = false
local storeWeaponHands = false
local timeReload = GetGameTimer()
LocalPlayer["state"]["Buttons"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Buttons")
AddEventHandler("inventory:Buttons", function(status)
	LocalPlayer["state"]["Buttons"] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Buttons"] then
			timeDistance = 1
			DisableControlAction(1, 75, true)
			DisableControlAction(1, 47, true)
			DisableControlAction(1, 257, true)
			DisablePlayerFiring(PlayerPedId(), true)
		end

		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINECDS
-----------------------------------------------------------------------------------------------------------------------------------------
local adrenalineCds = Config["adrenalineCds"]
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINEDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.adrenalineDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k, v in pairs(adrenalineCds) do
		local distance = #(coords - vector3(v[1], v[2], v[3]))
		if distance <= 15 then
			return true
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- throwableWeapons
-----------------------------------------------------------------------------------------------------------------------------------------
local currentWeapon = ""
RegisterNetEvent("inventory:throwableWeapons")
AddEventHandler("inventory:throwableWeapons", function(weaponName)
	currentWeapon = weaponName

	local ped = PlayerPedId()
	if GetSelectedPedWeapon(ped) == GetHashKey(currentWeapon) then
		while GetSelectedPedWeapon(ped) == GetHashKey(currentWeapon) do
			if IsPedShooting(ped) then
				vSERVER.removeThrowable(currentWeapon)
			end
			Wait(0)
		end
		currentWeapon = ""
	else
		cRP.storeWeaponHands()
		currentWeapon = ""
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Close")
AddEventHandler("inventory:Close", function()
	if Backpack then
		Backpack = false
		SetNuiFocus(false, false)
		TriggerEvent("hud:Active", true)
		SendNUIMessage({ action = "setVisibility", data = false })
		StopScreenEffect("MenuMGSelectionIn")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("removeFocus", function()
	TriggerEvent("inventory:Close")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem", function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:useItem", data["slot"], data["amount"],"nui")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem", function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:sendItem", data["slot"], data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot", function(data)
	if MumbleIsConnected() and (data["amount"] > 0) then
		vSERVER.invUpdate(data["slot"], data["target"], data["amount"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:clearWeapons")
AddEventHandler("inventory:clearWeapons", function()
	if Weapon ~= "" then
		Weapon = ""
		weaponActive = false
		RemoveAllPedWeapons(PlayerPedId(), true)
	end
end)

RegisterNetEvent("clearAmmoInWeapon", function(k, v)
	SetAmmoInClip(PlayerPedId(), GetHashKey(k), v)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:verifyWeapon")
AddEventHandler("inventory:verifyWeapon", function(splitName)
	if Weapon == splitName then
		local ped = PlayerPedId()
		local weaponAmmo = GetAmmoInPedWeapon(ped, Weapon)
		if not vSERVER.verifyWeapon(Weapon, weaponAmmo) then
			RemoveAllPedWeapons(ped, true)
			weaponActive = false
			Weapon = ""
		end
	else
		if Weapon == "" then
			vSERVER.existWeapon(splitName)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:preventWeapon")
AddEventHandler("inventory:preventWeapon", function(storeWeapons)
	if Weapon ~= "" then
		local ped = PlayerPedId()
		local weaponAmmo = GetAmmoInPedWeapon(ped, Weapon)

		vSERVER.preventWeapon(Weapon, weaponAmmo)

		weaponActive = false
		Weapon = ""

		if storeWeapons then
			RemoveAllPedWeapons(ped, true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
local function requestInventory()
	local dropsData = {}
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local _, cdz = GetGroundZFor_3dCoord(coords["x"], coords["y"], coords["z"])

	local slotCounter = 200

	for k, v in pairs(Drops) do
		local distance = #(vector3(coords["x"], coords["y"], cdz) - vector3(v["coords"][1], v["coords"][2], v["coords"][3]))
		if distance <= 0.9 then
			local slot = tostring(slotCounter)

			dropsData[slot] = v
			dropsData[slot]["id"] = k
			dropsData[slot]["slot"] = slot
			dropsData[slot]["image"] = Config["imagesProvider"] .. v.index .. ".png"

			slotCounter = slotCounter + 1 
		end
	end

	local inventory, invWeight, invMaxWeight = vSERVER.requestInventory()
	if inventory then
		return inventory, parseInt(invWeight), invMaxWeight, dropsData 
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Update")
AddEventHandler("inventory:Update", function()
    local userProfile = vSERVER.getUserProfile()
    local inventory,invWeight,invMaxWeight,drops = requestInventory()
	SendNUIMessage({ action = "setProfile",data = {
		name = userProfile.name .. " " .. userProfile.name2,
		image = userProfile.photo,
		id = userProfile.passport,
		bank = userProfile.bank,
		dollar = userProfile.wallet,
		weight = invWeight,
		maxWeight = invMaxWeight,
		vip = {
			time = 30,
			label = "Booster"
		}
	}})
    SendNUIMessage({ action = "updateBackpack",data = inventory })
    SendNUIMessage({ action = "updateDrop",data = drops })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("openBackpack", function(source, args, rawCommand)
	if GetEntityHealth(PlayerPedId()) > 101 and not LocalPlayer["state"]["Buttons"] and MumbleIsConnected() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
			local userProfile = vSERVER.getUserProfile()
			local slots, isVip = vSERVER.getVip()
			local inventory,invWeight,invMaxWeight,drops = requestInventory()

			Backpack = true
			SetNuiFocus(true, true)

			local hasDropNearby = false

			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			local _, cdz = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z)

			for _, v in pairs(Drops) do
				local dropDistance = #(vector3(coords.x, coords.y, cdz) - vector3(v["coords"][1], v["coords"][2], v["coords"][3]))
				if dropDistance <= 0.9 then
					hasDropNearby = true
					break
				end
			end

			SendNUIMessage({ action = "setShowDrop", data = hasDropNearby })

			TriggerEvent("hud:Active", false)
			SendNUIMessage({ action = "setVisibility", data = true })
			SendNUIMessage({ action = "setColor", data = Config["inventoryColor"] or "0,140,324" })
			SendNUIMessage({ action = "setColor", data = Config["inventoryColor"] or "0,140,324" })
			SendNUIMessage({ action = "updateBackpack",data = inventory })
			SendNUIMessage({ action = "updateDrop",data = drops })

			SendNUIMessage({
				action = "setInventory",
				data = {
					slot = slots,
					shop = "https://fortalcityrp.centralcart.com.br",
					vip = isVip
				}
			})
			
			SendNUIMessage({ action = "setProfile",data = {
				name = userProfile.name .. " " .. userProfile.name2,
				image = userProfile.photo,
				id = userProfile.passport,
				bank = userProfile.bank,
				dollar = userProfile.wallet,
				weight = invWeight,
				maxWeight = invMaxWeight,
				vip = {
					time = 30,
					label = "Booster"
				}
			}})
			StartScreenEffect("MenuMGSelectionIn", 0, true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("openBackpack", "Manusear a mochila.", "keyboard", "OEM_3")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
local slotSelect = 0
RegisterCommand("useWeaponBackpack", function(source, args, rawCommand)
	if GetEntityHealth(PlayerPedId()) > 101 and not LocalPlayer["state"]["Buttons"] and MumbleIsConnected() then
		if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] and not IsPlayerFreeAiming(PlayerId()) then
			local ped = PlayerPedId()
			if IsControlPressed(1,21) then
				if args[1] == "DOWN" then 
					if slotSelect == 0 then 
						slotSelect = 5
					else 
						slotSelect = slotSelect - 1 
					end
				elseif args[1] == "UP" then 
					if slotSelect == 5 then 
						slotSelect = 0
					else 
						slotSelect = slotSelect + 1 
					end
				end
				TriggerServerEvent("inventory:useItem",tostring(30+slotSelect),1,"nui")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("useWeaponBackpack UP", "Utilizar armas", "MOUSE_WHEEL", "IOM_WHEEL_UP")
RegisterKeyMapping("useWeaponBackpack DOWN", "Utilizar armas", "MOUSE_WHEEL", "IOM_WHEEL_DOWN")


-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.parachuteColors()
	local ped = PlayerPedId()
	GiveWeaponToPed(ped, "GADGET_PARACHUTE", 1, false, true)
	SetPedParachuteTintIndex(ped, math.random(7))
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.returnWeapon()
	if Weapon ~= "" then
		return Weapon
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWeapon(Hash)
	if Weapon == Hash then
		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:stealTrunk")
AddEventHandler("inventory:stealTrunk", function(entity)
	if Weapon == "WEAPON_CROWBAR" then
		local trunk = GetEntityBoneIndexByName(entity[3], "boot")
		if trunk ~= -1 then
			local ped = PlayerPedId()
			local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.5, 0.0)
			local coordsEnt = GetWorldPositionOfEntityBone(entity[3], trunk)
			local distance = #(coords - coordsEnt)
			if distance <= 3.0 then
				vSERVER.stealTrunk(entity)
			end
		end
	else
		TriggerEvent("Notify", "important", "Atenção", "Pé de Cabra não encontrado.", "amarelo", 5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAttachs = Config["weaponAttachs"]
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkAttachs(nameItem, nameWeapon)
	return weaponAttachs[nameItem][nameWeapon]
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putAttachs(nameItem, nameWeapon)
	GiveWeaponComponentToPed(PlayerPedId(), nameWeapon, weaponAttachs[nameItem][nameWeapon])
end

RegisterNUICallback("changePhoto", function(data)
	vSERVER.changePhoto(data.url)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.putWeaponHands(weaponName, weaponAmmo, attachs)
	if not putWeaponHands then
		if weaponAmmo == nil then
			weaponAmmo = 0
		end

		if weaponAmmo > 0 then
			weaponActive = true
		end

		putWeaponHands = true
		LocalPlayer["state"]["Cancel"] = true

		local ped = PlayerPedId()
		if HasPedGotWeapon(ped, GetHashKey("GADGET_PARACHUTE"), false) then
			RemoveAllPedWeapons(ped, true)
			cRP.parachuteColors()
		else
			RemoveAllPedWeapons(ped, true)
		end
		Config["wieldWeapon"](ped, weaponName, weaponAmmo)
		TriggerServerEvent("skinweapon:check",weaponName)
		
		if attachs ~= nil then
			for nameItem, _ in pairs(attachs) do
				cRP.putAttachs(nameItem, weaponName)
			end
		end

		LocalPlayer["state"]["Cancel"] = false
		putWeaponHands = false
		Weapon = weaponName

		if vSERVER.dropWeapons(Weapon) then
			RemoveAllPedWeapons(ped, true)
			weaponActive = false
			Weapon = ""
		end

		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREWEAPONHANDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeWeaponHands()
	if not storeWeaponHands then
		storeWeaponHands = true
		local ped = PlayerPedId()
		local lastWeapon = Weapon
		LocalPlayer["state"]["Cancel"] = true
		local weaponAmmo = GetAmmoInPedWeapon(ped, Weapon)
		Config["keepWeapon"](ped,lastWeapon,weaponAmmo)
		LocalPlayer["state"]["Cancel"] = false
		RemoveAllPedWeapons(ped, true)
		storeWeaponHands = false
		weaponActive = false
		Weapon = ""

		return true, weaponAmmo, lastWeapon
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONAMMOS
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponAmmos = Config["weaponAmmos"]
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGECHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeCheck(ammoType)
	local weaponHash = nil
	local ped = PlayerPedId()
	local weaponStatus = false

	if weaponAmmos[ammoType] then
		for k, v in pairs(weaponAmmos[ammoType]) do
			if Weapon == v then
				weaponHash = Weapon
				weaponStatus = true
				break
			end
		end
	end

	local weaponAmmo = GetAmmoInPedWeapon(ped, Weapon)
	return weaponStatus, weaponHash, weaponAmmo
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.rechargeWeapon(weaponHash, ammoAmount)
	AddAmmoToPed(PlayerPedId(), weaponHash, ammoAmount)
	weaponActive = true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTOREWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
	while true do
		local entity = GetPlayerPed(-1)

		local owner = NetworkGetEntityOwner(entity)
		local source = GetPlayerServerId(owner)

		local Ped = PlayerPedId()
		if IsPedArmed(Ped, 6) then
			if IsPedShooting(Ped) then
				TriggerServerEvent("get:client_evidence", source)
			end
		end
		Wait(1)
	end
end)


Citizen.CreateThread(function()
	while true do
		local timeDistance = 999

		if Weapon ~= "" then
			timeDistance = 100
			local ped = PlayerPedId()
			local weaponIn, ammo = GetAmmoInClip(ped, Weapon)
			local weaponAmmo = GetAmmoInPedWeapon(ped, Weapon)
			vSERVER.returnAmmout(weaponAmmo)
			TriggerEvent("hud:Ammount", ammo, weaponAmmo)
		else
			TriggerEvent("hud:Ammount", "0", "0")
		end
		Wait(timeDistance)
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false, false)

	while true do
		local timeDistance = 999


		if weaponActive and Weapon ~= "" then
			timeDistance = 100
			local ped = PlayerPedId()
			local weaponIn, ammo = GetAmmoInClip(ped, Weapon)
			local weaponAmmo = GetAmmoInPedWeapon(ped, Weapon)

			if GetGameTimer() >= timeReload and IsPedReloading(ped) then
				vSERVER.preventWeapon(Weapon, weaponAmmo)
				timeReload = GetGameTimer() + 1000
			end

			if weaponAmmo <= 0 or (Weapon == "WEAPON_PETROLCAN" and weaponAmmo <= 135 and IsPedShooting(ped)) or IsPedSwimming(ped) then
				vSERVER.preventWeapon(Weapon, weaponAmmo)
				RemoveAllPedWeapons(ped, true)
				weaponActive = false
				Weapon = ""
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
local fireTimers = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKCRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkCracker()
	if GetGameTimer() <= fireTimers then
		return true
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FIRECRACKER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Firecracker")
AddEventHandler("inventory:Firecracker", function()
	if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
		RequestNamedPtfxAsset("scr_indep_fireworks")
		while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
			Citizen.Wait(1)
		end
	end

	local explosives = 25
	local ped = PlayerPedId()
	fireTimers = GetGameTimer() + (5 * 60000)
	local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.6, 0.0)
	local myObject, objNet = vRPS.CreateObject("ind_prop_firework_03", coords["x"], coords["y"], coords["z"])
	if myObject then
		local spawnObjects = 0
		local uObject = NetworkGetEntityFromNetworkId(objNet)
		while not DoesEntityExist(uObject) and spawnObjects <= 1000 do
			uObject = NetworkGetEntityFromNetworkId(objNet)
			spawnObjects = spawnObjects + 1
			Citizen.Wait(1)
		end

		spawnObjects = 0
		local objectControl = NetworkRequestControlOfEntity(uObject)
		while not objectControl and spawnObjects <= 1000 do
			objectControl = NetworkRequestControlOfEntity(uObject)
			spawnObjects = spawnObjects + 1
			Citizen.Wait(1)
		end

		PlaceObjectOnGroundProperly(uObject)
		FreezeEntityPosition(uObject, true)

		SetEntityAsNoLongerNeeded(uObject)

		Citizen.Wait(10000)

		repeat
			UseParticleFxAssetNextCall("scr_indep_fireworks")
			local explode = StartNetworkedParticleFxNonLoopedAtCoord("scr_indep_firework_trailburst", coords["x"], coords["y"],
				coords["z"], 0.0, 0.0, 0.0, 2.5, false, false, false, false)
			explosives = explosives - 1

			Citizen.Wait(2000)
		until explosives <= 0

		TriggerServerEvent("tryDeleteObject", objNet)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKWATER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkWater()
	return IsPedSwimming(PlayerPedId())
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- LOADANIMDIC
-----------------------------------------------------------------------------------------------------------------------------------------
function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem", function(data)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local _, cdz = GetGroundZFor_3dCoord(coords["x"], coords["y"], coords["z"])

		TriggerServerEvent("inventory:Drops", data["item"], data["slot"], data["amount"], coords["x"], coords["y"], cdz)
	end
end)

RegisterNUICallback("destroyItem", function(data)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local _, cdz = GetGroundZFor_3dCoord(coords["x"], coords["y"], coords["z"])
		TriggerServerEvent("inventory:Destroy", data["item"], data["slot"], data["amount"], coords["x"], coords["y"], cdz)
	end
end)

RegisterCommand("cancelcraft", function()
	TriggerServerEvent("cancelcraft")
end)

RegisterKeyMapping("cancelcraft", "Cancelar crafting", "keyboard", "F6")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:TABLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Table")
AddEventHandler("drops:Table", function(Table)
	Drops = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ADICIONAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Adicionar")
AddEventHandler("drops:Adicionar", function(Number, Table)
	Drops[Number] = Table
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:REMOVER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Remover")
AddEventHandler("drops:Remover", function(Number)
	if Drops[Number] then
		Drops[Number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPS:ATUALIZAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("drops:Atualizar")
AddEventHandler("drops:Atualizar", function(Number, Amount)
	if Drops[Number] then
		Drops[Number]["amount"] = Amount
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDROPBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		for _, v in pairs(Drops) do
			local distance = #(coords - vector3(v["coords"][1], v["coords"][2], v["coords"][3]))
			if distance <= 50 then
				timeDistance = 1
				DrawMarker(21, v["coords"][1], v["coords"][2], v["coords"][3] + 0.25, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.25, 0.35, 0.25, 0, 0, 139, 100, 1, 0, 0, 1)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

-- Citizen.CreateThread(function()
-- 	while true do
-- 		local timeDistance = 999
-- 		local ped = PlayerPedId()
-- 		local coords = GetEntityCoords(ped)

-- 		for k, v in pairs(Drops) do
-- 			local distance = #(coords - vector3(v["coords"][1], v["coords"][2], v["coords"][3]))

-- 			if distance <= 50.0 then
-- 				timeDistance = 1
-- 				DrawMarker(21, v["coords"][1], v["coords"][2], v["coords"][3] + 0.25, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.25, 0.35, 0.25, 0, 0, 139, 100, 1, 0, 0, 1)

-- 				if distance <= 1.5 then
-- 					DrawText3D(v["coords"][1], v["coords"][2], v["coords"][3] + 0.45, "[E] Pegar")

-- 					if IsControlJustPressed(0, 38) then 
-- 						TriggerServerEvent("inventory:Pickup", k, v["amount"], v["slot"] or 1)
-- 						break 
-- 					end
-- 				end
-- 			end
-- 		end

-- 		Citizen.Wait(timeDistance)
-- 	end
-- end)

-- function DrawText3D(x, y, z, text)
-- 	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
-- 	local p = GetGameplayCamCoords()
-- 	local distance = #(vector3(x, y, z) - p)
-- 	local scale = 0.30 

-- 	if onScreen then
-- 		SetTextScale(scale, scale)
-- 		SetTextFont(4)
-- 		SetTextProportional(1)
-- 		SetTextColour(255, 255, 255, 215)
-- 		SetTextEntry("STRING")
-- 		SetTextCentre(true)
-- 		AddTextComponentString(text)
-- 		DrawText(_x, _y)
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PICKUPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("pickupItem", function(data)
	if MumbleIsConnected() then
		TriggerServerEvent("inventory:Pickup", data["id"], data["amount"], data["target"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELCHAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.wheelChair(vehPlate)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	local coords = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.75, 0.0)
	local myVehicle = vGARAGE.serverVehicle("wheelchair", coords["x"], coords["y"], coords["z"], heading, vehPlate, 0, nil,
		1000)

	if NetworkDoesNetworkIdExist(myVehicle) then
		local vehicleNet = NetToEnt(myVehicle)
		if NetworkDoesNetworkIdExist(vehicleNet) then
			SetVehicleOnGroundProperly(vehicleNet)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- WHEELTREADS
-----------------------------------------------------------------------------------------------------------------------------------------
local wheelChair = false
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(vehicle)
			if model == -1178021069 then
				if not IsEntityPlayingAnim(ped, "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester", 3) then
					vRP.playAnim(true, { "missfinale_c2leadinoutfin_c_int", "_leadin_loop2_lester" }, true)
					wheelChair = true
				end
			end
		else
			if wheelChair then
				vRP.removeObjects("one")
				wheelChair = false
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARISCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
local scanTable = {}
local initSounds = {}
local soundScanner = 999
local userScanner = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local scanCoords = {
	{ -1811.94, -968.5,  1.72,  357.17 },
	{ -1788.29, -958.0,  3.35,  328.82 },
	{ -1756.9,  -942.98, 6.91,  311.82 },
	{ -1759.97, -910.12, 7.58,  334.49 },
	{ -1791.44, -904.11, 5.12,  39.69 },
	{ -1827.87, -900.32, 2.48,  68.04 },
	{ -1840.76, -882.39, 2.81,  51.03 },
	{ -1793.4,  -819.9,  7.73,  328.82 },
	{ -1737.69, -791.3,  9.44,  317.49 },
	{ -1714.6,  -784.61, 9.82,  306.15 },
	{ -1735.88, -757.92, 10.11, 2.84 },
	{ -1763.22, -764.65, 9.49,  65.2 },
	{ -1786.23, -782.4,  8.71,  99.22 },
	{ -1809.5,  -798.29, 7.89,  104.89 },
	{ -1816.35, -827.68, 6.44,  141.74 },
	{ -1833.23, -856.58, 3.52,  147.41 },
	{ -1842.88, -869.45, 2.98,  144.57 },
	{ -1865.34, -858.4,  2.12,  99.22 },
	{ -1868.01, -835.58, 3.0,   51.03 },
	{ -1860.76, -810.59, 4.04,  8.51 },
	{ -1848.85, -790.99, 6.3,   348.67 },
	{ -1834.31, -767.03, 8.17,  337.33 },
	{ -1819.3,  -742.04, 8.85,  331.66 },
	{ -1804.76, -713.39, 9.76,  331.66 },
	{ -1805.32, -695.22, 10.23, 348.67 },
	{ -1824.32, -685.97, 10.23, 36.86 },
	{ -1849.16, -699.25, 9.45,  85.04 },
	{ -1868.9,  -716.3,  8.86,  110.56 },
	{ -1890.07, -736.57, 6.27,  124.73 },
	{ -1909.8,  -759.44, 3.52,  130.4 },
	{ -1920.19, -782.25, 2.8,   144.57 },
	{ -1939.84, -765.34, 1.99,  85.04 },
	{ -1932.96, -746.47, 3.05,  8.51 },
	{ -1954.69, -722.8,  3.03,  28.35 },
	{ -1954.53, -688.85, 4.06,  11.34 },
	{ -1939.8,  -651.94, 8.74,  351.5 },
	{ -1926.48, -627.37, 10.67, 348.67 },
	{ -1920.73, -615.67, 10.95, 340.16 },
	{ -1924.48, -596.03, 11.56, 51.03 },
	{ -1952.53, -597.0,  11.02, 70.87 },
	{ -1972.12, -609.32, 8.73,  102.05 },
	{ -1989.01, -629.48, 5.21,  124.73 },
	{ -2002.97, -659.48, 3.03,  141.74 },
	{ -2028.03, -658.61, 1.82,  107.72 },
	{ -2045.57, -637.91, 2.02,  65.2 },
	{ -2031.42, -618.65, 3.23,  0.0 },
	{ -2003.74, -603.38, 6.3,   328.82 },
	{ -1982.79, -588.43, 10.01, 317.49 },
	{ -1968.4,  -565.72, 11.42, 323.15 },
	{ -1980.98, -545.43, 11.58, 5.67 },
	{ -1996.36, -552.72, 11.68, 17.01 },
	{ -2013.33, -573.78, 8.95,  102.05 },
	{ -2030.05, -604.62, 3.93,  133.23 },
	{ -2035.79, -626.99, 3.0,   150.24 },
	{ -2053.05, -626.67, 2.31,  113.39 },
	{ -2062.58, -596.05, 3.03,  45.36 },
	{ -2096.8,  -579.13, 2.75,  53.86 },
	{ -2116.49, -559.09, 2.29,  48.19 },
	{ -2093.8,  -539.57, 3.74,  22.68 },
	{ -2067.11, -526.37, 6.98,  328.82 },
	{ -2049.71, -516.4,  9.13,  308.98 },
	{ -2029.87, -507.17, 11.49, 300.48 },
	{ -2049.27, -492.94, 11.17, 11.34 },
	{ -2073.38, -483.05, 9.13,  42.52 },
	{ -2102.99, -470.71, 6.52,  56.7 },
	{ -2119.62, -451.87, 6.67,  48.19 },
	{ -2134.43, -460.37, 5.24,  93.55 },
	{ -1805.06, -936.1,  2.53,  189.93 },
	{ -1786.4,  -932.99, 4.38,  269.3 },
	{ -1744.87, -926.96, 7.65,  269.3 },
	{ -1763.18, -925.72, 6.99,  104.89 },
	{ -1773.65, -895.76, 7.35,  357.17 },
	{ -1750.28, -883.7,  7.75,  277.8 },
	{ -1733.24, -862.29, 8.17,  311.82 },
	{ -1703.01, -838.56, 9.03,  300.48 },
	{ -1720.85, -834.19, 8.95,  31.19 },
	{ -1747.12, -839.86, 8.39,  138.9 },
	{ -1764.27, -856.95, 7.75,  147.41 },
	{ -1776.27, -868.44, 7.78,  119.06 },
	{ -1803.86, -872.72, 5.34,  93.55 },
	{ -1744.12, -901.55, 7.7,   79.38 },
	{ -1765.09, -808.12, 8.58,  31.19 },
	{ -1773.17, -728.07, 10.01, 8.51 },
	{ -1849.14, -729.09, 8.85,  136.07 },
	{ -1866.65, -758.66, 6.96,  150.24 },
	{ -1886.42, -794.12, 3.25,  158.75 },
	{ -1795.97, -748.07, 9.17,  297.64 },
	{ -1915.8,  -682.79, 8.0,   62.37 },
	{ -1911.86, -651.71, 10.26, 0.0 },
	{ -1899.29, -623.49, 11.34, 345.83 },
	{ -1847.11, -670.69, 10.45, 17.01 },
	{ -1874.69, -647.34, 10.92, 39.69 },
	{ -1958.9,  -629.78, 8.34,  73.71 },
	{ -1951.39, -575.59, 11.53, 343.0 },
	{ -1991.28, -569.55, 10.72, 164.41 },
	{ -2056.68, -569.32, 4.57,  99.22 },
	{ -2088.29, -560.62, 3.27,  87.88 },
	{ -2042.45, -542.51, 8.46,  308.98 },
	{ -2020.91, -528.58, 11.12, 306.15 },
	{ -2092.91, -499.58, 5.37,  79.38 },
	{ -2113.6,  -521.59, 2.27,  147.41 },
	{ -2139.09, -496.06, 2.27,  48.19 },
	{ -2122.44, -486.23, 3.56,  280.63 },
	{ -2034.27, -577.42, 6.74,  294.81 },
	{ -2003.72, -536.62, 11.78, 320.32 },
	{ -2023.41, -551.31, 9.59,  255.12 },
	{ -2014.0,  -626.04, 3.76,  189.93 },
	{ -1967.67, -656.53, 5.24,  255.12 },
	{ -1878.77, -672.36, 9.76,  257.96 },
	{ -1827.96, -702.26, 9.67,  240.95 },
	{ -1855.87, -771.67, 6.94,  164.41 },
	{ -1846.08, -830.98, 3.79,  175.75 },
	{ -1830.72, -804.5,  6.67,  334.49 },
	{ -1770.76, -835.92, 7.84,  311.82 },
	{ -1724.61, -812.2,  9.25,  303.31 },
	{ -1828.9,  -719.11, 9.3,   65.2 },
	{ -1893.81, -707.65, 7.73,  110.56 },
	{ -1921.84, -716.82, 5.22,  212.6 },
	{ -1891.7,  -756.03, 4.95,  218.27 },
	{ -1890.51, -818.0,  2.95,  303.31 },
	{ -1806.69, -770.32, 8.29,  306.15 },
	{ -1763.57, -747.01, 9.81,  303.31 },
	{ -1980.27, -691.34, 3.02,  189.93 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local amountCoords = 0
	repeat
		amountCoords = amountCoords + 1
		local rand = math.random(#scanCoords)
		scanTable[amountCoords] = scanCoords[rand]
		Citizen.Wait(1)
	until amountCoords == 25
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCANNERCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:updateScanner")
AddEventHandler("inventory:updateScanner", function(status)
	userScanner = status
	soundScanner = 999
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if userScanner then
			local ped = PlayerPedId()
			if not IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)

				for k, v in pairs(scanTable) do
					local distance = #(coords - vector3(v[1], v[2], v[3]))
					if distance <= 7.25 then
						soundScanner = 1000

						if initSounds[k] == nil then
							initSounds[k] = true
						end

						if distance <= 1.25 then
							timeDistance = 1
							soundScanner = 250

							if IsControlJustPressed(1, 38) and MumbleIsConnected() then
								TriggerServerEvent("inventory:makeProducts", {}, "scanner")

								local rand = math.random(#scanCoords)
								scanTable[k] = scanCoords[rand]
								initSounds[k] = nil
								soundScanner = 999
							end
						end
					else
						if initSounds[k] then
							initSounds[k] = nil
							soundScanner = 999
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSCANNERSOUND
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if userScanner and (soundScanner == 1000 or soundScanner == 250) then
			PlaySoundFrontend(-1, "MP_IDLE_TIMER", "HUD_FRONTEND_DEFAULT_SOUNDSET")
		end

		Citizen.Wait(soundScanner)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BOXLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local boxList = {
	{ 594.43,   146.51,   97.31,  "Medic" },
	{ 660.57,   268.11,   102.06, "Medic" },
	{ 552.50,   -197.71,  53.76,  "Medic" },
	{ 333.86,   -561.83,  28.75,  "Medic" },
	{ 696.06,   -966.19,  23.26,  "Medic" },
	{ 1152.45,  -1531.43, 34.66,  "Medic" },
	{ 1382.03,  -2081.88, 51.28,  "Medic" },
	{ 589.08,   -2802.64, 5.34,   "Medic" },
	{ -452.97,  -2810.19, 6.59,   "Medic" },
	{ -1007.09, -2835.14, 13.22,  "Medic" },
	{ -2018.03, -361.23,  47.41,  "Medic" },
	{ -1727.11, 250.50,   61.67,  "Medic" },
	{ -1089.41, 2717.06,  18.35,  "Medic" },
	{ 322.07,   2870.01,  44.33,  "Medic" },
	{ 1162.30,  2722.15,  37.31,  "Medic" },
	{ 1745.07,  3325.18,  40.41,  "Medic" },
	{ 2013.45,  3934.56,  31.65,  "Medic" },
	{ 2526.61,  4191.89,  44.57,  "Medic" },
	{ 2874.13,  4861.62,  61.49,  "Medic" },
	{ 1985.15,  6200.30,  41.32,  "Medic" },
	{ 1549.42,  6613.58,  2.15,   "Medic" },
	{ -300.29,  6390.89,  29.89,  "Medic" },
	{ -815.19,  5384.08,  33.79,  "Medic" },
	{ -1613.17, 5262.20,  3.25,   "Medic" },
	{ -199.71,  3638.30,  63.72,  "Medic" },
	{ -1487.49, 2688.97,  2.96,   "Medic" },
	{ -3266.54, 1139.91,  1.95,   "Medic" },
	{ 574.19,   132.92,   98.45,  "Weapons" },
	{ 344.74,   929.16,   202.43, "Weapons" },
	{ -123.21,  1896.61,  196.31, "Weapons" },
	{ -1097.20, 2705.98,  21.97,  "Weapons" },
	{ -2198.33, 4242.54,  46.92,  "Weapons" },
	{ -1486.84, 4983.19,  62.66,  "Weapons" },
	{ 1345.95,  6396.18,  32.39,  "Weapons" },
	{ 2535.65,  4661.52,  33.06,  "Weapons" },
	{ 1166.19,  -1339.58, 35.07,  "Weapons" },
	{ 1112.41,  -2500.32, 32.34,  "Weapons" },
	{ 259.26,   -3113.36, 4.80,   "Weapons" },
	{ -1621.63, -1037.19, 12.13,  "Weapons" },
	{ -3421.65, 974.54,   10.89,  "Weapons" },
	{ -1910.37, 4624.45,  56.06,  "Weapons" },
	{ 895.66,   3212.04,  40.52,  "Weapons" },
	{ 1802.75,  4604.32,  36.65,  "Weapons" },
	{ 443.32,   6456.24,  27.68,  "Weapons" },
	{ 64.84,    6320.81,  37.85,  "Weapons" },
	{ -748.40,  5595.82,  40.64,  "Weapons" },
	{ -2683.33, 2303.38,  20.84,  "Supplies" },
	{ -2687.00, 2304.36,  20.84,  "Supplies" },
	{ -1282.21, 2559.87,  17.36,  "Supplies" },
	{ 160.43,   3119.01,  42.39,  "Supplies" },
	{ 1062.20,  3527.83,  33.13,  "Supplies" },
	{ 2364.56,  3154.49,  47.20,  "Supplies" },
	{ 2521.62,  2637.86,  36.94,  "Supplies" },
	{ 2572.34,  477.76,   107.68, "Supplies" },
	{ 1206.30,  -1089.56, 39.24,  "Supplies" },
	{ 1039.79,  -244.01,  67.28,  "Supplies" },
	{ 499.27,   -530.36,  23.73,  "Supplies" },
	{ 592.17,   -2114.34, 4.75,   "Supplies" },
	{ 513.09,   -2584.10, 13.34,  "Supplies" },
	{ -2.98,    -1299.73, 28.26,  "Supplies" },
	{ 182.61,   -1086.84, 28.26,  "Supplies" },
	{ 712.27,   -852.63,  23.24,  "Supplies" },
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBOXES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k, v in pairs(boxList) do
		exports["target"]:AddCircleZone("Boxes:" .. k, vector3(v[1], v[2], v[3]), 1.0, {
			name = "Boxes:" .. k,
			heading = 3374176,
			useZ = true
		}, {
			shop = k,
			distance = 1.5,
			options = {
				{
					event = "inventory:lootSystem",
					label = "Abrir",
					tunnel = "boxes",
					service = v[4]
				}
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStop", function(resource)
	TriggerServerEvent("vRP:Print", "pausou o resource " .. resource)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRELIST
-----------------------------------------------------------------------------------------------------------------------------------------
local tyreList = {
	["wheel_lf"] = 0,
	["wheel_rf"] = 1,
	["wheel_lm"] = 2,
	["wheel_rm"] = 3,
	["wheel_lr"] = 4,
	["wheel_rr"] = 5
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:removeTyres")
AddEventHandler("inventory:removeTyres", function(Entity)
	if GetVehicleDoorLockStatus(Entity[3]) == 1 then
		if Weapon == "WEAPON_WRENCH" then
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)

			for k, Tyre in pairs(tyreList) do
				local Selected = GetEntityBoneIndexByName(Entity[3], k)
				if Selected ~= -1 then
					local coordsWheel = GetWorldPositionOfEntityBone(Entity[3], Selected)
					local distance = #(coords - coordsWheel)
					if distance <= 1.0 then
						TriggerServerEvent("inventory:removeTyres", Entity, Tyre)
					end
				end
			end
		else
			TriggerEvent("Notify", "important", "Atenção", "Chave Inglesa não encontrada.", "amarelo", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:EXPLODETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:explodeTyres")
AddEventHandler("inventory:explodeTyres", function(vehNet, vehPlate, Tyre)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			if GetVehicleNumberPlateText(Vehicle) == vehPlate then
				SetVehicleTyreBurst(Vehicle, Tyre, true, 1000.0)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYRESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tyreStatus()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		local Vehicle = vRP.nearVehicle(5)
		local coords = GetEntityCoords(ped)

		for k, Tyre in pairs(tyreList) do
			local Selected = GetEntityBoneIndexByName(Vehicle, k)
			if Selected ~= -1 then
				local coordsWheel = GetWorldPositionOfEntityBone(Vehicle, Selected)
				local distance = #(coords - coordsWheel)
				if distance <= 1.0 then
					return true, Tyre, VehToNet(Vehicle), GetVehicleNumberPlateText(Vehicle)
				end
			end
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.tyreHealth(vehNet, Tyre)
	if NetworkDoesNetworkIdExist(vehNet) then
		local Vehicle = NetToEnt(vehNet)
		if DoesEntityExist(Vehicle) then
			return GetTyreHealth(Vehicle, Tyre)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local DrugsPeds = {}
local StealPeds = {}
local DrugsTimer = GetGameTimer()
local StealTimer = GetGameTimer()
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTEALNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) and IsPedArmed(Ped, 7) then
			local Handler, Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not StealPeds[Selected] and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 5 then
						timeDistance = 100

						local Pid = PlayerId()
						if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) then
							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							local SelectedTimers = 0
							local SelectedControl = NetworkRequestControlOfEntity(Selected)
							while not SelectedControl and SelectedTimers <= 1000 do
								SelectedControl = NetworkRequestControlOfEntity(Selected)
								SelectedTimers = SelectedTimers + 1
							end

							TaskSetBlockingOfNonTemporaryEvents(Selected, true)
							SetBlockingOfNonTemporaryEvents(Selected, true)
							SetEntityAsMissionEntity(Selected, true, true)
							SetPedDropsWeaponsWhenDead(Selected, false)
							TaskTurnPedToFaceEntity(Selected, Ped, 3.0)
							SetPedSuffersCriticalHits(Selected, false)
							SetPedAsNoLongerNeeded(Selected)
							StealPeds[Selected] = true

							RequestAnimDict("random@mugging3")
							while not HasAnimDictLoaded("random@mugging3") do
								Wait(1)
							end

							local SelectedRobbery = 500
							LocalPlayer["state"]["Buttons"] = true
							LocalPlayer["state"]["Commands"] = true
							TaskPlayAnim(Selected, "random@mugging3", "handsup_standing_base", 8.0, 8.0, -1, 16, 0, 0, 0, 0)

							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 and (IsPedInMeleeCombat(Ped) or IsPlayerFreeAiming(Pid)) then
									SelectedRobbery = SelectedRobbery - 1

									if not IsEntityPlayingAnim(Selected, "random@mugging3", "handsup_standing_base", 3) then
										TaskPlayAnim(Selected, "random@mugging3", "handsup_standing_base", 8.0, 8.0, -1, 16, 0, 0, 0, 0)
									end

									if SelectedRobbery <= 0 then
										local Anim = "mp_safehouselost@"
										local Hash = "prop_paper_bag_small"

										RequestModel(Hash)
										while not HasModelLoaded(Hash) do
											Wait(1)
										end

										RequestAnimDict(Anim)
										while not HasAnimDictLoaded(Anim) do
											Wait(1)
										end

										local Object = CreateObject(Hash, Coords["x"], Coords["y"], Coords["z"], false, false, false)
										AttachEntityToEntity(Object, Selected, GetPedBoneIndex(Selected, 28422), 0.0, -0.05, 0.05, 180.0, 0.0,
											0.0, false, false, false, false, 2, true)
										TaskPlayAnim(Selected, Anim, "package_dropoff", 8.0, 8.0, -1, 16, 0, 0, 0, 0)

										Wait(3000)

										if DoesEntityExist(Object) then
											SetModelAsNoLongerNeeded(Hash)
											DeleteEntity(Object)
										end

										ClearPedSecondaryTask(Selected)
										TaskWanderStandard(Selected, 10.0, 10)
										TriggerServerEvent("inventory:StealPeds")


										LocalPlayer["state"]["Buttons"] = false
										LocalPlayer["state"]["Commands"] = false

										break
									end
								else
									ClearPedSecondaryTask(Selected)
									TaskWanderStandard(Selected, 10.0, 10)

									LocalPlayer["state"]["Buttons"] = false
									LocalPlayer["state"]["Commands"] = false

									break
								end

								Wait(1)
							end
						end
					end
				end

				Success, Selected = FindNextPed(Handler)
			until not Success
			EndFindPed(Handler)
		end

		Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleanEffectDrugs")
AddEventHandler("cleanEffectDrugs", function()
	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end

	if GetScreenEffectIsActive("DMT_flight") then
		StopScreenEffect("DMT_flight")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local Ped = PlayerPedId()

		if not IsPedInAnyVehicle(Ped) then
			local Handler, Selected = FindFirstPed()

			repeat
				if not IsEntityDead(Selected) and not DrugsPeds[Selected] and not IsPedDeadOrDying(Selected) and GetPedArmour(Selected) <= 0 and not IsPedAPlayer(Selected) and not IsPedInAnyVehicle(Selected) and GetPedType(Selected) ~= 28 then
					local Coords = GetEntityCoords(Ped)
					local pCoords = GetEntityCoords(Selected)
					local Distance = #(Coords - pCoords)

					if Distance <= 1 then
						timeDistance = 1

						if IsControlJustPressed(1, 38) and GetGameTimer() >= DrugsTimer and vSERVER.AmountDrugs() then
							DrugsTimer = GetGameTimer() + 5000

							ClearPedTasks(Selected)
							ClearPedSecondaryTask(Selected)
							ClearPedTasksImmediately(Selected)

							local SelectedTimers = 0
							local SelectedRobbery = 500
							LocalPlayer["state"]["Buttons"] = true
							LocalPlayer["state"]["Commands"] = true
							local SelectedControl = NetworkRequestControlOfEntity(Selected)
							while not SelectedControl and SelectedTimers <= 1000 do
								SelectedControl = NetworkRequestControlOfEntity(Selected)
								SelectedTimers = SelectedTimers + 1
							end

							TaskSetBlockingOfNonTemporaryEvents(Selected, true)
							SetBlockingOfNonTemporaryEvents(Selected, true)
							SetEntityAsMissionEntity(Selected, true, true)
							SetPedDropsWeaponsWhenDead(Selected, false)
							TaskTurnPedToFaceEntity(Selected, Ped, 3.0)
							SetPedSuffersCriticalHits(Selected, false)
							SetPedAsNoLongerNeeded(Selected)
							FreezeEntityPosition(Selected,true)
							DrugsPeds[Selected] = true

							-- local talkRequest = math.random(1,#Config["TalkNPCRequest"])
							-- TriggerEvent("showme:NPC", Config["TalkNPCRequest"][talkRequest],Selected)
							-- TriggerEvent("sounds:source","voz"..talkRequest.."", 1.0)
							-- print("voz"..talkRequest.."")

							exports["talk_npc"]:talkRequest(Selected)


							
							while true do
								local Coords = GetEntityCoords(Ped)
								local pCoords = GetEntityCoords(Selected)
								local Distance = #(Coords - pCoords)

								if Distance <= 2 then
									SelectedRobbery = SelectedRobbery - 1

									if SelectedRobbery <= 0 then
										local Anim = "mp_safehouselost@"
										local Hash = "prop_anim_cash_note"

										RequestModel(Hash)
										while not HasModelLoaded(Hash) do
											Wait(1)
										end

										RequestAnimDict(Anim)
										while not HasAnimDictLoaded(Anim) do
											Wait(1)
										end

										local Object = CreateObject(Hash, Coords["x"], Coords["y"], Coords["z"], false, false, false)
										AttachEntityToEntity(Object, Selected, GetPedBoneIndex(Selected, 28422), 0.0, 0.0, 0.0, 90.0, 0.0,
											0.0, false, false, false, false, 2, true)
										vRP.createObjects(Anim, "package_dropoff", "prop_paper_bag_small", 16, 28422, 0.0, -0.05, 0.05, 180.0,
											0.0, 0.0)
										TaskPlayAnim(Selected, Anim, "package_dropoff", 8.0, 8.0, -1, 16, 0, 0, 0, 0)

										Wait(3000)

										if DoesEntityExist(Object) then
											SetModelAsNoLongerNeeded(Hash)
											DeleteEntity(Object)
										end

										vRP.removeObjects()
										ClearPedSecondaryTask(Selected)
										FreezeEntityPosition(Selected,false)
										TaskWanderStandard(Selected, 10.0, 10)
										TriggerServerEvent("inventory:DrugsPeds")

										LocalPlayer["state"]["Buttons"] = false
										LocalPlayer["state"]["Commands"] = false

										break
									end
								else
									ClearPedSecondaryTask(Selected)
									FreezeEntityPosition(Selected,false)
									TaskWanderStandard(Selected, 10.0, 10)

									LocalPlayer["state"]["Buttons"] = false
									LocalPlayer["state"]["Commands"] = false

									break
								end

								Wait(1)
							end
						end
					end
				end

				Success, Selected = FindNextPed(Handler)
			until not Success
			EndFindPed(Handler)
		end

		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKARMS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.CheckArms()
	return exports["paramedic"]:Arms()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISVARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local disSelect = 1
local disPlate = nil
local disModel = nil
local disActive = false
local disVehicle = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCOORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disCoords = {
	{ 1222.5,   -704.47,  60.46,  280.63 },
	{ 1130.51,  -485.59,  65.38,  73.71 },
	{ 1145.64,  -275.44,  68.73,  87.88 },
	{ 870.49,   -36.63,   78.54,  56.7 },
	{ 686.17,   270.39,   93.18,  240.95 },
	{ 424.75,   248.87,   102.97, 252.29 },
	{ 320.31,   344.97,   104.97, 164.41 },
	{ -305.23,  379.3,    110.1,  14.18 },
	{ -585.54,  526.74,   107.3,  215.44 },
	{ -141.85,  -1415.44, 30.26,  119.06 },
	{ 78.27,    -1442.22, 29.08,  323.15 },
	{ 37.9,     -1627.08, 29.05,  320.32 },
	{ 8.93,     -1758.65, 29.07,  48.19 },
	{ -57.56,   -1845.21, 26.25,  320.32 },
	{ 165.33,   -1862.16, 23.88,  155.91 },
	{ 281.15,   -2081.27, 16.58,  110.56 },
	{ 273.47,   -2569.7,  5.48,   204.1 },
	{ 879.22,   -2174.3,  30.28,  172.92 },
	{ 1116.02,  -1502.53, 34.46,  272.13 },
	{ 1318.13,  -534.38,  71.83,  158.75 },
	{ 1272.4,   -353.88,  68.85,  110.56 },
	{ 653.32,   176.89,   94.78,  68.04 },
	{ 638.88,   285.34,   102.97, 150.24 },
	{ 320.97,   495.35,   152.24, 286.3 },
	{ -74.63,   495.95,   144.22, 8.51 },
	{ 176.89,   483.66,   141.99, 351.5 },
	{ 181.24,   380.51,   108.55, 0.0 },
	{ -398.45,  337.43,   108.48, 0.0 },
	{ -472.76,  353.61,   103.64, 337.33 },
	{ -947.26,  574.26,   100.76, 343.0 },
	{ -1093.13, 597.22,   102.83, 212.6 },
	{ -1271.82, 452.79,   94.8,   19.85 },
	{ -1452.14, 533.73,   118.98, 243.78 },
	{ -1507.85, 429.28,   110.84, 45.36 },
	{ -1945.59, 461.12,   101.76, 96.38 },
	{ -2001.96, 368.42,   94.24,  184.26 },
	{ -1325.69, 275.44,   63.19,  221.11 },
	{ -1281.53, 251.9,    63.1,   0.0 },
	{ -905.31,  -161.16,  41.65,  25.52 },
	{ -1023.98, -889.95,  5.43,   28.35 },
	{ -1318.87, -1141.38, 4.26,   90.71 },
	{ -1311.98, -1262.24, 4.33,   17.01 },
	{ -1297.72, -1316.22, 4.5,    0.0 },
	{ -1245.66, -1408.65, 4.08,   306.15 },
	{ -1092.76, -1595.64, 4.31,   306.15 },
	{ -963.01,  -1592.08, 4.79,   19.85 },
	{ -915.94,  -1541.24, 4.79,   17.01 },
	{ -1612.04, 172.37,   59.56,  206.93 },
	{ -1242.87, 381.54,   75.12,  14.18 },
	{ -1486.76, 40.22,    54.19,  345.83 },
	{ -1576.99, -81.09,   53.9,   272.13 },
	{ -1391.2,  75.67,    53.46,  130.4 },
	{ -1371.61, -26.18,   53.01,  0.0 },
	{ -1643.74, -232.78,  54.63,  252.29 },
	{ -1656.27, -379.46,  45.09,  232.45 },
	{ -1591.38, -643.5,   29.93,  232.45 },
	{ -1486.49, -735.27,  25.29,  181.42 },
	{ -1423.37, -963.41,  7.03,   56.7 },
	{ -1277.8,  -1149.11, 6.08,   113.39 },
	{ -1070.8,  -1424.54, 5.12,   257.96 },
	{ -1069.67, -1250.98, 5.49,   119.06 },
	{ -1610.2,  -812.21,  9.81,   138.9 },
	{ -2061.94, -455.86,  11.44,  320.32 },
	{ -2981.69, 83.31,    11.29,  147.41 },
	{ -3045.4,  111.55,   11.32,  320.32 },
	{ -2960.51, 368.42,   14.54,  31.19 },
	{ -3052.28, 599.99,   7.11,   289.14 },
	{ -3253.1,  987.45,   12.23,  0.0 },
	{ -3236.9,  1038.27,  11.42,  266.46 },
	{ -3156.21, 1153.75,  20.83,  246.62 },
	{ -1819.34, 785.21,   137.68, 223.94 },
	{ -1749.7,  366.06,   89.47,  116.23 },
	{ -1194.9,  322.62,   70.48,  17.01 },
	{ -1207.54, 272.21,   69.3,   286.3 },
	{ -722.21,  -76.25,   37.31,  243.78 },
	{ -475.64,  -218.96,  36.16,  212.6 },
	{ -532.25,  -270.6,   34.98,  110.56 },
	{ -465.2,   -451.88,  33.97,  82.21 },
	{ -391.09,  -456.15,  30.72,  127.56 },
	{ -357.4,   -767.63,  38.55,  272.13 },
	{ -330.9,   -935.02,  30.85,  68.04 },
	{ -27.99,   -2547.6,  5.78,   53.86 },
	{ -140.18,  -2506.08, 5.76,   53.86 },
	{ -168.21,  -2583.56, 5.76,   0.0 },
	{ -219.34,  -2488.65, 5.76,   87.88 },
	{ -340.93,  -2430.9,  5.76,   138.9 },
	{ -434.24,  -2441.94, 5.76,   232.45 },
	{ 124.19,   -2898.73, 5.76,   0.0 },
	{ 237.55,   -3315.73, 5.56,   201.26 },
	{ 150.76,   -3184.91, 5.63,   178.59 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLECATEGORY
-----------------------------------------------------------------------------------------------------------------------------------------
local DismantleCategory = {
	["B"] = {
		"panto", "prairie", "rhapsody", "blista", "dilettante", "emperor2", "emperor", "bfinjection", "ingot", "regina"
	},
	["B+"] = {
		"asbo", "brioso", "club", "weevil", "felon", "felon2", "jackal", "oracle", "zion", "zion2", "buccaneer", "virgo",
		"voodoo", "bifta", "rancherxl", "bjxl", "cavalcade", "gresley", "habanero", "rocoto", "primo", "stratum", "pigalle",
		"peyote", "manana", "streiter"
	},
	["A"] = {
		"exemplar", "windsor", "windsor2", "blade", "clique", "dominator", "faction2", "gauntlet", "moonbeam", "nightshade",
		"sabregt2", "tampa", "rebel", "baller", "cavalcade2", "fq2", "huntley", "landstalker", "patriot", "radi", "xls",
		"blista2",
		"retinue", "stingergt", "surano", "specter", "sultan", "schwarzer", "schafter2", "ruston", "rapidgt", "raiden",
		"ninef",
		"ninef2", "omnis", "massacro", "jester", "feltzer2", "futo", "carbonizzare"
	},
	["A+"] = {
		"voltic", "sc1", "sultanrs", "tempesta", "nero", "nero2", "reaper", "gp1", "infernus", "bullet", "banshee2",
		"turismo2", "retinue",
		"mamba", "infernus2", "feltzer3", "coquette2", "futo2", "zr350", "tampa2", "sugoi", "sultan2", "schlagen", "penumbra",
		"pariah",
		"paragon", "jester3", "gb200", "elegy", "furoregt"
	},
	["S"] = {
		"zentorno", "xa21", "visione", "vagner", "vacca", "turismor", "t20", "osiris", "italigtb", "entityxf", "cheetah",
		"autarch", "sultan3",
		"cypher", "vectre", "growler", "comet6", "jester4", "euros", "calico", "neon", "kuruma", "issi7", "italigto",
		"komoda", "elegy2", "coquette4"
	},
	["S+"] = {
		"mazdarx72", "rangerover", "civictyper", "subaruimpreza", "corvettec7", "ferrariitalia", "mustang1969", "vwtouareg",
		"mercedesg65", "bugattiatlantic", "m8competition", "audirs6", "audir8", "silvias15", "camaro", "mercedesamg63",
		"dodgechargerrt69", "skyliner342", "astonmartindbs", "panameramansory", "lamborghinihuracanlw", "lancerevolutionx",
		"porsche911", "jeepcherokee", "dodgecharger1970", "golfgti", "subarubrz", "nissangtr", "mustangfast", "golfmk7",
		"lancerevolution9", "shelbygt500", "ferrari812", "bmwm4gts", "ferrarif12", "bmwm5e34", "toyotasupra2", "escalade2021",
		"fordmustang", "mclarensenna", "lamborghinihuracan", "acuransx", "toyotasupra", "escaladegt900", "bentleybacalar"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.Dismantle(Experience)
	if not disActive then
		disActive = true
		disSelect = math.random(#disCoords)
		disPlate = "DISM" .. (1000 + LocalPlayer["state"]["Id"])

		local Category = ClassCategory(Experience)
		local ModelRandom = math.random(#DismantleCategory[Category])
		disModel = DismantleCategory[Category][ModelRandom]

		local RandomX = math.random(25, 100)
		local RandomY = math.random(25, 100)

		if math.random(2) >= 2 then
			TriggerEvent("NotifyPush",
				{
					code = 20,
					title = "Localização do Veículo",
					x = disCoords[disSelect][1] + RandomX + 0.0,
					y = disCoords[disSelect][2] - RandomY + 0.0,
					z = disCoords[disSelect][3],
					vehicle = vehicleName(disModel) .. " - " .. disPlate,
					blipColor = 60
				})
		else
			TriggerEvent("NotifyPush",
				{
					code = 20,
					title = "Localização do Veículo",
					x = disCoords[disSelect][1] - RandomX + 0.0,
					y = disCoords[disSelect][2] + RandomY + 0.0,
					z = disCoords[disSelect][3],
					vehicle = vehicleName(disModel) .. " - " .. disPlate,
					blipColor = 60
				})
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLESTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.DismantleStatus()
	return disActive
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISRESET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:Disreset")
AddEventHandler("inventory:Disreset", function()
	disSelect = 1
	disPlate = nil
	disModel = nil
	disActive = false
	disVehicle = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if disActive and not disVehicle then
			local Ped = PlayerPedId()
			local Coords = GetEntityCoords(Ped)
			local Distance = #(Coords - vec3(disCoords[disSelect][1], disCoords[disSelect][2], disCoords[disSelect][3]))

			if Distance <= 125 then
				disVehicle = vGARAGE.serverVehicle(disModel, disCoords[disSelect][1], disCoords[disSelect][2],
					disCoords[disSelect][3], disCoords[disSelect][4], disPlate, 1000, nil, 1000)

				print('disVehicle', json.encode(disVehicle), json.encode(disCoords[disSelect]))

				if NetworkDoesNetworkIdExist(disVehicle) then
					local vehNet = NetToEnt(disVehicle)
					if NetworkDoesNetworkIdExist(vehNet) then
						SetVehicleOnGroundProperly(vehNet)
					end
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local disPeds = {
	"ig_abigail", "a_m_m_afriamer_01", "ig_mp_agent14", "csb_agent", "ig_amandatownley", "s_m_y_ammucity_01",
	"u_m_y_antonb", "g_m_m_armboss_01",
	"g_m_m_armgoon_01", "g_m_m_armlieut_01", "ig_ashley", "s_m_m_autoshop_01", "ig_money", "g_m_y_ballaeast_01",
	"g_f_y_ballas_01", "g_m_y_ballasout_01",
	"s_m_y_barman_01", "u_m_y_baygor", "a_m_o_beach_01", "ig_bestmen", "a_f_y_bevhills_01", "a_m_m_bevhills_02",
	"u_m_m_bikehire_01", "u_f_y_bikerchic",
	"mp_f_boatstaff_01", "s_m_m_bouncer_01", "ig_brad", "ig_bride", "u_m_y_burgerdrug_01", "a_m_m_business_01",
	"a_m_y_business_02", "s_m_o_busker_01",
	"ig_car3guy2", "cs_carbuyer", "g_m_m_chiboss_01", "g_m_m_chigoon_01", "g_m_m_chigoon_02", "u_f_y_comjane", "ig_dale",
	"ig_davenorton", "s_m_y_dealer_01",
	"ig_denise", "ig_devin", "a_m_y_dhill_01", "ig_dom", "a_m_y_downtown_01", "ig_dreyfuss"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local disWeapons = { "WEAPON_HEAVYPISTOL", "WEAPON_SMG", "WEAPON_ASSAULTSMG", "WEAPON_APPISTOL", "WEAPON_SPECIALCARBINE",
	"WEAPON_PUMPSHOTGUN" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inventory:DisPed")
AddEventHandler("inventory:DisPed", function()
	local Ped = PlayerPedId()
	local Rand = math.random(#disPeds)
	local Coords = GetEntityCoords(Ped)
	local Weapon = math.random(#disWeapons)
	local cX = Coords["x"] + math.random(-25.0, 25.0)
	local cY = Coords["y"] + math.random(-25.0, 25.0)
	local Hit, EntCoords = GetSafeCoordForPed(cX, cY, Coords["z"], false, 16)
	local Entity, EntityNet = vRPS.CreatePed(disPeds[Rand], EntCoords["x"], EntCoords["y"], EntCoords["z"], 3374176, 4)
	if Entity then
		Wait(1000)

		local SpawnEntity = 0
		local NetEntity = NetworkGetEntityFromNetworkId(EntityNet)
		while not DoesEntityExist(NetEntity) and SpawnEntity <= 1000 do
			NetEntity = NetworkGetEntityFromNetworkId(EntityNet)
			SpawnEntity = SpawnEntity + 1
			Wait(1)
		end

		SpawnEntity = 0
		local NetControl = NetworkRequestControlOfEntity(NetEntity)
		while not NetControl and SpawnEntity <= 1000 do
			NetControl = NetworkRequestControlOfEntity(NetEntity)
			SpawnEntity = SpawnEntity + 1
			Wait(1)
		end

		SetPedArmour(NetEntity, 100)
		SetPedAccuracy(NetEntity, 100)
		SetPedKeepTask(NetEntity, true)
		SetCanAttackFriendly(NetEntity, false, true)
		TaskCombatPed(NetEntity, Ped, 0, 16)
		SetPedCombatAttributes(NetEntity, 46, true)
		SetPedCombatAbility(NetEntity, 2)
		SetPedCombatAttributes(NetEntity, 0, true)
		GiveWeaponToPed(NetEntity, disWeapons[Weapon], -1, false, true)
		SetPedDropsWeaponsWhenDead(NetEntity, false)
		SetPedCombatRange(NetEntity, 2)
		SetPedFleeAttributes(NetEntity, 0, 0)
		SetPedConfigFlag(NetEntity, 58, true)
		SetPedConfigFlag(NetEntity, 75, true)
		SetPedFiringPattern(NetEntity, -957453492)
		SetBlockingOfNonTemporaryEvents(NetEntity, true)
		SetEntityAsNoLongerNeeded(NetEntity)
	end
end)

RegisterNetEvent("police:trackStolenVehicle")
AddEventHandler("police:trackStolenVehicle", function(netVeh)
    local vehicle = NetToVeh(netVeh)
    if DoesEntityExist(vehicle) then
        local blip = AddBlipForEntity(vehicle)
        SetBlipSprite(blip, 225) 
        SetBlipColour(blip, 1)   
        SetBlipScale(blip, 0.8)
        SetBlipFlashes(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Veículo Roubado")
        EndTextCommandSetBlipName(blip)

        CreateThread(function()
            local timePassed = 0
            while DoesBlipExist(blip) and timePassed < 180 do
                if not DoesEntityExist(vehicle) then
                    RemoveBlip(blip)
                    break
                end
                Citizen.Wait(1000)
                timePassed = timePassed + 1
            end

            if DoesBlipExist(blip) then
                RemoveBlip(blip)
            end
        end)
    end
end)


RegisterNetEvent("police:trackBlip")
AddEventHandler("police:trackBlip", function(coords)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 58) 
    SetBlipColour(blip, 3)  
    SetBlipScale(blip, 0.9)
    SetBlipFlashes(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pessoa Rastreada")
    EndTextCommandSetBlipName(blip)


    SetTimeout(30000, function()
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end)
end)

RegisterNetEvent("weplants:createBlip")
AddEventHandler("weplants:createBlip", function(x, y, z)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 496) 
    SetBlipColour(blip, 2) 
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Minha Plantação")
    EndTextCommandSetBlipName(blip)

    Citizen.CreateThread(function()
        Citizen.Wait(30 * 60000) 
        RemoveBlip(blip)
    end)
end)

RegisterNetEvent("custom:applyHandcuffProp")
AddEventHandler("custom:applyHandcuffProp", function()
    local ped = PlayerPedId()

    local cuffs = CreateObject(GetHashKey("p_cs_cuffs_02_s"), GetEntityCoords(ped), true, true, true)
    local networkId = ObjToNet(cuffs)

    SetNetworkIdExistsOnAllMachines(networkId, true)
    SetNetworkIdCanMigrate(networkId, false)
    NetworkSetNetworkIdDynamic(networkId, true)

    AttachEntityToEntity(
        cuffs,
        ped,
        GetPedBoneIndex(ped, 60309),
        -0.055, 0.06, 0.04,
        265.0, 155.0, 80.0,
        true, false, false, false, 0, true
    )

    TriggerEvent("custom:storeCuffEntity", cuffs)
end)

local storedCuffs = nil
RegisterNetEvent("custom:storeCuffEntity")
AddEventHandler("custom:storeCuffEntity", function(entity)
    storedCuffs = entity
end)

RegisterNetEvent("custom:removeCuffProp")
AddEventHandler("custom:removeCuffProp", function()
    if storedCuffs then
        DeleteEntity(storedCuffs)
        storedCuffs = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASH REGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
local registerCoords = {}
function cRP.cashRegister()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k, v in pairs(registerCoords) do
		local distance = #(coords - vector3(v[1], v[2], v[3]))
		if distance <= 1 then
			return false, v[1], v[2], v[3]
		end
	end

	local object = GetClosestObjectOfType(coords, 0.4, GetHashKey("prop_till_01"), 0, 0, 0)
	if DoesEntityExist(object) then
		SetEntityHeading(ped, GetEntityHeading(object) - 360.0)
		local coords = GetEntityCoords(object)
		return true, coords.x, coords.y, coords.z
	end

	return false
end

RegisterNetEvent("inventory:updateRegister")
AddEventHandler("inventory:updateRegister", function(status)
	registerCoords = status
end)


function isMeleeWeapon(wep_name)
	if wep_name == "prop_golf_iron_01" then
		return true
	elseif wep_name == "w_me_bat" then
		return true
	elseif wep_name == "prop_ld_jerrycan_01" then
		return true
	else
		return false
	end
end

--[[ Citizen.CreateThread(function()

	while true do

		TriggerEvent("hud:ActiveArmed",weaponActive)

		Wait(0)
	end


end) ]]

RegisterCommand('test', function()
	local talkRequest = math.random(1,#Config["TalkNPCRequest"])
	TriggerEvent("showme:NPC", Config["TalkNPCRequest"][talkRequest])
end)