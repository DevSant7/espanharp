if Config.Framework ~= "standalone" then

    return

end

function GetJob()

    return "unemployed"

end

function GetJobGrade()

    return 0

end

function GetCompanyData(cb)

    local companyData = {

        job = GetJob(),

        jobLabel = "Unemployed",

        isBoss = false,

        duty = nil

    }

    return companyData

end

function DepositMoney(amount, cb)

    return 0

end

function WithdrawMoney(amount, cb)

    return 0

end

function HireEmployee(source, cb)

    return false

end

function FireEmployee(id, cb)

    return false

end

function SetGrade(id, newGrade, cb)

    return false

end

function ToggleDuty(duty)

end