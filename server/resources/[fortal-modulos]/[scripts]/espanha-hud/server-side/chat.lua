-- =====================================================
-- HUD SERVER — Chat
-- =====================================================
-- Autoridade sobre QUEM pode falar em cada contexto (hudConfig.chats, vindo de
-- shared-side/_shared.lua) e sobre o alcance do chat "local". O client
-- (client-side/chat.lua) só pede envio; quem decide se o contexto é permitido,
-- filtra palavra proibida e resolve os destinatários é este arquivo.
-- =====================================================

local ChatCooldown = {}
local CHAT_COOLDOWN_MS = 800
local CHAT_MAX_LENGTH = 250
local LOCAL_CHAT_RADIUS = 20.0

-----------------------------------------------------------------------------------------------------------------------------------------
-- CANUSECONTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
local function CanUseContext(Passport,Context)
	local Chat = hudConfig.chats[Context]
	if not Chat then
		return false
	end

	if not Chat.permissions or #Chat.permissions == 0 then
		return true
	end

	for _,Permission in ipairs(Chat.permissions) do
		if vRP.HasGroup(Passport,Permission) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISOFFENSIVE
-----------------------------------------------------------------------------------------------------------------------------------------
-- O client já bloqueia (client-side/chat.lua -> isOffensive), mas isso é só UX: quem edita a
-- memória do jogo ou chama o evento direto passa por cima. A palavra proibida só é palavra
-- proibida de verdade se o servidor também recusar.
local function IsOffensive(Text)
	local Lower = string.lower(Text)
	for _,Word in pairs(hudConfig.offensiveWord) do
		if string.find(Lower,Word,1,true) then
			return true
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCHATS
-----------------------------------------------------------------------------------------------------------------------------------------
-- client-side/chat.lua -> vSERVER.getChats(). Só devolve os contextos que o jogador
-- pode de fato usar — sem isso todo mundo veria (e tentaria postar em) "adm"/"policia".
function HUD.getChats()
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return {}
	end

	local Allowed = {}
	for Context,Chat in pairs(hudConfig.chats) do
		if CanUseContext(Passport,Context) then
			Allowed[Context] = { color = Chat.color }
		end
	end

	return Allowed
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDGLOBALMESSAGE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("sendGlobalMessage")
AddEventHandler("sendGlobalMessage",function(Message,Context)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return
	end

	local CurrentTimer = GetGameTimer()
	if ChatCooldown[source] and ChatCooldown[source] > CurrentTimer then
		return
	end
	ChatCooldown[source] = CurrentTimer + CHAT_COOLDOWN_MS

	if type(Context) ~= "string" or not hudConfig.chats[Context] then
		Context = "global"
	end

	if not CanUseContext(Passport,Context) then
		return
	end

	if type(Message) ~= "string" then
		return
	end

	Message = Message:gsub("^%s+",""):gsub("%s+$","")
	if Message == "" or #Message > CHAT_MAX_LENGTH then
		return
	end

	if IsOffensive(Message) then
		TriggerClientEvent("Notify",source,"negado","Uma palavra proibida foi encontrada no seu texto.",5000)
		return
	end

	local Name = vRP.FullName(Passport)
	local Chat = hudConfig.chats[Context]
	local Css = { author = Name, authorID = Passport }

	if Context == "local" then
		local Coords = vRP.GetEntityCoords(source)

		for _,TargetSource in pairs(vRP.Players()) do
			local TargetCoords = vRP.GetEntityCoords(TargetSource)
			if #(Coords - TargetCoords) <= LOCAL_CHAT_RADIUS then
				TriggerClientEvent("chat:ClientMessage",TargetSource,Context,Message,Name,false,Chat.color,Css)
			end
		end
	elseif Chat.permissions and #Chat.permissions > 0 then
		for _,TargetSource in pairs(vRP.Players()) do
			local TargetPassport = vRP.Passport(TargetSource)
			if TargetPassport and CanUseContext(TargetPassport,Context) then
				TriggerClientEvent("chat:ClientMessage",TargetSource,Context,Message,Name,false,Chat.color,Css)
			end
		end
	else
		TriggerClientEvent("chat:ClientMessage",-1,Context,Message,Name,false,Chat.color,Css)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	ChatCooldown[source] = nil
end)
