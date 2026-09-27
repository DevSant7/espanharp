-- =====================================================
-- CONTADOR DE FPS
-- O numero e medido aqui, mas quem manda mostrar ou nao e o europa_boost: a preferencia vive no
-- painel de otimizacao (e no KVP dele). Sem o europa_boost rodando o contador simplesmente nao
-- aparece, entao a hud nao depende dele para funcionar.
-- =====================================================
local BOOST_RESOURCE = "europa_boost"
local SAMPLE_INTERVAL = 100
local PUSH_INTERVAL = 500
local WINDOW = 10

local showFps = false
local lastPushed = -1

---@param enabled boolean
local function setVisible(enabled)
    local state = enabled == true

    if showFps == state then return end

    showFps = state
    lastPushed = -1

    SendNUIMessage({ action = "set:hud", data = { showFps = state } })
end

RegisterNetEvent("europa_boost:counter", setVisible)
AddEventHandler("europa_boost:counter", setVisible)

-- A hud pode subir antes ou depois do painel: alem do evento, perguntamos uma vez no start.
CreateThread(function()
    Wait(3000)

    if GetResourceState(BOOST_RESOURCE) ~= "started" then return end

    local ok, enabled = pcall(function()
        return exports[BOOST_RESOURCE]:isCounterVisible()
    end)

    if ok then
        setVisible(enabled)
    end
end)

CreateThread(function()
    local samples = {}
    local cursor = 0
    local nextPush = 0

    while true do
        if not showFps then
            -- Zerado enquanto escondido: nada de medir de graca.
            samples = {}
            cursor = 0
            Wait(1000)
        else
            local frameTime = GetFrameTime()

            if frameTime > 0 then
                local fps = 1.0 / frameTime

                if fps == fps and fps ~= math.huge then
                    cursor = (cursor % WINDOW) + 1
                    samples[cursor] = fps
                end
            end

            if GetGameTimer() >= nextPush then
                nextPush = GetGameTimer() + PUSH_INTERVAL

                local total, count = 0, 0

                for i = 1, WINDOW do
                    if samples[i] then
                        total = total + samples[i]
                        count = count + 1
                    end
                end

                local average = count > 0 and math.floor((total / count) + 0.5) or 0

                if average ~= lastPushed then
                    lastPushed = average
                    SendNUIMessage({ action = "set:hud", data = { fps = average } })
                end
            end

            Wait(SAMPLE_INTERVAL)
        end
    end
end)
