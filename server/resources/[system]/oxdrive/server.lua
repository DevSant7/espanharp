local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local myQuerys = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONINIT
-----------------------------------------------------------------------------------------------------------------------------------------
local function onInit()
	return exports["oxmysql"] ~= nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONPREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
local function onPrepare(Name,Query)
	if not Name or not Query then
		print("[oxdrive] AVISO: onPrepare chamado com Name ou Query nil")
		return
	end
	myQuerys[Name] = Query
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONQUERY
-----------------------------------------------------------------------------------------------------------------------------------------
local function onQuery(Name,Results,Mode)
	-- Verificação 1: o Name foi passado?
	if not Name then
		print("[oxdrive] ERRO: onQuery chamado sem Name")
		return 0, 0
	end

	-- Verificação 2: a query foi registrada antes?
	local query = myQuerys[Name]
	if not query then
		print("[oxdrive] AVISO: Query não registrada: " .. tostring(Name))
		return 0, 0
	end

	-- Verificação 3: Results é uma tabela? (evita erro no for)
	Results = Results or {}

	query = query:gsub("%,",", ")
	local Params = { _ = true }

	for k,v in pairs(Results) do
		Params[k] = v
	end

	local r = async()
	
	if Mode == "execute" then
		exports["oxmysql"]:query(query,Params,function(data)
			r(data or 0)
		end)
	elseif Mode == "scalar" then
		exports["oxmysql"]:scalar(query,Params,function(scalar)
			r(scalar)
		end)
	else
		exports["oxmysql"]:query(query,Params,function(rows)
			rows = rows or {}
			r(rows, #rows)
		end)
	end

	return r:wait()
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ASYNC
-----------------------------------------------------------------------------------------------------------------------------------------
async(function()
	vRP.registerDrivers("oxmysql",onInit,onPrepare,onQuery)
end)