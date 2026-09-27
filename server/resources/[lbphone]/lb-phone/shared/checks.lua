local checks = {}

local checkId = 0

function AddCheck(event, handler)

    local resource = GetInvokingResource()

    checkId += 1

    if not checks[event] then

        checks[event] = {}

    end

    local check = {

        id = checkId,

        event = event,

        action = handler,

        resource = resource,

    }

    table.insert(checks[event], check)

    return checkId

end

exports("AddCheck", AddCheck)

function RemoveCheck(id)

    for _, eventChecks in pairs(checks) do

        for i = 1, #checks do

            local check = eventChecks[i]

            if check.id == id then

                table.remove(eventChecks, i)

                return true

            end

        end

    end

    return false

end

exports("RemoveCheck", RemoveCheck)

function ValidateChecks(event, ...)

    if not checks[event] then

        return true

    end

    local eventChecks = checks[event]

    for i = 1, #eventChecks do

        local check = eventChecks[i]

        local success, allowed = pcall(function(...)

            return check.action(...)

        end, ...)

        if not success then

            local stackTrace = Citizen.InvokeNative(`FORMAT_STACK_TRACE` & 0xFFFFFFFF, nil, 0, Citizen.ResultAsString())

            print(("^1SCRIPT ERROR: Check '%s' (id %i, by resource '%s') failed: %s^7\n%s"):format(event, i, check.resource, allowed or "", stackTrace or ""))

        end

        if allowed == false then

            return false

        end

    end

    return true

end

AddEventHandler("onResourceStop", function()

    local resource = GetInvokingResource()

    for _, eventChecks in pairs(checks) do

        for i = #eventChecks, 1, -1 do

            local check = eventChecks[i]

            if check.resource == resource then

                table.remove(eventChecks, i)

            end

        end

    end

end)
