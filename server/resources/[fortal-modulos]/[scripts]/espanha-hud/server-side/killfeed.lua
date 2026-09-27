-- =====================================================
-- HUD SERVER — Killfeed
-- =====================================================
-- client-side/killfeed.lua só reporta a PRÓPRIA morte ("Report only our OWN death").
-- Este arquivo valida esse relato (o `killerSource` é mesmo um jogador conectado?
-- não é a própria vítima? não passou dos limites?) antes de publicar a kill pra
-- cidade inteira — o client nunca decide sozinho quem matou quem.
--
-- Contextos privados (Killfeeds[x].private, ver shared-side/killfeed.lua) NÃO passam
-- por aqui: o próprio dono do contexto (arena, ffa, evento...) chama o export
-- `broadcastKillToSources` só para os jogadores/espectadores daquela partida.
-- =====================================================

local KillfeedCooldown = {}
local KILLFEED_COOLDOWN_MS = 1200
local KILLFEED_MAX_DISTANCE = 300

-----------------------------------------------------------------------------------------------------------------------------------------
-- REPORTKILL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("killfeed:reportKill")
AddEventHandler("killfeed:reportKill",function(KillerSource,WeaponHash,IsHeadshot,Distance)
	local source = source
	local VictimPassport = vRP.Passport(source)
	if not VictimPassport then
		return
	end

	local CurrentTimer = GetGameTimer()
	if KillfeedCooldown[source] and KillfeedCooldown[source] > CurrentTimer then
		return
	end
	KillfeedCooldown[source] = CurrentTimer + KILLFEED_COOLDOWN_MS

	KillerSource = tonumber(KillerSource)
	if not KillerSource or KillerSource == source or not GetPlayerName(KillerSource) then
		return
	end

	local KillerPassport = vRP.Passport(KillerSource)
	if not KillerPassport then
		return
	end

	local Payload = {
		context = KILLFEED_DEFAULT_CONTEXT,
		killer = { id = KillerPassport, name = vRP.FullName(KillerPassport) },
		killed = { id = VictimPassport, name = vRP.FullName(VictimPassport) },
		weapon = Weapons[tonumber(WeaponHash)] or false,
		headshot = IsHeadshot == true,
		distance = math.max(0,math.min(parseInt(Distance),KILLFEED_MAX_DISTANCE))
	}

	TriggerClientEvent("killfeed:client:push",-1,Payload)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BROADCASTKILLTOSOURCES
-----------------------------------------------------------------------------------------------------------------------------------------
-- Usado por resources DONOS de um contexto privado (arena, ffa, evento, dominação) pra
-- publicar uma kill só para quem está naquela partida, sem passar pelo fan-out global.
exports("broadcastKillToSources",function(SourceList,Data)
	if type(SourceList) ~= "table" or type(Data) ~= "table" then
		return false
	end

	if type(Data.killer) ~= "table" or type(Data.killed) ~= "table" then
		return false
	end

	if not Data.context or not Killfeeds[Data.context] or Killfeeds[Data.context].enabled == false then
		return false
	end

	for _,TargetSource in ipairs(SourceList) do
		if GetPlayerName(TargetSource) then
			TriggerClientEvent("killfeed:client:push",TargetSource,Data)
		end
	end

	return true
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect",function(Passport,source)
	KillfeedCooldown[source] = nil
end)
