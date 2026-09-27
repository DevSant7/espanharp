
# Fortal Dealership

Sistema de concessionária desenvolvida para **Fortal Roleplay**

Tecnologias utilizadas:
 - 
 [Lua](https://www.lua.org/)
 [FxDK](https://docs.fivem.net/docs/)
 [vRP](https://github.com/vRP-framework/vRP)
 [ReactJs](https://pt-br.legacy.reactjs.org/)
 [TypeScript](https://www.typescriptlang.org/)
 [TailwindCSS](https://tailwindcss.com/)

### Configuração Geral

Utilize o arquivo `Config.lua` para modificar e adicionar dados na concessionária

```lua
Config = {
    Color = {0, 140, 234}, -- Adicione a cor geral da HUD em RGB
    Images = "https://cdn.blacknetwork.com.br/conce/", -- Adicione o diretório das imagens do veículos, todos devem ser em formato PNG
    DefaultStock = 25, -- Adicione aqui a quantidade de estoque padrão para um veículo

    Peds = { -- Nesta secão você deve adicionara distancia que um PED será renderizado, o modelo dele, a animação que ele executará que pode ser nenhuma igualmente, e as coordenadas
        {
            Distance = 30,
            Model = "ig_paper",
            Anim = { dict = "anim@heists@heist_corona@single_team", set = "single_team_loop_boss" },
            Coords = { x = -56.51, y = -1098.55, z = 26.42, h = 31.19 }
        },
        {
            Distance = 30,
            Model = "ig_paper",
            Anim = { dict = "anim@heists@heist_corona@single_team", set = "single_team_loop_boss" },
            Coords = { x = -347.47, y = -133.41, z = 39.01, h = 249.45 }
        }
    },

    Show = {
        Coords = { -- Adicione aqui as coordenadas, serão baseadas na ordem dos peds
            { x = -44.82, y = -1097.48, z = 26.42, h = 68.04 },
            { x = -336.39, y = -137.31, z = 39.01, h = 68.04 },
        },
        Colors = { -- Adicione as cores que podem ser selecionadas para os veículos que pode ser achado em https://wiki.rage.mp/wiki/Vehicle_Colors
            { rgb = {218, 25, 24}, id = 28 },
            { rgb = {102, 184, 31}, id = 55 },
            { rgb = {11, 156, 241}, id = 70 },
            { rgb = {255, 255, 255}, id = 134 },
            { rgb = {13, 17, 22}, id = 0 }
        }
    },

    Types = {"super", "elétrico", "comum"}, -- Adicione as categorias dos veículos aqui em ordem de expansão
 
    Vehicles = { -- Adicione os veículos com a categoria, o nome, o spawn, o preço sendo primeiro o em dinheiro e depois em diamantes, caso não queira que possa ser comprado em diamantes apenas retire o segundo valor. Adicione igualmente se desejar as cores default em RGB a primária e secundaria que podem ser achadas em https://wiki.rage.mp/wiki/Vehicle_Colors
        {
            section = "super",
            name = "Adder",
            spawn = "adder",
            price = {125000, 25},
            defaultColors = {
                primary = {255, 255, 255},
                secondary = {25, 40, 81}
            }
        },
        {
            section = "comum",
            name = "Panto",
            spawn = "panto",
            price = {125000, 25},
        },
        {
            section = "elétrico",
            name = "Imorgon",
            spawn = "imorgon",
            price = {125000, 25},
        }
    }
}
```