-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------

-- Deixe com verdadeiro
NotifyConfig = true
-- Aqui voce pode notificar o player apos pegar seu carro inicial
NotifySuccess =
"Nossa equipe da administração está muito feliz em ter você conosco, trabalhamos incansavelmente para desenvolver o melhor ambiente para sua diversão, conte conosco e saiba que o nosso discord está aberto para <b>dúvidas</b>, <b>sugestões</b> e afins.<br><br>Tenha uma ótima estadia e um bom jogo.<br>Divirta-se!"
-- Aqui voce pode notificar o player apos não conseguir pegar o carro
NotifyFailed = "Você já resgatou o seu prêmio inicial!"


--- Maximo de veiculos
MaxVehicles = 20


---- Lista de veiculos  (OBS: A quantidade maxima de veiculos são 4 )

Vehicles = {
    {
        id = 1,
        name = "toros",         -- Deixe o nome do carro como maiusculo quando salvar na base e poem o nome dele aqui
        subName = "VEICULO", -- Nome de destaque do carro
        photo = "toros",          -- foto que sera do carro
    },
    {
        id = 2,
        name = "bestiagts",     -- Deixe o nome do carro como maiusculo quando salvar na base e poem o nome dele aqui
        subName = "VEICULO",  -- Nome de destaque do carro
        photo = "bestiagts", -- foto que sera do carro
    },
    {
        id = 3,
        name = "sultanrs",     -- Deixe o nome do carro como maiusculo quando salvar na base e poem o nome dele aqui
        subName = "VEICULO",  -- Nome de destaque do carro
        photo = "sultanrs", -- foto que sera do carro
    },
    {
        id = 4,
        name = "esskey",             -- Deixe o nome do carro como maiusculo quando salvar na base e poem o nome dele aqui
        subName = "MOTOCICLETA", -- Nome de destaque do carro
        photo = "esskey",            -- foto que sera do carro
    },
}
