Commands = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA DAR UM ITEM A TODOS OS JOGADORES
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["itemall"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        if args[1] and args[2] then 
            local users = vRP.getPlayersOn() 
            for k,_ in pairs(users) do 
                vRP.generateItem(k,args[1],args[2],true)
            end 
        end 
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA CHECAR OS GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["vgroups"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        if args[1] then
            local Result = ""
            local Groups = vRP.Groups()
            local OtherPassport = args[1]
            for Permission, _ in pairs(Groups) do
                local Data = vRP.DataGroups(Permission)
                if Data[OtherPassport] then
                    Result = Result .. "\n Permissão: " .. Permission .. " Nível: " .. Data[OtherPassport] .. ""
                end
            end

            if Result ~= "" then
                TriggerClientEvent("Notify", source, "verde", "Sucesso", "O jogador tem os seguintes grupos: " .. Result,10000)
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDO PARA PUXAR TODOS OS JOGADORES PARA VOCÊ
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["tpall"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local playerPed = GetPlayerPed(source)
        local playerPedCoords = GetEntityCoords(playerPed)
        local users = vRP.getPlayersOn()

        for k, v in pairs(users) do
            if v ~= source then 
                local nped = GetPlayerPed(v)

                if nped and DoesEntityExist(nped) then
                    SetEntityCoords(nped, playerPedCoords)
                    Wait(500)
                end
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEM
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["gem"] = {
    ["permissions"] = { "Owner", },
    callback = function(source, args)
        local ID = parseInt(args[1])
        local Amount = parseInt(args[2])
        local identity = vRP.userIdentity(ID)
        if identity then
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "Gemas adicionadas.",
                10000)
            vRP.execute("accounts/infosUpdategems", { steam = identity["steam"], gems = Amount })
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO PREFEITURA
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["anunciar"] = {
    ["permissions"] = { "Owner", "Admin", "Burguer" },
    callback = function(source, _)
        local message = vRP.prompt(source, "Mensagem:", "")
		if not message or message == "" then
			return
		end
		
		TriggerClientEvent("Notify2", -1, "prefeitura", "Mensagem enviada pela Prefeitura", message, 15000)
		TriggerClientEvent("sounds:source", -1, "notify2", 1)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGAR JOGADOR NO COLO
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["h"] = {
    ["permissions"] = { "Owner", "Admin" },
    callback = function(source, _)
        local otherPlayer = vRPC.nearestPlayer(source, 0.8)
        if otherPlayer then
            TriggerClientEvent("toggleCarry", otherPlayer, source)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNAR
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["tuning"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, _)
        TriggerClientEvent("admin:vehicleTuning", source)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAR INVENTARIO
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["limparinv"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args, _)
        local user_id = vRP.getUserId(source)

        if args[1] then
            local nuser_id = parseInt(args[1])
            vRP.clearInventory(nuser_id)
            TriggerClientEvent("Notify", source, "important", "Atenção", "Inventario limpo do id: " .. args[1],
                "amarelo", 5000)
            exports["config"]:SendLog("InvClear",user_id,nuser_id,{})
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISOMED
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["avisomed"] = {
    ["permissions"] = { "Admin", "Paramedic" },
    callback = function(source, _)
        local message = vRP.prompt(source, "Mensagem:", "")
        if message == "" then
            return
        end
        TriggerClientEvent("Notify2", -1, "medic", "Mensagem enviada pela Hospital", message, 15000)

        TriggerClientEvent("sounds:source", -1, "notification", 0.5)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO Pon
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["pon"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, _)
        local users = vRP.getPlayersOn()

        local players = ""
        local quantidade = 0
        for k, _ in pairs(users) do
            if (players == "") then
                players = players .. k
            else
                players = players .. ", " .. k
            end

            quantidade = quantidade + 1
        end
        TriggerClientEvent('Notify', source, 'verde', 'Sucesso',
            'Total onlines: ' .. quantidade .. ' IDs onlines: ' .. players, 5000)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["wl"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        vRP.execute("accounts/setwl", { id = tostring(args[1]), whitelist = 1 })
        TriggerClientEvent("Notify", source, "verde", "Sucesso", "Você aprovou o ID " .. args[1] .. ".", 5000)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["unwl"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        vRP.execute("accounts/setwl", { id = tostring(args[1]), whitelist = 0 })
        TriggerClientEvent("Notify", source, "verde", "Sucesso", "Você removeu o ID " .. args[1] .. ".", 5000)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["blips"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        vRPC.blipsAdmin(source)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD (CORRIGIDO: user_id agora é definido)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["god"] = {
    ["permissions"] = { "Admin", "Moderador" },
    callback = function(source, args, _)
        local user_id = vRP.getUserId(source)
        if user_id then
            if args[1] then
                local nuser_id = parseInt(args[1])
                local otherPlayer = vRP.userSource(nuser_id)
                if otherPlayer then
                    local ped = GetPlayerPed(otherPlayer)
                    local pedCoords = GetEntityCoords(ped)

                    vRP.upgradeThirst(nuser_id, 100)
                    vRP.upgradeHunger(nuser_id, 100)
                    vRP.downgradeStress(nuser_id, 100)
                    vSURVIVAL.revivePlayer(otherPlayer, 200)
                    TriggerClientEvent("resetBleeding", source)

                    exports["config"]:SendLog("God",user_id,nuser_id,{
                        Coords = pedCoords
                    })
                end
            else
                local ped = GetPlayerPed(source)
                local pedCoords = GetEntityCoords(ped)

                vSURVIVAL.revivePlayer(source, 200)
                vRP.upgradeThirst(user_id, 100)
                vRP.upgradeHunger(user_id, 100)
                vRP.downgradeStress(user_id, 100)
                TriggerClientEvent("resetBleeding", source)

                exports["config"]:SendLog("God",user_id,user_id,{
                    Coords = pedCoords
                })
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["priority"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local nuser_id = parseInt(args[1])
        local identity = vRP.userIdentity(nuser_id)
        if identity then
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "Prioridade adicionada.", 5000)
            vRP.execute("accounts/setPriority", { steam = identity["steam"], priority = 99 })
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["delete"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local nuser_id = parseInt(args[1])
        vRP.execute("characters/removeCharacters", { id = nuser_id })
        TriggerClientEvent("Notify", source, "verde", "Sucesso", "Personagem <b>" .. nuser_id .. "</b> deletado.", 5000)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["nc"] = {
    ["permissions"] = { "Admin", "Moderador", "Nc" },
    callback = function(source, _)
        local user_id = vRP.getUserId(source)
        local coords = GetEntityCoords(GetPlayerPed(source))
        vRPC.noClip(source)
        
        exports["config"]:SendLog("Noclip",user_id,nil,{
            Coords = coords 
        })
    end
} 

Commands["peso"] = {
    permissions = { "Admin" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        if user_id then
            local target_id = tonumber(args[1])
            local new_weight = tonumber(args[2])

            if target_id and new_weight then
                vRP.setWeight(target_id, new_weight)

                TriggerClientEvent("Notify", source, "sucesso", "Peso máximo do ID " .. target_id .. " foi definido para " .. new_weight .. ".")
            else
                TriggerClientEvent("Notify", source, "aviso", "Uso correto: /peso <id> <peso>")
            end
        end
    end
}

Commands["dm"] = {
    permissions = { "Admin", "Moderador" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        if user_id then
            if #args == 1 then
                local nuser_id = tonumber(args[1])
                local nsource = vRP.getUserSource(nuser_id)

                if nsource then
                    local identity = vRP.userIdentity(user_id)
                    local nidentity = vRP.userIdentity(nuser_id)

                    local resposta = vKEYBOARD.keyArea(source, "Mensagem a ser enviada:")
                    if not resposta then return end
                    resposta = resposta[1]

                    TriggerClientEvent("Notify", nsource, "aviso", "[ATENDIMENTO ADMIN] " .. identity["name"] .. " " .. identity["name2"] .. ": " .. resposta, 5000)
                else
                    TriggerClientEvent("Notify", source, "negado", "Usuário não está online.")
                end
            else
                TriggerClientEvent("Notify", source, "aviso", "Uso correto: /dm <id>")
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPECTATE
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["spectate"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, _)
        if Spectate then
            Spectate = false
            TriggerClientEvent("admin:resetSpectate", source)
            TriggerClientEvent("Notify", source, "amarelo", "Atenção", "Desativado.", 5000)
        else
            Spectate = true
            TriggerClientEvent("admin:initSpectate", source)
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "Ativado.", 5000)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK (CORRIGIDO: user_id agora é definido no callback)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["kick"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        TriggerClientEvent("Notify", source, "amarelo", "Atenção", "Passaporte <b>" .. args[1] .. "</b> expulso.", 5000)
        vRP.kick(args[1], "Expulso da cidade.")
    end
}

Commands["kick2"] = {
    ["permissions"] = { "Rm"},
    callback = function(source, args)
        TriggerClientEvent("Notify", source, "amarelo", "Atenção", "Passaporte <b>" .. args[1] .. "</b> expulso.", 5000)
        vRP.kick(args[1], args[2])
    end
}

Commands["pd"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        vRP.kick(parseInt(args[1]), "A historia do seu personagem chegou ao fim...")
        TriggerClientEvent("Notify", source, "amarelo", "Atenção", "PD aplicado com sucesso ID: " .. args[1], 5000)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN (CORRIGIDO: user_id agora é definido)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["ban"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        local nuser_id = parseInt(args[1])
        local identity = vRP.userIdentity(nuser_id)
        if identity then
            vRP.kick(nuser_id, "Banido.")
            vRP.execute("banneds/insertBanned", { steam = identity["steam"] })
            if not args[2] then args[2] = 9999999999999 end
            exports["config"]:SendLog("Ban", user_id, nuser_id, args)
            TriggerClientEvent("Notify", source, "amarelo", "Atenção",
                "Passaporte <b>" .. nuser_id .. "</b> banido por <b>" .. time .. " dias.", 5000)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["unban"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local nuser_id = parseInt(args[1])
        local identity = vRP.userIdentity(nuser_id)
        if identity then
            vRP.execute("banneds/removeBanned", { steam = identity["steam"] })
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "Passaporte " .. nuser_id .. " desbanido.", 5000)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPARAREA
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["limpararea"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local ped = GetPlayerPed(source)
        if ped then
            local coords = GetEntityCoords(ped)
            TriggerClientEvent("syncarea", -1, coords.x, coords.y, coords.z)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["tpcds"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        local fcoords = vRP.prompt(source, "Insira as coordenadas para teleportar:", "")
        if not fcoords then
            return
        end
        local coords = {}
        for coord in string.gmatch(fcoords or "0,0,0", "[^,]+") do
            table.insert(coords, coord)
        end
        args = { Coords = coords }
        vRP.teleport(source, coords[1] or 0, coords[2] or 0, coords[3] or 0)
        exports["config"]:SendLog("TpCds", user_id, nil, args)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["cds"] = {
    ["permissions"] = { "Admin", "Moderador" },
    callback = function(source, _)
        local Ped = GetPlayerPed(source)
        local coords = GetEntityCoords(Ped)
        local heading = GetEntityHeading(Ped)
        vRP.prompt(source, "CORDENADAS", "PEGAR CORDENADAS.",
            mathLegth(coords["x"]) .. "," .. mathLegth(coords["y"]) ..
            "," .. mathLegth(coords["z"]) .. "," .. mathLegth(heading))
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["group"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local user_id     = vRP.getUserId(source)
        local nuser_id    = parseInt(args[1])
        local groupsCache = vRP.Groups()


        if groupsCache[args[2]] then 
            vRP.setPermission(nuser_id, args[2], args[3])
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "Adicionado " ..args[2] .. " ao passaporte " .. args[1] .. ".", 5000)
            args = { ['1'] = args[2] }
            exports["config"]:SendLog("AddGroup",user_id,nuser_id,args)
        else
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "Grupo inexistente.", 5000)
        end 
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["ungroup"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        TriggerClientEvent("Notify", source, "verde", "Sucesso", "Removido " .. args[2] ..
        " ao passaporte " .. args[1] .. ".", 5000)

        local user_id = vRP.getUserId(source)
        vRP.remPermission(args[1], args[2])
        if vRP.hasPermission(user_id, "wait" .. args[2]) then
            vRP.remPermission(user_id, "wait" .. args[2])
            TriggerEvent("blipsystem:serviceExit", source)
            local nuser_id = tonumber(args[1])
            args = { ['1'] = args[2] }
            exports["config"]:SendLog("RemGroup", user_id, nuser_id, args)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["tptome"] = {
    ["permissions"] = { "Admin","Moderador" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        local otherPlayer = vRP.userSource(args[1])
        if otherPlayer then
            local ped = GetPlayerPed(source)
            local coords = GetEntityCoords(ped)

            vRP.teleport(otherPlayer, coords["x"], coords["y"], coords["z"])
            local nuser_id = parseInt(args[1])
            args = { Coords = coords }
            exports["config"]:SendLog("Tptome", user_id, nuser_id, args)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO (CORRIGIDO: user_id agora é definido)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["tpto"] = {
    ["permissions"] = { "Admin", "Moderador" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        local target_id = tonumber(args[1])
        if not target_id then
            TriggerClientEvent("Notify", source, "negado", "ID inválido.")
            return
        end

        local permission = vRP.hasPermission(user_id, "Owner")

        -- Restrição: somente quem tem permissão Owner pode dar TP no ID 1 ou 2
        if (target_id == 1 or target_id == 2) and not permission then
            TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para teleportar para esse ID.")
            return
        end

        local otherPlayer = vRP.userSource(target_id)
        if otherPlayer then
            local ped = GetPlayerPed(otherPlayer)
            local coords = GetEntityCoords(ped)
            vRP.teleport(source, coords["x"], coords["y"], coords["z"])

            args = { Coords = coords }
            exports["config"]:SendLog("Tpto", user_id, target_id, args)
        else
            TriggerClientEvent("Notify", source, "negado", "Jogador não encontrado.")
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY (CORRIGIDO: user_id agora é definido)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["tpway"] = {
    ["permissions"] = { "Admin", "Moderador" },
    callback = function(source, _)
        local user_id = vRP.getUserId(source)
        clientAPI.teleportWay(source)
        local coords = GetEntityCoords(GetPlayerPed(source))
        args = { Coords = coords }
        exports["config"]:SendLog("TpWay", user_id, nil, args)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["limbo"] = {
    ["permissions"] = false,
    callback = function(source, _)
        local user_id = vRP.getUserId(source)
        if user_id and vRP.getHealth(source) <= 101 then
            clientAPI.teleportLimbo(source)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["hash"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local vehicle = vRPC.vehicleHash(source)
        if vehicle then
            vRP.prompt(source, "Hash do veículo:", vehicle)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["resetchar"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local nuser_id = tonumber(args[1])
        if nuser_id then
            local identity = vRP.userIdentity(nuser_id)
            if identity then
                if vRP.request(source, "Deseja resetar a APARÊNCIA do personagem <b>"..identity["name"].." "..identity["name2"].. "</b>? (Inventário será preservado)") then
                    local nSource = vRP.userSource(nuser_id)

                    local currentDataTable = vRP.execute("playerdata/getUserdata", { user_id = nuser_id, key = "datatable" })
                    if currentDataTable and currentDataTable[1] then
                        vRP.execute("playerdata/setUserdata", {
                            user_id = nuser_id,
                            key = "saved_datatable_reset",
                            value = currentDataTable[1].dvalue
                        })
                        
                        local decoded = json.decode(currentDataTable[1].dvalue)
                        if decoded and decoded.inventory then
                            vRP.execute("playerdata/setUserdata", {
                                user_id = nuser_id,
                                key = "saved_inventory_reset",
                                value = json.encode(decoded.inventory)
                            })
                        end
                    end

                    vRP.execute("characters/updateReset", { user_id = nuser_id, reset = 1 })

                    if nSource then
                        local ped = GetPlayerPed(source)
                        local coords = GetEntityCoords(ped)

                        if coords then
                            vRP.execute("playerdata/setUserdata", { user_id = nuser_id, key = "Position", value = json.encode({ x = coords.x, y = coords.y, z = coords.z }) })
                        end
                        
                        TriggerEvent("fortal-character:Server:Creator:Open", nSource)

                        TriggerClientEvent("Notify", source, "sucesso", "Aparência resetada! Inventário será restaurado automaticamente.", 5000)
                        TriggerClientEvent("Notify", nSource, "importante", "Aparência resetada! Seus itens serão restaurados em alguns segundos.", 8000)
                    else
                        TriggerClientEvent("Notify", source, "sucesso", "Aparência será resetada quando o jogador conectar!", 5000)
                    end
                end
            else
                TriggerClientEvent("Notify", source, "negado", "ID não encontrado!", 5000)
            end
        else
            local user_id = vRP.getUserId(source)
            if user_id then
                if vRP.request(source, "Deseja resetar a APARÊNCIA do seu personagem? (Inventário será preservado)") then

                    local currentDataTable = vRP.execute("playerdata/getUserdata", { user_id = user_id, key = "datatable" })
                    if currentDataTable and currentDataTable[1] then
                        vRP.execute("playerdata/setUserdata", {
                            user_id = user_id,
                            key = "saved_datatable_reset",
                            value = currentDataTable[1].dvalue
                        })

                        local decoded = json.decode(currentDataTable[1].dvalue)
                        if decoded and decoded.inventory then
                            vRP.execute("playerdata/setUserdata", {
                                user_id = user_id,
                                key = "saved_inventory_reset",
                                value = json.encode(decoded.inventory)
                            })
                        end
                    end

                    vRP.execute("characters/updateReset", { user_id = user_id, reset = 1 })

                    local ped = GetPlayerPed(source)
                    local coords = GetEntityCoords(ped)

                    if coords then
                        vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Position", value = json.encode({ x = coords.x, y = coords.y, z = coords.z }) })
                    end

                    TriggerEvent("fortal-character:Server:Creator:Open", source)

                    TriggerClientEvent("Notify", source, "sucesso", "Resetando aparência... Seus itens serão restaurados automaticamente!", 5000)
                end
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX (CORRIGIDO: user_id agora é definido)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["fix"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        local vehicle, vehNet, vehPlate, vehName = vRPC.vehList(source, 10)
        if vehicle then
            local activePlayers = vRPC.activePlayers(source)
            for _, v in ipairs(activePlayers) do
                async(function()
                    TriggerClientEvent("inventory:repairAdmin", v, vehNet, vehPlate)
                    local vehicle = GetEntityModel(vRPC.getNearestVehicle(source, 7))
                    args = { ['1'] = vehicle }
                    exports["config"]:SendLog("VehicleFix", user_id, nil, args)
                end)
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["players"] = {
    ["permissions"] = { "Admin", "Moderador" },
    callback = function(source, args)
        TriggerClientEvent("Notify", source, "verde", "Atenção", "Jogadores Conectados: " .. GetNumPlayerIndices(), 5000)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS2
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["cds2"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local Ped = GetPlayerPed(source)
        local coords = GetEntityCoords(Ped)
        vRP.prompt(source, "Cordenadas:",
            "[x]=" .. mathLegth(coords["x"]) .. ",[y]=" .. mathLegth(coords["y"]) .. ",[z]=" .. mathLegth(coords["z"]))
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["announce"] = {
    ["permissions"] = { "Admin" },
    callback = function(_, _, rawCommand)
        TriggerClientEvent("chatME", -1, "^6ALERTA^9Governador^0" .. rawCommand:sub(9))
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO PM
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["avisopm"] = {
    ["permissions"] = { "Admin", "Police" },
    callback = function(source, _)
        local message = vRP.prompt(source, "Mensagem:", "")
        if not message or message == "" then
            return
        end
        
		TriggerClientEvent("Notify2", -1, "police", "Mensagem enviada pela Polícia", message, 15000)
		TriggerClientEvent("sounds:source", -1, "notify2", 1)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICKALL (CORRIGIDO: permissão alterada para Admin para evitar abuso)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["kickall"] = {
    ["permissions"] = { "Owner" }, -- Agora só o Owner pode kickar todos
    callback = function(source, args)
        local playerList = vRP.userList()
        for k, v in pairs(playerList) do
            vRP.kick(k, "A Cidade reiniciou para correçoes de bugs e atualizaçoes.")
            Wait(100)
        end
        TriggerEvent("admin:KickAll")
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATIVAR/DESATIVAR MODO DE DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["admindebug"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        TriggerClientEvent("ToggleDebug", source)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR ITEM PARA ALGUM JOGADOR (CORRIGIDO)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["itemp"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local user_id = parseInt(args[1])
        if user_id then
            vRP.generateItem(user_id, tostring(args[2]), parseInt(args[3]), true)
            TriggerClientEvent("Notify", source, "verde", "Sucesso", "Envio concluído.", 10000)
        end
    end
}

Commands["item"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        if user_id then
            vRP.generateItem(user_id, tostring(args[1]), parseInt(args[2]), true)
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAR CARRO PARA ALGUM JOGADOR (CORRIGIDO)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["addcar"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        if not args[1] or not args[2] then
            TriggerClientEvent("Notify", source, "vermelho", "Uso: /addcar [ID] [veículo]", 5000)
            return
        end

        local vehicle = args[2]
        local targetId = parseInt(args[1])
        local user_id = vRP.getUserId(source) 

        vRP.execute("vehicles/addVehicles", {
            user_id = targetId,
            vehicle = vehicle,
            plate = vRP.generatePlate(),
            work = tostring(false)
        })

        TriggerClientEvent("Notify", targetId, "verde", "Recebido o veículo " .. vehicle .. " em sua garagem.", 5000)
        TriggerClientEvent("Notify", source, "verde", "Sucesso", "Adicionado o veículo " .. vehicle .. " na garagem de ID <b>" .. targetId .. ".", 10000)

        exports["config"]:SendLog("VehicleAdd", user_id, targetId, { vehicle })
    end
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER CARRO DE ALGUM JOGADOR (CORRIGIDO)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["remcar"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        if not args[1] or not args[2] then
            TriggerClientEvent("Notify", source, "vermelho", "Uso: /remcar [ID] [veículo]", 5000)
            return
        end

        local user_id = vRP.getUserId(source) 
        local targetId = parseInt(args[1])
        local vehicle = args[2]

        vRP.execute("vehicles/removeVehicles", {
            user_id = targetId,
            vehicle = vehicle
        })

        TriggerClientEvent("Notify", targetId, "verde", "Removido o veículo " .. vehicle .. " de sua garagem.", 5000)
        TriggerClientEvent("Notify", source, "verde", "Sucesso", "Removido o veículo " .. vehicle .. " da garagem de ID <b>" .. targetId .. "</b>.", 10000)

        exports["config"]:SendLog("VehicleRemove", user_id, targetId, { vehicle })
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["rem"] = {
    ["permissions"] = false,
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        if user_id and args[1] and parseInt(args[2]) > 0 then
            local Group = args[1]
            local nuser_id = parseInt(args[2])
            local identity = vRP.userIdentity(nuser_id)

            if identity then
                if vRP.hasPermission(user_id, "set" .. Group) then
                    vRP.cleanPermission(nuser_id)
                    TriggerClientEvent("Notify", source, "important", "Atenção", "Passaporte " .. nuser_id .. "removido.",
                        "amarelo", 5000)
                end
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["add"] = {
    ["permissions"] = false,
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        if user_id and args[1] and parseInt(args[2]) > 0 then
            local Group = args[1]
            local nuser_id = parseInt(args[2])
            local identity = vRP.userIdentity(nuser_id)

            if identity then
                if vRP.hasPermission(user_id, "set" .. Group) then
                    vRP.cleanPermission(nuser_id)
                    vRP.setPermission(nuser_id, Group)
                    TriggerClientEvent("Notify", source, "check", "Sucesso", "Passaporte " .. nuser_id .. " adicionado.",
                        "verde", 5000)
                end
            end
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- E2
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["e2"] = {
    ["permissions"] = { "Paramedic" },
    callback = function(source, args)
        local otherPlayer = vRPC.nearestPlayer(source)
        if otherPlayer and vRP.getHealth(source) > 100 then
            TriggerClientEvent("emotes", otherPlayer, args[1])
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- E (CORRIGIDO: user_id agora é definido)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["e"] = {
    ["permissions"] = false,
    callback = function(source, args)
        local user_id = vRP.getUserId(source)
        if args[2] == "friend" then
            local otherPlayer = vRPC.nearestPlayer(source)
            if otherPlayer then
                if vRP.getHealth(otherPlayer) > 100 and not clientAPI.getHandcuff(otherPlayer) then
                    local identity = vRP.userIdentity(user_id)

                    if vRP.request(otherPlayer, "Pedido de <b>" .. identity["name"] .. "</b> da animação <b>" .. args[1] .. "</b>?") then
                        TriggerClientEvent("emotes", otherPlayer, args[1])
                        TriggerClientEvent("emotes", source, args[1])
                    end
                end
            end
        else
            TriggerClientEvent("emotes", source, args[1])
        end
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["status"] = {
    ["permissions"] = {"Admin"},
    callback = function(source)
        local onlinePlayers = GetNumPlayerIndices()
        local policia = vRP.getUsersByPermission("Police")
        local paramedico = vRP.getUsersByPermission("Paramedic")
        local mec = vRP.getUsersByPermission("Mechanic")
        local staff = vRP.getUsersByPermission("Admin")
        local user_id = vRP.getUserId(source)

        TriggerClientEvent("Notify", source, "check", "Lista de jogadores",
            "Jogadores: " ..
            onlinePlayers ..
            "\n Administração: " ..
            #staff .. 
            "\n Policiais:" 
            .. #policia .. 
            "\n Paramédicos: " 
            .. #paramedico .. 
            "\n Mecânicos: " 
            .. #mec .. ".",
            "verde", 9000)
    end
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- / COR (CORRIGIDO: args agora é recebido na função)
-----------------------------------------------------------------------------------------------------------------------------------------
Commands["cor"] = {
    ["permissions"] = { "Admin" },
    callback = function(source, args)
        TriggerClientEvent('changeWeaponColor', source, args[1])
    end
}