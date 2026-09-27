if Config.Framework ~= "standalone" then

    return

end

function GetBalance(source)

    return 0

end

function AddMoney(source, amount)

    return true

end

function AddMoneyOffline(identifier, amount)

    if amount <= 0 then

        return false

    end

    return true

end

function RemoveMoney(source, amount)

    return true

end
