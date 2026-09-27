Utils = {}

Utils.functions = {
    userId = function(source)
        return vRP.getUserId(source)
    end,
    userIdentity = function(user_id)
        local identity = vRP.userIdentity(user_id)
        if identity then 
            return identity.name.." "..identity.name2
        end
    end,
    tryPayment = function(user_id,value)
        return vRP.paymentFull(user_id,value)
    end,
    giveMoney = function(user_id,value)
        return vRP.addBank(user_id,value)
    end,
    request = function(source,text)
        return vRP.request(source,text,5000)
    end,
    getSourceFromId = function(user_id)
        return vRP.userSource(user_id)
    end,
    notify = function(source,type,message)
        if type == "green" then -- sucesso
            TriggerClientEvent("Notify",source,"sucesso",message,5000)
        else
            TriggerClientEvent("Notify",source,"negado",message,5000)
        end
    end,
    format = function(value)
        return parseFormat(value)
    end
}

Utils.messages = {
    ["request"] = "O jogador %s está te cobrando $ %s. Deseja efetuar o pagamento?",
    ["sucess"] = "Você efetuou o pagamento com sucesso.",
    ["denied"] = "Você não possui dinheiro suficiente",
    ["sucess2"] = "Sua cobrança foi paga com sucesso e você recebeu $ %s.",
    ["denied2"] = "O jogador recusou sua cobrança"
}
