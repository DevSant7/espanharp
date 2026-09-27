local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
Config = {}

-- Coloque o item de dinheiro aqui da sua base
Config.Item = "dollars"

Config.InvestmentsSystem = {
    enabled = false, -- true para ativar, false para desativar o sistema de investimentos
}

-- O prazo em milissegundos para o pagamento do investimento e rendimento da conta
Config.Days = 30 -- 30 dias

-- A taxa de lucro, expressa como uma fração, aplicada ao valor investido
Config.Tax = 0.03  -- Taxa de 3% de lucro do valor investido

--- Quais cards ja pre-setado para transferencia automatica sem digitação
Config.Actions = {
	"500",
	"1000",
	"5000",
	"10000",
	"20000",
	"50000",
	"100000",
	"150000",
	"200000",
	"500000",
	"1000000",
	"2000000",
	"3000000",
	"4000000",
	"5000000",
	"6000000",
	"7000000",
	"8000000",
	"9000000",
  	"10000000",
}

Config.functions = {
	["GetUserSource"] = function(user_id)
		return vRP.getUserSource(user_id)
	end,
	["GetUserId"] = function(source)
		return vRP.getUserId(source)
	end,
	["Request"] = function(source,text)
		return vRP.request(source,text)
	end,
	["GetIdentify"] = function(user_id)
		local identify = vRP.userIdentity(user_id)
		return identify.name,identify.name2
	end,
	["TryGetMoneyInInventory"] = function(user_id, item, money)
		return vRP.tryGetInventoryItem(user_id, item, money)
	end,
	["GiveMoneyInInventory"] = function(user_id, item, money)
		return vRP.giveInventoryItem(user_id, item, money)
	end,
	["PrepareConsult"] = function(prepare, sql)
		return vRP.prepare(prepare, sql)
	end,
	["QueryConsult"] = function(prepare, sql)
		return vRP.query(prepare, sql)
	end,
	["ExecuteConsult"] = function(prepare, sql)
		return vRP.execute(prepare, sql)
	end
}


--***IMPORTANTE***--

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

--[[ 
	Quando for adicionar um script que necessite criar um imposto para ser cobrado ao player

	OBS = {
		typeParams = tem que ser "cars" ou "homes" para o icone do front-end ser renderizado de acordo com o imposto cobrado
	}
	exemplo : TriggerEvents("bank:create-imposts",source, "IPVA hornet",1000,'cars',user_id)
]]

--***IMPORTANTE***--
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
--[[ 
	Quando for adicionar um script que necessite criar uma multa para ser cobrado ao player
	exemplo : TriggerEvents("bank:create-imposts",source, 'Multa por ultrapassar a velocidade maxima',100.000,'Detran PMESP',user_id)
]]
