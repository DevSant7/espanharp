-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timeDeath = 300
local ropeCarry = false
local deathStatus = false
local emergencyButton = false
LocalPlayer["state"]["Active"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMEGENCYTEXTS
-----------------------------------------------------------------------------------------------------------------------------------------
local emergencyTexts = {
	{ "Encontrei uma pessoa acidentada e necessita de paramédicos urgentemente." },
	{ "Necessito de ajuda, uma pessoa acabou de se ferir gravemente e está perdendo muito sangue." },
	{ "Encontrei uma pessoa reclamando de muitas dores no corpo e falta de ar, ela precisa de primeiros socorros." },
	{ "Encontrei uma pessoa inconsciente e eu não sei o que fazer, venha rapido por favor." }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP:PLAYERACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vRP:playerActive")
AddEventHandler("vRP:playerActive",function(user_id,name)
	LocalPlayer["state"]["Id"] = user_id
	LocalPlayer["state"]["Active"] = true
	SetRichPresenceDiscord(user_id,name)
	
	local pid = PlayerId()
	local ped = PlayerPedId()

	SetEntityInvincible(ped,true)
	FreezeEntityPosition(ped,false)
	NetworkSetFriendlyFireOption(true)
	SetCanAttackFriendly(ped,true,false)

	SetRadarZoom(1100)
	SetMaxWantedLevel(0)
	SetPedHelmet(ped,false)
	SetPlayerTargetingMode(2)
	DistantCopCarSirens(false)
	SetWeaponsNoAutoswap(true)
	SetPlayerCanUseCover(pid,false)
	SetPedSteersAroundPeds(ped,true)
	DisableVehicleDistantlights(true)
	SetFlashLightKeepOnWhileMoving(true)
	SetPedDropsWeaponsWhenDead(ped,false)
	SetPedCanLosePropsOnDamage(ped,false,0)
	SetPedCanBeKnockedOffVehicle(ped,false)
	SetPedCanRagdollFromPlayerImpact(ped,false)

	SetPedConfigFlag(ped,48,true)
    SetPedConfigFlag(ped,33,false)

	for i = 0,121 do
		EnableDispatchService(i,false)
	end

	Citizen.Wait(10000)

	SetEntityInvincible(ped,false)
end)


function SetRichPresenceDiscord(user_id, name)
    local LabelDiscord = "#"..user_id.." "..name
    if name == 'Individuo Indigente' then
        LabelDiscord = "#"..user_id.." Criando personagem"
    end

	SetDiscordAppId(1348069879671951450)
    SetDiscordRichPresenceAsset("logo_fortal")
    SetRichPresence(LabelDiscord)
    SetDiscordRichPresenceAssetSmall("logo_fortal")
    SetDiscordRichPresenceAssetText("ESPANHA RP")
    SetDiscordRichPresenceAssetSmallText("ESPANHA RP")

    while true do
        Wait(1000)

        local identity = vRPS.felpGetIdentity(user_id)
		local newName = identity["name"].." "..identity["name2"]
        if newName ~= name or newName ~= 'Individuo Indigente' then 
            name = newName 
            LabelDiscord = "#"..user_id.." "..name
            if name == 'Individuo Indigente' then
                LabelDiscord = "#"..user_id.." Criando personagem"
            end
            SetRichPresence(LabelDiscord) 
            break 
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:ROPECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("player:ropeCarry")
AddEventHandler("player:ropeCarry",function()
	ropeCarry = not ropeCarry
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		SetPlayerHealthRechargeLimit(PlayerId(),0)

		if GetEntityMaxHealth(PlayerPedId()) ~= 200 then
			SetEntityMaxHealth(PlayerPedId(),200)
			SetPedMaxHealth(PlayerPedId(),200)
		end

		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.checkDeath()
	if deathStatus and timeDeath <= 0 then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWNPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.respawnPlayer()
	timeDeath = 300
	deathStatus = false

	ClearPedTasks(PlayerPedId())
	ClearPedBloodDamage(PlayerPedId())
	SetEntityHealth(PlayerPedId(),200)
	SetEntityInvincible(PlayerPedId(),false)

	TriggerEvent("paramedic:Reset")
	TriggerEvent("inventory:CleanWeapons")
	LocalPlayer["state"]["Handcuff"] = false
	TriggerServerEvent("pma-voice:toggleMute",false)

	DoScreenFadeOut(0)
	SetEntityCoordsNoOffset(PlayerPedId(),-1041.25,-2744.99,21.35,false,false,false,true)
	SendNUIMessage({ death = false })
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.revivePlayer(Health,Arena)
	SetEntityHealth(PlayerPedId(),Health)
	SetEntityInvincible(PlayerPedId(),false)

	if Arena then
		SetPedArmour(PlayerPedId(),100)
	end

	if deathStatus then
		timeDeath = 300
		deathStatus = false

		ClearPedTasks(PlayerPedId())

		SendNUIMessage({ death = false })

		if LocalPlayer["state"]["Route"] < 900000 then
			TriggerEvent("paramedic:Reset")
			TriggerServerEvent("pma-voice:toggleMute",false)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMEDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local deathTimers = GetGameTimer()

	while true do
		if GetGameTimer() >= deathTimers then
			deathTimers = GetGameTimer() + 1000

			if deathStatus then
				if timeDeath > 0 then
					timeDeath = timeDeath - 1
				end
			end
		end

		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if deathStatus then
			timeDistance = 1
			DisableControlAction(1,18,true)
			DisableControlAction(1,22,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,68,true)
			DisableControlAction(1,70,true)
			DisableControlAction(1,91,true)
			DisableControlAction(1,69,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,140,true)
			DisableControlAction(1,142,true)
			DisableControlAction(1,257,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDEATH (Detecta a morte do jogador)
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local timeDistance = 1000 -- Fica verificando a cada 1 segundo para economizar performance

		-- Se o jogador está morto e o deathStatus ainda não foi ativado
		if IsEntityDead(ped) and not deathStatus then
			timeDistance = 1 -- Acelera a verificação quando está morto
			deathStatus = true
			timeDeath = 300 -- Reseta o timer de morte para 5 minutos (300 segundos)

			-- Toca a animação de morto e mantém o corpo no chão
			local coords = GetEntityCoords(ped)
			NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
			SetEntityHealth(ped, 101) -- Deixa o jogador com "morte clínica" (para não levantar sozinho)
			ClearPedTasksImmediately(ped)
			SetEntityInvincible(ped, false) -- Garante que o god não deixe o jogador invencível durante a morte
			
			-- Envia o comando para a NUI (a tela de morte que você tem no HTML)
			SendNUIMessage({ death = true })
			
			-- Ativa o botão de emergência (se você tiver essa função)
			emergencyButton = true
		end

		-- Se o jogador está vivo e o deathStatus está ativo, reseta tudo
		if not IsEntityDead(ped) and deathStatus then
			deathStatus = false
			timeDeath = 300
			emergencyButton = false
			SendNUIMessage({ death = false })
		end

		Citizen.Wait(timeDistance)
	end
end)