Utils = {}

Utils.functions = {
    getUserId = function(source)
        return vRP.getUserId(source)
    end,
    getUserIdentity = function(user_id)
        return vRP.userIdentity(user_id)
    end,
    nearestPlayers = function(source,dist)
        return vRPC.nearestPlayers(source,tonumber(dist))
    end
}