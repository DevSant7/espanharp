local Portas = {} 
--- FUNCOES DO SERVIDOR (API)
-----------------------------------------------------------------------------------------------------------------------------------------
function src.Permission(doorId)
  local source = source
  local userId = vRP.getUserId(source)

  if not userId then
    return
  end

  if not Portas[doorId] then
    return
  end

  local porta = Portas[doorId]
  local temPermissao = false

  if type(porta["perm"]) == "table" then
    for _, permName in ipairs(porta["perm"]) do
      if vRP.hasPermission(userId, permName) or vRP.hasPermission(userId, "Rm") then
        temPermissao = true
        break
      end
    end
  else
    if porta["perm"] and vRP.hasPermission(userId, porta["perm"]) or vRP.hasPermission(userId, "Rm") then
      temPermissao = true
    end
  end

  if temPermissao then
    porta["lock"] = not porta["lock"] 

    exports.oxmysql:query("UPDATE doors SET config = ? WHERE id = ?", {json.encode(porta), doorId}, function(result) 
      if not (result and result.affectedRows and result.affectedRows > 0) then 
      end
    end)
  
    TriggerClientEvent("doors:updateState", -1, doorId, porta["lock"])

    if porta["other"] and porta["other"] ~= 0 and Portas[porta["other"]] then
      local SecondDoorId = porta["other"]
      local secondPorta = Portas[SecondDoorId]

      secondPorta["lock"] = not secondPorta["lock"]
      exports.oxmysql:query("UPDATE doors SET config = ? WHERE id = ?", {json.encode(secondPorta), SecondDoorId}, function(result) 
        if not (result and result.affectedRows and result.affectedRows > 0) then 
        end
      end)

      TriggerClientEvent("doors:updateState", -1, SecondDoorId, secondPorta["lock"])
    end

    vRPC.playAnim(source, true, { "anim@heists@keycard@", "exit" }, false)
    Citizen.Wait(350)
    vRPC.stopAnim(source)

    return true 
  end
end

RegisterNetEvent("serverAPI:toggleDoorLock", function(doorId)
  src.Permission(doorId)
end)

--- COMANDOS DO SERVIDOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addtrancas", function(source, args, rawCommand)
  local userId = vRP.getUserId(source)
  if not userId or not vRP.hasPermission(userId, "Admin") then
    return
  end

  TriggerClientEvent("client:requestRayCastDoor", source)
  TriggerClientEvent("Notify", source, "azul", "Mire na porta. Clique ESQUERDO para selecionar. Clique DIREITO ou ESC para cancelar.", 8000)
end)

RegisterNetEvent("server:receiveRayCastDoorResult", function(responseDoors)
  local source = source
  local userId = vRP.getUserId(source)

  if not userId then return end

  if not responseDoors then
    TriggerClientEvent("Notify", source, "vermelho", "Selecao de porta cancelada ou falha na detecao.", 5000)
    return
  end

  local config1 = vRP.prompt(source, "Permissao (ex: 'policia' ou 'admin', deixe vazio para sem permissao):", "")
  local config2 = vRP.prompt(source, "Distancia de interacao (numero, ex: 5.0):", "")

  if not config1 or not config2 then
    TriggerClientEvent("Notify", source, "vermelho", "Configuracao de porta cancelada.", 5000)
    return
  end

  local distance = tonumber(config2) or 5.0
  local permission = config1 ~= "" and config1 or nil

  local function setupDoorTable(doorHash, coords, otherDoorId, entityId)
    return {
      hash = doorHash,
      lock = true,   
      text = true,
      distance = distance,
      press = 5,
      perm = permission,
      other = otherDoorId ~= 0 and otherDoorId or nil,
      x = tonumber(coords.x),
      y = tonumber(coords.y),
      z = tonumber(coords.z),
      entity = entityId 
    }
  end

  if not responseDoors.doorA then
    local result = exports.oxmysql:query_async("INSERT INTO doors (config) VALUES (@config)", { config = "{}" })

    if result.insertId then
      Portas[result.insertId] = setupDoorTable(responseDoors.hash, responseDoors.coords, 0, responseDoors.entity)
      exports.oxmysql:query("UPDATE doors SET config = ? WHERE id = ?", {json.encode(Portas[result.insertId]), result.insertId})
      TriggerClientEvent("doors:updateState", -1, result.insertId, Portas[result.insertId]["lock"], Portas[result.insertId])
      TriggerClientEvent("Notify", source, "verde", "Tranca de porta unica adicionada com sucesso. ID: " .. result.insertId, 5000)
    else
      TriggerClientEvent("Notify", source, "vermelho", "Erro ao adicionar tranca no banco de dados.", 5000)
    end
  else
    local queryA = exports.oxmysql:query_async("INSERT INTO doors (config) VALUES (@config)", { config = "{}" })
    if queryA.insertId then
      local queryB = exports.oxmysql:query_async("INSERT INTO doors (config) VALUES (@config)", { config = "{}" })
      if queryB.insertId then
        Portas[queryA.insertId] = setupDoorTable(responseDoors.doorA.hash, responseDoors.doorA.coords, queryB.insertId, responseDoors.doorA.entity)
        Portas[queryB.insertId] = setupDoorTable(responseDoors.doorB.hash, responseDoors.doorB.coords, queryA.insertId, responseDoors.doorB.entity)

        exports.oxmysql:query("UPDATE doors SET config = ? WHERE id = ?", {json.encode(Portas[queryA.insertId]), queryA.insertId})
        exports.oxmysql:query("UPDATE doors SET config = ? WHERE id = ?", {json.encode(Portas[queryB.insertId]), queryB.insertId})

        TriggerClientEvent("doors:updateState", -1, queryA.insertId, Portas[queryA.insertId]["lock"], Portas[queryA.insertId])
        TriggerClientEvent("doors:updateState", -1, queryB.insertId, Portas[queryB.insertId]["lock"], Portas[queryB.insertId])
        TriggerClientEvent("Notify", source, "verde", "Tranca de porta dupla adicionada com sucesso. IDs: " .. queryA.insertId .. " e " .. queryB.insertId, 5000)
      else
        TriggerClientEvent("Notify", source, "vermelho", "Erro ao adicionar a segunda tranca no banco de dados.", 5000)
        exports.oxmysql:query("DELETE FROM doors WHERE id = ?", {queryA.insertId})
      end
    else
      TriggerClientEvent("Notify", source, "vermelho", "Erro ao adicionar a primeira tranca no banco de dados.", 5000)
    end
  end
end)

RegisterCommand("deltrancas", function(source, args, rawCommand)
  local userId = vRP.getUserId(source)
  if not userId or not vRP.hasPermission(userId, "Admin") then
    return
  end

  local doorId = tonumber(args[1])
  if not doorId or not Portas[doorId] then
    TriggerClientEvent("Notify", source, "vermelho", "Uso: /deltrancas [ID da porta]", 5000)
    return
  end

  local portaParaRemover = Portas[doorId]

  exports.oxmysql:query("DELETE FROM doors WHERE id = ?", {doorId})

  if portaParaRemover.other and Portas[portaParaRemover.other] then
    local otherDoorId = portaParaRemover.other
    exports.oxmysql:query("DELETE FROM doors WHERE id = ?", {otherDoorId})
    Portas[otherDoorId] = nil
    TriggerClientEvent("doors:remove", -1, otherDoorId)
  end

  Portas[doorId] = nil

  TriggerClientEvent("doors:remove", -1, doorId)
  TriggerClientEvent("Notify", source, "verde", "Tranca " .. doorId .. " removida com sucesso.", 5000)
end)

--- SINCRONIZACAO INICIAL E AO CONECTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local function CarregarPortasDoDB()
  local DoorsConsult = exports.oxmysql:query_async("SELECT * FROM doors")
  local contadorPortas = 0
  Portas = {} 

  if DoorsConsult then
    for _, v in pairs(DoorsConsult) do
      if v.config ~= "{}" then
        local decodedConfig = json.decode(v.config)
        if decodedConfig then
          Portas[v.id] = decodedConfig
          contadorPortas = contadorPortas + 1
        end
      end
    end
  end
  return contadorPortas
end

Citizen.CreateThread(function()
  Citizen.Wait(1000) 
  
  local numPortas = CarregarPortasDoDB()

  TriggerClientEvent("doors:fullSync", -1, Portas) 
  print("[Portas Servidor] Sistema de portas carregado e sincronizado com " .. numPortas .. " portas.")
end)


RegisterServerEvent("doors:requestSync")
AddEventHandler("doors:requestSync", function()
  local source = source
  TriggerClientEvent("doors:fullSync", source, Portas)
end)