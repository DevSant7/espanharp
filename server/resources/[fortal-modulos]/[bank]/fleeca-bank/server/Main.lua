local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

vFunc = {}
Tunnel.bindInterface("fleeca-bank", vFunc)

vFunc.TransferMoney = function(nuser_id, value)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	nuser_id = tonumber(nuser_id)

	if user_id == nuser_id then
		return {
			error = true,
			message = "Voce não pode fazer essa transferencia."
		}
	end

	local nuser_source = Config.functions["GetUserSource"](nuser_id)
	local getNuser_id = Config.functions["GetUserId"](nuser_source)

	if not getNuser_id then
		return {
			error = true,
			message = "Esta conta não foi encontrada."
		}
	end

	local getBalance = isBalance(user_id, value)

	if not getBalance then
		return {
			error = true,
			message = "Saldo insuficiente."
		}
	end

	transferCompleted(user_id, value, getNuser_id)
	TriggerEvent("bank:balance", source)
	TriggerEvent("bank:balance", nuser_source)
	TriggerEvent("bank:register-transaction", source, {
		reason = "Houve uma transferencia de R$ " .. formatarNumero(value) .. "para o ID " .. getNuser_id,
		hours = os.time(),
		typeReason = "Pagou",
		value = value,
		user_id = user_id
	})
	return {
		error = false,
		message = "Transferencia concluida."
	}
end

vFunc.PaymentsInvoice = function(id, price)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local isBalance = isBalance(user_id, price)
	local getInvoiceById = getByIdInvoice({ id = id })[1]

	if not isBalance then
		return {
			error = true,
			message = "Saldo insuficiente."
		}
	end

	remBalance({ user_id = user_id, bank = price })

	setBalance({ user_id = getInvoiceById["nuser_id"], bank = price })

	TriggerEvent("bank:register-transaction", source, {
		reason = getInvoiceById["reason"],
		hours = os.time(),
		typeReason = "Pagou",
		value = price,
		user_id = user_id
	})
	TriggerEvent("bank:register-graphics", source, {
		value = price,
		user_id = user_id
	})
	deleteInvoice({ id = id })
	TriggerEvent("bank:invoice", source)

	return {
		error = false,
		message = "Fatura paga."
	}
end

vFunc.CreatedInvoice = function(nuser_id, reason, value)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local identify = Config.functions["GetIdentify"](user_id)
	local identify_nuser_id = Config.functions["GetIdentify"](nuser_id)

	if user_id == nuser_id then
		return {
			error = true,
			message = "Transação incorreta."
		}
	end

	local nuser_source = Config.functions["GetUserSource"](nuser_id)
	local getNuser_id = Config.functions["GetUserId"](nuser_source)

	if not getNuser_id then
		return {
			error = true,
			message = "Esta conta não foi encontrada."
		}
	end

	if not Config.functions["Request"](nuser_source, "Desejar aceitar a fatura de " .. identify) then
		return {
			error = true,
			message = identify_nuser_id .. " não aceitou a fatura."
		}
	end

	insertInvoice({
		reason = reason,
		value = value,
		user_id = nuser_id,
		nuser_id = user_id,
	})

	TriggerEvent("bank:invoice", source)
	TriggerEvent("bank:invoice", nuser_source)

	return {
		error = false,
		message = "Fatura criada com sucesso."
	}
end

vFunc.CreatedInvestments = function(investments)
    local source = source
    local user_id = Config.functions["GetUserId"](source)

    if not Config.InvestmentsSystem.enabled then
        TriggerClientEvent("Notify", source, "negado", "O sistema de investimentos está desativado no momento.")
        return {
            error = true,
            message = "Sistema de investimentos desativado."
        }
    end

    if user_id then
        local getBalance = isBalance(user_id, investments)

        if not getBalance then
            return {
                error = true,
                message = "Saldo insuficiente."
            }
        end

        local queryInvestments = getInvestments(user_id)
        if queryInvestments then
            local queryDate = formatarDia(parseInt(queryInvestments["date"]))
            return {
                error = true,
                message = "Você deve aguardar " .. queryDate .. " dias restantes."
            }
        end

        local currentDate = os.date("*t")
        remBalance({ user_id = user_id, bank = investments })

        newInvestments({
            user_id = user_id,
            investments = investments,
            investmentsInitial = investments,
            date = Config.Days * 86400000,
            lastInitial = currentDate.day .. "/" .. currentDate.month .. "/" .. currentDate.year,
            datePreview = currentDate.day .. "/" .. currentDate.month .. "/" .. currentDate.year,
            profit = 0
        })

        TriggerEvent("bank:investments", source)

        TriggerEvent("bank:register-transaction", source, {
            reason = "Houve um investimento de R$ " .. formatarNumero(investments),
            hours = os.time(),
            typeReason = "Retirou",
            value = investments,
            user_id = user_id
        })

        return {
            error = false,
            message = "Investimento feito com sucesso."
        }
    end
end


vFunc.GetInvestments = function()
    local source = source
    local user_id = Config.functions["GetUserId"](source)

    if not Config.InvestmentsSystem.enabled then
        TriggerClientEvent("Notify", source, "negado", "O saque de investimentos está desativado no momento.")
        return {
            error = true,
            message = "Sistema de saque de investimentos desativado."
        }
    end

    local value = getInvestments(user_id)
    local queryInvestments = getInvestments(user_id)

    if not queryInvestments then
        return {
            error = true,
            message = "Não foi encontrado nenhum investimento feito nos últimos dias..."
        }
    end

    if queryInvestments["date"] >= os.time() then
        return {
            error = true,
            message = "Você deve aguardar " .. formatarDia(parseInt(queryInvestments["date"])) .. " dias restantes."
        }
    end

    value = value["investments"]

    setBalance({ user_id = user_id, bank = value })
    TriggerEvent("bank:balance", source)
    TriggerEvent("bank:register-graphics", source, {
        value = value,
        user_id = user_id
    })

    TriggerEvent("bank:register-transaction", source, {
        reason = "Houve um recebimento de investimento de R$ " .. formatarNumero(value),
        hours = os.time(),
        typeReason = "Retirou",
        value = value,
        user_id = user_id
    })

    deleteInvestments({ user_id = user_id })
    Config.functions["GiveMoneyInInventory"](user_id, Config.Item, value)

    return {
        error = false,
        message = "Você acabou de sacar R$ " .. formatarNumero(value) .. "."
    }
end


vFunc.PaymentsFines = function(id, value)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local isBalance = isBalance(user_id, value)

	if not isBalance then
		return {
			error = true,
			message = "Saldo insuficiente."
		}
	end

	remBalance({ user_id = user_id, bank = value })
	TriggerEvent("bank:register-transaction", source, {
		reason = "Multas pagas",
		hours = os.time(),
		typeReason = "Pagou",
		value = value,
		user_id = user_id
	})
	TriggerEvent("bank:register-graphics", source, {
		value = value,
		user_id = user_id
	})
	vRP.delFines(user_id, value)
	TriggerEvent("bank:fines", source)
	return {
		error = false,
		message = "Multa paga."
	}
end


vFunc.PaymentsImposts = function(id, value)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local price = value
	local isBalance = isBalance(user_id, price)
	local getImpostsById = getImpostsById(id)

	if not isBalance then
		return {
			error = true,
			message = "Saldo insuficiente."
		}
	end

	remBalance({ user_id = user_id, bank = price })

	if getImpostsById["type"] == "cars" then
		Config.functions["ExecuteConsult"]("black/updateVehiclesTax", {
			user_id = user_id,
			vehicle = getImpostsById["car"]
		})
	end

	TriggerEvent("bank:register-transaction", source, {
		reason = getImpostsById["reason"],
		hours = os.time(),
		typeReason = "Pagou",
		value = price,
		user_id = user_id
	})
	TriggerEvent("bank:register-graphics", source, {
		value = price,
		user_id = user_id
	})

	deleteImposts({ id = id })

	TriggerEvent("bank:imposts", source)

	return {
		error = false,
		message = "Imposto pago."
	}
end

vFunc.Deposit = function(value)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local getMoney = Config.functions["TryGetMoneyInInventory"](user_id, Config.Item, value)
	if not getMoney then
		return {
			error = true,
			message = "Voce nao possui dinheiro para depositar"
		}
	end

	setBalance({ user_id = user_id, bank = value })
	TriggerEvent("bank:balance", source)
	TriggerEvent("bank:register-transaction", source, {
		reason = "Houve um deposito de R$ " .. formatarNumero(value),
		hours = os.time(),
		typeReason = "Pagou",
		value = value,
		user_id = user_id
	})
	TriggerEvent("bank:register-graphics", source, {
		value = value,
		user_id = user_id
	})

	return {
		error = false,
		message = "Voce acabou de depositar R$ " .. formatarNumero(value) .. "."
	}
end

vFunc.Withdraw = function(value)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local isBalance = isBalance(user_id, value)

	if not isBalance then
		return {
			error = true,
			message = "Voce nao possui dinheiro em conta para sacar"
		}
	end

	remBalance({ user_id = user_id, bank = value })
	TriggerEvent("bank:balance", source)
	TriggerEvent("bank:register-graphics", source, {
		value = value,
		user_id = user_id
	})

	TriggerEvent("bank:register-transaction", source, {
		reason = "Houve um saque de R$ " .. formatarNumero(value),
		hours = os.time(),
		typeReason = "Retirou",
		value = value,
		user_id = user_id
	})

	Config.functions["GiveMoneyInInventory"](user_id, Config.Item, value)

	return {
		error = false,
		message = "Voce acabou de sacar R$ " .. formatarNumero(value) .. "."
	}
end

RegisterNetEvent("bank:identify", function()
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	if user_id then
		local name, _ = Config.functions["GetIdentify"](user_id)

		TriggerEvent("bank:transactions", source)
		TriggerEvent("bank:balance", source)
		TriggerEvent("bank:invoice", source)
		TriggerEvent("bank:imposts", source)
		TriggerEvent("bank:fines", source)
		TriggerEvent("bank:investments", source)
		TriggerEvent("bank:monthlyIncome", source)
		TriggerEvent("bank:graphics", source)
		TriggerClientEvent("bank:nuiMessage", source, "identify", name)
		TriggerClientEvent("bank:nuiMessage", source, "listMoneys", Config.Actions)
	end
end)

RegisterNetEvent("bank:balance", function(source)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local queryBalance = getBalance(user_id)

	if not queryBalance then
		TriggerClientEvent("bank:nuiMessage", source, "balance", 0)
		return
	end

	TriggerClientEvent("bank:nuiMessage", source, "balance", formatarNumero(tonumber(queryBalance)))
end)

RegisterNetEvent("bank:fines", function(source)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	if user_id then
		local findFinesDoUser = getFines({ user_id = user_id })

		if not findFinesDoUser then
			TriggerClientEvent("bank:nuiMessage", source, "fines", 0)
			return
		end

		TriggerClientEvent("bank:nuiMessage", source, "fines", findFinesDoUser[1].fines)
	end
end)


RegisterNetEvent("bank:imposts", function(source)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	if user_id then
		local cacheImposts = {}
		local findImpostsDoUser = getImposts({ user_id = user_id })

		if not findImpostsDoUser then
			TriggerClientEvent("bank:nuiMessage", source, "imposts", {})
			return
		end

		for _, v in pairs(findImpostsDoUser) do
			table.insert(cacheImposts, {
				id = v["id"],
				reason = v["reason"],
				value = v["value"],
				type = v["type"],
			})
		end

		TriggerClientEvent("bank:nuiMessage", source, "imposts", cacheImposts)
	end
end)




RegisterNetEvent("bank:transactions", function(source)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local queryTransactions = getTransation({
		user_id = user_id
	})

	if not queryTransactions then
		TriggerClientEvent("bank:nuiMessage", source, "transactions", {})

		return
	end

	local cacheTransactions = {}

	for k, v in pairs(queryTransactions) do
		table.insert(cacheTransactions, {
			reason = v["reason"],
			hours = v["hours"],
			typeReason = v["typeReason"],
			value = v["value"]
		})
	end

	TriggerClientEvent("bank:nuiMessage", source, "transactions", cacheTransactions)
end)



RegisterNetEvent("bank:graphics", function(source)
	local user_id = Config.functions["GetUserId"](source)
	local queryGraphics = getAllGraphics {
		user_id = user_id
	}

	if not queryGraphics then
		TriggerClientEvent("bank:nuiMessage", source, "graphics", {})

		return
	end

	local cacheGraphics = {}

	for k, v in pairs(queryGraphics) do
		table.insert(cacheGraphics, {
			id = v["id"],
			value = v["value"]
		})
	end

	TriggerClientEvent("bank:nuiMessage", source, "graphics", cacheGraphics)
end)


RegisterNetEvent("bank:invoice", function(source)
	local user_id = Config.functions["GetUserId"](source)
	local queryInvoice = getAllInvoice({ user_id = user_id })

	if not queryInvoice then
		TriggerClientEvent("bank:nuiMessage", source, "invoices", {})
		return
	end

	local cacheInvoice = {}

	for k, v in pairs(queryInvoice) do
		local name, name2 = Config.functions["GetIdentify"](v["nuser_id"])

		if user_id ~= v['nuser_id'] then
			table.insert(cacheInvoice, {
				id = v["id"],
				reason = v["reason"],
				identify = name ..
				" " .. name2 .. " (" .. v["nuser_id"] .. ") | R$" .. formatarNumero(v["value"]) .. "",
				value = v["value"]
			})
		end
	end

	TriggerClientEvent("bank:nuiMessage", source, "invoices", cacheInvoice)
end)

RegisterNetEvent("bank:register-graphics", function(source, ...)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	insertGraphics(...)
	TriggerEvent("bank:graphics", source)
end)

RegisterNetEvent("bank:register-imposts", function(source, ...)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	newImposts(...)
	TriggerEvent("bank:imposts", source)
end)

RegisterNetEvent("bank:investments", function(source)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	local queryInvestments = getInvestments(user_id)


	if not queryInvestments then
		TriggerClientEvent("bank:nuiMessage", source, "investments:isWithdraw", true)
		TriggerClientEvent("bank:nuiMessage", source, "investments", 0)
		TriggerClientEvent("bank:nuiMessage", source, "investments:profit", 0)
		return
	end

	local amount = parseInt(queryInvestments["investments"]);
	local dateInitial = parseInt(queryInvestments["date"]);

	local currentDate = os.date("*t")


	local splitDateInitial = splitString(queryInvestments["lastInitial"], "/")

	local dateInitialTime = os.date("*t",
		os.time({ year = splitDateInitial[3], month = splitDateInitial[2], day = splitDateInitial[1] }))



	local queryDate = formatarDia(parseInt(queryInvestments["date"]))
	if (queryDate == 0) then
		TriggerClientEvent("bank:nuiMessage", source, "investments:isWithdraw", false)
		TriggerClientEvent("bank:nuiMessage", source, "investments", amount)
		TriggerClientEvent("bank:nuiMessage", source, "investments:profit", queryInvestments["profit"])
		return
	end

	local datePreviewSplit = splitString(queryInvestments["datePreview"], "/")
	local datePreviewDate = os.date("*t",
		os.time({ year = datePreviewSplit[3], month = datePreviewSplit[2], day = datePreviewSplit[1] }))
	local dateInitialTime = os.time({ year = splitDateInitial[3], month = splitDateInitial[2], day = splitDateInitial
	[1] })


	if (datePreviewDate.day ~= currentDate.day) then
		local countDays = countDays(user_id, dateInitialTime, os.time())
		updateInvestments({
			user_id = user_id,
			investments = amount + countDays,
			date = queryInvestments["date"] - 86400000,
			datePreview = "" .. currentDate.day .. "/" .. currentDate.month .. "/" .. currentDate.year,
			profit = countDays
		})

		TriggerClientEvent("bank:nuiMessage", source, "investments:isWithdraw", true)
		TriggerClientEvent("bank:nuiMessage", source, "investments", queryInvestments["investments"])
		TriggerClientEvent("bank:nuiMessage", source, "investments:profit", queryInvestments["profit"])
		return
	end

	TriggerClientEvent("bank:nuiMessage", source, "investments:isWithdraw", true)
	TriggerClientEvent("bank:nuiMessage", source, "investments", queryInvestments["investments"])
	TriggerClientEvent("bank:nuiMessage", source, "investments:profit", queryInvestments["profit"])
end)

function countDays(user_id, dateInitalInvested, dateNow)
	local investments = getInvestments(user_id)
	local countDays = os.difftime(dateNow, dateInitalInvested) * 1000
	local days = customRound(countDays / 86400000)

	local result = math.floor(math.abs(parseInt(investments["investmentsInitial"]) * Config.Tax * days))
	return result
end

function customRound(number)
	local floorValue = math.floor(number)
	local decimalPart = number - floorValue

	if decimalPart >= 0.5 then
		return floorValue + 1
	else
		return floorValue
	end
end

RegisterNetEvent("bank:monthlyIncome", function(source)
	local source = source
	local user_id = Config.functions["GetUserId"](source)

	if user_id then
		local queryMonthlyIncome = getMonthlyIncome({ user_id = user_id })

		if not queryMonthlyIncome then
			TriggerClientEvent("bank:nuiMessage", source, "monthlyIncome", formatarNumero(0))

			return
		end

		TriggerClientEvent("bank:nuiMessage", source, "monthlyIncome", formatarNumero(queryMonthlyIncome["value"]))
	end
end)

RegisterNetEvent("bank:register-transaction", function(source, ...)
	local source = source
	local user_id = Config.functions["GetUserId"](source)
	newTransation(...)

	local queryMonthlyIncome = getMonthlyIncome({ user_id = user_id })

	local value = (...)["value"]
	local typeReason = (...)["typeReason"]

	if (typeReason ~= "Retirou") then
		if (not queryMonthlyIncome) then
			newMonthlyIncome({
				user_id = user_id,
				value = value
			})
		else
			updateMonthlyIncome({
				user_id = user_id,
				value = value
			})
		end
	end
	TriggerEvent("bank:graphics", source)
end)

RegisterNetEvent("bank:create-imposts", function(source, reason, value, typeParams, user_id)
	newImposts({
		reason = reason,
		value = value,
		type = typeParams,
		user_id = user_id,
	})
end)

RegisterNetEvent("bank:create-imposts-car", function(source, reason, value, typeParams, car, user_id)
	newImposts({
		reason = reason,
		value = value,
		type = typeParams,
		car = car,
		user_id = user_id,
	})
end)

RegisterNetEvent("bank:delete-impost-car", function(user_id, reason, value)
	if user_id then
		local imposts = getImpostsByType({ user_id = user_id, type = "cars" })
		if imposts[1] then
			if imposts[1].reason == reason and imposts[1].value == value then
				deleteImposts({
					id = imposts[1].id
				})
				return true
			end
		end
	end
end)

exports("existImpostCar", function(user_id, reason, value)
	if user_id then
		local imposts = getImpostsByType({ user_id = user_id, type = "cars" })
		if imposts[1] then
			if imposts[1].reason == reason and imposts[1].value == value then
				return true
			end
		end
	end
end)

exports("getImposts", function()
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		local imposts = getImpostsByType({ user_id = user_id, type = "cars" })
		if imposts[1] then
			return true
		end
		return false
	end
end)

RegisterNetEvent("bank:create-fines", function(source, reason, fine, service, user_id)
	newFines({
		user_id = user_id,
		fine = fine,
	})
end)