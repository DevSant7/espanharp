local statusExamples = {
    waiting = {             -- enviar para o jogador quando ele fizer chamado
        status = "waiting", -- waiting || request || accepted
        averageWaitingSeconds = 79,
    },
    request = {             -- enviar para o staff com o nome do player q fez o chamado
        status = "request", -- waiting || request || accepted
        player = { name = "Miguel Facca", id = 1923 },
    },
    accepted = {             -- mostrar pro jogador com o staff do staff q aceitou
        status = "accepted", -- waiting || request || accepted
        staff = { name = "Dravin Muniz", id = 381 },
    },
}

RegisterNetEvent("hud:call.set",function(payload)
    SendNUIMessage({ action = "set:call", data = payload })
end)


RegisterCommand("hud:call.remove", function()
    TriggerServerEvent("adminpanel:CallFinishPlayer")
    SendNUIMessage({ action = "set:call", data = false })
end)

RegisterKeyMapping("hud:call.remove", "[PAINELCHAMADOS] remover chamado", "keyboard", "F7")