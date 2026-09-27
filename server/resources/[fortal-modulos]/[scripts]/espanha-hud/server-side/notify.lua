-- =====================================================
-- HUD SERVER — Notify (pedidos, votação, resposta a alerta policial)
-- =====================================================

-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDMESSAGE  (policeAlerts.lua -> "sendMessage" -> vSERVER.SendMessage(author.id))
-----------------------------------------------------------------------------------------------------------------------------------------
-- Avisa o autor do alerta (`AuthorPassport`) que alguém está respondendo à ocorrência.
-- Reaproveita o mesmo evento que o client já sabe tratar (receiveNotifyPushResponse ->
-- exports.smartphone:createSMS) e a API oficial de telefone do vRP (vRP.Phone) — mesmo que
-- hoje ela devolva "Inativo" (é um stub do próprio vRP core, fora do escopo deste resource).
function HUD.SendMessage(AuthorPassport)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return false
	end

	AuthorPassport = parseInt(AuthorPassport)
	if AuthorPassport <= 0 then
		return false
	end

	local TargetSource = vRP.Source(AuthorPassport)
	if not TargetSource then
		return false
	end

	local CallerPhone = vRP.Phone(Passport)
	local CallerName = vRP.FullName(Passport)

	TriggerClientEvent("receiveNotifyPushResponse",TargetSource,CallerPhone,("%s está a caminho da sua ocorrência."):format(CallerName))

	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DS:RECIVEREQUEST  (notify.lua -> "DS:keyBindAccept" / "DS:keyBindRefuse")
-----------------------------------------------------------------------------------------------------------------------------------------
-- "DS:genRequest" não é disparado por nenhum resource deste workspace — o vRP core já tem
-- o próprio sistema de confirmação (vRP.Request, ver vrp/modules/vrp.lua). Isto existe só
-- como compatibilidade: relaia a resposta como evento local para quem eventualmente disparar
-- um "DS:genRequest" próprio poder reagir, sem este resource inventar a lógica de negócio.
RegisterServerEvent("DS:reciveRequest")
AddEventHandler("DS:reciveRequest",function(RequestId,Accepted)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport then
		return
	end

	TriggerEvent("DS:requestResponse",source,parseInt(RequestId),Accepted == true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VOTAÇÃO  (notify.lua -> "NotifyVote" / "hud:vote:submit" / "vote:results")
-----------------------------------------------------------------------------------------------------------------------------------------
-- O client só permite UMA votação ativa por vez (`local activeVote` em notify.lua), então
-- o servidor espelha essa mesma regra: uma votação por vez para o resource inteiro.
local ActiveVote = nil -- { options, votes = {[Passport]=OptionIndex}, recipients }

local function TallyVote()
	if not ActiveVote then
		return
	end

	local Vote = ActiveVote
	ActiveVote = nil

	local Results = {}
	for Index = 1,#Vote.options do
		Results[Index] = 0
	end

	for _,OptionIndex in pairs(Vote.votes) do
		Results[OptionIndex + 1] = (Results[OptionIndex + 1] or 0) + 1
	end

	local Recipients = Vote.recipients or vRP.Players()
	for _,TargetSource in pairs(Recipients) do
		TriggerClientEvent("vote:results",TargetSource,Results)
	end
end

RegisterServerEvent("hud:vote:submit")
AddEventHandler("hud:vote:submit",function(OptionIndex)
	local source = source
	local Passport = vRP.Passport(source)
	if not Passport or not ActiveVote or ActiveVote.votes[Passport] then
		return
	end

	OptionIndex = tonumber(OptionIndex)
	if not OptionIndex or OptionIndex < 0 or OptionIndex >= #ActiveVote.options then
		return
	end

	ActiveVote.votes[Passport] = OptionIndex
end)

-- Export para outros resources (painel de eventos, admin) iniciarem uma votação usando a
-- mesma UI/UX que a HUD já sabe desenhar, sem duplicar o desenho nem o placar.
exports("StartVote",function(Title,Message,DurationSeconds,Author,Options,RecipientSources)
	if ActiveVote or type(Options) ~= "table" or #Options < 2 then
		return false
	end

	DurationSeconds = math.max(5,tonumber(DurationSeconds) or 30)
	ActiveVote = { options = Options, votes = {}, recipients = RecipientSources }

	local Payload = {
		title = Title,
		message = Message,
		finish_at = DurationSeconds,
		author = Author,
		options = Options
	}

	local Recipients = RecipientSources or vRP.Players()
	for _,TargetSource in pairs(Recipients) do
		TriggerClientEvent("NotifyVote",TargetSource,Payload)
	end

	SetTimeout(DurationSeconds * 1000,TallyVote)

	return true
end)
