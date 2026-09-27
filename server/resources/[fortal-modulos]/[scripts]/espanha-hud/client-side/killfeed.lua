-- =====================================================
-- KILLFEED — Client
-- =====================================================
-- Receives kill payloads from the server and forwards
-- them to the NUI using the standard "set:notify:kill"
-- action. The server already filters by context; a
-- defensive check here guarantees no stray entry slips
-- into the UI during a context swap.
-- =====================================================

local CurrentContext = KILLFEED_DEFAULT_CONTEXT

-- =====================================================
-- QUEM SOU EU NA LINHA
-- =====================================================
-- A NUI destaca a linha de quem MATOU (borda vermelha acesa) diferente da linha
-- de quem so participou. Quem decide isso e o cliente, e nao o servidor: o
-- payload de uma kill e o MESMO para todo mundo do contexto (`broadcastKill`
-- manda a mesma tabela para cada source), entao "eu sou o autor" so pode ser
-- respondido aqui, comparando o passaporte local.
--
-- Duas fontes porque nenhuma cobre sozinha o comeco da sessao: o statebag e o
-- valor autoritativo (o servidor escreve em `vrp/modules/player.lua`) e o
-- `hud:setUserId` e o que chega no login e na troca de personagem. O que a NUI
-- guarda NAO serve: o `PlayerState` do `client.lua` e local daquele arquivo, e o
-- handler do statebag de la atualiza o cliente sem repassar para a interface.
local ReportedPassport = nil

RegisterNetEvent("hud:setUserId", function(number)
    ReportedPassport = tonumber(number)
end)

---@return number|nil
local function localPassport()
    local fromBag = tonumber(LocalPlayer.state.Passport)
    if fromBag and fromBag > 0 then return fromBag end

    if ReportedPassport and ReportedPassport > 0 then return ReportedPassport end

    return nil
end

local function resolveWeaponImage(weapon)
    if not weapon or weapon == "" then return nil end

    local base = hudConfig and hudConfig.armoryUrl
    if not base or base == "" then return nil end

    return base .. tostring(weapon) .. ".png"
end

local function sendToNUI(data)
    if type(data) ~= "table" then return end
    if type(data.killer) ~= "table" or type(data.killed) ~= "table" then return end

    local context = data.context
    if not context or not Killfeeds[context] or Killfeeds[context].enabled == false then
        context = KILLFEED_DEFAULT_CONTEXT
    end

    if context ~= CurrentContext then return end

    local passport = localPassport()
    local killerId = tonumber(data.killer.id)

    SendNUIMessage({
        action = "set:notify:kill",
        data = {
            killer   = data.killer,
            killed   = data.killed,
            image    = data.image or resolveWeaponImage(data.weapon),
            isKiller = passport ~= nil and killerId ~= nil and killerId == passport,
        },
    })
end

RegisterNetEvent("killfeed:client:setContext", function(context)
    if not context or not Killfeeds[context] or Killfeeds[context].enabled == false then
        context = KILLFEED_DEFAULT_CONTEXT
    end
    CurrentContext = context
end)

RegisterNetEvent("killfeed:client:push", function(data)
    sendToNUI(data)
end)

-- =====================================================
-- KILL DETECTION
-- =====================================================
-- Report only our OWN death to the server (never the
-- death of others — that avoids duplicate broadcasts
-- and stops clients from spoofing kills). The server
-- then routes the payload to the right context.
-- =====================================================

local LastReportedAt = 0
local ReportCooldownMs = 1500
local SKEL_HEAD_BONE   = 31086

local function isHeadshot(ped)
    local ok, bone = pcall(GetPedLastDamageBone, ped)
    if not ok then return false end

    -- Depending on the FiveM build, GetPedLastDamageBone returns either
    -- a single boneId or (hasBone, boneId). Accept both shapes.
    if type(bone) == "boolean" then
        local _, realBone = GetPedLastDamageBone(ped)
        return realBone == SKEL_HEAD_BONE
    end

    return bone == SKEL_HEAD_BONE
end

local function reportLocalDeath(attackerPed, weaponHash)
    local ped = PlayerPedId()
    if not IsPedAPlayer(attackerPed) or attackerPed == ped then return end

    local now = GetGameTimer()
    if now - LastReportedAt < ReportCooldownMs then return end
    LastReportedAt = now

    local killerIdx = NetworkGetPlayerIndexFromPed(attackerPed)
    local killerSrc = GetPlayerServerId(killerIdx)
    if not killerSrc or killerSrc <= 0 then return end

    local distance = #(GetEntityCoords(attackerPed) - GetEntityCoords(ped))

    TriggerServerEvent("killfeed:reportKill", killerSrc, weaponHash, isHeadshot(ped), math.floor(distance))
end

AddEventHandler("gameEventTriggered", function(event, args)
    if event ~= "CEventNetworkEntityDamage" then return end

    local victim   = args[1]
    local attacker = args[2]
    local isFatal  = args[6]
    local weapon   = args[7]

    if isFatal ~= 1 then return end
    if not IsEntityAPed(victim) then return end
    if victim ~= PlayerPedId() then return end

    reportLocalDeath(attacker, weapon)
end)

exports("getKillfeedContext", function()
    return CurrentContext
end)
