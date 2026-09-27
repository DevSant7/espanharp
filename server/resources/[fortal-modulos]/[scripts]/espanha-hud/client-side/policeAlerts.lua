-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local showBlips = {}
local timeBlips = {}
local numberBlips = 0
local showingNotifys = false

RegisterNetEvent("NotifyPush")
AddEventHandler("NotifyPush",function(data)
	data["street"] = GetStreetNameFromHashKey(GetStreetNameAtCoord(data["x"],data["y"],data["z"]))

	numberBlips = numberBlips + 1

	timeBlips[numberBlips] = 60

	-- Alerta por area: quem chama pode mandar um `radius` em vez de confiar no ponto. Ai o
	-- blip vira um circulo e a policia recebe a regiao, nao a porta -- o ponto exato seria o
	-- centro do circulo e entregaria o mesmo que antes, entao os dois nunca convivem.
	-- Sem `radius` nada muda para os outros alertas.
	local alertRadius = tonumber(data["radius"])

	if alertRadius and alertRadius > 0 then
		showBlips[numberBlips] = AddBlipForRadius(data["x"] + 0.0,data["y"] + 0.0,data["z"] + 0.0,alertRadius + 0.0)

		SetBlipColour(showBlips[numberBlips],data["blipColor"])
		SetBlipAlpha(showBlips[numberBlips],128)
	else
		showBlips[numberBlips] = AddBlipForCoord(data["x"],data["y"],data["z"])

		SetBlipSprite(showBlips[numberBlips],270)
		SetBlipDisplay(showBlips[numberBlips],4)
		SetBlipAsShortRange(showBlips[numberBlips],true)
		SetBlipColour(showBlips[numberBlips],data["blipColor"])
		SetBlipScale(showBlips[numberBlips],0.9)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(data["title"])
		EndTextCommandSetBlipName(showBlips[numberBlips])
	end

	if parseInt(data["code"]) == 4 then
		TriggerEvent("sounds:Private","deathcop",0.7)
	end
    SendNUIMessage({
        action = 'notify:police',
        data = {
			code = data['code'],
            title = data['title'],
            author = {
              id = data['user_id'],
              name = data['name'] or data['criminal'],
            },
			phone = data['phone'],
            location = {
              zone = 'Norte',
              street = data["street"],
			  cds = {
				x = data.x,
				y = data.y,
				z = data.z
			  }
            },
            timeout = 8000, -- milissegundos
			time = data['time']
        }
    })
end)

RegisterNUICallback("phone", function(data, cb)
	if not data.phone then return end

	exports.smartphone:callPlayer(data.phone)
	cb(true)
end)

RegisterNUICallback("sendMessage", function(data, cb)
	if not data.author or not data.author.id then return end

	vSERVER.SendMessage(data.author.id)
	cb(true)
end)

RegisterNetEvent("receiveNotifyPushResponse", function(phone, message)
	exports.smartphone:createSMS(phone or '0800', message)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		for k,v in pairs(timeBlips) do
			if timeBlips[k] > 0 then
				timeBlips[k] = timeBlips[k] - 1

				if timeBlips[k] <= 0 then
					RemoveBlip(showBlips[k])
					showBlips[k] = nil
					timeBlips[k] = nil
				end
			end
		end

		Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOn",function(Data,Callback)
	-- Pedido vindo da própria NUI. Com a HUD escondida (partida, criação de personagem) a
	-- página não desenha, e conceder foco aqui devolvia o cursor preso pela porta dos
	-- fundos — depois de o `showNotifys` já ter bloqueado a porta da frente.
	if HudVisible == false then return end

	SetNuiFocus(true,true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOCUSOFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("focusOff",function(Data,Callback)
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Waypoint
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("markLocation",function(Data,Callback)
	SetNewWaypoint(Data["x"] + 0.0001,Data["y"] + 0.0001,Data["z"] + 0.0001)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
function showNotifys(status)
	if LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or IsPauseMenuActive() then return end

	-- Mesmo caso do chat (ver `openChat` no chat.lua): com a HUD escondida o histórico é
	-- invisível, mas o `SetNuiFocus` abaixo continua valendo — apertar F2 no meio de uma
	-- partida deixava o jogador com o cursor preso numa tela vazia.
	--
	-- Só o ABRIR é bloqueado. Fechar continua livre em qualquer situação: quem já estava
	-- com o painel aberto quando a HUD sumiu precisa de saída.
	if status and HudVisible == false then return end

	showingNotifys = status

	SetNuiFocus(status, status)

	SendNUIMessage({ action = "notify:police:historyVisibility", data = showingNotifys })
end

RegisterCommand("showNotifys", function()
	if not showingNotifys then
		showNotifys(true)
	else
		showNotifys(false)
	end
end)

RegisterKeyMapping("showNotifys", "Visualizar notificações.", "keyboard", "F2")