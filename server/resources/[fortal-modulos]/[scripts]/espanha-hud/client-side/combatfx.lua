-- =====================================================
-- COMBAT FX — Mira, Marcador de Dano e Efeito de Kill
-- =====================================================
-- Renderizacao NATIVA (DrawRect/DrawText) dirigida pelas
-- opcoes que o menu (/menu) ja persiste em KVP. Nada de
-- NUI aqui: mira, hitmarker e efeito de eliminacao sao
-- desenhados direto na tela.
--
-- Opcoes consumidas (KVP escrito por client-side/menu.lua):
--   hud:menu:opt:crosshair        (toggle)  -> mira central on/off
--   hud:menu:opt:crosshair-color  (hex)     -> cor da mira
--   hud:menu:opt:damage-marker    (toggle)  -> marcador de dano on/off
--   hud:menu:opt:marker-color     (hex)     -> cor do numero/hitmarker
--   hud:menu:opt:kill-effect      (id)      -> ping|flash|shake|none
--   hud:menu:opt:hit-sound        (id)      -> arrow|ping|beep|none
--   hud:menu:opt:kill-sound       (id)      -> ping|arrow|beep|none
--   hud:menu:opt:hit-volume       (0-100)   -> 0 = silencia o som de acerto
--
-- menu.lua chama HudCombatFX.set(id, value) ao vivo quando
-- o jogador altera uma dessas opcoes (ver Effects la).
-- =====================================================

-- ----------------------------------------------------------------
-- CONFIG (tamanhos em pixels; livre pra ajustar)
-- ----------------------------------------------------------------
local C = {
    -- mira central
    gap = 6, len = 9, th = 2, dot = true,
    dotSize = 3,               -- tamanho do ponto central (estilos dot/circle)
    circleR = 9, circleSeg = 32, -- raio (px) e num. de segmentos do estilo "circle"
    bracketD = 12, bracketArm = 6, -- meia-extensao e tamanho do "L" do estilo "brackets"
    -- tick de acerto (hitmarker que "pulsa" no acerto)
    hitGap = 8, hitLen = 7, hitTh = 2,
    -- marcador de eliminacao (efeito "ping")
    killGap = 10, killLen = 13, killTh = 3,
}

local CROSS_A      = 230    -- opacidade da mira
local HITTICK_MS   = 180    -- duracao do tick de acerto
local POPUP_MS     = 850    -- duracao do numero de dano apos o ultimo hit
local KILLMARK_MS  = 500    -- duracao do marcador de kill (efeito ping)
local FLASH_MS     = 350    -- duracao do flash de kill
local FLASH_MAX_A  = 120    -- opacidade maxima do flash
local KILL_COOLDOWN = 800   -- anti-retrigger do efeito de kill (ms)
local ACCUM_MS     = 250    -- janela pra somar dano no mesmo alvo

local UNARMED = `WEAPON_UNARMED`

-- Sons frontend por opcao { audioName, audioRef }
local HIT_SOUNDS = {
    arrow = { "Menu_Accept",       "Phone_SoundSet_Default" },
    ping  = { "PICK_UP",           "HUD_FRONTEND_DEFAULT_SOUNDSET" },
    beep  = { "TIMER_STOP",        "HUD_MINI_GAME_SOUNDSET" },
}
local KILL_SOUNDS = {
    ping  = { "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET" },
    arrow = { "Menu_Accept",        "Phone_SoundSet_Default" },
    beep  = { "CHECKPOINT_NORMAL",  "HUD_MINI_GAME_SOUNDSET" },
}

-- ----------------------------------------------------------------
-- ESTADO (defaults espelham o template do menu)
-- ----------------------------------------------------------------
local S = {
    crosshairEnabled = false,
    crosshairType    = "cross",
    crosshairColor   = { 242, 242, 242 },
    markerEnabled    = false,
    markerColor      = { 255, 226, 74 }, -- amarelo (#FFE24A)
    killEffect       = "ping",
    hitSound         = "arrow",
    killSound        = "ping",
    hitVolume        = 36,
}

-- ----------------------------------------------------------------
-- HELPERS
-- ----------------------------------------------------------------
local function hexToRgb(hex)
    if type(hex) ~= "string" then return 242, 242, 242 end
    hex = hex:gsub("#", "")
    if #hex ~= 6 then return 242, 242, 242 end
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    if not r or not g or not b then return 242, 242, 242 end
    return r, g, b
end

local function rotToDir(rot)
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vec3(-math.sin(z) * num, math.cos(z) * num, math.sin(x))
end

-- DrawRect a partir de pixels (centro + tamanho) -> normalizado
local function rectPx(sw, sh, cx, cy, w, h, r, g, b, a)
    DrawRect(cx / sw, cy / sh, w / sw, h / sh, r, g, b, a)
end

-- Desenha uma "cruz" (mira / tick / marcador) com contorno preto pra leitura
local function drawCross(gap, len, th, r, g, b, a, dot)
    local sw, sh = GetActiveScreenResolution()
    local cx, cy = sw * 0.5, sh * 0.5
    local off = gap + len / 2
    local ob = math.floor(a * 0.55) -- contorno

    -- contorno (1px maior em cada lado)
    rectPx(sw, sh, cx, cy - off, th + 2, len + 2, 0, 0, 0, ob)
    rectPx(sw, sh, cx, cy + off, th + 2, len + 2, 0, 0, 0, ob)
    rectPx(sw, sh, cx - off, cy, len + 2, th + 2, 0, 0, 0, ob)
    rectPx(sw, sh, cx + off, cy, len + 2, th + 2, 0, 0, 0, ob)
    -- cor
    rectPx(sw, sh, cx, cy - off, th, len, r, g, b, a)
    rectPx(sw, sh, cx, cy + off, th, len, r, g, b, a)
    rectPx(sw, sh, cx - off, cy, len, th, r, g, b, a)
    rectPx(sw, sh, cx + off, cy, len, th, r, g, b, a)

    if dot then
        rectPx(sw, sh, cx, cy, th + 2, th + 2, 0, 0, 0, ob)
        rectPx(sw, sh, cx, cy, th, th, r, g, b, a)
    end
end

-- Ponto central (reutilizado por "dot" e "circle")
local function drawDot(sw, sh, cx, cy, size, r, g, b, a, ob)
    rectPx(sw, sh, cx, cy, size + 2, size + 2, 0, 0, 0, ob)
    rectPx(sw, sh, cx, cy, size, size, r, g, b, a)
end

-- ----------------------------------------------------------------
-- ESTILOS DE MIRA
-- ----------------------------------------------------------------
-- cross: 4 barras + ponto (classico)  |  dot: so o ponto
-- t: barras esquerda/direita/baixo (sem topo)
-- circle: anel + ponto  |  brackets: 4 cantos em "L"
local function drawCrosshairStyle(style, r, g, b, a)
    local sw, sh = GetActiveScreenResolution()
    local cx, cy = sw * 0.5, sh * 0.5
    local ob = math.floor(a * 0.55)

    if style == "dot" then
        drawDot(sw, sh, cx, cy, C.dotSize, r, g, b, a, ob)

    elseif style == "t" then
        local off = C.gap + C.len / 2
        -- baixo
        rectPx(sw, sh, cx, cy + off, C.th + 2, C.len + 2, 0, 0, 0, ob)
        rectPx(sw, sh, cx, cy + off, C.th, C.len, r, g, b, a)
        -- esquerda
        rectPx(sw, sh, cx - off, cy, C.len + 2, C.th + 2, 0, 0, 0, ob)
        rectPx(sw, sh, cx - off, cy, C.len, C.th, r, g, b, a)
        -- direita
        rectPx(sw, sh, cx + off, cy, C.len + 2, C.th + 2, 0, 0, 0, ob)
        rectPx(sw, sh, cx + off, cy, C.len, C.th, r, g, b, a)

    elseif style == "circle" then
        local R, seg = C.circleR, C.circleSeg
        for i = 0, seg - 1 do
            local ang = (i / seg) * math.pi * 2.0
            local px = cx + math.cos(ang) * R
            local py = cy + math.sin(ang) * R
            rectPx(sw, sh, px, py, 3, 3, 0, 0, 0, ob)
            rectPx(sw, sh, px, py, 2, 2, r, g, b, a)
        end
        drawDot(sw, sh, cx, cy, C.dotSize, r, g, b, a, ob)

    elseif style == "brackets" then
        local d, arm, th = C.bracketD, C.bracketArm, C.th
        for _, s in ipairs({ { -1, -1 }, { 1, -1 }, { -1, 1 }, { 1, 1 } }) do
            local sx, sy = s[1], s[2]
            local ccx, ccy = cx + sx * d, cy + sy * d
            -- braco horizontal (aponta pro centro)
            local hx = ccx - sx * (arm / 2)
            rectPx(sw, sh, hx, ccy, arm + 2, th + 2, 0, 0, 0, ob)
            rectPx(sw, sh, hx, ccy, arm, th, r, g, b, a)
            -- braco vertical (aponta pro centro)
            local vy = ccy - sy * (arm / 2)
            rectPx(sw, sh, ccx, vy, th + 2, arm + 2, 0, 0, 0, ob)
            rectPx(sw, sh, ccx, vy, th, arm, r, g, b, a)
        end

    else -- "cross"
        drawCross(C.gap, C.len, C.th, r, g, b, a, C.dot)
    end
end

local function playSound(pair)
    if not pair then return end
    PlaySoundFrontend(-1, pair[1], pair[2], true)
end

-- ----------------------------------------------------------------
-- EFEITOS TRANSIENTES (timestamps em GetGameTimer)
-- ----------------------------------------------------------------
local hitTickAt     = 0
local killMarkAt    = 0
local flashAt       = 0
local lastKillAt    = 0
local lastHitSndAt  = 0
local dmgPopups     = {} -- { value, victim, t (ultimo hit), ox }

local DmgCache   = {} -- [entity] = { h = vida, a = colete } ANTES do dano
local pendingRay = nil

-- ----------------------------------------------------------------
-- CONDICOES DA MIRA
-- ----------------------------------------------------------------
local function shouldDrawCrosshair()
    if not S.crosshairEnabled then return false end
    local ped = PlayerPedId()
    if IsEntityDead(ped) then return false end
    if IsPedInAnyVehicle(ped, false) then return false end
    local _, weapon = GetCurrentPedWeapon(ped, true)
    if weapon == UNARMED then return false end
    return true
end

-- ----------------------------------------------------------------
-- DESENHO DOS EFEITOS
-- ----------------------------------------------------------------
-- numero de dano: centralizado EM CIMA do crosshair (ex.: "-49")
local DMG_BASE_Y = 0.5 - 0.07 -- acima do centro/mira

local function drawDamageNumber(p, age)
    local r, g, b = S.markerColor[1], S.markerColor[2], S.markerColor[3]
    local prog = age / POPUP_MS
    local a = math.floor(255 * (1 - prog * prog))
    if a <= 0 then return end
    local drift = 0.03 * prog -- sobe um pouco ao terminar
    local x = 0.5
    local y = DMG_BASE_Y + (p.oy or 0.0) - drift

    SetTextFont(4)
    SetTextProportional(true)
    SetTextScale(0.0, 0.5)
    SetTextColour(r, g, b, a)
    SetTextCentre(true)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentSubstringPlayerName("-" .. tostring(p.value))
    DrawText(x, y)
end

-- Retorna true se desenhou algo (mantem a thread em Wait(0))
local function drawEffects()
    local now = GetGameTimer()
    local drew = false

    -- flash de kill
    if flashAt > 0 then
        local age = now - flashAt
        if age <= FLASH_MS then
            local a = math.floor(FLASH_MAX_A * (1 - age / FLASH_MS))
            if a > 0 then
                DrawRect(0.5, 0.5, 1.0, 1.0, 255, 255, 255, a)
                drew = true
            end
        else
            flashAt = 0
        end
    end

    -- marcador de kill (efeito "ping": cruz vermelha que expande)
    if killMarkAt > 0 then
        local age = now - killMarkAt
        if age <= KILLMARK_MS then
            local prog = age / KILLMARK_MS
            local a = math.floor(255 * (1 - prog))
            local s = 1.0 + 1.3 * prog
            drawCross(C.killGap * s, C.killLen, C.killTh, 224, 16, 22, a, false)
            drew = true
        else
            killMarkAt = 0
        end
    end

    -- tick de acerto (pulso na cor do marcador)
    if hitTickAt > 0 then
        local age = now - hitTickAt
        if age <= HITTICK_MS then
            local prog = age / HITTICK_MS
            local a = math.floor(CROSS_A * (1 - prog))
            local s = 1.0 + 0.7 * prog
            drawCross(C.hitGap * s, C.hitLen, C.hitTh,
                S.markerColor[1], S.markerColor[2], S.markerColor[3], a, false)
            drew = true
        else
            hitTickAt = 0
        end
    end

    -- numeros de dano
    if #dmgPopups > 0 then
        for i = #dmgPopups, 1, -1 do
            local p = dmgPopups[i]
            local age = now - p.t
            if age > POPUP_MS then
                table.remove(dmgPopups, i)
            else
                drawDamageNumber(p, age)
                drew = true
            end
        end
    end

    return drew
end

-- ----------------------------------------------------------------
-- THREAD DE RENDER (idle quando nao ha nada a desenhar)
-- ----------------------------------------------------------------
CreateThread(function()
    while true do
        local drew = false
        if not IsPauseMenuActive() then
            if shouldDrawCrosshair() then
                -- usamos a NOSSA mira tambem ao mirar (ADS): escondemos a
                -- reticula nativa do jogo pra nao ficar duas miras sobrepostas
                HideHudComponentThisFrame(14)
                drawCrosshairStyle(S.crosshairType,
                    S.crosshairColor[1], S.crosshairColor[2], S.crosshairColor[3], CROSS_A)
                drew = true
            end
            if drawEffects() then drew = true end
        end
        Wait(drew and 0 or 100)
    end
end)

-- ----------------------------------------------------------------
-- SEED DE VIDA+COLETE (raycast da camera enquanto ha arma em punho)
-- Guarda vida E colete do alvo ANTES do dano pra calcular o delta no
-- primeiro tiro. Sem isso, o 1o acerto sairia sem numero.
-- ----------------------------------------------------------------
CreateThread(function()
    local pruneAcc = 0
    while true do
        local wait = 500
        local ped = PlayerPedId()
        local active = S.markerEnabled and not IsEntityDead(ped)

        if active then
            local _, weapon = GetCurrentPedWeapon(ped, true)
            if weapon ~= UNARMED then
                wait = 120

                -- le o resultado do probe anterior
                if pendingRay then
                    local _, hit, _, _, entity = GetShapeTestResult(pendingRay)
                    if (hit == 1 or hit == true) and entity and entity ~= 0
                        and DoesEntityExist(entity) and IsEntityAPed(entity) and entity ~= ped then
                        DmgCache[entity] = { h = GetEntityHealth(entity), a = GetPedArmour(entity) }
                    end
                    pendingRay = nil
                end

                -- dispara um novo probe pra frente da camera
                local from = GetGameplayCamCoord()
                local dir = rotToDir(GetGameplayCamRot(2))
                local to = from + dir * 80.0
                pendingRay = StartShapeTestLosProbe(from.x, from.y, from.z, to.x, to.y, to.z, -1, ped, 4)
            end
        else
            pendingRay = nil
        end

        -- limpeza periodica do cache (entidades que sumiram/morreram)
        pruneAcc = pruneAcc + wait
        if pruneAcc >= 8000 then
            pruneAcc = 0
            for ent in pairs(DmgCache) do
                if not DoesEntityExist(ent) or IsEntityDead(ent) then
                    DmgCache[ent] = nil
                end
            end
        end

        Wait(wait)
    end
end)

-- ----------------------------------------------------------------
-- ACAO: acerto / eliminacao
-- ----------------------------------------------------------------
local function pushDamage(victim, dmg)
    local now = GetGameTimer()
    local last = dmgPopups[#dmgPopups]
    -- soma no mesmo alvo se foi ha pouco (rajada) -> um numero que cresce
    if last and last.victim == victim and (now - last.t) < ACCUM_MS then
        last.value = last.value + dmg
        last.t = now
    else
        dmgPopups[#dmgPopups + 1] = {
            value  = dmg,
            victim = victim,
            t      = now,
            oy     = math.random(-8, 8) / 1000.0, -- leve variacao vertical (multi-alvo)
        }
        if #dmgPopups > 10 then table.remove(dmgPopups, 1) end
    end
end

local function onHit(victim, dmg)
    local now = GetGameTimer()
    hitTickAt = now
    if dmg and dmg > 0 then
        pushDamage(victim, dmg)
    end
    -- throttle no som: evita spam com shotgun/automatica (varios eventos por disparo)
    if S.hitVolume and S.hitVolume > 0 and (now - lastHitSndAt) >= 70 then
        lastHitSndAt = now
        playSound(HIT_SOUNDS[S.hitSound])
    end
end

local function onKill()
    local now = GetGameTimer()
    if now - lastKillAt < KILL_COOLDOWN then return end
    lastKillAt = now

    playSound(KILL_SOUNDS[S.killSound])

    local fx = S.killEffect
    if fx == "flash" then
        flashAt = now
    elseif fx == "shake" then
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.20)
    elseif fx == "ping" then
        killMarkAt = now
    end
end

-- ----------------------------------------------------------------
-- DETECCAO DE DANO CAUSADO POR MIM
-- (handler proprio; NAO mexe no killfeed.lua que trata a MINHA morte)
-- ----------------------------------------------------------------
AddEventHandler("gameEventTriggered", function(event, args)
    if event ~= "CEventNetworkEntityDamage" then return end
    if not S.markerEnabled and S.killEffect == "none" and S.killSound == "none" then
        return
    end

    local victim   = args[1]
    local attacker = args[2]
    local isFatal  = args[6]
    local ped = PlayerPedId()

    if attacker ~= ped then return end
    if not victim or victim == ped then return end
    if not IsEntityAPed(victim) then return end

    -- marcador de dano (qualquer ped que eu acertar)
    -- soma vida + colete: o colete absorve o dano antes da vida, entao sem
    -- contar o colete o numero so aparecia depois que ele acabava.
    if S.markerEnabled then
        local curH = GetEntityHealth(victim)
        local curA = GetPedArmour(victim)
        local prev = DmgCache[victim]
        local dmg
        if prev then
            local dh = prev.h - curH
            local da = prev.a - curA
            if dh < 0 then dh = 0 end
            if da < 0 then da = 0 end
            local total = dh + da
            if total > 0 then dmg = total end
        end
        DmgCache[victim] = { h = curH, a = curA }
        onHit(victim, dmg)
    end

    -- efeito de eliminacao (somente jogadores)
    if isFatal == 1 and IsPedAPlayer(victim) then
        onKill()
    end
end)

-- ----------------------------------------------------------------
-- API pro menu.lua (aplica alteracoes ao vivo) + carga inicial do KVP
-- ----------------------------------------------------------------
local function kvp(key) return GetResourceKvpString(key) end

local function loadSettings()
    S.crosshairEnabled = kvp("hud:menu:opt:crosshair") == "1"
    S.crosshairType    = kvp("hud:menu:opt:crosshair-type") or "cross"
    S.crosshairColor   = { hexToRgb(kvp("hud:menu:opt:crosshair-color") or "#F2F2F2") }
    S.markerEnabled    = kvp("hud:menu:opt:damage-marker") == "1"
    S.markerColor      = { hexToRgb(kvp("hud:menu:opt:marker-color") or "#FFE24A") }
    S.killEffect       = kvp("hud:menu:opt:kill-effect") or "ping"
    S.hitSound         = kvp("hud:menu:opt:hit-sound") or "arrow"
    S.killSound        = kvp("hud:menu:opt:kill-sound") or "ping"
    S.hitVolume        = tonumber(kvp("hud:menu:opt:hit-volume")) or 36
end

HudCombatFX = {}

function HudCombatFX.set(id, value)
    if id == "crosshair" then
        S.crosshairEnabled = value == true
    elseif id == "crosshair-type" then
        S.crosshairType = value
    elseif id == "crosshair-color" then
        S.crosshairColor = { hexToRgb(value) }
    elseif id == "damage-marker" then
        S.markerEnabled = value == true
    elseif id == "marker-color" then
        S.markerColor = { hexToRgb(value) }
    elseif id == "kill-effect" then
        S.killEffect = value
    elseif id == "hit-sound" then
        S.hitSound = value
    elseif id == "kill-sound" then
        S.killSound = value
    elseif id == "hit-volume" then
        S.hitVolume = tonumber(value) or S.hitVolume
    end
end

CreateThread(function()
    while not NetworkIsPlayerActive(PlayerId()) do Wait(500) end
    loadSettings()
end)
