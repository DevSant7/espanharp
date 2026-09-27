-- VRP
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-- CONNECTION
Creative = {}
Tunnel.bindInterface("painel",Creative)
vCLIENT = Tunnel.getInterface("painel")

vRP.prepare("rstore/userData", "SELECT * FROM panel WHERE passport = @passport")
vRP.prepare("rstore/getUsers", "SELECT * FROM panel WHERE `group` = @group")
vRP.prepare("rstore/remUser", "DELETE FROM panel WHERE passport = @passport and `group` = @group")
vRP.prepare("rstore/addUser", "INSERT INTO panel (passport,`group`,hierarchy) VALUES(@passport,@group,@hierarchy)")
vRP.prepare("rstore/remUserAll", "DELETE FROM panel WHERE passport = @passport")
vRP.prepare("rstore/updateHierarchy","UPDATE panel SET hierarchy = @hierarchy WHERE `group` = @group AND passport = @passport")

-- VARIABLES
local Panel = {}

-- PAINEL
RegisterCommand("pn", function(source, Message)
    local user_id = vRP.getUserId(source)
    if not user_id then return end

    local group = Message[1]
    if group and Jobs[group] then
        if vRP.hasPermission(user_id, group) then
            Panel[user_id] = group

            local Members = GetMembers(group)
            local Data = {
                groupName = group,
                members = Members
            }

            vCLIENT.Open(source, Data)
        else
            Panel[user_id] = nil
            TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para acessar este grupo.", 5000)
        end
    else
        TriggerClientEvent("Notify", source, "amarelo", "Grupo inválido ou não permitido.", 5000)
    end
end)

RegisterCommand(LiderCommand, function(source,args)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,LiderPermission) then
		local Player = tonumber(args[1])
		local Job = args[2]

		if Jobs[Job] then
			local PlayerIdentity = vRP.userIdentity(Player)
			if PlayerIdentity then
				local Role = Jobs[Job]["Hierarchy"][1]
				vRP.execute("rstore/addUser", { passport = Player, group = Job, hierarchy = Role})
				TriggerClientEvent("Notify",source,"amarelo",PlayerIdentity.name.." "..PlayerIdentity.name2.." foi setado como "..Role,9000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Esse membro não existe",9000)
			end
		else
			TriggerClientEvent("Notify",source,"amarelo","Essa organização não está configurada no painel",9000)
		end
	end
end)

function CheckPermission(Passport, TargetPassport)
    local Info = GetInfos(Passport)
    if not Info or not Info.Found then
        print("[CheckPermission] Nenhuma informação encontrada para o usuário:", Passport)
        return false
    end

    local TargetInfo = GetInfos(TargetPassport)
    if not TargetInfo or not TargetInfo.Found then
        return false
    end

    -- Verifica se estão no mesmo grupo
    if Info.Group ~= TargetInfo.Group then
        return false
    end

    local Config = Jobs[Info.Group]
    if not Config or not Config.Hierarchy then
        return false
    end

    local myIndex = GetHierarchyIndex(Info.Group, Info.Hierarchy)
    local targetIndex = GetHierarchyIndex(TargetInfo.Group, TargetInfo.Hierarchy)

    -- Só permite se meu index for menor (ou seja, cargo mais alto)
    return myIndex and targetIndex and myIndex < targetIndex
end

function GetMembers(group)
	local Query = vRP.query("rstore/getUsers",{ group = group })
	local Members = {}

	if Query and #Query > 0 then
		for _,v in ipairs(Query) do
			local Identity = vRP.userIdentity(v.passport)
			if Identity then
				table.insert(Members, {
					name = Identity.name.." "..Identity.name2,
					phone = Identity.phone,
					role = v.hierarchy,
					online = vRP.userSource(v.passport) ~= nil,
					id = v.passport
				})
			end
		end
	end
	return Members
end

function GetInfos(user_id)
	local Query = vRP.query("rstore/userData",{ passport = user_id })
	if Query and Query[1] then
		local Info = Query[1]
		return {
			Found = true,
			Hierarchy = Info.hierarchy,
			Group = Info.group,
			Active = vRP.userSource(Info.passport) ~= nil
		}
	end
	return { Found = false }
end

function GetHierarchyIndex(Job,Role)
	for k,v in ipairs(Jobs[Job].Hierarchy) do
		if v == Role then
			return k
		end
	end
	return nil
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMISS
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Dismiss(Number)
	local source = source
	local Number = tonumber(Number)
	local Passport = vRP.getUserId(source)
	if Passport and Panel[Passport] and Passport ~= Number then
		if CheckPermission(Passport, Number) then

			-- Remove da tabela do banco
			vRP.execute("rstore/remUser", { passport = Number, group = Panel[Passport] })

			-- Remove permissões do usuário
			if Jobs[Panel[Passport]]["haveWait"] then
				vRP.remPermission(Number,"wait"..Panel[Passport])
				vRP.remPermission(Number,Panel[Passport])
			else
				vRP.remPermission(Number,Panel[Passport])
			end

			local nSource = vRP.userSource(Number)

			if nSource then
				TriggerClientEvent("Notify",nSource,"amarelo","Você foi exonerado da sua organização",9000)
			end

			TriggerClientEvent("Notify",source,"verde","Passaporte removido.",5000)
			TriggerClientEvent("painel:Update",source,Panel[Passport])
		end
	end
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- INVITE
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Invite(Number)
    local source = source
    local Number = parseInt(Number)
    local Passport = vRP.getUserId(source)
    if Passport and Panel[Passport] and Passport ~= Number and vRP.userIdentity(Number) then
        local Info = GetInfos(Passport)
        if Info.Found and GetHierarchyIndex(Info.Group, Info.Hierarchy) == 1 then -- só líder pode convidar
            local NSource = vRP.userSource(Number)
            if NSource then
                TriggerClientEvent("Notify",source,"amarelo","O convite foi enviado...",5000)
                if vRP.request(NSource,"Você foi convidado para entrar no(a) "..Panel[Passport]) then
                    local HierarchyLength = #Jobs[Panel[Passport]]["Hierarchy"]
                    vRP.execute("rstore/addUser", { passport = Number, group = Panel[Passport], hierarchy = Jobs[Panel[Passport]].Hierarchy[HierarchyLength] })
                    vRP.setPermission(Number, Panel[Passport], tostring(HierarchyLength))
                    TriggerClientEvent("painel:Update",source,Panel[Passport])
                    TriggerClientEvent("Notify",source,"amarelo","Convite aceito",5000)
                    TriggerClientEvent("Notify",NSource,"amarelo","Parabéns, agora você faz parte da nossa organização!",5000)
                else
                    TriggerClientEvent("Notify",source,"amarelo","Convite para entrar na organização negado",5000)
                end
            else
                TriggerClientEvent("Notify",source,"amarelo","O membro precisa estar na cidade",5000)
            end
        else
            TriggerClientEvent("Notify",source,"vermelho","Você não tem permissão para convidar.",5000)
        end
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- HIERARCHY
-----------------------------------------------------------------------------------------------------------------------------------------
function Creative.Hierarchy(OtherPassport,Mode)
    local source = source
    local Passport = vRP.getUserId(source)
    if Passport and Panel[Passport] and Passport ~= OtherPassport and vRP.userIdentity(OtherPassport) then
        if CheckPermission(Passport,OtherPassport) then
            local Infos = GetInfos(OtherPassport)
            if Infos.Found then
                local Index = GetHierarchyIndex(Panel[Passport], Infos.Hierarchy)
                if Mode == "Demote" and Index < #Jobs[Panel[Passport]].Hierarchy then
                    local nextIndex = Index + 1
                    vRP.execute("rstore/updateHierarchy", { passport = OtherPassport, group = Panel[Passport], hierarchy = Jobs[Panel[Passport]].Hierarchy[nextIndex] })
                    vRP.setPermission(OtherPassport, Panel[Passport], tostring(nextIndex))
                    TriggerClientEvent("Notify",source,"verde","Membro rebaixado.",5000)
                elseif Mode == "Promote" and Index > 1 then
                    local prevIndex = Index - 1
                    vRP.execute("rstore/updateHierarchy", { passport = OtherPassport, group = Panel[Passport], hierarchy = Jobs[Panel[Passport]].Hierarchy[prevIndex] })
                    vRP.setPermission(OtherPassport, Panel[Passport], tostring(prevIndex))
                    TriggerClientEvent("Notify",source,"verde","Membro promovido.",5000)
                else
                    TriggerClientEvent("Notify",source,"amarelo","Cargo já está no limite.",5000)
                end
                TriggerClientEvent("painel:Update",source,Panel[Passport])
            else
                TriggerClientEvent("Notify",source,"amarelo","Esse cidadão está bugado",5000)
            end
        end
    end
end


