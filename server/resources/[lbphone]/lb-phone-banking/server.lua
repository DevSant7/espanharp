-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÃO PARA PEGAR NOME
-----------------------------------------------------------------------------------------------------------------------------------------
local function getPlayerName(user_id)
    if not user_id then
        return "Indisponível"
    end
    
    if vRP.getUserName then
        local name = vRP.getUserName(user_id)
        if name and name ~= "" then
            return name
        end
    end
    
    local identity = vRP.userIdentity(user_id)
    if identity then
        local firstName = identity.name or "Desconhecido"
        local lastName = identity.name2 or ""
        if lastName and lastName ~= "" then
            return firstName .. " " .. lastName
        end
        return firstName
    end
    
    return "Indisponível"
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET ACCOUNT DATA
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getAccountData()
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then
        return {
            account = { id = 0, name = "Indisponível" },
            balance = 0,
            wallet = 0,
            fines = 0,
            invoices = {},
            historyItems = {}
        }
    end

    local bank = vRP.getBank(user_id) or 0
    local wallet = vRP.getInventoryItemAmount(user_id, "dollars") or 0
    local fines = vRP.getFines(user_id) or 0

    local name = getPlayerName(user_id)

    local historyItems = {}

    table.insert(historyItems, {
        title = "Conta Bancária",
        amount = bank,
        transaction_type = 2,
        description = "Saldo atual da conta",
        created_at = os.date("%Y-%m-%dT%H:%M:%SZ")
    })

    if fines > 0 then
        table.insert(historyItems, {
            title = "Multas Pendentes",
            amount = fines,
            transaction_type = 1,
            description = "Multas a pagar",
            created_at = os.date("%Y-%m-%dT%H:%M:%SZ")
        })
    end

    return {
        account = {
            id = user_id,
            name = name
        },
        balance = bank,
        wallet = wallet,
        fines = fines,
        invoices = {},
        historyItems = historyItems
    }
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET SENDER INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.getSenderInfo(targetId)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then
        return false
    end

    local target = parseInt(targetId)
    
    if not target or target <= 0 then
        return false
    end
    
    if target == user_id then
        return false
    end

    local name = getPlayerName(target)
    
    if name and name ~= "Indisponível" and name ~= "Desconhecido" then
        return name
    end

    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFER MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.transferMoney(data)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then
        return false
    end

    if actived[user_id] then
        return false
    end

    local targetId = parseInt(data.targetId)
    local amount = parseInt(data.amount)

    if amount <= 0 then
        TriggerClientEvent("banking:notify", source, "Banco", "Valor inválido.")
        return false
    end

    if targetId == user_id then
        TriggerClientEvent("banking:notify", source, "Banco", "Você não pode transferir para si mesmo.")
        return false
    end

    local targetName = getPlayerName(targetId)
    if not targetName or targetName == "Indisponível" or targetName == "Desconhecido" then
        TriggerClientEvent("banking:notify", source, "Banco", "Destinatário não encontrado.")
        return false
    end

    local targetSource = vRP.getUserSource(targetId)

    actived[user_id] = true

    local bank = vRP.getBank(user_id) or 0
    
    if bank >= amount then
        if vRP.paymentBank(user_id, amount) then
            vRP.addBank(targetId, amount)

            local senderName = getPlayerName(user_id)

            TriggerClientEvent("banking:notify", source, "Banco", "Transferência de $"..amount.." realizada com sucesso para "..targetName..".")
            
            if targetSource then
                TriggerClientEvent("banking:notify", targetSource, "Banco", "Você recebeu $"..amount.." de "..senderName..".")
                TriggerClientEvent("banking:refresh", targetSource)
            end

            TriggerClientEvent("banking:refresh", source)

            actived[user_id] = nil
            return true
        else
            TriggerClientEvent("banking:notify", source, "Banco", "Erro ao processar transferência.")
        end
    else
        TriggerClientEvent("banking:notify", source, "Banco", "Saldo insuficiente no banco.")
    end

    actived[user_id] = nil
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.depositMoney(amount)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then
        return false
    end

    if actived[user_id] then
        return false
    end

    local amount = parseInt(amount)
    if amount <= 0 then
        TriggerClientEvent("banking:notify", source, "Banco", "Valor inválido.")
        return false
    end

    actived[user_id] = true

    if vRP.tryGetInventoryItem(user_id, "dollars", amount, true) then
        vRP.addBank(user_id, amount)
        
        TriggerClientEvent("banking:notify", source, "Banco", "Depósito de $"..amount.." realizado com sucesso.")
        TriggerClientEvent("banking:refresh", source)
        
        actived[user_id] = nil
        return true
    else
        TriggerClientEvent("banking:notify", source, "Banco", "Você não possui essa quantia em mãos.")
    end

    actived[user_id] = nil
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.withdrawMoney(amount)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then
        return false
    end

    if actived[user_id] then
        return false
    end

    local amount = parseInt(amount)
    if amount <= 0 then
        TriggerClientEvent("banking:notify", source, "Banco", "Valor inválido.")
        return false
    end

    if vRP.getFines(user_id) > 0 then
        TriggerClientEvent("banking:notify", source, "Banco", "Você possui multas pendentes. Pague-as antes de sacar.")
        return false
    end

    actived[user_id] = true

    local itemWeight = vRP.getItemWeight("dollars")
    if (vRP.getInventoryWeight(user_id) + (itemWeight * amount)) <= vRP.getInventoryMaxWeight(user_id) then
        if vRP.paymentBank(user_id, amount) then
            vRP.generateItem(user_id, "dollars", amount, true)
            TriggerClientEvent("banking:notify", source, "Banco", "Saque de $"..amount.." realizado com sucesso.")
            TriggerClientEvent("banking:refresh", source)
            
            actived[user_id] = nil
            return true
        else
            TriggerClientEvent("banking:notify", source, "Banco", "Saldo insuficiente no banco.")
        end
    else
        TriggerClientEvent("banking:notify", source, "Banco", "Mochila cheia.")
    end

    actived[user_id] = nil
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- 🔥 PAY FINES (CORRIGIDO - FUNCIONANDO)
-----------------------------------------------------------------------------------------------------------------------------------------
function src.payFines()
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then
        TriggerClientEvent("banking:notify", source, "Banco", "Você não está logado.")
        return false
    end

    if actived[user_id] then
        return false
    end

    local fineAmount = vRP.getFines(user_id)

    if fineAmount <= 0 then
        TriggerClientEvent("banking:notify", source, "Banco", "Você não possui multas pendentes.")
        return false
    end

    actived[user_id] = true

    -- 🔥 Verifica se tem saldo suficiente
    local bank = vRP.getBank(user_id) or 0
    
    if bank >= fineAmount then
        -- 🔥 Paga a multa (remove do banco)
        if vRP.paymentBank(user_id, fineAmount) then
            -- 🔥 Zera as multas
            vRP.setFines(user_id, 0)

            TriggerClientEvent("banking:notify", source, "Banco", "Multas de $"..fineAmount.." pagas com sucesso.")
            TriggerClientEvent("banking:refresh", source)
            
            actived[user_id] = nil
            return true
        else
            TriggerClientEvent("banking:notify", source, "Banco", "Erro ao processar pagamento das multas.")
        end
    else
        TriggerClientEvent("banking:notify", source, "Banco", "Saldo insuficiente para pagar as multas. Você precisa de $"..fineAmount..".")
    end

    actived[user_id] = nil
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSULT FINES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.consultFines()
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id then
        TriggerClientEvent("banking:notify", source, "Banco", "Você não está logado.")
        return false
    end

    local fineAmount = vRP.getFines(user_id)

    if fineAmount > 0 then
        TriggerClientEvent("banking:notify", source, "Banco", "Você tem $"..fineAmount.." em multas pendentes.")
    else
        TriggerClientEvent("banking:notify", source, "Banco", "Você não possui multas pendentes.")
    end

    return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATE INVOICE (desativado)
-----------------------------------------------------------------------------------------------------------------------------------------
function src.generateInvoice(data)
    TriggerClientEvent("banking:notify", source, "Banco", "Sistema de faturas indisponível.")
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PAY INVOICE (desativado)
-----------------------------------------------------------------------------------------------------------------------------------------
function src.payInvoice(invoiceId)
    TriggerClientEvent("banking:notify", source, "Banco", "Sistema de faturas indisponível.")
    return false
end

print("^2[phone-banking] Server iniciado com sucesso!^0")