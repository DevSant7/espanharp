-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNNEL CONFIGURATION
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)
serverAPI = Tunnel.getInterface(GetCurrentResourceName())

-----------------------------------------------------------------------------------------------------------------------------------------
-- ONCLIENTRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onClientResourceStart",function(Resource)
	if GetCurrentResourceName() == Resource then
		SetNuiFocus(false,false)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN NUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("open",function()
    local Ped = PlayerPedId()
    if GetEntityHealth(Ped) > 100 then
        if serverAPI and serverAPI.getUserData then
            -- SEMPRE buscar dados frescos do servidor ao abrir o banco
            local userData = serverAPI.getUserData()
            
            if userData then
                print("^2[FORTAL_BANK] Dados válidos recebidos:", json.encode(userData))
                SetNuiFocus(true,true)
                SendNUIMessage({ action = "setVisible", data = true })
                SendNUIMessage({ action = "setUserData", data = userData })
                -- Sempre forçar para a tela de login quando abrir
                SendNUIMessage({ action = "forceLogin", data = true })
                -- Forçar refresh de todos os dados no frontend
                SendNUIMessage({ action = "refreshAllData", data = true })
                print("^2[FORTAL_BANK] NUI aberta com dados atualizados")
            else
                SetNuiFocus(true,true)
                SendNUIMessage({ action = "setVisible", data = true })
                SendNUIMessage({ action = "forceLogin", data = true })
            end
        else
            SetNuiFocus(true,true)
            SendNUIMessage({ action = "setVisible", data = true })
            SendNUIMessage({ action = "forceLogin", data = true })
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDEFRAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("hideFrame",function(Data,Callback)
    SetNuiFocus(false,false)
    SendNUIMessage({ action = "setVisible", data = false })
    Callback("Ok")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("deposit",function(Data,Callback)
    if serverAPI and serverAPI.deposit then
        local result = serverAPI.deposit(Data.amount, Data.accountType, Data.accountId)
        Callback(result)
    else
        Callback({ success = false, message = "Servidor não disponível" })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- WITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("withdraw",function(Data,Callback)
    if serverAPI and serverAPI.withdraw then
        local result = serverAPI.withdraw(Data.amount, Data.accountType, Data.accountId)
        Callback(result)
    else
        Callback({ success = false, message = "Servidor não disponível" })
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET TRANSACTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getTransactions",function(Data,Callback)
    if serverAPI and serverAPI.getTransactions then
        local transactions = serverAPI.getTransactions(Data.accountType, Data.accountId)
        Callback(transactions)
    else
        Callback({})
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET EXPENSES LAST 4 WEEKS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getExpensesLast4Weeks",function(Data,Callback)
    if serverAPI and serverAPI.getExpensesLast4Weeks then
        local expenses = serverAPI.getExpensesLast4Weeks(Data.accountType, Data.accountId)
        Callback(expenses)
    else
        Callback(0)
    end
end)

-- Invoices
RegisterNUICallback("getUserInvoices",function(Data,Callback)
    if serverAPI and serverAPI.getUserInvoices then
        local invoices = serverAPI.getUserInvoices()
        Callback(invoices)
    else
        Callback({})
    end
end)

RegisterNUICallback("getPendingInvoicesTotal",function(Data,Callback)
    if serverAPI and serverAPI.getPendingInvoicesTotal then
        local total = serverAPI.getPendingInvoicesTotal()
        Callback(total)
    else
        Callback(0)
    end
end)

RegisterNUICallback("payInvoice",function(Data,Callback)
    if serverAPI and serverAPI.payInvoice then
        local ok = serverAPI.payInvoice(Data.id)
        Callback(ok)
    else
        Callback(false)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GET BALANCE HISTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("getBalanceHistory",function(Data,Callback)
    print("^3[FORTAL_BANK] getBalanceHistory callback - Data:", json.encode(Data))
    if serverAPI and serverAPI.getBalanceHistory then
        local history = serverAPI.getBalanceHistory(Data.period, Data.accountType, Data.accountId)
        print("^3[FORTAL_BANK] getBalanceHistory callback - Result:", json.encode(history))
        Callback(history)
    else
        print("^1[FORTAL_BANK] serverAPI.getBalanceHistory não disponível")
        Callback({})
    end
end)

RegisterNUICallback("getAccountInfo",function(Data,Callback)
    if serverAPI and serverAPI.getAccountInfo then
        local accountInfo = serverAPI.getAccountInfo()
        Callback(accountInfo)
    else
        Callback({})
    end
end)

RegisterNUICallback("refreshUserData",function(Data,Callback)
    if serverAPI and serverAPI.getUserData then
        local userData = serverAPI.getUserData()
        if userData then
            print("^2[FORTAL_BANK] Dados atualizados recebidos:", json.encode(userData))
            SendNUIMessage({ action = "setUserData", data = userData })
            Callback({ success = true, data = userData })
        else
            Callback({ success = false })
        end
    else
        Callback({ success = false })
    end
end)

RegisterNUICallback("updateAccountInfo",function(Data,Callback)
    if serverAPI and serverAPI.updateAccountInfo then
        local success = serverAPI.updateAccountInfo(Data)
        Callback(success)
    else
        Callback(false)
    end
end)

RegisterNUICallback("resetSecurityPin",function(Data,Callback)
    if serverAPI and serverAPI.resetSecurityPin then
        local success = serverAPI.resetSecurityPin()
        Callback(success)
    else
        Callback(false)
    end
end)

RegisterNUICallback("getUserJointAccounts",function(Data,Callback)
    if serverAPI and serverAPI.getUserJointAccounts then
        local accounts = serverAPI.getUserJointAccounts()
        Callback(accounts)
    else
        Callback({})
    end
end)

RegisterNUICallback("createJointAccount",function(Data,Callback)
    if serverAPI and serverAPI.createJointAccount then
        local result = serverAPI.createJointAccount(Data)
        Callback(result)
    else
        Callback({ success = false, message = "Erro no servidor" })
    end
end)

RegisterNUICallback("getJointAccountBalance",function(Data,Callback)
    if serverAPI and serverAPI.getJointAccountBalance then
        local balance = serverAPI.getJointAccountBalance(Data.account_id)
        Callback(balance)
    else
        Callback(0)
    end
end)

RegisterNUICallback("showNotification",function(Data,Callback)
    if Data.type and Data.message then
        showNotification(Data.type, Data.message)
    end
    Callback(true)
end)

RegisterNUICallback("transfer",function(Data,Callback)
    if serverAPI and serverAPI.transfer then
        local result = serverAPI.transfer(Data.amount, Data.target_key, Data.accountType, Data.accountId)
        Callback(result)
    else
        Callback({ success = false, message = "Servidor não disponível", type = "error" })
    end
end)

RegisterNUICallback("getTransferKey",function(Data,Callback)
    if serverAPI and serverAPI.getTransferKey then
        local transferKey = serverAPI.getTransferKey()
        Callback(transferKey)
    else
        Callback(nil)
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOW NOTIFICATION
-----------------------------------------------------------------------------------------------------------------------------------------
function showNotification(type, message)
    SendNUIMessage({ 
        action = "showNotification", 
        data = { 
            type = type, 
            message = message 
        } 
    })
end

-- Expor funções para o servidor chamar
function src.showNotification(type, message)
    showNotification(type, message)
end

function src.refreshAll()
    -- Força todos os hooks a recarregarem dados
    SendNUIMessage({ action = "refreshAllData", data = true })
end

RegisterNetEvent("fortal_bank:showNotification")
AddEventHandler("fortal_bank:showNotification", function(type, message)
    showNotification(type, message)
end)
