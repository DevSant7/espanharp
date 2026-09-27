local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vFunc = {}
Tunnel.bindInterface("fortal-dealership-server", vFunc)

-- Test Drive Storage
local TestDriveVehicles = {}
local TestDriveTimers = {}

-- Cache de veículos para melhor performance
local VehiclesCache = {}
local CacheTime = {}
local CACHE_DURATION = 300000 -- 5 minutos

-- Variável para armazenar o tipo de concessionária por jogador
local PlayerDealershipType = {}

-- Função para formatar números
local function formatNumber(value)
    if not value or type(value) ~= "number" then
        return "0"
    end
    
    local formatted = tostring(value)
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
        if k == 0 then
            break
        end
    end
    return formatted
end

vRP.prepare("dealership/CreateTable", [[
  CREATE TABLE IF NOT EXISTS `dealership` (
  `id` int NOT NULL AUTO_INCREMENT,
  `spawn` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `stock` int DEFAULT '25',
  PRIMARY KEY (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
]])
vRP.prepare("dealership/SelectVehicle", "SELECT * FROM dealership WHERE spawn = @spawn")
vRP.prepare("dealership/SelectAllVehicles", "SELECT * FROM dealership")
vRP.prepare("dealership/InsertVehicle", "INSERT INTO dealership(spawn, stock) VALUES(@spawn, @stock)")
vRP.prepare("dealership/SetVehicleStock", "UPDATE dealership SET stock = @stock WHERE spawn = @spawn")
vRP.prepare("vehicles/selectExpired", [[
	SELECT * FROM vehicles WHERE vip_expiry > 0 AND vip_expiry <= @current
]])

vRP.prepare("vehicles/removeVehicles2", [[
	DELETE FROM vehicles WHERE user_id = @user_id AND vehicle = @vehicle
]])


vRP.prepare("vehicles/addVehicles2", [[
	INSERT INTO vehicles(user_id, vehicle,tax, plate, work, vip_expiry)
	VALUES(@user_id, @vehicle,@tax, @plate, @work, @vip_expiry)
]])



CreateThread(function()
	while true do
		local expired = vRP.query("vehicles/selectExpired", { current = os.time() })

		for _, v in pairs(expired) do
			vRP.execute("vehicles/removeVehicles2", {
				user_id = v.user_id,
				vehicle = v.vehicle
			})

			local source = vRP.getUserSource(v.user_id)
			if source then
				TriggerClientEvent("Notify", source, "aviso", "Seu veículo VIP '"..v.vehicle.."' expirou e foi removido.")
			end
		end

		Wait(600000) 
	end
end)

local CategorysMaxTrunks = {}

function DeepCopy(original)
  local originalType = type(original)
  local copy

  if originalType == 'table' then
      copy = {}
      for originialKey, originalValue in next, original, nil do
          copy[DeepCopy(originialKey)] = DeepCopy(originalValue)
      end
      setmetatable(copy, DeepCopy(getmetatable(original)))
  else
      copy = original
  end

  return copy
end

-- Função para limpar completamente o test drive de um usuário
local function ClearTestDrive(userId)
    if TestDriveVehicles[userId] then
        local playerSource = TestDriveVehicles[userId].source
        
        -- Clear timer if exists
        if TestDriveTimers[userId] then
            ClearTimeout(TestDriveTimers[userId])
            TestDriveTimers[userId] = nil
        end

        -- Clear test drive data
        TestDriveVehicles[userId] = nil
        
        return playerSource
    end
    return nil
end

vFunc.GetPlayerInfos = function()
  local playerSource = source
  local userId = vRP.getUserId(playerSource)

  if userId then
      local userIdentity = vRP.userIdentity(userId)
      local userBank = vRP.getBank(userId)
      local userDiamonds = vRP.userGemstone(userId)
      local userVehicles = vRP.query("vehicles/getVehicles", { user_id = userId })

      return {
          balance = userBank,
          diamonds = userDiamonds,
          vehicles = { #userVehicles, userIdentity.garage }
      }
  end

  return nil
end

vFunc.SetDealershipType = function(dealershipType)
  local playerSource = source
  PlayerDealershipType[playerSource] = dealershipType
end

vFunc.GetDealershipType = function()
  local playerSource = source
  return PlayerDealershipType[playerSource] or "normal"
end

vFunc.GetVehicleTypes = function()
  local playerSource = source
  local dealershipType = PlayerDealershipType[playerSource] or "normal"
  
  -- Retornar apenas as categorias permitidas para este tipo de concessionária
  return Config.DealershipTypes[dealershipType] or Config.DealershipTypes.normal
end

vFunc.GetVehicles = function(category)
  local playerSource = source
  local dealershipType = PlayerDealershipType[playerSource] or "normal"
  
  -- Verificar se a categoria é permitida para este tipo de concessionária
  local allowedCategories = Config.DealershipTypes[dealershipType] or Config.DealershipTypes.normal
  local categoryAllowed = false
  
  for _, allowedCategory in pairs(allowedCategories) do
      if allowedCategory == category then
          categoryAllowed = true
          break
      end
  end
  
  -- Se categoria não permitida, usar a primeira categoria permitida
  if not categoryAllowed then
      if dealershipType == "vip" then
          category = allowedCategories[1] or "blindado"
      else
          category = allowedCategories[1] or "comum"
      end
  end
  
  -- Verificar cache por categoria e tipo de concessionária
  local currentTime = GetGameTimer()
  local cacheKey = dealershipType .. "_" .. category
  
  if not VehiclesCache[cacheKey] then
      VehiclesCache[cacheKey] = nil
      CacheTime[cacheKey] = 0
  end
  
  if VehiclesCache[cacheKey] and (currentTime - CacheTime[cacheKey]) < CACHE_DURATION then
      return VehiclesCache[cacheKey]
  end

  local query = vRP.query("dealership/SelectAllVehicles")
  local stocks = {}
  local vehicles = {}

  -- Organizar stocks do banco
  for _, vehicle in pairs(query) do
      stocks[vehicle.spawn] = vehicle.stock
  end

  -- Processar apenas veículos da categoria selecionada
  for id, vehicle in pairs(Config.Vehicles) do
      if vehicle.section == category then
          local vehicleStock = stocks[vehicle.spawn] or Config.DefaultStock
          
          local data = DeepCopy(vehicle)
          data.id = id
          data.stock = vehicleStock
          data.image = Config.Images..vehicle.spawn..".png"

          -- Usar stats da config ou padrão baseado na categoria
          if not data.stats then
              data.stats = {}
          end
          
          if not data.stats.trunk then
              -- Definir trunk padrão baseado na categoria
              if vehicle.section == "motos" or vehicle.section == "MOTOS" then
                  data.stats.trunk = {15, 30}
              elseif vehicle.section == "super" then
                  data.stats.trunk = {20, 40}
              elseif vehicle.section == "blindados" or vehicle.section == "blindado" then
                  data.stats.trunk = {40, 80}
              elseif vehicle.section == "SUV" then
                  data.stats.trunk = {80, 160}
              else -- comum e classes VIP
                  data.stats.trunk = {35, 70}
              end
          end

          -- Adicionar trunk dinâmico se a função existir
          if vehicleChest then
              local success, dynamicTrunk = pcall(vehicleChest, vehicle.spawn)
              if success and dynamicTrunk and dynamicTrunk > 0 then
                  data.stats.trunk[1] = dynamicTrunk
                  if CategorysMaxTrunks[data.section] and dynamicTrunk > CategorysMaxTrunks[data.section] then
                      data.stats.trunk[2] = CategorysMaxTrunks[data.section]
                  else
                      data.stats.trunk[2] = math.max(data.stats.trunk[2], dynamicTrunk)
                  end
              end
          end

          table.insert(vehicles, data)
      end
  end

  -- Atualizar cache para esta categoria e tipo de concessionária
  VehiclesCache[cacheKey] = vehicles
  CacheTime[cacheKey] = currentTime

  return vehicles
end

vFunc.GetVehiclesByCategories = function(categories)
  local allVehicles = {}
  
  for _, category in pairs(categories) do
      local categoryVehicles = vFunc.GetVehicles(category)
      for _, vehicle in pairs(categoryVehicles) do
          table.insert(allVehicles, vehicle)
      end
  end
  
  return allVehicles
end

vFunc.StartTestDrive = function(vehicleSpawn, vehicleName)
    local playerSource = source
    local userId = vRP.getUserId(playerSource)
    local dealershipType = PlayerDealershipType[playerSource] or "normal"

    if userId and vehicleSpawn then
        -- Check if player is already in test drive
        if TestDriveVehicles[userId] then
            TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Negado", "Você já está em um test drive. Finalize o atual primeiro.", 5000)
            return false
        end

        -- Find vehicle data
        local vehicleData = nil
        for k,v in pairs(Config.Vehicles) do
            if v.spawn == vehicleSpawn then
                vehicleData = v
                break
            end
        end

        if vehicleData then
            -- Store test drive info with server start time
            TestDriveVehicles[userId] = {
                spawn = vehicleSpawn,
                name = vehicleName,
                source = playerSource,
                dealershipType = dealershipType,
                vehicleSection = vehicleData.section,
                startTime = GetGameTimer(),
                duration = Config.TestDrive.Duration
            }

            -- Start test drive on client
            TriggerClientEvent("fortal-dealership:Client:StartTestDrive", playerSource, vehicleSpawn, vehicleData, vehicleName, Config.TestDrive.Duration)
            
            -- Determinar tipo baseado na categoria do veículo
            local vipCategories = {"blindado", "CLASSE S+", "CLASSE S", "CLASSE A", "CLASSE B", "CLASSE C", "CLASSE D", "MOTOS", "SUV"}
            local isVipCategory = false
            
            for _, vipCat in pairs(vipCategories) do
                if vehicleData.section == vipCat then
                    isVipCategory = true
                    break
                end
            end
            
            local dealershipTypeText = isVipCategory and "VIP" or "normal"
            TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Test Drive", "Test drive "..dealershipTypeText.." do <b>"..vehicleName.."</b> iniciado! Você tem "..Config.TestDrive.Duration.." segundos.", 5000)

            -- Set timer to end test drive
            TestDriveTimers[userId] = SetTimeout(Config.TestDrive.Duration * 1000, function()
                vFunc.EndTestDrive(userId)
            end)

            return true
        end
    end

    return false
end

vFunc.EndTestDrive = function(userId)
    local playerSource = ClearTestDrive(userId)
    
    if playerSource then
        local vehicleName = TestDriveVehicles[userId] and TestDriveVehicles[userId].name or "veículo"

        -- End test drive on client
        TriggerClientEvent("fortal-dealership:Client:EndTestDrive", playerSource)
        TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Test Drive", "Test drive finalizado!", 5000)

        return true
    end

    return false
end

-- Função para forçar o fim do test drive (chamada pelo cliente)
vFunc.ForceEndTestDrive = function()
    local playerSource = source
    local userId = vRP.getUserId(playerSource)
    
    if userId and TestDriveVehicles[userId] then
        return vFunc.EndTestDrive(userId)
    end
    
    return false
end

-- Função para verificar se o jogador está em test drive
vFunc.IsInTestDrive = function()
    local playerSource = source
    local userId = vRP.getUserId(playerSource)
    
    if userId and TestDriveVehicles[userId] then
        return true
    end
    
    return false
end

-- Função para obter o tempo restante do test drive
vFunc.GetTestDriveTimeRemaining = function()
    local playerSource = source
    local userId = vRP.getUserId(playerSource)
    
    if userId and TestDriveVehicles[userId] then
        local testDriveData = TestDriveVehicles[userId]
        local currentTime = GetGameTimer()
        local elapsedTime = math.floor((currentTime - testDriveData.startTime) / 1000)
        local timeRemaining = math.max(0, testDriveData.duration - elapsedTime)
        
        return {
            timeRemaining = timeRemaining,
            vehicleName = testDriveData.name,
            dealershipType = testDriveData.dealershipType
        }
    end
    
    return nil
end

-- Função para obter lista de players em test drive
vFunc.GetTestDrivePlayers = function()
    local testDrivePlayers = {}
    for userId, data in pairs(TestDriveVehicles) do
        table.insert(testDrivePlayers, data.source)
    end
    return testDrivePlayers
end

vFunc.BuyVehicle = function(vehicleSpawn, currency, colors)
    local playerSource = source
    local userId = vRP.getUserId(playerSource)

    if userId and vehicleSpawn then
        local query = vRP.query("dealership/SelectVehicle", { spawn = vehicleSpawn })

        if query[1] then
            local vehicleData = nil

            for k, v in pairs(Config.Vehicles) do
                if v.spawn == vehicleSpawn then
                    vehicleData = v
                    break
                end
            end

            if vehicleData then            
                if query[1].stock > 0 then

                    -- VERIFICAR SE JÁ TEM O VEÍCULO
                    local alreadyHasVehicle = vRP.query("vehicles/selectVehicles", { user_id = userId, vehicle = vehicleSpawn })
                    if alreadyHasVehicle and alreadyHasVehicle[1] then
                        TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Negado", "Você já possui o veículo <b>"..vehicleData.name.."</b> na sua garagem.", 5000)
                        return false
                    end

                    -- VERIFICAR LIMITE DA GARAGEM
                    local allVehicles = vRP.query("vehicles/getVehicles", { user_id = userId })
                    local totalVehicles = 0
                    for _, v in pairs(allVehicles) do
                        if v.work ~= "true" then
                            totalVehicles = totalVehicles + 1
                        end
                    end

                    local identity = vRP.userIdentity(userId)
                    if identity and totalVehicles >= identity.garage then
                        TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Negado", "Você atingiu o limite de veículos na sua garagem.", 5000)
                        return false
                    end

                    -- CONTINUAR COM O PROCESSO NORMAL DE COMPRA
                    local price = 0
                    local currencyText = ""
                    local confirmMessage = ""
                    local dealershipType = PlayerDealershipType[playerSource] or "normal"

                    if dealershipType == "vip" then
                        price = vehicleData.price or 0
                        currencyText = "gemas"
                        confirmMessage = "Comprar o veículo <b>"..(vehicleData.name or "Desconhecido").."</b> por <b>"..formatNumber(price).."</b> "..currencyText.."?"
                        currency = "diamonds"
                    else
                        if type(vehicleData.price) == "table" then
                            price = vehicleData.price[1] or 0
                        else
                            price = vehicleData.price or 0
                        end
                        currencyText = "dólares"
                        confirmMessage = "Comprar o veículo <b>"..(vehicleData.name or "Desconhecido").."</b> por <b>$"..formatNumber(price).."</b> "..currencyText.."?"
                        currency = "money"
                    end

                    if price <= 0 then
                        TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Erro", "Preço do veículo inválido.", 5000)
                        return false
                    end

                    TriggerClientEvent("fortal-dealership:Client:Close", playerSource)

                    if vRP.request(playerSource, confirmMessage, "Comprar") then
                        local response = false

                        if currency == "money" then
                            response = vRP.paymentFull(userId, price)
                        else
                            response = vRP.paymentGems(userId, price)
                        end

                        if response then
                            local plate = vRP.generatePlate()
                            local isVip = false
                            local vipCategories = {"blindado", "CLASSE S+", "CLASSE S", "CLASSE A", "CLASSE B", "CLASSE C", "CLASSE D", "MOTOS", "SUV"}

                            for _, cat in pairs(vipCategories) do
                                if vehicleData.section == cat then
                                    isVip = true
                                    break
                                end
                            end

                            local arrestValue = 0
                            if isVip then
                                arrestValue = os.time() + (30 * 24 * 60 * 60)
                            end

                            vRP.execute("vehicles/addVehicles2", {
                                user_id = userId,
                                vehicle = vehicleSpawn,
                                tax = os.time() + 604800,
                                plate = plate,
                                work = "false",
                                vip_expiry = isVip and os.time() + (30 * 24 * 60 * 60) or 0
                            })

                            vRP.execute("dealership/SetVehicleStock", { spawn = vehicleSpawn, stock = (query[1].stock - 1) })

                            TriggerClientEvent("Notify", playerSource, "verde", "Sucesso", "Você adquiriu o veículo <b>"..(vehicleData.name or "Desconhecido").."</b> com sucesso!", 5000)
                            TriggerClientEvent("fortal-dealership:Client:Update", playerSource)

                            VehiclesCache = {}

                            if colors then
                                local mods = { colors = colors, extracolors = {} }
                                vRP.execute("entitydata/setData",{ dkey = "custom:"..userId..":"..vehicleSpawn, value = json.encode(mods) })
                            end 

                            -- LOG WEBHOOK
                            local logWebhook = isVip and Config.Webhooks.VehiclesVip or Config.Webhooks.VehiclesNormal
                            local logMsg = {
                                username = "Concessionária",
                                embeds = {{
                                    title = "Esse jogador comprou um veículo na Concessionária",
                                    color = 0,
                                    fields = {
                                        {
                                            name = "👤 Jogador",
                                            value = "```" .. identity.name .. " " .. identity.name2 .. " (" .. userId .. ")```",
                                            inline = true
                                        },
                                        {
                                            name = "🚗 Veículo",
                                            value = "```" .. (vehicleData.name or vehicleSpawn) .. "```",
                                            inline = true
                                        },
                                        {
                                            name = "💰 Preço",
                                            value = "```" .. formatNumber(price) .. " " .. currencyText .. "```",
                                            inline = true
                                        }
                                    },
                                    footer = {
                                        text = os.date("%d/%m/%Y • %H:%M:%S")
                                    }
                                }}
                            }
                            PerformHttpRequest(logWebhook, function() end, "POST", json.encode(logMsg), {["Content-Type"] = "application/json"})

                            return true
                        else
                            TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Negado", "Você não possui <b>"..currencyText.."</b> suficientes.", 5000)
                        end
                    else
                        TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Cancelado", "Compra cancelada.", 3000)
                    end

                    SetTimeout(1000, function()
                        TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Concessionária", "Use /dealership para reabrir a concessionária.", 5000)
                    end)
                else
                    TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Negado", "Não há mais estoque do veículo "..(vehicleData.name or "desconhecido").." na concessionária.", 5000)
                end
            end
        end
    end

    return false
end



vFunc.CheckStock = function(vehicleSpawn, vehicleName)
  local playerSource = source
  local query = vRP.query("dealership/SelectVehicle", { spawn = vehicleSpawn })

  if query and query[1] then
      if query[1].stock > 0 then
          return true
      else
          TriggerClientEvent("fortal-dealership:Client:Notify", playerSource, "Negado", "Não há mais estoque do veículo "..(vehicleName or "desconhecido").." na concessionária.", 5000)
      end
  end

  return false
end

-- Event to handle player disconnect during test drive
AddEventHandler("vRP:playerLeave", function(userId, playerSource)
  if TestDriveVehicles[userId] then
      ClearTestDrive(userId)
  end
  
  -- Limpar tipo de concessionária do jogador
  PlayerDealershipType[playerSource] = nil
end)

-- Cleanup test drives that are too old (safety measure)
CreateThread(function()
    while true do
        Wait(30000) -- Check every 30 seconds
        
        local currentTime = GetGameTimer()
        for userId, testDriveData in pairs(TestDriveVehicles) do
            if testDriveData.startTime and testDriveData.duration then
                local elapsedTime = math.floor((currentTime - testDriveData.startTime) / 1000)
                if elapsedTime > (testDriveData.duration + 60) then -- 60 segundos de margem
                    ClearTestDrive(userId)
                    
                    -- Notify client to clean up as well
                    if testDriveData.source then
                        TriggerClientEvent("fortal-dealership:Client:EndTestDrive", testDriveData.source)
                    end
                end
            end
        end
    end
end)

CreateThread(function()
  vRP.execute("dealership/CreateTable")
  
  local query = vRP.query("dealership/SelectAllVehicles")
  local data = {}

  for _, vehicle in pairs(query) do
      data[vehicle.spawn] = true
  end

  for _, vehicle in pairs(Config.Vehicles) do
      if not data[vehicle.spawn] then
          vRP.execute("dealership/InsertVehicle", { spawn = vehicle.spawn, stock = Config.DefaultStock })
      end
  end
end)

CreateThread(function()
  for _,category in ipairs(Config.Types) do
      CategorysMaxTrunks[category] = 0
  end

  for _, vehicle in ipairs(Config.Vehicles) do
      if CategorysMaxTrunks[vehicle.section] then
          -- Tentar usar função dinâmica primeiro
          local vehicleTrunk = 0
          if vehicleChest then
              local success, result = pcall(vehicleChest, vehicle.spawn)
              if success and result then
                  vehicleTrunk = result
              end
          end
          
          -- Se não conseguir valor dinâmico, usar da config ou padrão
          if vehicleTrunk == 0 then
              if vehicle.stats and vehicle.stats.trunk and vehicle.stats.trunk[1] then
                  vehicleTrunk = vehicle.stats.trunk[1]
              else
                  -- Padrão baseado na categoria
                  if vehicle.section == "motos" or vehicle.section == "MOTOS" then
                      vehicleTrunk = 15
                  elseif vehicle.section == "super" then
                      vehicleTrunk = 20
                  elseif vehicle.section == "blindados" or vehicle.section == "blindado" then
                      vehicleTrunk = 40
                  elseif vehicle.section == "SUV" then
                      vehicleTrunk = 80
                  else -- comum e classes VIP
                      vehicleTrunk = 35
                  end
              end
          end
          
          if vehicleTrunk > CategorysMaxTrunks[vehicle.section] then
              CategorysMaxTrunks[vehicle.section] = vehicleTrunk
          end
      end
  end
end)
