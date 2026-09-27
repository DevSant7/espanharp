-----------------------------------------------------------------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------------------------------------------------------------
local Gymnasium = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("target:Gymnasium")
AddEventHandler("target:Gymnasium",function(Value)
	local source = source
	local Ped = GetPlayerPed(source)
	local user_id = vRP.getUserId(source)
	if user_id and not Gymnasium["Gymnasium"..Value.Location..":"..Value.Equipment..""..Value.Position] then

		Gymnasium["Gymnasium"..Value.Location..":"..Value.Equipment..""..Value.Position] = { 
			Location = Value.Location, 
			Equipment = Value.Equipment, 
			Position = Value.Position, 
			user_id = user_id 
		}
		GlobalState["Gymnastics"] = { 
			Location = Value.Location, 
			Equipment = Value.Equipment, 
			Position = Value.Position, 
			Available = false 
		}

		FreezeEntityPosition(Ped,true)
		Player(source)["state"]["Buttons"] = true
		Player(source)["state"]["Cancel"] = true

		if Value.Anim[3] ~= "prop_barbell_01" then
			if Value.Anim[1] == "mouse@byc_crunch" and Value.Anim[2] == "byc_crunch_clip" then
				local x = Value.Coords[1] - math.sin(math.rad(Value.Coords[4])) * 0.25
				local y = Value.Coords[2] + math.cos(math.rad(Value.Coords[4])) * 0.25
				SetEntityCoords(Ped,x, y, Value.Coords[3]+0.50, true, true, true, true)		
				SetEntityRotation(Ped,-20.0,0.0,Value.Coords[4])
			elseif Value.Anim[3] == "prop_barbell_100kg" then
				SetEntityHeading(Ped,Value.Coords[4])
				SetEntityCoords(Ped,Value.Coords[1], Value.Coords[2], Value.Coords[3]-0.5, true, true, true, true)		
			elseif Value.Anim[1] == "mouse@situp" and Value.Anim[2] == "situp_clip" then
				SetEntityHeading(Ped,Value.Coords[4])
				SetEntityCoords(Ped,Value.Coords[1], Value.Coords[2], Value.Coords[3]+0.5, true, true, true, true)		
			else
				SetEntityHeading(Ped,Value.Coords[4])
				SetEntityCoords(Ped,Value.Coords[1], Value.Coords[2], Value.Coords[3], true, true, true, true)		
			end
		end

		if Value.Anim[3] then
			vRPC.createObjects(source,Value.Anim[1],Value.Anim[2],Value.Anim[3],1,28422)
		else
			vRPC.playAnim(source,false,{Value.Anim[1],Value.Anim[2]},true)
		end

        TriggerClientEvent("Progress",source,5000)
        
        Wait(5000)
		-- if vTASKBAR.taskLockpick(source) then
		if vRP.getWeight(user_id) < 100 then 
			vRP.setWeight(user_id,1)
		end
		
		if math.random(100) <= 15 then
			vRP.downgradeHunger(user_id, 1)
			vRP.downgradeThirst(user_id, 2)
		end
		-- end

		Gymnasium["Gymnasium"..Value.Location..":"..Value.Equipment..""..Value.Position] = nil
		GlobalState["Gymnastics"] = { 
			Location = Value.Location, 
			Equipment = Value.Equipment, 
			Position = Value.Position, 
			Available = true 
		}

		vRPC.removeObjects(source)
		FreezeEntityPosition(Ped,false)
		Player(source)["state"]["Buttons"] = false
		Player(source)["state"]["Cancel"] = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(Passport,source)
	TriggerClientEvent("target:Gymnasium",source,{Gymnasium,vRP.userData(Passport,"Gym")})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function(Passport,source)
	for Key,Value in pairs(Gymnasium) do
		if Value == Passport then
			GlobalState["Gymnastics"] = { 
				Location = Value.Location, 
				Equipment = Value.Equipment, 
				Position = Value.Position, 
				Available = true 
			}
			Gymnasium[Key] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("target:PaymentGym")
AddEventHandler("target:PaymentGym",function(Location,Price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local Data = vRP.userData(user_id,"Gymnasium") or {}
		if not Data[tostring(Location)] or (Data[tostring(Location)] <= os.time()) then
			if vRP.hasGroup(user_id,"Premium") or vRP.request(source,"Assinar Academia por <b>$"..parseFormat(Price).."</b>? Lembrando que a duração do mesmo é de 7 dias.") and vRP.paymentFull(user_id,tonumber(Price)) then
				Data[tostring(Location)] = os.time() + 604800
				vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Gymnasium", value = json.encode(Data) })
				TriggerClientEvent("Notify",source,"verde","Obrigado por escolher nossa academia.",5000) 
				TriggerClientEvent("target:Gymnasium",source,{Gymnasium,Data})
			end
		else
			TriggerClientEvent("target:Gymnasium",source,{Gymnasium,Data})
            TriggerClientEvent("Notify",source,"verde","Você iniciou o treino!",5000) 
		end
	end
end)