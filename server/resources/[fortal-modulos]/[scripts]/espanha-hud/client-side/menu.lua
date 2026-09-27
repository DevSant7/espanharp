-- ================================================================
-- HUD SETTINGS MENU  (comando /menu -> acao NUI 'menu:hud')
-- Backend do menu data-driven (front: store Menu.ts + MenuOptions):
--   get:menu:list          -> devolve os menus com o estado salvo do jogador
--   post:menu:changeOption -> valida, persiste (KVP client-side) e aplica efeito
--
-- IMPORTANTE: as abas "HUD" e "Velocimetro" sao tratadas pelo PROPRIO front
-- (componentes bespoke <Hud/> e <Velocimeter/>), e o front ja as injeta na
-- lista de categorias. Por isso este backend NAO devolve um menu "HUD" nem
-- "Velocimetro" -> senao geram aba duplicada.
--
-- Persistencia: KVP client-side (mesmo padrao do 'hud:hideMap').
-- Estado NAO salvo = mantem o default definido aqui em `Menus`.
-- Estrutura/labels espelham o mock de Menu.ts (getMenus) 1:1.
-- ================================================================

-- Animacoes da radio (espelho do europa_radio: anim-1 .. anim-18)
local RADIO_ANIM_OPTIONS = {}
for i = 1, 18 do
    RADIO_ANIM_OPTIONS[i] = { id = "anim-" .. i, label = "Animação " .. i }
end

-- ----------------------------------------------------------------
-- TEMPLATE / DEFAULTS  (espelho do mock do front — fonte da verdade)
-- ----------------------------------------------------------------
local Menus = {
    {
        title = "Audio e Chat",
        toggles = {
            title = "Configurações",
            options = {
                { id = "hide-chat", title = "Ocultar Chat", icon = "mdi:chat-remove", active = true, className = "" },
            },
        },
        multiSelects = {
            title = "Configurações",
            options = {
                { id = "close-after", title = "Fechar após", icon = "mdi:chat-remove-outline", selectedOption = "ping", options = { "ping", "5s", "10s", "30s", "never" }, tooltip = "Tempo para fechar o chat automaticamente" },
            },
        },
        slideRanges  = { title = "", options = {} },
        selects      = { title = "", options = {} },
        colorPickers = { title = "", options = {} },
    },
    {
        title    = "Clima",
        toggles  = { title = "", options = {} },
        multiSelects = { title = "", options = {} },
        slideRanges  = { title = "", options = {} },
        selects = {
            title = "Configurações",
            options = {
                { id = "sunny",         title = "Ensolarado",           icon = "mdi:weather-sunny",           description = "Clima quente com sol e poucas nuvens.",        selected = true },
                { id = "clear",         title = "Céu Limpo",            icon = "mdi:weather-sunny-off",       description = "Céu aberto com presença leve de nuvens.",      selected = false },
                { id = "partly-cloudy", title = "Parcialmente Nublado", icon = "mdi:weather-partly-cloudy",   description = "Mistura de sol e nuvens ao longo do período.", selected = false },
                { id = "fog",           title = "Neblina",              icon = "mdi:weather-fog",             description = "Baixa visibilidade causada por nevoeiro.",     selected = false },
                { id = "clearing",      title = "Céu Limpando",         icon = "mdi:weather-partly-rainy",    description = "Nuvens estão se dissipando, abrindo espaço.",  selected = false },
                { id = "storm",         title = "Tempestade",           icon = "mdi:weather-lightning-rainy", description = "Chuva intensa com raios e ventos fortes.",     selected = false },
            },
        },
        colorPickers = { title = "", options = {} },
    },
    {
        title   = "Rádio",
        toggles = { title = "", options = {} },
        multiSelects = {
            title = "Configurações",
            options = {
                { id = "radio-animation",     title = "Animação da rádio",   icon = "mdi:radio",         selectedOption = "anim-1", options = RADIO_ANIM_OPTIONS, tooltip = "Animação usada ao falar no rádio" },
                { id = "radio-ped-animation", title = "Posição da animação", icon = "mdi:account-voice", selectedOption = "mouth",   options = { { id = "mouth", label = "Na Boca" }, { id = "shoulder", label = "No Ombro" } }, tooltip = "Onde o personagem segura o rádio" },
            },
        },
        slideRanges = {
            title = "Configurações",
            options = {
                { id = "radio-volume", title = "Volume da frequência", icon = "mdi:volume-high", min = 0, max = 100, value = 60, isPercentage = true },
            },
        },
        selects      = { title = "", options = {} },
        colorPickers = { title = "", options = {} },
    },
    {
        title = "Combat",
        toggles = {
            title = "Configurações",
            options = {
                { id = "damage-marker", title = "Marcador de dano", icon = "mdi:crosshairs", active = false, className = "", tooltip = "Mostra o dano causado ao acertar um alvo" },
                { id = "crosshair",     title = "Mira central",     icon = "mdi:crosshairs-gps", active = false, className = "", tooltip = "Exibe uma mira fixa no centro da tela" },
                { id = "weapon-stance", title = "Arma baixada",     icon = "mdi:pistol", active = true, className = "", tooltip = "Segura a arma ao lado do corpo ao andar e correr" },
                { id = "party-outline", title = "Contorno da Party", icon = "mdi:account-multiple-outline", active = true, className = "", tooltip = "Desenha um contorno nos colegas de party" },
                { id = "party-outline-name", title = "Nome da Party", icon = "mdi:tag-text-outline", active = true, className = "", tooltip = "Mostra o nome dos colegas acima da cabeça" },
            },
        },
        multiSelects = {
            title = "Configurações",
            options = {
                { id = "crosshair-type", title = "Tipo de mira", icon = "mdi:crosshairs-gps", selectedOption = "cross", options = {
                    { id = "cross",    label = "Cruz" },
                    { id = "dot",      label = "Ponto" },
                    { id = "t",        label = "T" },
                    { id = "circle",   label = "Círculo" },
                    { id = "brackets", label = "Cantos" },
                }, tooltip = "Formato da mira central" },
                { id = "kill-effect", title = "Efeito de eliminação", icon = "mdi:skull-crossbones", selectedOption = "ping", options = { "ping", "flash", "shake", "none" }, tooltip = "Efeito visual ao eliminar um jogador" },
                { id = "hit-sound",   title = "Som de acerto",     icon = "mdi:bullseye-arrow", selectedOption = "arrow", options = { "arrow", "ping", "beep", "none" }, tooltip = "Som ao acertar um alvo" },
                { id = "kill-sound",  title = "Som de eliminação", icon = "mdi:skull",          selectedOption = "ping",  options = { "ping", "arrow", "beep", "none" }, tooltip = "Som ao eliminar um jogador" },
            },
        },
        slideRanges = {
            title = "Configurações",
            options = {
                { id = "hit-volume", title = "Volume de acerto", icon = "mdi:volume-high", min = 0, max = 100, value = 36, isPercentage = true },
            },
        },
        selects     = { title = "", options = {} },
        colorPickers = {
            title = "Configurações",
            options = {
                { id = "marker-color",    title = "Cor do Mostrador de Dano", icon = "mdi:palette", color = "#FFE24A", tooltip = "Cor do número de dano exibido no acerto" },
                { id = "crosshair-color", title = "Cor da mira",     icon = "mdi:palette", color = "#F2F2F2", tooltip = "Cor da mira central" },
                { id = "party-outline-color", title = "Cor do Contorno da Party", icon = "mdi:palette", color = "#FFFF00", tooltip = "Cor do contorno dos colegas de party" },
                { id = "party-name-color",    title = "Cor do Nome da Party",     icon = "mdi:palette", color = "#FFFFFF", tooltip = "Cor do nome dos colegas de party" },
            },
        },
    },
    -- ------------------------------------------------------------
    -- Menus espelhados de outros resources (estado vive la; ponte via Bridge)
    -- ------------------------------------------------------------
    {
        title = "Veículo",
        toggles = {
            title = "Configurações",
            options = {
                { id = "veh-autolock", title = "Fechamento automático", icon = "mdi:car-door-lock", active = false, description = "Fechar o veículo automaticamente ao sair dele.", className = "" },
            },
        },
        multiSelects = {
            title = "Configurações",
            options = {
                { id = "veh-autolock-distance", title = "Distância do fechamento", icon = "mdi:map-marker-distance", selectedOption = "5", options = {
                    { id = "any", label = "Ao sair" },
                    { id = "5",   label = "5 Metros" },
                    { id = "10",  label = "10 Metros" },
                    { id = "25",  label = "25 Metros" },
                    { id = "50",  label = "50 Metros" },
                }, tooltip = "Fechar automaticamente após esta distância" },
            },
        },
        slideRanges  = { title = "", options = {} },
        selects      = { title = "", options = {} },
        colorPickers = { title = "", options = {} },
    },
    {
        title = "Inventário",
        toggles = {
            title = "Configurações",
            options = {
                { id = "inv-item-info", title = "Informações do Item", icon = "mdi:information-outline", active = true, description = "Exibir as informações dos itens ao passar o mouse.", className = "" },
            },
        },
        multiSelects = {
            title = "Configurações",
            options = {
                { id = "inv-background", title = "Tipo do Fundo", icon = "mdi:format-color-fill", selectedOption = "black", options = {
                    { id = "black",       label = "Fundo Escurecido" },
                    { id = "transparent", label = "Totalmente Transparente" },
                    { id = "blur",        label = "Blur (Opaco)" },
                }, tooltip = "Cor do fundo do inventário" },
            },
        },
        slideRanges  = { title = "", options = {} },
        selects      = { title = "", options = {} },
        colorPickers = { title = "", options = {} },
    },
    {
        title = "Desempenho",
        toggles = {
            title = "Configurações",
            options = {
                { id = "fps-boost", title = "Otimização (FPS)", icon = "mdi:speedometer", active = false, description = "Ativa o modo de otimização de FPS.", className = "" },
                { id = "fps-counter", title = "Contador de FPS", icon = "mdi:chart-line", active = false, description = "Mostra o FPS na HUD, embaixo do horário.", className = "" },
            },
        },
        multiSelects = { title = "", options = {} },
        slideRanges  = { title = "", options = {} },
        selects      = { title = "", options = {} },
        colorPickers = { title = "", options = {} },
    },
}

-- Secoes (chave no menu -> tipo logico da opcao)
local SECTIONS = {
    { key = "toggles",      kind = "toggle" },
    { key = "multiSelects", kind = "multiSelect" },
    { key = "slideRanges",  kind = "slideRange" },
    { key = "selects",      kind = "select" },
    { key = "colorPickers", kind = "colorPicker" },
}

-- Mapeamento das opcoes do menu "Clima" -> tipo de clima do GTA
-- (reaproveita o comando /clima existente via ExecuteCommand, mesma logica)
local WEATHER_MAP = {
    ["sunny"]         = "EXTRASUNNY",
    ["clear"]         = "CLEAR",
    ["partly-cloudy"] = "CLOUDS",
    ["fog"]           = "FOGGY",
    ["clearing"]      = "CLEARING",
    ["storm"]         = "THUNDER",
}

-- ----------------------------------------------------------------
-- HELPERS
-- ----------------------------------------------------------------
local function deepcopy(t)
    if type(t) ~= "table" then return t end
    local out = {}
    for k, v in pairs(t) do
        out[k] = deepcopy(v)
    end
    return out
end

local function slug(str)
    return (tostring(str):lower():gsub("[^%w]+", "-"):gsub("^%-+", ""):gsub("%-+$", ""))
end

local function isValidHexColor(str)
    return type(str) == "string" and str:match("^#%x%x%x%x%x%x$") ~= nil
end

local function contains(list, value)
    for _, v in ipairs(list) do
        if v == value then return true end
    end
    return false
end

-- multiSelect: `options` pode ser lista de strings OU de { id, label }.
-- Extrai so os ids (valores realmente persistidos/enviados).
local function extractIds(options)
    local ids = {}
    for _, o in ipairs(options) do
        ids[#ids + 1] = (type(o) == "table") and o.id or o
    end
    return ids
end

local function clamp(n, min, max)
    if n < min then return min end
    if n > max then return max end
    return n
end

-- ----------------------------------------------------------------
-- INDICE  (id da opcao -> metadados: onde vive, tipo, restricoes)
-- Construido 1x a partir do template `Menus`.
-- ----------------------------------------------------------------
local Index = {}

local function buildIndex()
    Index = {}
    for _, menu in ipairs(Menus) do
        local menuSlug = slug(menu.title)
        for _, section in ipairs(SECTIONS) do
            local block = menu[section.key]
            if block and block.options then
                for _, opt in ipairs(block.options) do
                    Index[opt.id] = {
                        kind      = section.kind,
                        sectionKey = section.key,
                        menuTitle = menu.title,
                        menuSlug  = menuSlug,
                        optionIds = opt.options and extractIds(opt.options) or nil, -- multiSelect (ids)
                        min       = opt.min,       -- slideRange
                        max       = opt.max,       -- slideRange
                    }
                end
            end
        end
    end
end
buildIndex()

-- ----------------------------------------------------------------
-- KVP  (tudo em string; nil = nao salvo = usa o default do template)
--   toggle/multiSelect/slideRange/colorPicker -> "hud:menu:opt:<id>"
--   select (radio)                            -> "hud:menu:sel:<menuSlug>"
-- ----------------------------------------------------------------
local function kvpGet(key)
    return GetResourceKvpString(key)
end

local function kvpSet(key, value)
    SetResourceKvp(key, tostring(value))
end

-- ----------------------------------------------------------------
-- PONTE  (fonte da verdade dessas configs = outro resource, NAO o KVP do hud)
--   source = "esc"   -> europa_esc  (category/index/kind: toggle|multiSelect|otimization)
--   source = "radio" -> europa_radio (kind: animation|volume)
--   source = "boost" -> europa_boost (kind: counter)
-- Leem/gravam via exports, mantendo garagem/inventory/fps/radio em sincronia.
-- ----------------------------------------------------------------
local Bridge = {
    ["veh-autolock"]          = { source = "esc",   category = "Veiculo",    index = 1, kind = "toggle" },
    ["veh-autolock-distance"] = { source = "esc",   category = "Veiculo",    index = 2, kind = "multiSelect" },
    ["inv-item-info"]         = { source = "esc",   category = "Inventario", index = 2, kind = "toggle" },
    ["inv-background"]        = { source = "esc",   category = "Inventario", index = 1, kind = "multiSelect" },
    ["radio-ped-animation"]   = { source = "esc",   category = "Radio",      index = 1, kind = "multiSelect" },
    ["fps-boost"]             = { source = "esc",   kind = "otimization" },
    ["fps-counter"]           = { source = "boost", kind = "counter" },
    ["radio-animation"]       = { source = "radio", kind = "animation" },
    ["radio-volume"]          = { source = "radio", kind = "volume" },
    -- Contorno/nome da party (verdade vive no europa_party via Get/SetOutlineOption)
    ["party-outline"]         = { source = "party", optId = "enabled",     kind = "toggle" },
    ["party-outline-name"]    = { source = "party", optId = "nameEnabled", kind = "toggle" },
    ["party-outline-color"]   = { source = "party", optId = "color",       kind = "colorPicker" },
    ["party-name-color"]      = { source = "party", optId = "nameColor",   kind = "colorPicker" },
    -- Stance de arma baixada (verdade vive no europa_scripts/client/weaponstance.lua)
    ["weapon-stance"]         = { source = "scripts", kind = "weaponStance" },
}

local function resReady(name)
    return GetResourceState(name) == "started"
end

local function bridgeGet(b)
    if b.source == "esc" then
        if not resReady("europa_esc") then return nil end
        local ok, val = pcall(function()
            if b.kind == "toggle" then
                return exports["europa_esc"]:GetToggleConfig(b.category, b.index)
            elseif b.kind == "multiSelect" then
                return exports["europa_esc"]:GetMultiSelectConfig(b.category, b.index)
            elseif b.kind == "otimization" then
                return exports["europa_esc"]:GetOtimization()
            end
        end)
        if ok then return val end
    elseif b.source == "radio" then
        if not resReady("europa_radio") then return nil end
        local ok, val = pcall(function()
            if b.kind == "animation" then
                return exports["europa_radio"]:GetRadioAnimationId()
            elseif b.kind == "volume" then
                return exports["europa_radio"]:GetRadioVolume()
            end
        end)
        if ok then return val end
    elseif b.source == "party" then
        if not resReady("europa_party") then return nil end
        local ok, val = pcall(function()
            return exports["europa_party"]:GetOutlineOption(b.optId)
        end)
        if ok then return val end
    elseif b.source == "boost" then
        if not resReady("europa_boost") then return nil end
        local ok, val = pcall(function()
            if b.kind == "counter" then
                return exports["europa_boost"]:isCounterVisible()
            end
        end)
        if ok then return val end
    elseif b.source == "scripts" then
        if not resReady("europa_scripts") then return nil end
        local ok, val = pcall(function()
            if b.kind == "weaponStance" then
                return exports["europa_scripts"]:GetWeaponStanceEnabled()
            end
        end)
        if ok then return val end
    end
    return nil
end

local function bridgeSet(b, value)
    if b.source == "esc" then
        if not resReady("europa_esc") then return false end
        local ok, res = pcall(function()
            if b.kind == "toggle" then
                return exports["europa_esc"]:SetToggleConfig(b.category, b.index, value)
            elseif b.kind == "multiSelect" then
                return exports["europa_esc"]:SetMultiSelectConfig(b.category, b.index, value)
            elseif b.kind == "otimization" then
                return exports["europa_esc"]:SetOtimization(value)
            end
        end)
        return ok and res ~= false
    elseif b.source == "radio" then
        if not resReady("europa_radio") then return false end
        local ok, res = pcall(function()
            if b.kind == "animation" then
                return exports["europa_radio"]:SetRadioAnimation(value)
            elseif b.kind == "volume" then
                return exports["europa_radio"]:SetRadioVolume(value)
            end
        end)
        return ok and res ~= false
    elseif b.source == "party" then
        if not resReady("europa_party") then return false end
        local ok, res = pcall(function()
            return exports["europa_party"]:SetOutlineOption(b.optId, value)
        end)
        return ok and res ~= false
    elseif b.source == "boost" then
        if not resReady("europa_boost") then return false end
        -- Aqui vale o pcall, nao o retorno: setCounterVisible devolve o estado aplicado, e
        -- desligar o contador devolveria `false` — o que seria lido como falha.
        local ok = pcall(function()
            if b.kind == "counter" then
                exports["europa_boost"]:setCounterVisible(value)
            end
        end)
        return ok
    elseif b.source == "scripts" then
        if not resReady("europa_scripts") then return false end
        -- Devolve false de proposito quando a chave geral da cidade esta desligada:
        -- o front so aplica o switch se o Lua confirmar.
        local ok, res = pcall(function()
            if b.kind == "weaponStance" then
                return exports["europa_scripts"]:SetWeaponStanceEnabled(value)
            end
        end)
        return ok and res ~= false
    end
    return false
end

-- ----------------------------------------------------------------
-- OVERLAY  (aplica o estado salvo por cima de uma copia do template)
-- ----------------------------------------------------------------
local function buildMenusWithState()
    local menus = deepcopy(Menus)

    for _, menu in ipairs(menus) do
        local menuSlug = slug(menu.title)

        -- toggles
        for _, opt in ipairs(menu.toggles.options) do
            local bridge = Bridge[opt.id]
            if bridge then
                local v = bridgeGet(bridge)
                if type(v) == "boolean" then opt.active = v end
            else
                local saved = kvpGet("hud:menu:opt:" .. opt.id)
                if saved ~= nil then opt.active = (saved == "1") end
            end
        end

        -- multiSelects
        for _, opt in ipairs(menu.multiSelects.options) do
            local bridge = Bridge[opt.id]
            if bridge then
                local v = bridgeGet(bridge)
                if type(v) == "string" and contains(extractIds(opt.options), v) then
                    opt.selectedOption = v
                end
            else
                local saved = kvpGet("hud:menu:opt:" .. opt.id)
                if saved ~= nil and contains(opt.options, saved) then
                    opt.selectedOption = saved
                end
            end
        end

        -- slideRanges
        for _, opt in ipairs(menu.slideRanges.options) do
            local bridge = Bridge[opt.id]
            if bridge then
                local v = tonumber(bridgeGet(bridge))
                if v ~= nil then opt.value = clamp(math.floor(v + 0.5), opt.min, opt.max) end
            else
                local saved = tonumber(kvpGet("hud:menu:opt:" .. opt.id))
                if saved ~= nil then
                    opt.value = clamp(math.floor(saved + 0.5), opt.min, opt.max)
                end
            end
        end

        -- selects (radio por grupo)
        local selectedId = kvpGet("hud:menu:sel:" .. menuSlug)
        if selectedId ~= nil then
            for _, opt in ipairs(menu.selects.options) do
                opt.selected = (opt.id == selectedId)
            end
        end

        -- colorPickers
        for _, opt in ipairs(menu.colorPickers.options) do
            local bridge = Bridge[opt.id]
            if bridge then
                local v = bridgeGet(bridge)
                if isValidHexColor(v) then opt.color = v end
            else
                local saved = kvpGet("hud:menu:opt:" .. opt.id)
                if isValidHexColor(saved) then opt.color = saved end
            end
        end
    end

    return menus
end

-- ----------------------------------------------------------------
-- EFEITOS  (so o que precisa de nativo/outro resource; resto e front)
-- ----------------------------------------------------------------
local function applyWeather(optionId)
    local weather = WEATHER_MAP[optionId]
    if weather then
        ExecuteCommand(("clima %s"):format(weather))
    end
end

local Effects = {}

-- selects do menu "Clima" -> aplica o clima (mesma logica do /clima)
for optionId in pairs(WEATHER_MAP) do
    Effects[optionId] = function() applyWeather(optionId) end
end

-- Combat FX (mira, marcador de dano, efeito de kill, sons de acerto/kill)
-- O estado vive em client-side/combatfx.lua; aqui so notificamos ao vivo.
local COMBAT_FX_IDS = {
    "crosshair", "crosshair-type", "crosshair-color",
    "damage-marker", "marker-color",
    "kill-effect", "hit-sound", "kill-sound", "hit-volume",
}
for _, id in ipairs(COMBAT_FX_IDS) do
    Effects[id] = function(value)
        if HudCombatFX and HudCombatFX.set then
            HudCombatFX.set(id, value)
        end
    end
end

-- Aplica o efeito Lua da opcao (se houver). Tudo mais e persist-only (front aplica).
local function applyEffect(optionId, value)
    local fn = Effects[optionId]
    if fn then fn(value) end
end

-- ----------------------------------------------------------------
-- VALIDACAO + PERSISTENCIA  (nunca confiar no valor cru do cliente)
-- Retorna: ok(boolean), valueAplicado
-- ----------------------------------------------------------------
local function validateAndPersist(option)
    if type(option) ~= "table" or type(option.id) ~= "string" then
        return false
    end

    local meta = Index[option.id]
    if not meta then return false end

    local bridge = Bridge[option.id]

    if meta.kind == "toggle" then
        local active = option.active == true
        if bridge then
            if not bridgeSet(bridge, active) then return false end
        else
            kvpSet("hud:menu:opt:" .. option.id, active and "1" or "0")
        end
        return true, active

    elseif meta.kind == "multiSelect" then
        local sel = option.selectedOption
        if type(sel) ~= "string" or not contains(meta.optionIds, sel) then
            return false
        end
        if bridge then
            if not bridgeSet(bridge, sel) then return false end
        else
            kvpSet("hud:menu:opt:" .. option.id, sel)
        end
        return true, sel

    elseif meta.kind == "slideRange" then
        local val = tonumber(option.value)
        if val == nil then return false end
        val = clamp(math.floor(val + 0.5), meta.min, meta.max)
        if bridge then
            if not bridgeSet(bridge, val) then return false end
        else
            kvpSet("hud:menu:opt:" .. option.id, val)
        end
        return true, val

    elseif meta.kind == "select" then
        -- radio: escolher esta opcao = grupo passa a apontar pra ela
        kvpSet("hud:menu:sel:" .. meta.menuSlug, option.id)
        return true, option.id

    elseif meta.kind == "colorPicker" then
        local color = option.color
        if not isValidHexColor(color) then return false end
        if bridge then
            if not bridgeSet(bridge, color) then return false end
        else
            kvpSet("hud:menu:opt:" .. option.id, color)
        end
        return true, color
    end

    return false
end

-- ----------------------------------------------------------------
-- NUI CALLBACKS
-- ----------------------------------------------------------------
RegisterNUICallback("get:menu:list", function(_, cb)
    cb(buildMenusWithState())
end)

RegisterNUICallback("post:menu:changeOption", function(data, cb)
    local option = data and data.option
    local ok, value = validateAndPersist(option)
    if not ok then
        cb(false)
        return
    end

    applyEffect(option.id, value)
    cb(true)
end)

-- ----------------------------------------------------------------
-- REAPLICAR EFEITOS PERSISTIDOS AO CARREGAR  (clima)
-- ----------------------------------------------------------------
CreateThread(function()
    -- espera o player entrar de fato (comando /clima registrado no europa_scripts)
    while not NetworkIsPlayerActive(PlayerId()) do Wait(500) end
    Wait(2000)

    local savedWeather = kvpGet("hud:menu:sel:clima")
    if savedWeather and WEATHER_MAP[savedWeather] then
        applyWeather(savedWeather)
    end
end)
