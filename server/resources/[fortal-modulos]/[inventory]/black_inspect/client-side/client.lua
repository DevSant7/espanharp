-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("inspect",cRP)
vSERVER = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local isInspectOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data, cb)
	if isInspectOpen then
		SendNUIMessage({ action = "setVisibility", data = false })
		SetNuiFocus(false,false)
		isInspectOpen = false
		vSERVER.resetInspect()
	end
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data, cb)
	vSERVER.takeItem(data["item"],data["slot"],data["amount"],data["target"])
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data, cb)
	vSERVER.storeItem(data["item"],data["slot"],data["amount"],data["target"])
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT (INSPECTOR'S INVENTORY)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data, cb)
	vSERVER.updateSlot(data["slot"],data["target"],data["amount"])
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST (TARGET'S INVENTORY)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateChest",function(data, cb)
	vSERVER.updateChest(data["slot"],data["target"],data["amount"])
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestInventoryAndChest",function(data,cb)
	local myInventory,myChest,invPeso,invMaxpeso,chestPeso,chestMaxpeso = vSERVER.openChest()
	if myInventory then
		cb({ chest = myChest, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso,inventario = myInventory,invPeso = invPeso,invMaxpeso = invMaxpeso })
	else
		cb({})
	end
end)

RegisterNUICallback("Profile",function(data,cb)
	local userProfile = vSERVER.getUserProfile()
	if userProfile then
		cb(userProfile)
	else
		cb({})
	end
end) 

RegisterNUICallback("removeFocus",function(data, cb)
	SetNuiFocus(false,false)
	isInspectOpen = false
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSPECT:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:Update")
AddEventHandler("inspect:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openInspect()
	if not isInspectOpen then
		isInspectOpen = true
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "setColor", data = "60, 142, 220"})
		SendNUIMessage({ action = "setVisibility", data = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.closeInspect()
	if isInspectOpen then
		isInspectOpen = false
		SendNUIMessage({ action = "setVisibility", data = false })
		SetNuiFocus(false,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:updateInventory")
AddEventHandler("inspect:updateInventory",function(myInventory,myChest,invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	if isInspectOpen then
		SendNUIMessage({ 
			action = "updateBackpack", 
			data = myInventory 
		})
		SendNUIMessage({ 
			action = "updateDrop", 
			data = myChest 
		})
		SendNUIMessage({ 
			action = "setProfile", 
			data = {
				weight = invPeso,
				maxWeight = invMaxpeso,
				loseWeight = chestPeso,
				loseMaxWeight = chestMaxpeso
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPROFILE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:updateProfile")
AddEventHandler("inspect:updateProfile",function(profile)
	if isInspectOpen then
		SendNUIMessage({ 
			action = "setProfile", 
			data = profile 
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEINFO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("inspect:updateInfo")
AddEventHandler("inspect:updateInfo",function(info)
	if isInspectOpen then
		SendNUIMessage({ 
			action = "setInfo", 
			data = {
				slot = info.inspectorSlots,
				show = info.inspectorIsVip,
				targetSlots = info.targetSlots,
				targetShow = info.targetIsVip
			}
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET ON RESOURCE STOP
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	if isInspectOpen then
		SetNuiFocus(false,false)
		isInspectOpen = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KEY HANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		if isInspectOpen then
			if IsControlJustPressed(0, 322) or IsControlJustPressed(0, 177) then -- ESC key
				SendNUIMessage({ action = "setVisibility", data = false })
				SetNuiFocus(false,false)
				isInspectOpen = false
				vSERVER.resetInspect()
			end
		end
		Wait(0)
	end
end)

local invincible = false
local invincibleTimeout = nil

RegisterNetEvent("inspect:apply")
AddEventHandler("inspect:apply", function()
    local ped = PlayerPedId()

    if invincibleTimeout then
        CancelEvent(invincibleTimeout)
        invincibleTimeout = nil
    end

    invincible = true
    SetEntityInvincible(ped, true)

    invincibleTimeout = SetTimeout(60000, function()
        invincible = false
        SetEntityInvincible(ped, false)
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local ped = PlayerPedId()
        if invincible and IsEntityDead(ped) then
            invincible = false
            SetEntityInvincible(ped, false)
            if invincibleTimeout then
                CancelEvent(invincibleTimeout)
                invincibleTimeout = nil
            end
        end
    end
end)
