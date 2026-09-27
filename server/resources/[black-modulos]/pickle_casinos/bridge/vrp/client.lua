if GetResourceState('vrp') ~= 'started' then return end

-- Callbacks client-side (compatível com ESX/QB)
local pending, id = {}, 0
function ServerCallback(name, cb, ...)
    id = (id % 1000000) + 1
    pending[id] = cb
    TriggerServerEvent("pickle_casinos:triggerCallback", name, id, ...)
end
RegisterNetEvent("pickle_casinos:clientCallback", function(name, _id, ...)
    local cb = pending[_id]
    if cb then
        pending[_id](...)
        pending[_id] = nil
    end
end)

-- Notificação – usa a do próprio recurso (NUI)
function ShowNotification(text)
    TriggerEvent(GetCurrentResourceName()..":showNotificationLocal", text)
end

-- Grupos (podes simplificar para true; o servidor valida permissões críticas)
function CanAccessGroup(data) return true end

-- Inventário client (o script só precisa “estar Ready”)
Inventory = Inventory or {}
Inventory.Items = Inventory.Items or {}
Inventory.Ready = true

RegisterNetEvent("pickle_casinos:setupInventory", function(data)
    Inventory.Items = data.items or Inventory.Items
    Inventory.Ready = true
end)

RegisterNetEvent("pickle_casinos:updateInventory", function(_) end)
