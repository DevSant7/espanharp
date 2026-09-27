if Config.Framework ~= "standalone" then

    return

end

function GetJob(source)

    return "unemployed"

end

function GetAllEmployees(job)

    return {}

end

function GetEmployees(job)

    return {}

end

function RefreshCompanies()

    for i = 1, #Config.Companies.Services do

        local jobData = Config.Companies.Services[i]

        jobData.open = false

    end

end
