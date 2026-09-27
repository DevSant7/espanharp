-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Tools = module("lib/Tools")
vRPC = Tunnel.getInterface("vRP")
REQUEST = Tunnel.getInterface("request")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = {}
tvRP = {}
vRP.userIds = {}
vRP.userInfos = {}
vRP.userTables = {}
vRP.userSources = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNER/PROXY
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy.addInterface("vRP",vRP)
Tunnel.bindInterface("vRP",tvRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCORDHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webHook = "https://discord.com/api/webhooks/1358562618230571068/kMuh0bDfxLBce6ocCY22BPpG8VWPSG36DmrnirxcIZ5B60365jig-GAHAPbEzAiRIUNE"
-----------------------------------------------------------------------------------------------------------------------------------------
-- MYSQL
-----------------------------------------------------------------------------------------------------------------------------------------
local mysqlDriver
local userSql = {}
local mysqlInit = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- CACHE
-----------------------------------------------------------------------------------------------------------------------------------------
local cacheQuery = {}
local cachePrepare = {}
local srvData = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENHA
-----------------------------------------------------------------------------------------------------------------------------------------
local onlyPasswordMode = false
local requiredPassword = "senha123" 
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETIDENTITIES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getIdentities(source)
	local result = false

	local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			local splitName = splitString(v,":")
			result = splitName[2]
			break
		end
	end

	return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- getLbPhone
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getLbPhone(user_id)
    local result = vRP.query("vRP/getLbPhone", { user_id = user_id })
    if result and result[1] then
        return result[1].phone_number
    end
    return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REGISTERDRIVERS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.registerDrivers(name,onInit,onPrepare,onQuery)
	if not userSql[name] then
		userSql[name] = { onInit,onPrepare,onQuery }
		mysqlDriver = userSql[name]
		mysqlInit = true

		for _,prepare in pairs(cachePrepare) do
			onPrepare(table.unpack(prepare,1,table.maxn(prepare)))
		end

		for _,query in pairs(cacheQuery) do
			query[2](onQuery(table.unpack(query[1],1,table.maxn(query[1]))))
		end

		cachePrepare = {}
		cacheQuery = {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATETXT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateTxt(archive,text)
	archive = io.open("resources/logsystem/"..archive,"a")
	if archive then
		archive:write(text.."\n")
	end

	archive:close()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.prepare(name,query)
	if mysqlInit then
		mysqlDriver[2](name,query)
	else
		table.insert(cachePrepare,{ name,query })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUERY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.query(name,params,mode)
	if not mode then mode = "query" end

	if mysqlInit then
		return mysqlDriver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cacheQuery,{{ name,params or {},mode },r })
		return r:wait()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXECUTE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.execute(name,params)
	return vRP.query(name,params,"execute")
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getSrvdata(key)
	if srvData[key] == nil then
		local rows = vRP.query("entitydata/getData",{ dkey = key })
		if parseInt(#rows) > 0 then
			srvData[key] = { data = json.decode(rows[1]["dvalue"]), timer = 10 }
		else
			srvData[key] = { data = {}, timer = 10 }
		end
	end

	return srvData[key]["data"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setSrvdata(key,data)
	srvData[key] = { data = data, timer = 10 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMSRVDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remSrvdata(key)
	srvData[key] = { data = {}, timer = 10 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SRVSYNC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        for k,v in pairs(srvData) do
            if v["timer"] > 0 then
                v["timer"] = v["timer"] - 1

                if v["timer"] <= 0 then
                    vRP.execute("entitydata/setData",{ dkey = k, value = json.encode(v["data"]) })
                    srvData[k] = nil
                end
            end
        end

        Wait(10000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBANNED
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkBanned(steam)
	local consult = vRP.query("banneds/getBanned",{ steam = steam })
	if consult[1] then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFOACCOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.infoAccount(steam)
	local infoAccount = vRP.query("accounts/getInfos",{ steam = steam })
	return infoAccount[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userData(user_id,key)
	local consult = vRP.query("playerdata/getUserdata",{ user_id = user_id, key = key })
	if consult[1] then
		return json.decode(consult[1]["dvalue"])
	else
		return {}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEHOMEPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateHomePosition(user_id,x,y,z)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		dataTable["position"] = { x = mathLegth(x), y = mathLegth(y), z = mathLegth(z) }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userInventory(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["inventory"] == nil then
			dataTable["inventory"] = {}
		end

		return dataTable["inventory"]
	end

	return {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESELECTSKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateSelectSkin(user_id,hash)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		dataTable["skin"] = hash
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userGroups(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		return dataTable["perm"]
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERID
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getUserId(source)
	return vRP.userIds[parseInt(source)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userList()
	return vRP.userSources
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.userPlayers()
	return vRP.userIds
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.felpGetIdentity(user_id)
	return vRP.userIdentity(user_id)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETUSERSOURCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userSource(user_id)
	return vRP.userSources[parseInt(user_id)]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDATATABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getDatatable(user_id)
	return vRP.userTables[parseInt(user_id)] or false
end

function vRP.setDatatable(user_id,index,value)
	vRP.userTables[parseInt(user_id)][index]= value
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function(reason)
	playerDropped(source,reason)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("antiafk:kick")
AddEventHandler("antiafk:kick", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.kick(user_id, "Você foi removido por ficar AFK mais de uma hora.")
    end
end)

function vRP.kick(user_id,reason)
	local userSource = vRP.userSource(user_id)
	if userSource then
		playerDropped(userSource,"Kick/Afk")
		DropPlayer(userSource,reason)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
function playerDropped(source,reason)
	local source = parseInt(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Disconnect","**Source:** "..parseFormat(source).."\n**Passaporte:** "..parseFormat(user_id).."\n**Motivo:** "..reason.."\n**Horário:** "..os.date("%H:%M:%S"),3092790)

		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)

			dataTable["armour"] = GetPedArmour(ped)
			dataTable["health"] = GetEntityHealth(ped)
			local identity = vRP.userIdentity(user_id)
			local playerName = identity and (identity.name .. " " .. identity.name2) or "Desconhecido"
			

			exports["config"]:SendLog("PlayerExit", user_id, nil, {
				["1"] = reason,
				["2"] = coords.x,
				["3"] = coords.y,
				["4"] = coords.z,
				["5"] = playerName
			})
			
			TriggerEvent("playerDisconnect",user_id,source)

			if not Player(source).state.inSelector then
				vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Position", value = json.encode({ x = coords["x"], y = coords["y"], z = coords["z"] })})
			end

			vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(dataTable) })

			vRP.userSources[user_id] = nil
			vRP.userTables[user_id] = nil
			vRP.userInfos[user_id] = nil
			vRP.userIds[source] = nil
		end
	end
end

function vRP.rejoinPlayer(source)
	playerDropped(source, 'REJOINING')
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECTING
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:playerConnecting",function(source,identifiers,deferrals)
    deferrals.defer()
    Wait(0)

    local playerName = GetPlayerName(source)
    deferrals.update("Verificando acesso de " .. playerName .. "...")

    local steam = vRP.getIdentities(source)
    if not steam then
        deferrals.done("Conexão perdida com a Steam.")
        return
    end

    if onlyPasswordMode then
        deferrals.presentCard([[
        {
            "type": "adaptivecard",
            "body": [
                {
                    "type": "TextBlock",
                    "text": "CIDADE EM ATUALIZAÇÃO, PREVISÃO DE VOLTA ÀS 18:00HRS",
                    "weight": "bolder",
                    "size": "medium"
                },
                {
                    "type": "TextBlock",
                    "text": "Digite a senha para continuar:",
                    "wrap": true
                },
                {
                    "type": "Input.Text",
                    "id": "password",
                    "placeholder": "Senha"
                }
            ],
            "actions": [
                {
                    "type": "Action.Submit",
                    "title": "Entrar"
                }
            ],
            "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
            "version": "1.0"
        }
        ]], function(data, rawData)
            if not data or not data.password or data.password ~= requiredPassword then
                deferrals.done("Senha incorreta. Acesso negado.")
                return
            end

            handleConnection(steam, source, identifiers, deferrals)
        end)

        return 
    end

    handleConnection(steam, source, identifiers, deferrals)
end)

function handleConnection(steam, source, identifiers, deferrals)
    if not vRP.checkBanned(steam) then
        local infoAccount = vRP.infoAccount(steam)
        if infoAccount then
            if infoAccount["whitelist"] then
                deferrals.done()
            else
                deferrals.done("Envie na sala liberação: "..infoAccount["id"])
            end
        else
            local newAccount = vRP.execute("accounts/newAccount",{ steam = steam })
            deferrals.done("Envie na sala liberação: "..newAccount["insertId"])
        end
    else
        deferrals.done("Banido.")
    end

    TriggerEvent("Queue:removeQueue",identifiers)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.characterExit(source)
	if tonumber(source) <= 0 and tonumber(user_id) <= 0 then
		return false
	end 

	vRP.userIds[source] = user_id
end

function vRP.characterChosen(source,user_id,model,locate)
	if tonumber(source) <= 0 and tonumber(user_id) <= 0 then
		return false
	end 
	local identity = vRP.userIdentity(user_id)

	vRP.userIds[source] = user_id
	vRP.userInfos[user_id] = {}
	vRP.userSources[user_id] = source
	vRP.userTables[user_id] = vRP.userData(user_id,"Datatable")

	local userBank = vRP.userBank(user_id)
	if userBank then
		local bankValue = userBank["value"] or 0 
		vRP.userInfos[user_id]["bank"] = bankValue
	end

	if model ~= nil then
		vRP.userTables[user_id]["inventory"] = {}
		vRP.userTables[user_id]["hunger"]    = 100
		vRP.userTables[user_id]["thirst"]    = 100
		for _,item in pairs(Global.firstJoin.initialItens) do 
			vRP.generateItem(user_id,item[1],item[2],false)
		end 
		vRP.addBank(user_id,Global.firstJoin.bankMoney)
		vRP.userTables[user_id]["skin"] = GetHashKey(model)
		vRP.generateItem(user_id,"identity-"..user_id,1,false)
		vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Datatable", value = json.encode(vRP.userTables[user_id]) })
	end
	local infoAccount = vRP.infoAccount(identity["steam"])
	if infoAccount then
		vRP.userInfos[user_id]["premium"] = infoAccount["premium"]
		vRP.userInfos[user_id]["chars"] = infoAccount["chars"]

		PerformHttpRequest(webHook, function(err, text, headers) end, "POST", json.encode({
            content = user_id.." "..infoAccount["discord"].." "..identity["name"].." "..identity["name2"]
        }), {
            ["Content-Type"] = "application/json"
        })        
	end

	local identities = vRP.getIdentities(source)
	if identities ~= identity["steam"] then
		vRP.kick(user_id,"Expulso da cidade.")
	end

	local userGemstones = vRP.userGemstone(user_id)  
	TriggerClientEvent("hud:Gems",source,userGemstones)

	exports["config"]:SendLog("PlayerEnter",user_id,nil,{})

	TriggerClientEvent("vRP:playerActive",source,user_id,identity.name.." "..identity.name2)
	TriggerEvent("playerConnect",user_id,source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetGameType("Creative Roleplay")
	SetMapName("www.creative-rp.com")
end)

function vRP.getPlayersOn()
	local users = {}
	for k,v in pairs(vRP.userSources) do
		users[k] = v
	end
	return users
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:PRINT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:Print")
AddEventHandler("vRP:Print",function(message)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerEvent("discordLogs","Hackers","Passaporte **"..user_id.."** "..message..".",3092790)
	end
end)

vRP.getUserSource = vRP.userSource
vRP.getBankMoney = vRP.getBank
vRP.giveBankMoney = vRP.addBank
vRP.removeBankMoney = vRP.delBank
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERDER ITENS QUANDO MORRE
-----------------------------------------------------------------------------------------------------------------------------------------
local groupsVips = {
    ["Admin"] = true,
	["Bronze"] = true,
	["Prata"] = true,
	["Ouro"] = true,
	["Diamante"] = true,
	["Pascoa"] = true,
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERDER ITENS QUANDO MORRE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.clearInventory(user_id)
    vRP.userTables[user_id]["inventory"] = {}
    vRP.userTables[user_id]["weapons"] = {}
    vRP.upgradeThirst(user_id, 100)
    vRP.upgradeHunger(user_id, 100)

    local isVip = false
    for grupo, _ in pairs(groupsVips) do
        if vRP.hasPermission(user_id, grupo) then
            isVip = true
            break
        end
    end

    if not isVip then
        vRP.userTables[user_id]["weight"] = 30
    end

    return true
end 
------------- ----------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local weed = {}
local alcohol = {}
local chemical = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.weedReturn(user_id)
	if weed[user_id] then
		if os.time() < weed[user_id] then
			return parseInt(weed[user_id] - os.time())
		else
			weed[user_id] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEEDTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.weedTimer(user_id,timeSet)
	if weed[user_id] then
		weed[user_id] = weed[user_id] + (timeSet * 60)
	else
		weed[user_id] = os.time() + (timeSet * 60)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.chemicalReturn(user_id)
	if chemical[user_id] then
		if os.time() < chemical[user_id] then
			return parseInt(chemical[user_id] - os.time())
		else
			chemical[user_id] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.chemicalTimer(user_id,timeSet)
	if chemical[user_id] then
		chemical[user_id] = chemical[user_id] + (timeSet * 60)
	else
		chemical[user_id] = os.time() + (timeSet * 60)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALCOHOLRETURN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.alcoholReturn(user_id)
	if alcohol[user_id] then
		if os.time() < alcohol[user_id] then
			return parseInt(alcohol[user_id] - os.time())
		else
			alcohol[user_id] = nil
		end
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEMICALTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.alcoholTimer(user_id,timeSet)
	if alcohol[user_id] then
		alcohol[user_id] = alcohol[user_id] + (timeSet * 60)
	else
		alcohol[user_id] = os.time() + (timeSet * 60)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local permList = {}
local selfReturn = {}
local permissions = groups 
permList["Taxi"] = {}
permList["Dip"] = {}
permList["Police"] = {}
permList["Runners"] = {}
permList["Mechanic"] = {}
permList["Paramedic"] = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
exports('permissions', function()
	return permissions
end)

local ClientState = {
	['Police'] = true,
	['Mechanic'] = true,
	['Paramedic'] = true
}

function vRP.Groups()
    return groups
end

function vRP.DataGroups(Permission)
    return vRP.getSrvdata("Permissions:"..Permission)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(Passport, Permission, Level)
	if groups[Permission] then
        for k, v in pairs(groups[Permission].Parent) do
            local Datatable = vRP.getSrvdata("Permissions:"..k)
            if Datatable[tostring(Passport)] then
                if not Level or not (Datatable[tostring(Passport)] > Level) then
                    return true
                end
            end
        end
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPermission(user_id, perm, Level)
	local perm = tostring(perm)
    local Datatable = vRP.getSrvdata("Permissions:"..perm)
	if groups[perm] then 
		if Level then
			Level = parseInt(Level)
			if #groups[perm]["Hierarchy"] < Level then 
				Level = #groups[perm]["Hierarchy"]
				Datatable[tostring(user_id)] = Level
			else
				Datatable[tostring(user_id)] = Level
			end
		end
		if not Level then
			Datatable[tostring(user_id)] = #groups[perm]["Hierarchy"]
		end
	
		Wait(500)
		vRP.query("entitydata/SetData",{ dkey = "Permissions:"..perm,dvalue = json.encode(Datatable) })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.cleanPermission(user_id)
	local dataTable = vRP.getDatatable(user_id)
	local source = vRP.userSource(user_id)

	if dataTable then
		if dataTable["perm"] then
			for permission, _ in pairs(dataTable.perm) do
				if permission and ClientState[permission] then
					Player(parseInt(source)).state:set(permission, false, true)
				end
			end

			dataTable["perm"] = {}
		end
	else
		local userTables = vRP.userData(user_id, "Datatable")

		if userTables["inventory"] then
			if userTables["perm"] then
				userTables["perm"] = {}
				vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Datatable", value = json.encode(userTables) })
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.remPermission(Passport, Permission)
	local Datatable = vRP.getSrvdata("Permissions:"..Permission)
    if groups[Permission] then
        if Datatable[tostring(Passport)] then
            Datatable[tostring(Passport)] = nil
            vRP.query("entitydata/SetData",{ dkey = "Permissions:"..Permission,dvalue = json.encode(Datatable) })
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
---------------------------------------------------------------------------------------------
function vRP.Hierarchy(Permission)
    if groups[Permission] and groups[Permission]["Hierarchy"] then
        return groups[Permission]["Hierarchy"]
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePermission(user_id, perm, new)
	local new = tostring(new)
	local perm = tostring(perm)
	local dataTable = vRP.getDatatable(user_id)

	if dataTable then
		if dataTable["perm"] == nil then
			dataTable["perm"] = {}
		end

		if dataTable["perm"][perm] then
			dataTable["perm"][perm] = nil
		end

		if perm and ClientState[perm] and perm ~= "" then
			Player(parseInt(source)).state:set(perm, false, true)
		end

		if new and ClientState[new] and new ~= "" then
			Player(parseInt(source)).state:set(new, true, true)
		end

		dataTable["perm"][new] = true
	else
		if vRP.userTables[parseInt(user_id)]["inventory"] then
			if vRP.userTables[parseInt(user_id)]["perm"] == nil then
				vRP.userTables[parseInt(user_id)]["perm"] = {}
			end

			if vRP.userTables[parseInt(user_id)]["perm"][perm] then
				vRP.userTables[parseInt(user_id)]["perm"][perm] = nil
			end

			vRP.userTables[parseInt(user_id)]["perm"][new] = true

			vRP.execute("playerdata/setUserdata",
				{ user_id = user_id, key = "Datatable", value = json.encode(vRP.userTables[parseInt(user_id)]) })
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasGroup(Passport, Permission, Level)
	if groups[Permission] then
        for k, v in pairs(groups[Permission].Parent) do
            local Datatable = vRP.getSrvdata("Permissions:"..k)
            if Datatable[tostring(Passport)] then
                if not Level or not (Datatable[tostring(Passport)] > Level) then
                    return true
                end
            end
        end
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.numPermission(perm)
	local users     = vRP.getPlayersOn()
	local tableList = {}

	for k, v in pairs(users) do
		if vRP.hasPermission(k,perm) then  
			tableList[#tableList + 1] = v
		end 
	end

	return tableList
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(source, user_id, perm)
	if permList[perm] then
		permList[perm][user_id] = source
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(user_id, perm)
	if permList[perm][user_id] then
		permList[perm][user_id] = nil
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect", function(user_id, source)
	if permList["Police"][user_id] then
		permList["Police"][user_id] = nil
	end

	if permList["Dip"][user_id] then
		permList["Dip"][user_id] = nil
	end

	if permList["Paramedic"][user_id] then
		permList["Paramedic"][user_id] = nil
	end

	if permList["Taxi"][user_id] then
		permList["Taxi"][user_id] = nil
	end

	if permList["Mechanic"][user_id] then
		permList["Mechanic"][user_id] = nil
	end

	if permList["Runners"][user_id] then
		permList["Runners"][user_id] = nil
	end

	if selfReturn[user_id] then
		selfReturn[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect", function(user_id, source)
	if vRP.hasPermission(user_id, "Corrections") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "POLICE: Corrections", 24)
		TriggerClientEvent("service:Label", source, "Corrections", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Ranger") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "POLICE: Ranger", 69)
		TriggerClientEvent("service:Label", source, "Ranger", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "State") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("", source, "POLICE: State", 11)
		TriggerClientEvent("service:Label", source, "State", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Lspd") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "POLICE: Lspd", 18)
		TriggerClientEvent("service:Label", source, "Police", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Policia") then
		permList["Police"][user_id] = source
		TriggerClientEvent("vRP:PoliceService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "Policia", 3)
		TriggerClientEvent("service:Label", source, "Policia", "Sair de Serviço", 5000)
		TriggerClientEvent("service:Label", source, "Policia-2", "Sair de Serviço", 5000)
	end

	if vRP.hasPermission(user_id, "Paramedic") then
		permList["Paramedic"][user_id] = source
		TriggerClientEvent("vRP:ParamedicService", source, true)
		TriggerEvent("blipsystem:serviceEnter", source, "Paramedic", 6)
		TriggerClientEvent("service:Label", source, "Paramedic-1", "Sair de Serviço", 5000)
		TriggerClientEvent("service:Label", source, "Paramedic-2", "Sair de Serviço", 5000)
		TriggerClientEvent("service:Label", source, "Paramedic-3", "Sair de Serviço", 5000)
	end

	if vRP.hasGroup(user_id, "Mechanic") then
		permList["Mechanic"][user_id] = source
		TriggerClientEvent("service:Label", source, "Mechanic", "Sair de Serviço", 5000)
	end

	if vRP.hasGroup(user_id, "Runners") then
		permList["Runners"][user_id] = source
	end

	if vRP.hasGroup(user_id, "Roxos") then
		TriggerClientEvent("player:Relationship", source, "Roxos")
	end

	if vRP.hasGroup(user_id, "Verdes") then
		TriggerClientEvent("player:Relationship", source, "Verdes")
	end

	if vRP.hasGroup(user_id, "Azul") then
		TriggerClientEvent("player:Relationship", source, "Azul")
	end

	if vRP.hasGroup(user_id, "Amarelos") then
		TriggerClientEvent("player:Relationship", source, "Amarelos")
	end

	if vRP.hasGroup(user_id, "TheLost") then
		TriggerClientEvent("player:Relationship", source, "TheLost")
	end

	local dataTable = vRP.getDatatable(user_id)

	if dataTable and dataTable.perm then
		for permission, _ in pairs(dataTable.perm) do
			if permission and ClientState[permission] then
				Player(parseInt(source)).state:set(permission, true, true)
			end
		end
	end
end)

function vRP.getUsersByPermission(perm)
	local tableList = {}

	for user_id, source in pairs(vRP.userList()) do
		if vRP.hasPermission(user_id, perm) then
			table.insert(tableList, user_id)
		end
	end

	return tableList
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local requests = {}
local prompts = {}
local request_ids = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.request(source,text)
	return REQUEST.Function(source,text)
end

function tvRP.promptResult(text)
	if text == nil then
		text = ""
	end

	local prompt = prompts[source]
	if prompt ~= nil then
		prompts[source] = nil
		prompt(text)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROMPT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.prompt(source,title,default_text,value)
    local r = async()
    prompts[source] = r
    vRPC.prompt(source,title,default_text,value)
    return r:wait()
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FALSEIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.falseIdentity(user_id)
	local identity = vRP.query("fidentity/getResults",{ id = user_id })
	return identity[1] or false
end

function vRP.getPhoneData(playerId)
    local user_id = playerId

    local infos = vRP.query("vRP/getPlayerNumber", {
        user_id = user_id
    })

    if type(infos) == 'table' and infos[1] then
        local phoneNumber = infos[1].phone_number
        return {
            lbPhoneNumber = phoneNumber,
            lbFormattedNumber = exports['lb-phone']:FormatNumber(phoneNumber)
        }
    end
end
 
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERIDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userIdentity(user_id)
	local identity = vRP.query("characters/getUsers",{ id = user_id })
    if user_id and vRP.userSources[user_id] then
        if not vRP.userInfos[user_id] then
            vRP.userInfos[user_id] = {}
		end

		if identity and identity[1] then
			vRP.userInfos[user_id]["id"] = identity[1]["id"]
			vRP.userInfos[user_id]["sex"] = identity[1]["sex"]
			vRP.userInfos[user_id]["port"] = identity[1]["port"]
			vRP.userInfos[user_id]["blood"] = identity[1]["blood"]
			vRP.userInfos[user_id]["prison"] = identity[1]["prison"]
			vRP.userInfos[user_id]["garage"] = identity[1]["garage"]
			vRP.userInfos[user_id]["age"] = identity[1]["age"]
			vRP.userInfos[user_id]["fines"] = identity[1]["fines"]
			vRP.userInfos[user_id]["locate"] = identity[1]["locate"]
			vRP.userInfos[user_id]["phone"] = identity[1]["phone"]
			vRP.userInfos[user_id]["steam"] = identity[1]["steam"]
			vRP.userInfos[user_id]["profile_url"] = identity[1]["profile_url"]
			vRP.userInfos[user_id]["pincode"] = identity[1]["pincode"]
			vRP.userInfos[user_id]["bank"] = identity[1]["bank"]
			vRP.userInfos[user_id]["serial"] = identity[1]["serial"]
			vRP.userInfos[user_id]["name"] = identity[1]["name"]
			vRP.userInfos[user_id]["name2"] = identity[1]["name2"]
			vRP.userInfos[user_id]["state"] = identity[1]["state"]
		end

        return vRP.userInfos[user_id]
    else
        local identity = vRP.query("characters/getUsers",{ id = user_id })
        return identity[1] or false
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.initPrison(user_id,amount)
	vRP.execute("characters/setPrison",{ user_id = user_id, prison = parseInt(amount) })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["prison"] = parseInt(amount)
	end
end

function updateIdentity(user_id,informations)
	if informations then
		vRP.userInfos[user_id]['name'] = informations.name
		vRP.userInfos[user_id]['name2'] = informations.name2
	end
end

function vRP.updateProfile(user_id, image_url)
	if image_url then
		vRP.userInfos[user_id]['profile_url'] = image_url
		vRP.query("black/update_profile_url", { profile_url = image_url, id = user_id })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEPRISON
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updatePrison(user_id)
	vRP.execute("characters/removePrison",{ user_id = user_id, prison = 5 })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["prison"] = vRP.userInfos[user_id]["prison"] - 5

		if vRP.userInfos[user_id]["prison"] < 0 then
			vRP.userInfos[user_id]["prison"] = 0
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradePort(user_id,statusPort)
	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["port"] = parseInt(statusPort)
	end

	vRP.execute("characters/updatePort",{ port = statusPort, id = user_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGARAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeGarage(user_id)
	vRP.execute("characters/updateGarages",{ id = user_id })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["garage"] = vRP.userInfos[user_id]["garage"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATELOCATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateLocate(user_id)
	if vRP.userInfos[user_id] then
		if vRP.userInfos[user_id]["locate"] == "Sul" then
			vRP.execute("characters/updateLocate",{ id = user_id, locate = "Norte" })
			vRP.userInfos[user_id]["locate"] = "Norte"
		else
			vRP.execute("characters/updateLocate",{ id = user_id, locate = "Sul" })
			vRP.userInfos[user_id]["locate"] = "Sul"
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADECHARS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeChars(user_id)
	vRP.execute("accounts/infosUpdatechars",{ steam = vRP.userInfos[user_id]["steam"] })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["chars"] = vRP.userInfos[user_id]["chars"] + 1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userGemstone(user_id)
	local query = vRP.query("characters/getUsers",{ id = user_id })
	return query and query[1].gems or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEGEMSTONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeGemstone(user_id,amount)
	local source      = vRP.userSource(user_id)
	local currentGems = vRP.userGemstone(user_id)
	local newAmount   = parseInt(currentGems + amount)

	vRP.execute("characters/updateGems",{ id = user_id, gems = newAmount })

	if source then 
		TriggerClientEvent("hud:Gems",source,newAmount)
	end 
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADENAMES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeNames(user_id,name,name2)
	vRP.execute("characters/updateName",{ name = name, name2 = name2, user_id = user_id })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["name2"] = name2
		vRP.userInfos[user_id]["name"] = name
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradePhone(user_id,phone)
	vRP.execute("characters/updatePhone",{ phone = phone, id = user_id })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["phone"] = phone
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userPlate(vehPlate)
	local rows = vRP.query("vehicles/plateVehicles",{ plate = vehPlate })
	return rows[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERBLOOD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userBlood(bloodTypes)
	local rows = vRP.query("characters/getBlood",{ blood = bloodTypes })
	if rows[1] then
		return rows[1]["id"]
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userPhone(phoneNumber)
	local rows = vRP.query("characters/getPhone",{ phone = phoneNumber })
	return rows[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESTRINGNUMBER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""

	for i = 1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then
    		number = number..string.char(zbyte + math.random(0,9))
		elseif char == "L" then
			number = number..string.char(abyte + math.random(0,25))
		else
			number = number..char
		end
	end

	return number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePlate()
	local user_id = nil
	local vehPlate = ""

	repeat
		vehPlate = vRP.generateStringNumber("DDLLLDDD")
		user_id = vRP.userPlate(vehPlate)
	until not user_id

	return vehPlate
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generatePhone()
	local user_id = nil
	local phone = ""

	repeat
		phone = vRP.generateStringNumber("DDD-DDD")
		user_id = vRP.userPhone(phone)
	until not user_id

	return phone
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERSERIAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userSerial(number)
	local rows = vRP.query("characters/getSerial",{ serial = number })
	return rows[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEBLOODTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateBloodTypes(format)
	local zbyte = string.byte("0")
	local number = ""

	for i = 1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then
    		number = number..string.char(zbyte + math.random(1,4))
		else
			number = number..char
		end
	end

	return number
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEBLOOD
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateBlood()
	local user_id = nil
	local blood = ""

	repeat
		blood = vRP.generateBloodTypes("D")
		user_id = vRP.userBlood(blood)
	until not user_id

	return blood
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATESERIAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateSerial()
	local user_id = nil
	local serial = ""

	repeat
		serial = vRP.generateStringNumber("LLLDDD")
		user_id = vRP.userSerial(serial)
	until not user_id

	return serial
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local selfReturn = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.getWeight(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["weight"] == nil then
			dataTable["weight"] = 30
		end

		return dataTable["weight"]
	end

	return 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.setWeight(user_id,amount)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["weight"] == nil then
			dataTable["weight"] = 30
		end

		dataTable["weight"] = dataTable["weight"] + parseInt(amount)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWAPSLOT	
-----------------------------------------------------------------------------------------------------------------------------------------	
function vRP.swapSlot(user_id,slot,target)
	local inventory = vRP.userInventory(user_id)
	if inventory then
		local temporary = inventory[tostring(slot)]
		inventory[tostring(slot)] = inventory[tostring(target)]
		inventory[tostring(target)] = temporary
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORYWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.inventoryWeight(user_id)
	local totalWeight = 0
	local inventory = vRP.userInventory(user_id)

	for k,v in pairs(inventory) do
		if itemBody(v["item"]) then
			totalWeight = totalWeight + itemWeight(v["item"]) * parseInt(v["amount"])
		end
	end

	return totalWeight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBROKEN
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkBroken(nameItem)
	local splitName = splitString(nameItem,"-")
	if splitName[2] ~= nil then
		if itemDurability(nameItem) then
			local maxDurability = 86400 * itemDurability(nameItem)
			local actualDurability = parseInt(os.time() - splitName[2])
			local newDurability = (maxDurability - actualDurability) / maxDurability
			local actualPercent = parseInt(newDurability * 100)

			if actualPercent <= 1 then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.chestWeight(chestData)
	local totalWeight = 0

	for k,v in pairs(chestData) do
		if itemBody(v["item"]) then
			totalWeight = totalWeight + itemWeight(v["item"]) * parseInt(v["amount"])
		end
	end

	return totalWeight
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETINVENTORYITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getInventoryItemAmount(user_id,nameItem)
	local inventory = vRP.userInventory(user_id)

	for k,v in pairs(inventory) do
		local splitName01 = splitString(nameItem,"-")
		local splitName02 = splitString(v["item"],"-")
		if splitName01[1] == splitName02[1] then
			return { parseInt(v["amount"]),v["item"] }
		end
	end

	return { 0,"" }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMAMOUNT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.itemAmount(user_id,nameItem)
	local totalAmount = 0
	local splitName = splitString(nameItem,"-")
	local inventory = vRP.userInventory(user_id)

	for k,v in pairs(inventory) do
		local splitItem = splitString(v["item"],"-")
		if splitItem[1] == splitName[1] then
			totalAmount = totalAmount + v["amount"]
		end
	end

	return parseInt(totalAmount)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.giveInventoryItem(user_id,nameItem,amount,notify,slot)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local source = vRP.userSource(user_id)
		local inventory = vRP.userInventory(user_id)

		if not slot then
			local initial = 0

			repeat
				initial = initial + 1
			until inventory[tostring(initial)] == nil or (inventory[tostring(initial)] and inventory[tostring(initial)]["item"] == nameItem) or initial > vRP.getWeight(user_id)

			if initial <= vRP.getWeight(user_id) then
				initial = tostring(initial)

				if inventory[initial] == nil then
					inventory[initial] = { item = nameItem, amount = amount }
				elseif inventory[initial] and inventory[initial]["item"] == nameItem then
					inventory[initial]["amount"] = parseInt(inventory[initial]["amount"]) + amount
				end

				if notify and itemBody(nameItem) then
					TriggerClientEvent("itensNotify",source,{ "recebeu",itemIndex(nameItem),parseFormat(amount),itemName(nameItem) })
				end
			end
		else
			local selectSlot = tostring(slot)

			if inventory[selectSlot] then
				if inventory[selectSlot]["item"] == nameItem then
					inventory[selectSlot]["amount"] = parseInt(inventory[selectSlot]["amount"]) + amount
				end
			else
				inventory[selectSlot] = { item = nameItem, amount = amount }
			end

			if notify and itemBody(nameItem) then
				TriggerClientEvent("itensNotify",source,{ "recebeu",itemIndex(nameItem),parseFormat(amount),itemName(nameItem) })
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.generateItem(user_id,nameItem,amount,notify,slot)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local source = vRP.userSource(user_id)

		if itemDurability(nameItem) then
			if itemType(nameItem) == "Armamento" then
				local identity = vRP.userIdentity(user_id)
				nameItem = tostring(nameItem.."-"..os.time().."-"..identity["serial"])
			else
				nameItem = tostring(nameItem.."-"..os.time())
			end
		elseif itemCharges(nameItem) then
			nameItem = tostring(nameItem.."-"..itemCharges(nameItem))
		end

		local inventory = vRP.userInventory(user_id)

		if not slot then
			local initial = 0
			repeat
				initial = initial + 1
			until inventory[tostring(initial)] == nil or (inventory[tostring(initial)] and inventory[tostring(initial)]["item"] == nameItem) or initial > vRP.getWeight(user_id)

			if initial <= vRP.getWeight(user_id) then
				initial = tostring(initial)

				if inventory[initial] == nil then
					inventory[initial] = { item = nameItem, amount = amount }
				elseif inventory[initial] and inventory[initial]["item"] == nameItem then
					inventory[initial]["amount"] = parseInt(inventory[initial]["amount"]) + amount
				end

				if notify and itemBody(nameItem) then
					TriggerClientEvent("itensNotify",source,{ "recebeu",itemIndex(nameItem),parseFormat(amount),itemName(nameItem) })
				end
			end
		else
			local selectSlot = tostring(slot)

			if inventory[selectSlot] then
				if inventory[selectSlot]["item"] == nameItem then
					inventory[selectSlot]["amount"] = parseInt(inventory[selectSlot]["amount"]) + amount
				end
			else
				inventory[selectSlot] = { item = nameItem, amount = amount }
			end

			if notify and itemBody(nameItem) then
				TriggerClientEvent("itensNotify",source,{ "recebeu",itemIndex(nameItem),parseFormat(amount),itemName(nameItem) })
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKMAXITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.checkMaxItens(user_id,nameItem,amount)
	if itemBody(nameItem) then
		local amount = parseInt(amount)
		if itemMaxAmount(nameItem) ~= nil then
			if itemScape(nameItem) then
				return false
			else
				if (vRP.itemAmount(user_id,nameItem) + amount) > itemMaxAmount(nameItem) then
					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKBACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
local checkBackpack = {
	["defibrillator"] = 100
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYITENS
-----------------------------------------------------------------------------------------------------------------------------------------
function verifyItens(user_id,nameItem)
	local source = vRP.userSource(user_id)
	local splitName = splitString(nameItem,"-")
	local midName = splitName[1]

	if itemType(nameItem) == "Armamento" then
		TriggerClientEvent("inventory:verifyWeapon",source,midName)
	elseif checkBackpack[midName] then
		local consultItem = vRP.getInventoryItemAmount(user_id,nameItem)
		if consultItem[1] <= 0 then
			TriggerClientEvent("fortal-character:Client:Skinshop:RemoveBackpack",source,checkBackpack[midName])
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYGETINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryGetInventoryItem(user_id,nameItem,amount,notify,slot)
	selfReturn[user_id] = false
	local amount = parseInt(amount)
	local source = vRP.userSource(user_id)
	local inventory = vRP.userInventory(user_id)

	if not slot then
		for k,v in pairs(inventory) do
			local splitName = splitString(v["item"], "-")
			if (v["item"] == nameItem or splitName[1] == nameItem) and v["amount"] >= amount then
				v["amount"] = parseInt(v["amount"]) - amount

				if parseInt(v["amount"]) <= 0 then
					inventory[k] = nil
				end

				if notify and itemBody(nameItem) then
					TriggerClientEvent("itensNotify",source,{ "foi removido",itemIndex(nameItem),parseFormat(amount),itemName(nameItem) })
				end

				selfReturn[user_id] = true

				break
			end
		end
	else
		local selectSlot = tostring(slot)
		if inventory[selectSlot] and inventory[selectSlot]["item"] == nameItem and parseInt(inventory[selectSlot]["amount"]) >= amount then
			inventory[selectSlot]["amount"] = parseInt(inventory[selectSlot]["amount"]) - amount

			if parseInt(inventory[selectSlot]["amount"]) <= 0 then
				inventory[selectSlot] = nil
			end

			if notify and itemBody(nameItem) then
				TriggerClientEvent("itensNotify",source,{ "removeu",itemIndex(nameItem),parseFormat(amount),itemName(nameItem) })
			end

			selfReturn[user_id] = true
		end
	end

	local splitName = splitString(nameItem,"-")
	if itemType(splitName[1]) == "Animal" then
		TriggerClientEvent("dynamic:animalFunctions",source,"deletar")
	end

	verifyItens(user_id,nameItem)

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEINVENTORYITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removeInventoryItem(user_id,nameItem,amount,notify)
	local amount = parseInt(amount)
	local source = vRP.userSource(user_id)
	local inventory = vRP.userInventory(user_id)

	for k,v in pairs(inventory) do
		if v["item"] == nameItem and parseInt(v["amount"]) >= amount then
			v["amount"] = parseInt(v["amount"]) - amount

			if parseInt(v["amount"]) <= 0 then
				inventory[k] = nil
			end

			if notify and itemBody(nameItem) then
				TriggerClientEvent("itensNotify",source,{ "removeu",itemIndex(nameItem),parseFormat(amount),itemName(nameItem) })
			end

			break
		end
	end

	verifyItens(user_id,nameItem)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMIN:KICKALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("admin:KickAll")
AddEventHandler("admin:KickAll",function()
	for k,v in pairs(srvData) do
		if json.encode(v["data"]) == "[]" or json.encode(v["data"]) == "{}" then
			vRP.execute("entitydata/removeData",{ dkey = k })
		else
			vRP.execute("entitydata/setData",{ dkey = k, value = json.encode(v["data"]) })
		end
	end

	print("Save no banco de dados terminou, ja pode reiniciar o servidor.")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.invUpdate(user_id,slot,target,amount)
	selfReturn[user_id] = true

	if actived[user_id] == nil and parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local selectSlot = tostring(slot)
		local targetSlot = tostring(target)
		local inventory = vRP.userInventory(user_id)

		if inventory[selectSlot] then
			actived[user_id] = true
			local nameItem = inventory[selectSlot]["item"]

			if inventory[targetSlot] then
				if inventory[selectSlot] and inventory[targetSlot] then
					if nameItem == inventory[targetSlot]["item"] then
						if parseInt(inventory[selectSlot]["amount"]) >= amount then
							inventory[selectSlot]["amount"] = parseInt(inventory[selectSlot]["amount"]) - amount
							inventory[targetSlot]["amount"] = parseInt(inventory[targetSlot]["amount"]) + amount

							if parseInt(inventory[selectSlot]["amount"]) <= 0 then
								inventory[selectSlot] = nil
							end

							selfReturn[user_id] = false
						end
					else
						local temporary = inventory[selectSlot]
						inventory[selectSlot] = inventory[targetSlot]
						inventory[targetSlot] = temporary

						selfReturn[user_id] = false
					end
				end
			else
				if inventory[selectSlot] then
					if parseInt(inventory[selectSlot]["amount"]) >= amount then
						inventory[targetSlot] = { item = nameItem, amount = amount }
						inventory[selectSlot]["amount"] = parseInt(inventory[selectSlot]["amount"]) - amount

						if parseInt(inventory[selectSlot]["amount"]) <= 0 then
							inventory[selectSlot] = nil
						end

						selfReturn[user_id] = false
					end
				end
			end

			actived[user_id] = nil
		end
	end

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.tryChest(user_id,chestData,amount,slot,target)
	selfReturn[user_id] = true

	if actived[user_id] == nil and parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local selectSlot = tostring(slot)
		local targetSlot = tostring(target)
		local source = vRP.userSource(user_id)
		local consult = vRP.getSrvdata(chestData)

		if consult[selectSlot] then
			local nameItem = consult[selectSlot]["item"]
			local inventory = vRP.userInventory(user_id)
			actived[user_id] = true

			if vRP.checkMaxItens(user_id,nameItem,amount) then
				TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
				actived[user_id] = nil

				return selfReturn[user_id]
			end

			if (vRP.inventoryWeight(user_id) + (itemWeight(nameItem) * amount)) <= vRP.getWeight(user_id) then
				if inventory[targetSlot] and consult[selectSlot] then
					if inventory[targetSlot]["item"] == nameItem then
						if parseInt(consult[selectSlot]["amount"]) >= amount then
							inventory[targetSlot]["amount"] = parseInt(inventory[targetSlot]["amount"]) + amount
							consult[selectSlot]["amount"] = parseInt(consult[selectSlot]["amount"]) - amount

							if parseInt(consult[selectSlot]["amount"]) <= 0 then
								consult[selectSlot] = nil
							end

							selfReturn[user_id] = false
						end
					end
				else
					if consult[selectSlot] then
						if parseInt(consult[selectSlot]["amount"]) >= amount then
							inventory[targetSlot] = { item = nameItem, amount = amount }
							consult[selectSlot]["amount"] = parseInt(consult[selectSlot]["amount"]) - amount

							if parseInt(consult[selectSlot]["amount"]) <= 0 then
								consult[selectSlot] = nil
							end

							selfReturn[user_id] = false
						end
					end
				end
			end

			actived[user_id] = nil
		end
	end

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STORECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.storeChest(user_id,chestData,amount,dataWeight,slot,target)
	selfReturn[user_id] = true

	if actived[user_id] == nil and parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local selectSlot = tostring(slot)
		local targetSlot = tostring(target)
		local inventory = vRP.userInventory(user_id)

		if inventory[selectSlot] then
			actived[user_id] = true
			local consult = vRP.getSrvdata(chestData)
			local nameItem = inventory[selectSlot]["item"]

			if (vRP.chestWeight(consult) + (itemWeight(nameItem) * amount)) <= dataWeight then
				if consult[targetSlot] and inventory[selectSlot] then
					if nameItem == consult[targetSlot]["item"] then
						if parseInt(inventory[selectSlot]["amount"]) >= amount then
							consult[targetSlot]["amount"] = parseInt(consult[targetSlot]["amount"]) + amount
							inventory[selectSlot]["amount"] = parseInt(inventory[selectSlot]["amount"]) - amount

							if parseInt(inventory[selectSlot]["amount"]) <= 0 then
								inventory[selectSlot] = nil
							end

							selfReturn[user_id] = false
						end
					end
				else
					if inventory[selectSlot] then
						if parseInt(inventory[selectSlot]["amount"]) >= amount then
							consult[targetSlot] = { item = nameItem, amount = amount }
							inventory[selectSlot]["amount"] = parseInt(inventory[selectSlot]["amount"]) - amount

							if parseInt(inventory[selectSlot]["amount"]) <= 0 then
								inventory[selectSlot] = nil
							end

							selfReturn[user_id] = false
						end
					end
				end
			end

			verifyItens(user_id,nameItem)

			actived[user_id] = nil
		end
	end

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.updateChest(user_id,chestData,slot,target,amount)
	selfReturn[user_id] = true

	if actived[user_id] == nil and parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local selectSlot = tostring(slot)
		local targetSlot = tostring(target)
		local consult = vRP.getSrvdata(chestData)

		if consult[selectSlot] then
			actived[user_id] = true

			if consult[targetSlot] and consult[selectSlot] then
				if consult[selectSlot]["item"] == consult[targetSlot]["item"] then
					if parseInt(consult[selectSlot]["amount"]) >= amount then
						consult[selectSlot]["amount"] = parseInt(consult[selectSlot]["amount"]) - amount

						if parseInt(consult[selectSlot]["amount"]) <= 0 then
							consult[selectSlot] = nil
						end

						consult[targetSlot]["amount"] = parseInt(consult[targetSlot]["amount"]) + amount
						selfReturn[user_id] = false
					end
				else
					local temporary = consult[selectSlot]
					consult[selectSlot] = consult[targetSlot]
					consult[targetSlot] = temporary

					selfReturn[user_id] = false
				end
			else
				if consult[selectSlot] then
					if parseInt(consult[selectSlot]["amount"]) >= amount then
						consult[selectSlot]["amount"] = parseInt(consult[selectSlot]["amount"]) - amount
						consult[targetSlot] = { item = consult[selectSlot]["item"], amount = amount }

						if parseInt(consult[selectSlot]["amount"]) <= 0 then
							consult[selectSlot] = nil
						end

						selfReturn[user_id] = false
					end
				end
			end

			actived[user_id] = nil
		end
	end

	return selfReturn[user_id]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.storePolice(amount)
	local amount = parseInt(amount)
	local consult = vRP.getSrvdata("stackChest:State")
	if consult["100"] then
		if consult["100"]["item"] == "dollars" then
			consult["100"]["amount"] = parseInt(consult["100"]["amount"]) + amount
		else
			consult["100"] = { item = "dollars", amount = amount }
		end
	else
		consult["100"] = { item = "dollars", amount = amount }
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERBANK
function vRP.userBank(user_id)
	local user_id = parseInt(user_id)
	local bankInfos = vRP.query("bank/getInfos",{ user_id = user_id })
	return bankInfos[1] or false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addBank(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("bank/addValue",{ user_id = user_id, bank = amount, mode = mode })

		if vRP.userInfos[user_id] then
			vRP.userInfos[user_id]["bank"] = vRP.userInfos[user_id]["bank"] + amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delBank(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("bank/remValue",{ user_id = user_id, bank = amount, mode = mode })

		if vRP.userInfos[user_id] then
			vRP.userInfos[user_id]["bank"] = vRP.userInfos[user_id]["bank"] - amount

			if vRP.userInfos[user_id]["bank"] < 0 then
				vRP.userInfos[user_id]["bank"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getBank(user_id)
	local user_id = parseInt(user_id)
	if vRP.userInfos[user_id] then
		return vRP.userInfos[user_id]["bank"]
	else
		local identity = vRP.userIdentity(user_id)
		if identity then
			return identity["bank"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getFines(user_id)
	local user_id = parseInt(user_id)
	if vRP.userInfos[user_id] then
		return vRP.userInfos[user_id]["fines"]
	else
		local identity = vRP.userIdentity(user_id)
		if identity then
			return identity["fines"]
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.addFines(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("characters/addFines",{ id = user_id, fines = amount })

		if vRP.userInfos[user_id] then
			vRP.userInfos[user_id]["fines"] = vRP.userInfos[user_id]["fines"] + amount
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.delFines(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		vRP.execute("characters/removeFines",{ id = user_id, fines = amount })

		if vRP.userInfos[user_id] then
			vRP.userInfos[user_id]["fines"] = vRP.userInfos[user_id]["fines"] - amount

			if vRP.userInfos[user_id]["fines"] < 0 then
				vRP.userInfos[user_id]["fines"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTGEMS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentGems(user_id,amount)
	if parseInt(amount) > 0 then
		local source = vRP.userSource(user_id)
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id] then
			local gems = vRP.userGemstone(user_id)
			if gems >= amount then
				local gemsValue = parseInt(gems - amount)
				vRP.execute("characters/updateGems",{ id = user_id, gems = gemsValue })
				TriggerClientEvent("hud:Gems",source,gemsValue)
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentBank(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id] then
			if vRP.userInfos[user_id]["bank"] >= amount then
				vRP.delBank(user_id,amount)

				local source = vRP.userSource(user_id)
				if source then
					TriggerClientEvent("itensNotify",source,{ "pagou","dollars",parseFormat(amount),"Dólares" })
				end

				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.paymentFull(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.tryGetInventoryItem(user_id,"dollars",amount,true) then
			return true
		else
			if vRP.userInfos[user_id] then
				if vRP.userInfos[user_id]["bank"] >= amount then
					vRP.delBank(user_id,amount)

					local source = vRP.userSource(user_id)
					if source then
						TriggerClientEvent("itensNotify",source,{ "pagou","dollars",parseFormat(amount),"Dólares" })
					end

					return true
				end
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAWCASH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.withdrawCash(user_id,amount)
	if parseInt(amount) > 0 then
		local amount = parseInt(amount)
		local user_id = parseInt(user_id)
		if vRP.userInfos[user_id]["bank"] >= amount then
			vRP.generateItem(user_id,"dollars",amount,true)
			vRP.delBank(user_id,amount)
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SMARTPHONE:GETBANKMONEY
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setBankMoney(user_id, amount)
    local dif = amount - vRP.getBank(user_id)
    vRP.execute("bank/addValue",{ user_id = user_id, bank = dif })
    if vRP.userInfos[user_id] then
        vRP.userInfos[user_id]["bank"] = amount
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect",function(user_id,source)
	local dataTable = vRP.userData(user_id,"Datatable") or vRP.getDatatable(user_id)
	local positionTable = vRP.execute("playerdata/getUserdata", { user_id = user_id, key = "Position" })[1]
	local position = {}

	if (positionTable) then
		position = json.decode(positionTable["dvalue"])
	end

	if dataTable then
		if position then
			if position["x"] == nil or position["y"] == nil or position["z"] == nil then
				position = { x = -25.85, y = -147.48, z = 56.95 }
			end
		else
			position = { x = -25.85, y = -147.48, z = 56.95 }
		end
		vRP.teleport(source,position["x"],position["y"],position["z"])

		if dataTable["skin"] == nil then
			dataTable["skin"] = GetHashKey("mp_m_freemode_01")
		end

		if dataTable["weight"] == nil then
			dataTable["weight"] = 30
		end

		if dataTable["inventory"] == nil then
			dataTable["inventory"] = {}
		end

		if dataTable["health"] == nil then
			dataTable["health"] = 200
		end

		if dataTable["armour"] == nil then
			dataTable["armour"] = 0
		end

		if dataTable["stress"] == nil then
			dataTable["stress"] = 0
		end

		if dataTable["hunger"] == nil then
			dataTable["hunger"] = 100
		end

		if dataTable["thirst"] == nil then
			dataTable["thirst"] = 100
		end

		if dataTable["oxigen"] == nil then
			dataTable["oxigen"] = 100
		end

		if dataTable["experience"] == nil then
			dataTable["experience"] = 0
		end

		if dataTable["permission"] then
			dataTable["permission"] = nil
		end

		vRPC.applySkin(source,dataTable["skin"])
		vRP.setArmour(source,dataTable["armour"])
		vRPC.setHealth(source,dataTable["health"])

		TriggerClientEvent("hud:Stress",source,dataTable["stress"])
		TriggerClientEvent("hud:Hunger",source,dataTable["hunger"])
		TriggerClientEvent("hud:Thirst",source,dataTable["thirst"])
		TriggerClientEvent("hud:Oxigen",source,dataTable["oxigen"])
		TriggerClientEvent("hud:Exp",source,dataTable["experience"])

		TriggerClientEvent("tattoos:apply",source,vRP.userData(user_id,"nation_char"))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPEDADMIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeletePedAdmin")
AddEventHandler("tryDeletePedAdmin",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex[1])
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeleteObject")
AddEventHandler("tryDeleteObject",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 3 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEPED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryDeletePed")
AddEventHandler("tryDeletePed",function(entIndex)
	local idNetwork = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 1 then
		DeleteEntity(idNetwork)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if not user_id then return end

	-- Verifica se está morto via Deathscreen
	local isDead = vRPC.deadPlayer(source)
	if not isDead then
		TriggerClientEvent("Notify", source, "amarelo", "Você não está morto.", 5000)
		return
	end

	-- Fecha a NUI da Deathscreen + revive
	TriggerClientEvent("Deathscreen:resetPlayer", source)
	vRPC.respawnPlayer(source)

	-- Limpa inventário
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and dataTable["inventory"] then
		dataTable["inventory"] = {}
		vRP.upgradeThirst(user_id, 100)
		vRP.upgradeHunger(user_id, 100)
		vRP.downgradeStress(user_id, 100)
	end

	-- Limpa armas
	TriggerEvent("inventory:clearWeapons", user_id)

	-- Remove animais
	TriggerClientEvent("dynamic:animalFunctions", source, "deletar")

	-- Log
	TriggerEvent("discordLogs", "Airport",
		"**Passaporte:** "..parseFormat(user_id).."\n**Horário:** "..os.date("%H:%M:%S"), 3092790)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDAGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeThirst(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["thirst"] == nil then
			dataTable["thirst"] = 0
		end

		dataTable["thirst"] = dataTable["thirst"] + amount

		if dataTable["thirst"] > 100 then
			dataTable["thirst"] = 100
		end

		TriggerClientEvent("hud:Thirst",userSource,dataTable["thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeHunger(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["hunger"] == nil then
			dataTable["hunger"] = 0
		end

		dataTable["hunger"] = dataTable["hunger"] + amount

		if dataTable["hunger"] > 100 then
			dataTable["hunger"] = 100
		end

		TriggerClientEvent("hud:Hunger",userSource,dataTable["hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradeStress(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["stress"] == nil then
			dataTable["stress"] = 0
		end

		dataTable["stress"] = dataTable["stress"] + amount

		if dataTable["stress"] > 100 then
			dataTable["stress"] = 100
		end

		TriggerClientEvent("hud:Stress",userSource,dataTable["stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADETHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeThirst(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["thirst"] == nil then
			dataTable["thirst"] = 100
		end

		dataTable["thirst"] = dataTable["thirst"] - amount

		if dataTable["thirst"] < 0 then
			dataTable["thirst"] = 0
		end

		TriggerClientEvent("hud:Thirst",userSource,dataTable["thirst"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADEHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeHunger(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["hunger"] == nil then
			dataTable["hunger"] = 100
		end

		dataTable["hunger"] = dataTable["hunger"] - amount

		if dataTable["hunger"] < 0 then
			dataTable["hunger"] = 0
		end

		TriggerClientEvent("hud:Hunger",userSource,dataTable["hunger"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOWNGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.downgradeStress(user_id,amount)
	local userSource = vRP.userSource(user_id)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable and userSource then
		if dataTable["stress"] == nil then
			dataTable["stress"] = 0
		end

		dataTable["stress"] = dataTable["stress"] - amount

		if dataTable["stress"] < 0 then
			dataTable["stress"] = 0
		end

		TriggerClientEvent("hud:Stress",userSource,dataTable["stress"])
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOODS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Foods()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			if dataTable["thirst"] == nil then
				dataTable["thirst"] = 100
			end

			if dataTable["hunger"] == nil then
				dataTable["hunger"] = 100
			end

			dataTable["hunger"] = dataTable["hunger"] - 1
			dataTable["thirst"] = dataTable["thirst"] - 1

			if dataTable["thirst"] < 0 then
				dataTable["thirst"] = 0
			end

			if dataTable["hunger"] < 0 then
				dataTable["hunger"] = 0
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.Oxigen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			if dataTable["oxigen"] == nil then
				dataTable["oxigen"] = 100
			end

			dataTable["oxigen"] = dataTable["oxigen"] - 1
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECHARGEOXIGEN
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.rechargeOxigen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			dataTable["oxigen"] = 100
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getHealth(source)
	local ped = GetPlayerPed(source)
	return GetEntityHealth(ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MODELPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.modelPlayer(source)
	local ped = GetPlayerPed(source)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		return "mp_m_freemode_01"
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		return "mp_f_freemode_01"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:receiveSalary")
AddEventHandler("vRP:receiveSalary",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local dataTable = vRP.getDatatable(user_id)
		if dataTable then
			if dataTable["salary"] ~= nil then
				TriggerClientEvent("Notify",source,"check", "Sucesso","Recebeu $"..parseFormat(dataTable["salary"]).." em sua conta bancária.", "verde",5000)
				vRP.addBank(user_id,dataTable["salary"])
				dataTable["salary"] = nil
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:UPDATESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:updateSalary")
AddEventHandler("vRP:updateSalary",function(user_id,amount)
	--[[ local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["salary"] ~= nil then
			dataTable["salary"] = dataTable["salary"] + parseInt(amount)
		else
			dataTable["salary"] = parseInt(amount)
		end
	end ]]
	vRP.addBank(user_id,amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:EXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vRP:Experience")
AddEventHandler("vRP:Experience",function(source,user_id,amount)
	local dataTable = vRP.getDatatable(user_id)
	if dataTable then
		if dataTable["experience"] ~= nil then
			dataTable["experience"] = dataTable["experience"] + parseInt(amount)
		else
			dataTable["experience"] = parseInt(amount)
		end

		TriggerClientEvent("hud:Exp",source,dataTable["experience"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETARMOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setArmour(source,amount)
	local ped = GetPlayerPed(source)
	local armour = GetPedArmour(ped)

	SetPedArmour(ped,parseInt(armour + amount))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.teleport(source,x,y,z)
    local ped = GetPlayerPed(source)
    SetEntityCoords(ped,x + 0.0001,y + 0.0001,z + 0.0001,0,0,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEOBJECT
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreateObject(model,x,y,z)
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPED
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.CreatePed(model,x,y,z,heading,typ)
	local spawnPeds = 0
	local mHash = GetHashKey(model)
	local Ped = CreatePed(typ,mHash,x,y,z,heading,true,false)

	while not DoesEntityExist(Ped) and spawnPeds <= 1000 do
		spawnPeds = spawnPeds + 1
		Wait(1)
	end

	if DoesEntityExist(Ped) then
		return true,NetworkGetNetworkIdFromEntity(Ped)
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.setPremium(user_id)
	vRP.execute("accounts/setPremium",{ steam = vRP.userInfos[user_id]["steam"], premium = os.time() + 2592000, priority = 50 })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["premium"] = parseInt(os.time() + 2592000)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADEPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.upgradePremium(user_id)
	vRP.execute("accounts/updatePremium",{ steam = vRP.userInfos[user_id]["steam"] })

	if vRP.userInfos[user_id] then
		vRP.userInfos[user_id]["premium"] = vRP.userInfos[user_id]["premium"] + 2592000
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- USERPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.userPremium(user_id)
	if vRP.userInfos[user_id] then
		if vRP.userInfos[user_id]["premium"] >= os.time() then
			return true
		end
	else
		local identity = vRP.query("characters/getUsers",{ id = user_id })
		if identity[1] then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEAMPREMIUM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.steamPremium(steam)
	local infoAccount = vRP.infoAccount(steam)
	if infoAccount and infoAccount["premium"] >= os.time() then
		return true
	end

	return false
end

function vRP.getExperience(user_id,work)
    local dataTable = vRP.userData(user_id)
    if dataTable and not dataTable[work] then
        dataTable[work] = 0
    end
    return dataTable[work] or 0
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTEXPERIENCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.putExperience(user_id,work,number)
    local dataTable = vRP.userData(user_id)
    if dataTable then
        if not dataTable[work] then
            dataTable[work] = 0
        end
        dataTable[work] = dataTable[work] + number
    end
end

function vRP.consultItem(Passport,Item,Amount)
    if vRP.userSource(Passport) then
        if Amount > vRP.getInventoryItemAmount(Passport,Item)[1] then
            return false
        end
    end
    return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("characters/allChars","SELECT * FROM characters")
vRP.prepare("characters/getUsers","SELECT * FROM characters WHERE id = @id")
vRP.prepare("characters/getPhone","SELECT id FROM characters WHERE phone = @phone")
vRP.prepare("characters/getSerial","SELECT id FROM characters WHERE serial = @serial")
vRP.prepare("characters/getBlood","SELECT id FROM characters WHERE blood = @blood")
vRP.prepare("characters/updatePort","UPDATE characters SET port = @port WHERE id = @id")
vRP.prepare("characters/updateGems","UPDATE characters SET gems = @gems WHERE id = @id")
vRP.prepare("characters/updatePhone","UPDATE phone_phones SET phone_number = @phone WHERE id = @id")
vRP.prepare("characters/removeCharacters","UPDATE characters SET deleted = 1 WHERE id = @id")
vRP.prepare("characters/updateLocate","UPDATE characters SET locate = @locate WHERE id = @id")
vRP.prepare("characters/addFines","UPDATE characters SET fines = fines + @fines WHERE id = @id")
vRP.prepare("characters/setPrison","UPDATE characters SET prison = @prison WHERE id = @user_id")
vRP.prepare("characters/updateGarages","UPDATE characters SET garage = garage + 1 WHERE id = @id")
vRP.prepare("characters/removeFines","UPDATE characters SET fines = fines - @fines WHERE id = @id")
vRP.prepare("characters/getCharacters","SELECT * FROM characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/removePrison","UPDATE characters SET prison = prison - @prison WHERE id = @user_id")
vRP.prepare("characters/updateName","UPDATE characters SET name = @name, name2 = @name2 WHERE id = @user_id")
vRP.prepare("characters/updateReset","UPDATE characters SET reset = @reset WHERE id = @user_id")
vRP.prepare("characters/lastCharacters","SELECT id FROM characters WHERE steam = @steam ORDER BY id DESC LIMIT 1")
vRP.prepare("characters/countPersons","SELECT COUNT(steam) as qtd FROM characters WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/newCharacter","INSERT INTO characters(steam,name,name2,locate,sex,phone,serial,blood) VALUES(@steam,@name,@name2,@locate,@sex,@phone,@serial,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("bank/getInfos","SELECT bank FROM characters WHERE id = @user_id")
vRP.prepare("bank/addValue","UPDATE characters SET bank = bank + @bank WHERE id = @user_id ")
vRP.prepare("bank/remValue","UPDATE characters SET bank = bank - @bank WHERE id = @user_id")
vRP.prepare("bank/setValue","UPDATE characters SET bank = @bank WHERE id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACCOUNTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("accounts/getInfos","SELECT * FROM accounts WHERE steam = @steam")
vRP.prepare("accounts/newAccount","INSERT INTO accounts(steam) VALUES(@steam)")
vRP.prepare("accounts/updateWhitelist","UPDATE accounts SET whitelist = 1 WHERE steam = @steam")
vRP.prepare("accounts/setPriority","UPDATE accounts SET priority = @priority WHERE steam = @steam")
vRP.prepare("accounts/infosUpdatechars","UPDATE accounts SET chars = chars + 1 WHERE steam = @steam")
vRP.prepare("accounts/infosUpdategems","UPDATE accounts SET gems = gems + @gems WHERE steam = @steam")
vRP.prepare("accounts/updatePremium","UPDATE accounts SET premium = premium + 2592000 WHERE steam = @steam")
vRP.prepare("accounts/setPremium","UPDATE accounts SET premium = @premium, priority = @priority WHERE steam = @steam")
vRP.prepare("accounts/setwl","UPDATE accounts SET whitelist = @whitelist WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("playerdata/getUserdata","SELECT dvalue FROM playerdata WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("playerdata/setUserdata","REPLACE INTO playerdata(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTITYDATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("entitydata/removeData","DELETE FROM entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/getData","SELECT dvalue FROM entitydata WHERE dkey = @dkey")
vRP.prepare("entitydata/setData","REPLACE INTO entitydata(dkey,dvalue) VALUES(@dkey,@value)")
vRP.prepare("vRP/getLbPhone", "SELECT phone_number FROM phone_phones WHERE owner_id = @user_id LIMIT 1")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vehicles/plateVehicles","SELECT * FROM vehicles WHERE plate = @plate")
vRP.prepare("vehicles/getVehicles","SELECT * FROM vehicles WHERE user_id = @user_id")
vRP.prepare("vehicles/removeVehicles","DELETE FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/selectVehicles","SELECT * FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/paymentArrest","UPDATE vehicles SET arrest = 0 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/moveVehicles","UPDATE vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/plateVehiclesUpdate","UPDATE vehicles SET plate = @plate WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesDays","UPDATE vehicles SET rental = rental + 5184000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehiclesUpdate","UPDATE vehicles SET rental = UNIX_TIMESTAMP() + 5184000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/rentalVehicles","INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,rental,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 5184000,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/countVehicles","SELECT COUNT(vehicle) as qtd FROM vehicles WHERE user_id = @user_id AND work = @work AND rental <= 0")
vRP.prepare("vehicles/arrestVehicles","UPDATE vehicles SET arrest = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/updateVehiclesTax","UPDATE vehicles SET tax = UNIX_TIMESTAMP() + 2592000 WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vehicles/addVehicles","INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,tax) VALUES(@user_id,@vehicle,@plate,@work,UNIX_TIMESTAMP() + 604800)")
vRP.prepare("vehicles/updateVehicles","UPDATE vehicles SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres, nitro = @nitro WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROPERTYS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("propertys/selling","DELETE FROM propertys WHERE name = @name")
vRP.prepare("propertys/permissions","SELECT * FROM propertys WHERE name = @name")
vRP.prepare("propertys/totalHomes","SELECT name,tax FROM propertys WHERE owner = 1")
vRP.prepare("propertys/userList","SELECT name FROM propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countUsers","SELECT COUNT(*) as qtd FROM propertys WHERE user_id = @user_id")
vRP.prepare("propertys/countPermissions","SELECT COUNT(*) as qtd FROM propertys WHERE name = @name")
vRP.prepare("propertys/userOwnermissions","SELECT * FROM propertys WHERE name = @name AND owner = 1")
vRP.prepare("propertys/removePermissions","DELETE FROM propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/userPermissions","SELECT * FROM propertys WHERE name = @name AND user_id = @user_id")
vRP.prepare("propertys/updateOwner","UPDATE propertys SET user_id = @nuser_id WHERE user_id = @user_id AND name = @name")
vRP.prepare("propertys/updateTax","UPDATE propertys SET tax = UNIX_TIMESTAMP() + 2592000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateVault","UPDATE propertys SET vault = vault + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/updateFridge","UPDATE propertys SET fridge = fridge + 10, price = price + 10000 WHERE name = @name AND owner = 1")
vRP.prepare("propertys/newPermissions","INSERT IGNORE INTO propertys(name,interior,user_id,owner) VALUES(@name,@interior,@user_id,@owner)")
vRP.prepare("propertys/buying","INSERT IGNORE INTO propertys(name,interior,price,user_id,tax,residents,vault,fridge,owner) VALUES(@name,@interior,@price,@user_id,UNIX_TIMESTAMP() + 604800,@residents,@vault,@fridge,1)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("prison/cleanRecords","DELETE FROM prison WHERE nuser_id = @nuser_id")
vRP.prepare("prison/getRecords","SELECT * FROM prison WHERE nuser_id = @nuser_id ORDER BY id DESC")
vRP.prepare("prison/insertPrison","INSERT INTO prison(police,nuser_id,services,fines,text,date) VALUES(@police,@nuser_id,@services,@fines,@text,@date)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("fines/getFines2","SELECT * FROM mid_fines WHERE user_id = @user_id ORDER BY id DESC")
vRP.prepare("fines/removeFines2","DELETE FROM mid_fines WHERE id = @id AND user_id = @user_id")
vRP.prepare("fines/insertFines2","INSERT INTO mid_fines (user_id,nuser_id,date,price,text) VALUES(@user_id,@nuser_id,@date,@price,@text)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANNEDS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("banneds/getBanned","SELECT * FROM banneds WHERE steam = @steam")
vRP.prepare("banneds/removeBanned","DELETE FROM banneds WHERE steam = @steam")
vRP.prepare("banneds/insertBanned","INSERT INTO banneds(steam) VALUES(@steam)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("chests/getChests","SELECT * FROM chests WHERE name = @name")
vRP.prepare("chests/upgradeChests","UPDATE chests SET weight = weight + 25 WHERE name = @name")
-----------------------------------------------------------------------------------------------------------------------------------------
-- RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("races/checkResult","SELECT * FROM races WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/requestRanking","SELECT * FROM races WHERE raceid = @raceid ORDER BY points ASC LIMIT 5")
vRP.prepare("races/updateRecords","UPDATE races SET points = @points, vehicle = @vehicle WHERE raceid = @raceid AND user_id = @user_id")
vRP.prepare("races/insertRecords","INSERT INTO races(raceid,user_id,name,vehicle,points) VALUES(@raceid,@user_id,@name,@vehicle,@points)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINDENTITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("fidentity/getResults","SELECT * FROM fidentity WHERE id = @id")
vRP.prepare("fidentity/lastIdentity","SELECT id FROM fidentity ORDER BY id DESC LIMIT 1")
vRP.prepare("fidentity/newIdentity","INSERT INTO fidentity(name,name2,locate,blood) VALUES(@name,@name2,@locate,@blood)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANSMARTPHONE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("smartphone/cleanCalls","DELETE FROM smartphone_calls WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 3)")
vRP.prepare("smartphone/cleanTorMessages","DELETE FROM smartphone_tor_messages WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 3)")
vRP.prepare("smartphone/cleanMessages","DELETE FROM smartphone_whatsapp_messages WHERE created_at < (UNIX_TIMESTAMP() - 86400 * 7)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARTABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("black/playerdata","DELETE FROM playerdata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.prepare("black/entitydata","DELETE FROM entitydata WHERE dvalue = '[]' OR dvalue = '{}'")
vRP.prepare("black/cleanPremium","UPDATE accounts SET premium = '0', priority = '0' WHERE UNIX_TIMESTAMP() >= premium")

vRP.prepare("entitydata/SetData","REPLACE INTO entitydata(dkey,dvalue) VALUES(@dkey,@dvalue)")
vRP.prepare("entitydata/GetData","SELECT * FROM entitydata WHERE dkey = @dkey")

vRP.prepare("vRP/getPlayerNumber", "SELECT phone_number FROM phone_phones WHERE owner_id = @owner_id")
vRP.prepare("vRP/getPlayerByNumber", "SELECT owner_id FROM phone_phones WHERE phone_number = @phone_number")

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCLEANERS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	vRP.execute("black/playerdata")
	vRP.execute("black/entitydata")
	vRP.execute("black/cleanPremium")
	vRP.execute("smartphone/cleanCalls")
	vRP.execute("smartphone/cleanMessages")
	vRP.execute("smartphone/cleanTorMessages")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- LANG
-----------------------------------------------------------------------------------------------------------------------------------------
local Lang = Global.Lang
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Queue = {}
Queue.QueueList = {}
Queue.PlayerList = {}
Queue.PlayerCount = 0
Queue.Connecting = {}
Queue.ThreadCount = 0
local maxPlayers = 1024
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEAMRUNNING
-----------------------------------------------------------------------------------------------------------------------------------------
function steamRunning(source)
	local result = false
	local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			result = true
			break
		end
	end

	return result
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function getQueue(ids,trouble,source,connect)
	for k,v in ipairs(connect and Queue.Connecting or Queue.QueueList) do
		local inQueue = false

		if not source then
			for _,i in ipairs(v["ids"]) do
				if inQueue then
					break
				end

				for _,o in ipairs(ids) do
					if o == i then
						inQueue = true
						break
					end
				end
			end
		else
			inQueue = ids == v["source"]
		end

		if inQueue then
			if trouble then
				return k,connect and Queue.Connecting[k] or Queue.QueueList[k]
			end

			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISPRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
function isPriority(identifiers)
	local resultPriority = 0

	for _,v in pairs(identifiers) do
		if string.find(v,"steam") then
			local splitName = splitString(v,":")
			local infoAccount = vRP.infoAccount(splitName[2])
			if infoAccount then
				resultPriority = infoAccount["priority"]
				break
			end
		end
	end

	return resultPriority
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function addQueue(ids,connectTime,name,source,deferrals)
	if getQueue(ids) then
		return
	end

	local tmp = { source = source, ids = ids, name = name, firstconnect = connectTime, priority = isPriority(ids), timeout = 0, deferrals = deferrals }

	local _pos = false
	local queueCount = #Queue.QueueList + 1

	for k,v in ipairs(Queue.QueueList) do
		if tmp["priority"] then
			if not v["priority"] then
				_pos = k
			else
				if tmp["priority"] > v["priority"] then
					_pos = k
				end
			end

			if _pos then
				break
			end
		end
	end

	if not _pos then
		_pos = #Queue.QueueList + 1
	end

	table.insert(Queue.QueueList,_pos,tmp)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
function removeQueue(ids,source)
	if getQueue(ids,false,source) then
		local pos,data = getQueue(ids,true,source)
		table.remove(Queue.QueueList,pos)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function isConnect(ids,source,refresh)
	local k,v = getQueue(ids,refresh and true or false,source and true or false,true)

	if not k then
		return false
	end

	if refresh and k and v then
		Queue.Connecting[k]["timeout"] = 0
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVECONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function removeConnect(ids,source)
	for k,v in ipairs(Queue.Connecting) do
		local connect = false

		if not source then
			for _,i in ipairs(v["ids"]) do
				if connect then
					break
				end

				for _,o in ipairs(ids) do
					if o == i then
						connect = true
						break
					end
				end
			end
		else
			connect = ids == v["source"]
		end

		if connect then
			table.remove(Queue.Connecting,k)
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
function addConnect(ids,ignorePos,autoRemove,done)
	local function removeFromQueue()
		if not autoRemove then
			return
		end

		done(Lang.connecterror)
		removeConnect(ids)
		removeQueue(ids)
	end

	if #Queue.Connecting >= 100 then
		removeFromQueue()
		return false
	end

	if isConnect(ids) then
		removeConnect(ids)
	end

	local pos,data = getQueue(ids,true)
	if not ignorePos and (not pos or pos > 1) then
		removeFromQueue()
		return false
	end

	table.insert(Queue.Connecting,data)
	removeQueue(ids)
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEAMIDS
-----------------------------------------------------------------------------------------------------------------------------------------
function steamIds(source)
	return GetPlayerIdentifiers(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDATA
-----------------------------------------------------------------------------------------------------------------------------------------
function updateData(source,ids,deferrals)
	local pos,data = getQueue(ids,true)
	Queue.QueueList[pos]["ids"] = ids
	Queue.QueueList[pos]["timeout"] = 0
	Queue.QueueList[pos]["source"] = source
	Queue.QueueList[pos]["deferrals"] = deferrals
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTFULL
-----------------------------------------------------------------------------------------------------------------------------------------
function notFull(firstJoin)
	local canJoin = Queue.PlayerCount + #Queue.Connecting < maxPlayers and #Queue.Connecting < 100
	if firstJoin and canJoin then
		canJoin = #Queue.QueueList <= 1
	end

	return canJoin
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function setPosition(ids,newPos)
	local pos,data = getQueue(ids,true)
	table.remove(Queue.QueueList,pos)
	table.insert(Queue.QueueList,newPos,data)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local function playerConnect(name,setKickReason,deferrals)
		local source = source
		local ids = steamIds(source)
		local connectTime = os.time()
		local connecting = true

		deferrals.defer()

		CreateThread(function()
			while connecting do
				Wait(500)
				if not connecting then
					return
				end
				deferrals.update(Lang.connecting)
			end
		end)

		Wait(1000)

		local function done(message)
			connecting = false
			CreateThread(function()
				if message then
					deferrals.update(tostring(message) and tostring(message) or "")
				end

				Wait(1000)

				if message then
					deferrals.done(tostring(message) and tostring(message) or "")
					CancelEvent()
				end
			end)
		end

		local function update(message)
			connecting = false
			deferrals.update(tostring(message) and tostring(message) or "")
		end

		if not steamRunning(source) then
			done(Lang.steam)
			CancelEvent()
			return
		end

		local reason = "Removido da fila."

		local function setReason(message)
			reason = tostring(message)
		end

		TriggerEvent("Queue:playerJoinQueue",source,setReason)

		if WasEventCanceled() then
			done(reason)

			removeQueue(ids)
			removeConnect(ids)

			CancelEvent()
			return
		end

		local rejoined = false

		if getQueue(ids) then
			rejoined = true
			updateData(source,ids,deferrals)
		else
			addQueue(ids,connectTime,name,source,deferrals)
		end

		if isConnect(ids,false,true) then
			removeConnect(ids)

			if notFull() then
				local added = addConnect(ids,true,true,done)
				if not added then
					CancelEvent()
					return
				end

				done()
				TriggerEvent("Queue:playerConnecting",source,ids,deferrals)

				return
			else
				addQueue(ids,connectTime,name,source,deferrals)
				setPosition(ids,1)
			end
		end

		local pos,data = getQueue(ids,true)

		if not pos or not data then
			done(Lang.error)
			RemoveFromQueue(ids)
			RemoveFromConnecting(ids)
			CancelEvent()
			return
		end

		if notFull(true) then
			local added = addConnect(ids,true,true,done)
			if not added then
				CancelEvent()
				return
			end

			done()

			TriggerEvent("Queue:playerConnecting",source,ids,deferrals)

			return
		end

		update(string.format(Lang.position,pos,#Queue.QueueList))

		CreateThread(function()
			if rejoined then
				return
			end

			Queue.ThreadCount = Queue.ThreadCount + 1
			local dotCount = 0

			while true do
				Wait(1000)
				local dots = ""

				dotCount = dotCount + 1
				if dotCount > 3 then
					dotCount = 0
				end

				for i = 1,dotCount do
					dots = dots.."."
				end

				local pos,data = getQueue(ids,true)

				if not pos or not data then
					if data and data.deferrals then
						data.deferrals.done(Lang.error)
					end

					CancelEvent()
					removeQueue(ids)
					removeConnect(ids)
					Queue.ThreadCount = Queue.ThreadCount - 1
					return
				end

				if pos <= 1 and notFull() then
					local added = addConnect(ids)
					data.deferrals.update(Lang.join)
					Wait(500)

					if not added then
						data.deferrals.done(Lang.connecterror)
						CancelEvent()
						Queue.ThreadCount = Queue.ThreadCount - 1
						return
					end

					data.deferrals.update("Carregando conexão com o servidor.")

					removeQueue(ids)
					Queue.ThreadCount = Queue.ThreadCount - 1

					TriggerEvent("Queue:playerConnecting",source,data.ids,data.deferrals)
					
					return
				end

				local message = string.format(Global.serverName.."\n\n"..Lang.position.."%s\n"..Global.queueText,pos,#Queue.QueueList,dots)
				data.deferrals.update(message)
			end
		end)
	end

	AddEventHandler("playerConnecting",playerConnect)

	local function checkTimeOuts()
		local i = 1

		while i <= #Queue.QueueList do
			local data = Queue.QueueList[i]
			local lastMsg = GetPlayerLastMsg(data.source)

			if lastMsg == 0 or lastMsg >= 30000 then
				data.timeout = data.timeout + 1
			else
				data.timeout = 0
			end

			if not data.ids or not data.name or not data.firstconnect or data.priority == nil or not data.source then
				data.deferrals.done(Lang.error)
				table.remove(Queue.QueueList,i)
			elseif (data.timeout >= 120) and os.time() - data.firstconnect > 5 then
				data.deferrals.done(Lang.error)
				removeQueue(data.source,true)
				removeConnect(data.source,true)
			else
				i = i + 1
			end
		end

		i = 1

		while i <= #Queue.Connecting do
			local data = Queue.Connecting[i]
			local lastMsg = GetPlayerLastMsg(data.source)
			data.timeout = data.timeout + 1

			if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and os.time() - data.firstconnect > 5 then
				removeQueue(data.source,true)
				removeConnect(data.source,true)
			else
				i = i + 1
			end
		end

		SetTimeout(1000,checkTimeOuts)
	end

	checkTimeOuts()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Queue:playerConnect")
AddEventHandler("Queue:playerConnect",function()
	local source = source

	if not Queue.PlayerList[source] then
		local ids = steamIds(source)

		Queue.PlayerCount = Queue.PlayerCount + 1
		Queue.PlayerList[source] = true
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDROPPED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDropped",function()
	if Queue.PlayerList[source] then
		local ids = steamIds(source)

		Queue.PlayerCount = Queue.PlayerCount - 1
		Queue.PlayerList[source] = nil
		removeQueue(ids)
		removeConnect(ids)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEQUEUE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Queue:removeQueue",function(ids)
	removeQueue(ids)
	removeConnect(ids)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYCLEARVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryClearVehicle")
AddEventHandler("tryClearVehicle",function(entIndex)
	local Vehicle = NetworkGetEntityFromNetworkId(entIndex)
	if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
		SetVehicleDirtLevel(Vehicle,0.0)
	end
end)

exports("GetLicenseKey", function()
	return Global.licenseKey
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- vRP:playerDied
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("Deathscreen:playerDied")
AddEventHandler("Deathscreen:playerDied", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    TriggerEvent("discordLogs", "Morte",
        "**Passaporte:** "..parseFormat(user_id).."\n**Horário:** "..os.date("%H:%M:%S"),
        3092790)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- tvRP.hasPhoneItem
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.hasPhoneItem(itemName)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then
        return false
    end

    -- Verifica no inventário do vRP
    local amount = vRP.getInventoryItemAmount(user_id, itemName)
    return amount and amount[1] > 0
end