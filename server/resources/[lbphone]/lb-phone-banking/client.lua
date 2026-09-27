local Tunnel = module("vrp", "lib/Tunnel")
local Proxy  = module("vrp", "lib/Proxy")
local vRP    = Proxy.getInterface("vRP")
local vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local identifier = "nubank"

local function AddApp()
    local added, errorMessage = exports["lb-phone"]:AddCustomApp({
        identifier  = identifier,
        name        = "Nubank",
        description = "Sistema bancário para controle de finanças",
        developer   = "Oceania RolePlay",
        defaultApp  = true,
        size        = 59812,
        fixBlur     = true,
        ui          = GetCurrentResourceName() .. "/ui/dist/index.html",
        icon        = "https://cfx-nui-" .. GetCurrentResourceName() .. "/ui/icon.png",
        onOpen      = function()
            exports["lb-phone"]:SendCustomAppMessage(identifier, {
                action = "refreshBanking"
            })
        end,
    })

    if not added then
        print("[lb-phone-banking] Não foi possível adicionar o app:", errorMessage)
    end
end

CreateThread(function()
    while GetResourceState("lb-phone") ~= "started" do
        Wait(500)
    end

    AddApp()
end)

AddEventHandler("onResourceStart", function(resource)
    if resource == "lb-phone" then
        AddApp()
    end
end)

RegisterNUICallback("banking:getData", function(_, cb)
    cb(vSERVER.getAccountData())
end)

RegisterNUICallback("banking:getSenderInfo", function(data, cb)
    local senderInfo = vSERVER.getSenderInfo(data)
    if senderInfo then
        cb({ name = senderInfo })
    else
        cb({ name = nil })
    end
end)

RegisterNUICallback("banking:transferMoney", function(data, cb)
    cb({ success = vSERVER.transferMoney(data) })
end)

RegisterNUICallback("banking:deposit", function(data, cb)
    cb({ success = vSERVER.depositMoney(data.amount) })
end)

RegisterNUICallback("banking:withdraw", function(data, cb)
    cb({ success = vSERVER.withdrawMoney(data.amount) })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- 🔥 PAY FINES - NUI CALLBACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("banking:payFines", function(_, cb)
    cb({ success = vSERVER.payFines() })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- 🔥 CONSULT FINES - NUI CALLBACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("banking:consultFines", function(_, cb)
    cb({ success = vSERVER.consultFines() })
end)

RegisterNUICallback("banking:generateInvoice", function(data, cb)
    cb({ success = vSERVER.generateInvoice(data) })
end)

RegisterNUICallback("banking:payInvoice", function(data, cb)
    cb({ success = vSERVER.payInvoice(data.invoiceId) })
end)

RegisterNetEvent("banking:notify", function(title, content)
    exports["lb-phone"]:SendNotification({
        app     = identifier,
        title   = title,
        content = content
    })
end)

RegisterNetEvent("banking:refresh", function()
    print("^2[DEBUG] ^7Atualizando dados do banco...")
    
    exports["lb-phone"]:SendCustomAppMessage(identifier, {
        action = "refreshBanking"
    })
    
    SendNUIMessage({
        type = "refreshBanking"
    })
end)

RegisterNetEvent("phone-banking:forceRefresh", function()
    exports["lb-phone"]:SendCustomAppMessage(identifier, {
        action = "refreshBanking"
    })
end)

print("^2[phone-banking] Client iniciado com sucesso!^0")