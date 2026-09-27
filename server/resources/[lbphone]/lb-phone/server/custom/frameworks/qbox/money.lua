if Config.Framework ~= "qbox" then

    return

end

while not QB do

    Wait(500)

    debugprint("Money: Waiting for QBox to load")

end

function GetBalance(source)

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then

        debugprint("GetBalance: Failed to get player for source:", source)

        return 0

    end

    return qPlayer.Functions.GetMoney("bank") or 0

end

function AddMoney(source, amount)

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer or amount < 0 then

        return false

    end

    qPlayer.Functions.AddMoney("bank", math.floor(amount + 0.5), "lb-phone")

    return true

end

function AddMoneyOffline(identifier, amount)

    if amount <= 0 then

        return false

    end

    amount = math.floor(amount + 0.5)

    return MySQL.update.await("UPDATE players SET money = JSON_SET(money, '$.bank', JSON_EXTRACT(money, '$.bank') + ?) WHERE citizenid = ?", { amount, identifier }) > 0

end

function RemoveMoney(source, amount)

    if amount < 0 or GetBalance(source) < amount then

        return false

    end

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then

        debugprint("RemoveMoney: Failed to get player for source:", source)

        return false

    end

    qPlayer.Functions.RemoveMoney("bank", math.floor(amount + 0.5), "lb-phone")

    return true

end
