if Config.Framework ~= "esx" then

    return

end

while not ESX do

    Wait(500)

    debugprint("Money: Waiting for ESX to load")

end

function GetBalance(source)

    local xPlayer = ESX.GetPlayerFromId(source)

    return xPlayer?.getAccount("bank")?.money or 0

end

function AddMoney(source, amount)

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer or amount < 0 then

        return false

    end

    xPlayer.addAccountMoney("bank", amount)

    return true

end

function AddMoneyOffline(identifier, amount)

    if amount <= 0 then

        return false

    end

    amount = math.floor(amount + 0.5)

    return MySQL.update.await("UPDATE users SET accounts = JSON_SET(accounts, '$.bank', JSON_EXTRACT(accounts, '$.bank') + ?) WHERE identifier = ?", { amount, identifier }) > 0

end

function RemoveMoney(source, amount)

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer or amount < 0 or GetBalance(source) < amount then

        return false

    end

    xPlayer.removeAccountMoney("bank", amount)

    return true

end
