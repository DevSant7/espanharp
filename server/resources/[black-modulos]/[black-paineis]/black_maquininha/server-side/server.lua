local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("black_maquininha",src)
clientAPI = Tunnel.getInterface("black_maquininha")

function src.getUserData()
    local source = source 
    local userId = Utils.functions.userId(source)
    local userName = Utils.functions.userIdentity(userId) 

    return userId,userName 
end

function src.getUserDataFromId(user_id)
    if not user_id or user_id == 0 then return end 
    local userName = Utils.functions.userIdentity(user_id)

    return userName,user_id 
end

function src.createObject(model,x,y,z)
    local spawnObjects = 0
	local mHash = GetHashKey(model)
	local Object = CreateObject(mHash,x,y,z,true,true,false)

	while not DoesEntityExist(Object) and spawnObjects <= 1000 do
		spawnObjects = spawnObjects + 1
		Wait(1)
	end

	if DoesEntityExist(Object) then
		return true,NetworkGetNetworkIdFromEntity(Object)
	end

	return false
end

function src.tryDeleteObject(entIndex)
    local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 3 then
		DeleteEntity(idNetwork)
	end
end

function src.sendBill(user_id,value)
    local source = source 
    local userId = Utils.functions.userId(source)
    local userName = Utils.functions.userIdentity(userId) 
    local otherPlayer = Utils.functions.getSourceFromId(user_id)
    local otherPlayerId = user_id
    local requestMessage = string.format(Utils.messages["request"],userName,Utils.functions.format(value))
    local sucessMessage = string.format(Utils.messages["sucess2"],value)
    if Utils.functions.request(otherPlayer,requestMessage) then 
        if Utils.functions.tryPayment(otherPlayerId,value) then 
            Utils.functions.giveMoney(userId,value)
            Utils.functions.notify(otherPlayer,"green",Utils.messages["sucess"])
            Utils.functions.notify(source,"green",sucessMessage)
        else
            Utils.functions.notify(otherPlayer,"red",Utils.messages["denied"])
            Utils.functions.notify(source,"red",Utils.messages["denied2"])
        end 
    end 
    return false 
end