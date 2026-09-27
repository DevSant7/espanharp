-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local machineGlobal = 0
local machineStart = false
local pagamento = 10000

local activeMachines = {} -- Tabela para armazenar temporizadores por máquina

-- Função para gerar um hash (ou ID) único baseado nas coordenadas
local function getMachineId(x, y)
    return math.floor(x) .. "_" .. math.floor(y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startMachine(x, y)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local copAmount = vRP.numPermission("Police")
		local id = getMachineId(x, y)

		if #copAmount < 3 then
			TriggerClientEvent("Notify", source, "important", "Atenção","Necessário pelo menos <b>3 policiais</b> em serviço.","amarelo", 5000)
			return false
		end

		if activeMachines[id] and activeMachines[id].timer > 0 then
			TriggerClientEvent("Notify", source, "important", "Atenção","Aguarde "..activeMachines[id].timer.." segundos para tentar novamente.","amarelo", 5000)
			return false
		else
			activeMachines[id] = { timer = 1200, active = true }
			vRP.upgradeStress(user_id,10)
			vRP.wantedTimer(user_id,200)
			return true
		end
	end
	return false
end


function src.hasTimed()
	if parseInt(machineTimer) > 0 then
		return false
	else
		return true
	end
end

function src.removeC4(user_id,totalName,amount,bool,slot)
	vRP.tryGetInventoryItem(user_id,totalName,amount,bool,slot)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.callPolice(x,y,z)
	local copAmount = vRP.numPermission("Police")
	for k,v in pairs(copAmount) do
		async(function()
			TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 31, title = "Roubo ao Caixa Eletrônico", x = x, y = y, z = z, rgba = {170,80,25} })
		end)
	end
end

function src.toChannel(v)
	return v["x"] | v["y"]
end

function src.getGridzone(x,y)
	local gridChunk = vector2(x,y)
	return src.toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopMachine(x, y, z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local id = getMachineId(x, y)
		if activeMachines[id] and activeMachines[id].active then
			activeMachines[id].active = false
			local zIndex = z - 1
			TriggerEvent("cashmachine:invExplode", source, "dollarsroll", pagamento, x, y, zIndex)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for id, data in pairs(activeMachines) do
			if data.timer > 0 then
				activeMachines[id].timer = data.timer - 1
				if activeMachines[id].timer <= 0 then
					activeMachines[id].active = false
				end
			end
		end
		Citizen.Wait(1000)
	end
end)