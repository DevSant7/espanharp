-- =====================================================
-- HUD SERVER — Relógio e clima do mundo
-- =====================================================
-- Nada nesta base escrevia em GlobalState.Hours/Minutes/Weather. O resource "creative"
-- (client-side/core.lua) já os APLICA visualmente pra todo mundo, todo frame
-- (NetworkOverrideClockTime + SetWeatherTypeNow*), mas nunca existiu quem os PRODUZISSE —
-- por isso o relógio ficava travado em 00:00 e o clima do menu da HUD (client-side/menu.lua
-- -> ExecuteCommand("clima <tipo>")) não fazia nada: o comando "clima" nunca existiu em
-- lugar nenhum da base.
--
-- Velocidade do relógio é intencionalmente simples e ajustável abaixo.
-- =====================================================

local MINUTES_PER_TICK = 1
local REAL_SECONDS_PER_TICK = 1 -- 1 minuto do jogo a cada 1s real -> dia completo em 24min reais
local DEFAULT_WEATHER = "CLEAR"

-----------------------------------------------------------------------------------------------------------------------------------------
-- RELÓGIO
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	if GlobalState.Hours == nil then
		GlobalState.Hours = 12
	end
	if GlobalState.Minutes == nil then
		GlobalState.Minutes = 0
	end
	if GlobalState.Weather == nil then
		GlobalState.Weather = DEFAULT_WEATHER
	end

	while true do
		Wait(REAL_SECONDS_PER_TICK * 1000)

		local Minutes = GlobalState.Minutes + MINUTES_PER_TICK
		local Hours = GlobalState.Hours

		if Minutes >= 60 then
			Minutes = Minutes - 60
			Hours = (Hours + 1) % 24
		end

		GlobalState.Hours = Hours
		GlobalState.Minutes = Minutes
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLIMA  (menu.lua -> ExecuteCommand("clima <tipo>"))
-----------------------------------------------------------------------------------------------------------------------------------------
-- GlobalState.Weather é replicado e aplicado IGUAL pra todo mundo pelo "creative" -- então
-- só quem tem permissão de staff pode mudar. Sem esta trava, qualquer jogador trocaria o
-- clima do servidor inteiro só de abrir o menu da HUD (aba "Clima") e clicar numa opção.
local VALID_WEATHERS = {
	EXTRASUNNY = true, CLEAR = true, CLOUDS = true, FOGGY = true,
	CLEARING = true, THUNDER = true, OVERCAST = true, RAIN = true,
	SMOG = true, SNOW = true, BLIZZARD = true
}

RegisterCommand("clima",function(source,args)
	if source == 0 then
		return
	end

	local Passport = vRP.Passport(source)
	if not Passport or not vRP.HasGroup(Passport,hudConfig.announceStaffPermission) then
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão para mudar o clima.",5000)
		return
	end

	local Weather = args[1] and string.upper(args[1])
	if not Weather or not VALID_WEATHERS[Weather] then
		return
	end

	GlobalState.Weather = Weather
end,false)
