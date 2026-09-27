-----------------------------------------------------------------------
-- MOSTRAR OU ESCONDER BINDS DO INVENTÁRIO
-----------------------------------------------------------------------
local bindst = false 
RegisterCommand("activeTab", function(_, args, rawCommand)
    if bindst then 
        hideKeybinds()
        bindst = false 
    else
        bindst = true 
        showKeybinds()
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOWSHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function showKeybinds()
    -- O painel de atalhos mora na página da HUD e responde ao TAB — a MESMA tecla do placar
    -- dos eventos e da arena. Com a HUD escondida ele não deveria nem ser pedido: segurar
    -- TAB numa partida mandava a cidade desenhar por cima do placar assim que alguém
    -- religasse a HUD. Ver a trava em `client.lua`.
    if HudVisible == false then return end

    SendNUIMessage({
        action = 'inventory:binds',
        data = true -- ou false
    })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDESHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
function hideKeybinds()
    SendNUIMessage({
        action = 'inventory:binds',
        data = false -- ou false
    })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDESHORTCUTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("+shortcuts",showKeybinds)
RegisterCommand("-shortcuts",hideKeybinds)
