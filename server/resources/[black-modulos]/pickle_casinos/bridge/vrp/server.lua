-- bridge/vrp/server.lua
-- ✔ Carrega utils do vRP antes de usar module()
-- ✔ Sem goto / labels
-- ✔ Expõe RegisterCallback e integra banco/inventário/veículos

-- Descobre o nome do recurso vRP (ajusta aqui se o teu for outro)
local VRP_RES = nil
for _,name in ipairs({"vrp","vrpex"}) do
    local st = GetResourceState(name)
    if st and st:find("start") then VRP_RES = name break end
end
if not VRP_RES then
    print("^1[pickle_casinos][vrp] vRP não está iniciado.^0")
    return
end

-- Carrega utils.lua para definir 'module'
local utils = LoadResourceFile(VRP_RES, "lib/utils.lua")
if not utils then
    print("^1[pickle_casinos][vrp] Não encontrei "..VRP_RES.."/lib/utils.lua^0")
    return
end
local f,err = load(utils)
if not f then
    print("^1[pickle_casinos][vrp] Erro a compilar utils.lua: ^0"..tostring(err))
    return
end
f() -- agora existe 'module'

local okP, Proxy  = pcall(module, VRP_RES, "lib/Proxy")
local okT, Tunnel = pcall(module, VRP_RES, "lib/Tunnel")
if not okP or not okT or not Proxy or not Tunnel then
    print("^1[pickle_casinos][vrp] Falha a carregar Proxy/Tunnel do "..VRP_RES.."^0")
    return
end

local vRP = Proxy.getInterface("vRP")

-- ====== Itens usáveis (bridge p/ vRP) ======
local UsableRegistry = {}

-- Tenta detectar APIs comuns de “item usável” em forks do vRP
local HAS_vRP_UsableItem          = type(vRP.UsableItem) == "function"              -- creative-like
local HAS_vRP_registerUsableItem  = type(vRP.registerUsableItem) == "function"      -- alguns forks
-- (vRP “clássico puro” normalmente não tem API server-side para uso; aí fica fallback)

function RegisterUsableItem(itemName, handler)
    UsableRegistry[itemName] = handler

    if HAS_vRP_UsableItem then
        -- creative-like
        vRP.UsableItem(itemName, function(source, user_id, item, data)
            -- alguns forks passam (source,user_id,item,data); outros só (source)
            handler(source, itemName)
        end)
        print(("[pickle_casinos][vrp] Ligado vRP.UsableItem para '%s'"):format(itemName))
        return
    end

    if HAS_vRP_registerUsableItem then
        -- outros forks
        vRP.registerUsableItem(itemName, function(source)
            handler(source, itemName)
        end)
        print(("[pickle_casinos][vrp] Ligado vRP.registerUsableItem para '%s'"):format(itemName))
        return
    end

    -- Fallback: sem API nativa — continua a registar para eventual chamada manual.
    print(("[pickle_casinos][vrp] Sem API nativa para itens usáveis; registado fallback para '%s'"):format(itemName))
end

-- (Opcional) Função utilitária: se o teu inventário disparar um evento ao usar item,
-- podes chamar isto e o handler do casino executa.
RegisterNetEvent("pickle_casinos:useItemFallback", function(itemName)
    local src = source
    local fn = UsableRegistry[itemName]
    if fn then fn(src, itemName) end
end)


-- =======================
--  Callbacks (ESX/QB-like)
-- =======================
local __cbs = {}
function RegisterCallback(name, cb) __cbs[name] = cb end

RegisterNetEvent("pickle_casinos:triggerCallback", function(name, reqId, ...)
    local src = source
    local cb = __cbs[name]
    if cb then
        cb(src, function(...)
            TriggerClientEvent("pickle_casinos:clientCallback", src, name, reqId, ...)
        end, ...)
    else
        TriggerClientEvent("pickle_casinos:clientCallback", src, name, reqId, nil)
    end
end)

function GetIdentifier(source)
    local uid = vRP.getUserId(source)
    if not uid then return nil end
    return "vrp:"..uid
end

function GetSourceFromIdentifier(identifier)
    local uid = tostring(identifier or ""):match("vrp:(%d+)")
    uid = uid and tonumber(uid)
    if not uid then return nil end
    return vRP.getUserSource(uid)
end

function GetPlayerCharacterName(source)
    local uid = vRP.getUserId(source)
    if not uid then return ("Cidadão %s"):format(source) end
    if vRP.getUserIdentity then
        local idt = vRP.getUserIdentity(uid)
        if idt then
            local fn, ln = idt.firstname or idt.name or "Cidadão", idt.lastname or ""
            return (fn .. (ln ~= "" and (" " .. ln) or ""))
        end
    end
    return ("Cidadão %s"):format(uid)
end

-- =======================
-- Permissões / Grupos
-- =======================
local function _hasAny(list, uid)
    if not uid then return false end
    for _,flag in ipairs(list or {}) do
        local f = tostring(flag or "")
        local g = f:gsub("^group%.","")
        if (vRP.hasGroup and vRP.hasGroup(uid, g)) or
           (vRP.hasPermission and (vRP.hasPermission(uid, f) or vRP.hasPermission(uid, g) or vRP.hasPermission(uid, g..".permissao"))) then
            return true
        end
    end
    return false
end

function CanAccessGroup(source, data)
    if not data then return true end
    local uid = vRP.getUserId(source); if not uid then return false end
    -- data.jobs = { ["police"]=0, ["mec"]=0, ... } (no vRP ignoramos “grade”, basta ter o grupo)
    for k,_ in pairs(data.jobs or {}) do
        local g = tostring(k):gsub("^group%.","")
        if (vRP.hasGroup and vRP.hasGroup(uid, g)) or (vRP.hasPermission and (vRP.hasPermission(uid,g) or vRP.hasPermission(uid,g..".permissao"))) then
            return true
        end
    end
    return false
end

function CheckPermission(source, permission)
    if permission and permission.ignorePermissions then return true end
    local uid = vRP.getUserId(source); if not uid then return false end
    -- admin groups em Config.AdminGroups (["admin","god",...])
    if _hasAny((Config and Config.AdminGroups) or {}, uid) then return true end
    -- jobs/grupos específicos
    if permission and permission.jobs then
        for k,_ in pairs(permission.jobs) do
            local g = tostring(k):gsub("^group%.","")
            if (vRP.hasGroup and vRP.hasGroup(uid, g)) or (vRP.hasPermission and (vRP.hasPermission(uid,g) or vRP.hasPermission(uid,g..".permissao"))) then
                return true
            end
        end
    end
    -- permission.groups (se existir)
    if permission and permission.groups then
        for _,g in ipairs(permission.groups) do
            g = tostring(g):gsub("^group%.","")
            if (vRP.hasGroup and vRP.hasGroup(uid, g)) or (vRP.hasPermission and (vRP.hasPermission(uid,g) or vRP.hasPermission(uid,g..".permissao"))) then
                return true
            end
        end
    end
    return not permission
end

function IsPlayerAdmin(source)
    local uid = vRP.getUserId(source)
    return _hasAny((Config and Config.AdminGroups) or {"admin","god","Admin","Staff"}, uid)
end

-- =======================
--  Notificação
-- =======================
function ShowNotification(target, text)
    TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text)
end

-- =======================
--  Dinheiro (vRP)
-- =======================
-- Configuração: Defina como seu servidor gerencia dinheiro em mãos
local USE_MONEY_AS_ITEM = true -- true = usa item "dollars" | false = usa vRP.getMoney()
local MONEY_ITEM_NAME = "dollars" -- Nome do item que representa dinheiro em mãos

-- DEBUG: Lista de possíveis nomes de itens de dinheiro para testar
local POSSIBLE_MONEY_ITEMS = {
    "dollars", "money", "cash", "dinheiro", "dollar", "reais", "real"
}

-- Função para pegar dinheiro em mãos
local function getMoney(uid)
    if USE_MONEY_AS_ITEM then
        -- DEBUG: Testa diferentes nomes de itens de dinheiro
        for _, itemName in ipairs(POSSIBLE_MONEY_ITEMS) do
            local amt = vRP.getInventoryItemAmount(uid, itemName)
            if type(amt) == "table" then amt = amt[1] end
            amt = tonumber(amt) or 0
            if amt > 0 then
                print(("[DEBUG] Dinheiro encontrado: %d %s"):format(amt, itemName))
                return amt
            end
        end
        
        -- Se não encontrou com nenhum nome, tenta o nome configurado
        local amt = vRP.getInventoryItemAmount(uid, MONEY_ITEM_NAME)
        if type(amt) == "table" then amt = amt[1] end
        local finalAmt = tonumber(amt) or 0
        print(("[DEBUG] Item %s: %d"):format(MONEY_ITEM_NAME, finalAmt))
        return finalAmt
    else
        -- Usa função nativa do vRP
        if vRP.getMoney then 
            local money = vRP.getMoney(uid) or 0
            print(("[DEBUG] vRP.getMoney: %d"):format(money))
            return money 
        end
        if vRP.getWallet then 
            local money = vRP.getWallet(uid) or 0
            print(("[DEBUG] vRP.getWallet: %d"):format(money))
            return money 
        end
        print("[DEBUG] Nenhuma função de dinheiro encontrada no vRP")
        return 0
    end
end

-- Função para adicionar dinheiro em mãos
local function addMoney(uid, amount)
    if USE_MONEY_AS_ITEM then
        return vRP.giveInventoryItem(uid, MONEY_ITEM_NAME, amount, true)
    else
        if vRP.giveMoney then return vRP.giveMoney(uid, amount) end
        if vRP.addWallet then return vRP.addWallet(uid, amount) end
        return false
    end
end

-- Função para remover dinheiro em mãos
local function removeMoney(uid, amount)
    if USE_MONEY_AS_ITEM then
        return vRP.tryGetInventoryItem(uid, MONEY_ITEM_NAME, amount, true)
    else
        if vRP.tryPayment then return vRP.tryPayment(uid, amount) end
        if vRP.tryWithdrawWallet then return vRP.tryWithdrawWallet(uid, amount) end
        return false
    end
end

function GetMoney(source, currency)
    local uid = vRP.getUserId(source)
    print(("[DEBUG] GetMoney chamado - Source: %d, UID: %s"):format(source, tostring(uid)))
    if not uid then 
        print("[DEBUG] UID não encontrado, retornando 0")
        return 0 
    end
    
    -- DEBUG: Lista todos os itens do inventário
    if vRP.getInventory then
        local inventory = vRP.getInventory(uid)
        print("[DEBUG] Inventário completo:")
        for itemName, amount in pairs(inventory or {}) do
            local amt = amount
            if type(amount) == "table" then amt = amount[1] end
            print(("  - %s: %s"):format(itemName, tostring(amt)))
        end
    end
    
    local money = math.floor(getMoney(uid))
    print(("[DEBUG] Dinheiro obtido: %d"):format(money))
    TriggerClientEvent("pickle_casinos:updateMoney", source, money)
    return money
end

function AddMoney(source, amount, currency)
    amount = tonumber(amount) or 0
    if amount <= 0 then return true end
    local uid = vRP.getUserId(source); if not uid then return false end

    local success = addMoney(uid, amount)
    if success then
        local newMoney = getMoney(uid)
        TriggerClientEvent("pickle_casinos:updateMoney", source, newMoney)
        return true
    end
    return false
end

function RemoveMoney(source, amount, currency)
    amount = tonumber(amount) or 0
    if amount <= 0 then return true end
    local uid = vRP.getUserId(source); if not uid then return false end

    local success = removeMoney(uid, amount)
    if success then
        local newMoney = getMoney(uid)
        TriggerClientEvent("pickle_casinos:updateMoney", source, newMoney)
        return true
    end
    return false
end

-- =======================
--  Inventário (itens do bar/loja)
-- =======================
Inventory = Inventory or {}
Inventory.Items = Inventory.Items or {}
Inventory.Ready = true

Inventory.CanCarryItem = function(source, name, count)
    local uid = vRP.getUserId(source); if not uid then return false end
    if vRP.getInventoryWeight then
        local maxWeight = vRP.getInventoryMaxWeight and vRP.getInventoryMaxWeight(uid) or 100
        local currentWeight = vRP.getInventoryWeight(uid) or 0
        -- Assume peso de 1 por item se não houver função getItemWeight
        local itemWeight = 1
        if vRP.getItemWeight then
            itemWeight = vRP.getItemWeight(name) or 1
        end
        return (currentWeight + (itemWeight * count)) <= maxWeight
    end
    return true -- Se não houver sistema de peso, permite
end

Inventory.GetInventory = function(source)
    local uid = vRP.getUserId(source); if not uid then return {} end
    local items = {}
    if vRP.getInventory then
        local data = vRP.getInventory(uid)
        if data then
            for k, v in pairs(data) do
                local amount = v.amount or v
                if type(amount) == "table" then amount = amount[1] end
                if tonumber(amount) and tonumber(amount) > 0 then
                    items[#items + 1] = {
                        name = k,
                        label = k, -- vRP geralmente não tem labels, usa o nome do item
                        count = tonumber(amount),
                        weight = 1
                    }
                end
            end
        end
    end
    return items
end

Inventory.UpdateInventory = function(source)
    SetTimeout(1000, function()
        TriggerClientEvent("pickle_casinos:updateInventory", source, Inventory.GetInventory(source))
    end)
end

function GetItemCount(source, item)
    local uid = vRP.getUserId(source); if not uid then return 0 end
    local amt = vRP.getInventoryItemAmount(uid, item)
    if type(amt) == "table" then amt = amt[1] end
    return tonumber(amt) or 0
end

Inventory.GetItemCount = GetItemCount

function AddItem(source, item, amount)
    local uid = vRP.getUserId(source); if not uid then return false end
    amount = tonumber(amount) or 1
    print(item)
    local success = vRP.giveInventoryItem(uid, item, amount, true)
    if success then
        Inventory.UpdateInventory(source)
    end
    return success
end

Inventory.AddItem = AddItem

function RemoveItem(source, item, amount)
    local uid = vRP.getUserId(source); if not uid then return false end
    amount = tonumber(amount) or 1
    local success = vRP.tryGetInventoryItem(uid, item, amount, true)
    if success then
        Inventory.UpdateInventory(source)
    end
    return success
end

Inventory.RemoveItem = RemoveItem

Inventory.AddWeapon = function(source, name, count, metadata)
    -- No vRP, armas geralmente são itens normais no inventário
    Inventory.AddItem(source, name, count or 1)
end

Inventory.RemoveWeapon = function(source, name, count)
    -- No vRP, armas geralmente são itens normais no inventário
    Inventory.RemoveItem(source, name, count or 1)
end

function Inventory.HasWeapon(source, name, count)
    return GetItemCount(source, name) > 0
end

RegisterCallback("pickle_casinos:getInventory", function(source, cb)
    cb(Inventory.GetInventory(source))
end)

-- =======================
--  Job / Permissões
-- =======================
function GetPlayerJob(source)
    local uid = vRP.getUserId(source)
    if not uid or not vRP.getUserGroupByType then return "citizen", "0" end
    local job = vRP.getUserGroupByType(uid,"job") or "citizen"
    return job, "0"
end

-- =======================
--  Veículos (prémios)
-- =======================
function GetOwnedVehicleFromPlate(plate)
    local row = MySQL.Sync.fetchAll(
        "SELECT user_id FROM vehicles WHERE plate = @plate LIMIT 1",
        {["@plate"]=plate}
    )[1]
    return row and { owner = row.user_id } or nil
end

function AddOwnedVehicle(source, model)
    local uid = vRP.getUserId(source); if not uid then return false end
    local plate = (vRP.generatePlate and vRP.generatePlate()) or ("CAS"..math.random(1000,9999))
    MySQL.Async.execute(
        "INSERT IGNORE INTO vehicles(user_id,vehicle,plate,work,tax) VALUES(@uid,@veh,@plate,'false',UNIX_TIMESTAMP()+604800)",
        {["@uid"]=uid, ["@veh"]=model, ["@plate"]=plate}
    )
    return true, plate
end

function UpdateVehiclePlate(source, plate, newPlate)
    local uid = vRP.getUserId(source); if not uid then return end
    MySQL.Async.execute(
        "UPDATE vehicles SET plate = @new WHERE user_id = @uid AND plate = @old",
        {["@uid"]=uid, ["@old"]=plate, ["@new"]=newPlate}
    )
end

