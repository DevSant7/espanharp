local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

CreateThread(function()
    while true do
        local day = os.date("%A")

        for _,v in pairs(Config.Drop.Days) do
            if v == day then
                local now = os.date("*t")
                local dropTime = DecreaseTime(Config.Drop.Times.Start[1], Config.Drop.Times.Start[2])

                if now.hour == dropTime[1] and now.min == dropTime[2] then
                    StartEvent()

                    return
                end
            end
        end
        
        Wait(60 * 1000)
    end 
end)

function StartEvent()
    local locationIndex = math.random(1, #Config.Locations)

    TriggerClientEvent("sounds:source", -1, Config.Alert.Sound.Name, Config.Alert.Sound.Volume)
    
    TriggerClientEvent("fortal-airdrop:Client:StartDelay", -1, locationIndex)
    TriggerClientEvent('Notify2', -1,"airdrop", Config.Alert.Chat.Start.Title, Config.Alert.Chat.Start.Message,5000)
    CreateLoot()

    Wait((Config.Drop.Times.Decrease - Config.Drop.Times.Plane) * 60 * 1000)
 
    TriggerClientEvent("fortal-airdrop:Client:StartDrop", -1, locationIndex)
end

function CreateLoot()
	local data = {}
	local slotIndex = 200

	for _,v in pairs(Config.Items) do
		local amount = 0

		if type(v.amount) == "number" then
			amount = v.amount
		else
			amount = math.random(v.amount.min, v.amount.max)
		end

		data[tostring(slotIndex)] = {
			item = v.spawn,
			amount = amount
		}

		slotIndex = slotIndex + 1
	end

	vRP.setSrvdata("stackChest:AirDrop-1", data)
end

function DecreaseTime(hour, minute)
    minute = minute - Config.Drop.Times.Decrease
    
    if minute < 0 then
        minute = minute + 60
        hour = hour - 1
        
        if hour < 0 then
            hour = 23
        end
    end
    
    return {hour, minute}
end

RegisterCommand("startairdrop", function(playerSource)
    local userId = vRP.getUserId(playerSource)

    if vRP.hasGroup(userId, "Admin") then
        StartEvent()
    end
end)

