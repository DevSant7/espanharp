
# Fortal AirDrop

Sistema de AirDrop desenvolvida para **Fortal Roleplay**

Tecnologias utilizadas:
 - 
 [Lua](https://www.lua.org/)
 [FxDK](https://docs.fivem.net/docs/)
 [vRP](https://github.com/vRP-framework/vRP)

### Configuração Geral

É necessário fazer modificações no chest do seu servidor para que o mesmo possa identificar o baú criado dinamicamente pelo AirDrop, adicione verificações caso o chestName incluir "AirDrop" e assim passar mesmo esse chest não existinto. Um exemplo disso é o HeliCrash

Utilize o arquivo `Config.lua` para modificar e adicionar dados na concessionária

```lua
Config = {  
    Drop = {
        Times = {
            Start = {22, 0}, -- Coloque o horário que ele tem que começar com hora e minute
            Decrease = 30, -- Coloque o tempo em minutos que ele vai avisar antes do evento começar
            Plane = 5, -- Coloque o tempo em minutos de quanto antes do Start o avião vai ser criado
            Delete = 30 -- Coloque o tempo em minutos de em quanto tempo o AirDrop vai ser deletado após ele dropar no chão
        },
        DangerZone = {
            Radius = 50.0, -- Coloque o raio da zona vermelha
            Alpha = 128, -- Coloque a opacidade (0 - 255)
            Color = { 152, 0, 0 } -- Coloque a cor seguindo o formato RGB
        },
        Days = {"Monday", "Wednesday", "Friday"}, -- Coloque os dias que o AirDrop vai cair automaticamente em inglês com capitalização
        Height = 500, -- Coloque a altura que o avião estará
        Plane = "titan", -- Coloque o modelo do avião
        Distance = 2000, -- Coloque a distancia que o avião será criado, essa distancia é do raio completo, ou seja multiplique por 2
        Decrease = 0.01, -- Coloque o rate de diminuição da altura do AirDrop
        Object = {
            Box = "gr_prop_gr_rsply_crate04a", -- Coloque o modelo do objeto de caixa do AirDrop
            Parachute = "p_cargo_chute_s", -- Coloque o modelo do objeto de paraquedas do AirDrop
            Flare = "prop_flare_01" -- Coloque o modelo do objeto de sinalizador
        }
    },

    Alert = {
        Chat = { -- Coloque o "Title" e o "Message" para as mensagens de chat em cada estagio, "Start" é quando o evento iniciado e o "Dropping" é quando o AirDrop começa a cair
            Start = {
                Title = "AirDrop",
                Message = "O evento de AirDrop começou, ele cairá em breve!"
            },
            Dropping = {
                Title = "AirDrop",
                Message = "O AirDrop começou a cair agora, vá até o local para coleta-lo!"
            }
        },

        Sound = { -- Coloque o "Name e o "Volume" para o som no estágio de inicio do evento
            Name = "alarm",
            Volume = 0.1
        }
    },

    Blips = { -- Adicione "Sprite", "Colour" e "Text" para o blip que irá aparecer em cada estágio do evento
        Delay = {
            Sprite = 161,
            Colour = 1,
            Text = "AirDrop"
        },
        OnDrop = {
            Sprite = 550,
            Colour = 30,
            Text = "AirDrop"
        },
        Dropped = {
            Sprite = 478,
            Colour = 30,
            Text = "AirDrop"
        }
    },

    Particle = { -- Coloque o "Dict" e o "Name" da particula de sinalizador
        Dict = "core", 
        Name = "exp_grd_flare"
    },

    Locations = { -- Adicione seguindo o exemplo as possiveis localizações do AirDrop que será alguma dessas aleatoriamente
        { x = -1237.22, y = 102.86, z = 56.67 },
        { x = -1821.2, y = -752.45, z = 8.41 },
        { x = -1170.5, y = -1748.32, z = 3.99 },
        { x = -126.97, y = -2432.26, z = 6.0 },
        { x = 1349.03, y = -2733.29, z = 2.11 },
        { x = 2780.19, y = -711.92, z = 5.37 },
        { x = 2722.26, y = 1378.08, z = 24.52 },
        { x = 2951.0, y = 2797.19, z = 40.96 },
        { x = 3277.86, y = 5214.08, z = 18.28 },
        { x = 922.83, y = 6618.22, z = 3.52 },
        { x = -939.69, y = 6180.49, z = 4.16 },
        { x = -1577.6, y = 5161.52, z = 19.73 },
        { x = -3007.37, y = 3409.72, z = 10.19 },
        { x = -3086.69, y = 561.79, z = 2.36 },
        { x = -1885.81, y = 2521.88, z = 4.03 }
    },

    Items = { -- Adicione o spawn do item e além disso caso a quantidade dele seja aleatoria adicione "amount" como uma tabela contendi valor "min" e "max". Caso seja um valor individual apenas o adicione
        { spawn = "WEAPON_PISTOL_AMMO", amount = { min = 10, max = 20 } },
        { spawn = "lockpick2", amount = 1 },
        { spawn = "meth", amount = { min = 3, max = 6 } },
        { spawn = "dollarsroll", amount = { min = 3000, max = 6000 } }
    }
}
```