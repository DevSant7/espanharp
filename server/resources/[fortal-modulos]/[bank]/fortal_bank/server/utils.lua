Utils = Utils or {}

Utils.functions = {
    getUserId = function(source)
        if not source then
            print("^1[FORTAL_BANK] Utils.getUserId chamado com source nil")
            return nil
        end
        
        if not vRP then
            print("^1[FORTAL_BANK] Utils.getUserId: vRP não está inicializado")
            return nil
        end
        
        local user_id = vRP.getUserId(source)
        
        if not user_id then
            print("^1[FORTAL_BANK] Utils.getUserId: vRP.getUserId retornou nil para source:", source)
            return nil
        end
        
        return user_id
    end,
    
    getUserIdentity = function(user_id)
        if not user_id or not vRP then
            return nil
        end
        return vRP.userIdentity(user_id)
    end,
    
    getUserName = function(user_id)
        local identity = Utils.functions.getUserIdentity(user_id)
        if identity then
            return identity["name"].." "..identity["name2"]
        end
        return "Usuário"
    end,
    
    getUserBank = function(user_id)
        if not user_id or not vRP then
            return 0
        end
        return vRP.getBank(user_id)
    end,
    
    removeBank = function(user_id, amount)
        local query = vRP.query("bank/getInfos", { user_id = user_id })
        print("^3[FORTAL_BANK] Query result:", json.encode(query))
        if query[1] and query[1]["bank"] then
            local currentBank = query[1]["bank"]
            local newBank = currentBank - amount
            print("^3[FORTAL_BANK] Current bank:", currentBank, "New bank:", newBank)
            if newBank >= 0 then
                local executeResult = vRP.execute("bank/RemBank", { user_id = user_id, amount = amount })
                print("^3[FORTAL_BANK] Execute result:", executeResult)
                return true
            end
        end
        return false
    end
}