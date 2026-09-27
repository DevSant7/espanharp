
# Fortal Character

Sistema de personagem desenvolvida para **Fortal Roleplay**

Tecnologias utilizadas:
 - 
 [Lua](https://www.lua.org/)
 [FxDK](https://docs.fivem.net/docs/)
 [vRP](https://github.com/vRP-framework/vRP)
 [ReactJs](https://pt-br.legacy.reactjs.org/)
 [TypeScript](https://www.typescriptlang.org/)
 [TailwindCSS](https://tailwindcss.com/)

### Configuração Geral

Utilize o arquivo `Config.lua` para modificador os dados do sistema

```lua
Config = {
    Color = {60, 142, 220}, -- Cor do servidor em formato RGB
    AssetsUrl = "http://localhost/fortal-character/", -- URL base de onde serão chamados os assets dos modulos

    Anim = { -- Animação que será executada dentro dos modulos (troque para false caso nao queira)
        Dict = "mp_sleep",
        Name = "bind_pose_180"
    },

    Cameras = { -- Adicione o index sendo o ID, na tabela, adicione distancia, diferença de altura e diferença de altura do apontamento
        ['fullbody'] = { distance = 1.4, height = 0, pointOffSet = 0 },
        ['face'] = { distance = 0.7, height = 0.65, pointOffSet = 0.65 },
        ['torso'] = { distance = 1.0, height = 0.15, pointOffSet = 0.15 },
        ['feet'] = { distance = 1.2, height = -0.4, pointOffSet = -0.65 },
        ['eyes'] = { distance = 0.3, height = 0.70, pointOffSet = 0.70 },
        ['hair'] = { distance = 0.4, height = 0.65, pointOffSet = 0.65 },
        ['lips'] = { distance = 0.3, height = 0.65, pointOffSet = 0.65 },
        ['neck'] = { distance = 0.3, height = 0.55, pointOffSet = 0.60 },   
        ['chin'] = { distance = 0.3, height = 0.60, pointOffSet = 0.60 },
        ['nose'] = { distance = 0.35, height = 0.65, pointOffSet = 0.65 },
    }
}
```
OBS: Os assets/imagens dos modulos devem ser inseridos se baseando na pasta assets que há presente.

### Modulo - Seleção de Personagem

Utilize o arquivo `config/Selector.lua` para modificador os dados do sistema

```lua
Config.Selector = { 
    Main = vec3(-777.54,331.47,211.4), -- Coordenada do ponto central do local de seleção
    Spawns = { -- Spawns dos personagems, com suas respectivas coordendas e animações
        { -- SENTADO NA POLTRONA
            Coords = { x = -793.43, y = 341.39, z = 206.21, h = 238.12 }, -- Coordenada que o PED irá spawnar
            Anim = { -- Animação que será executada pelo ped, caso não deseje apenas retire o Anim
                Dict = "timetable@ron@ig_5_p3",
                Name = "ig_5_p3_base"
            },
            Camera = { -- Coordenadas de spawn e de apontamento da camera
                Coords = { x = -793.23, y = 340.8, z = 206.21 },
                Point = { x = -793.43, y = 341.39, z = 206.21 }
            }
        },
        { -- SENTADO NO QUARTO
            Coords = { x = -790.66, y = 340.65, z = 201.42, h = 96.38 },
            Anim = {
                Dict = "timetable@ron@ig_3_couch",
                Name = "base"
            },
            Camera = {
                Coords = { x = -791.26, y = 339.95, z = 201.42 },
                Point = { x = -790.66, y = 340.65, z = 201.42 },
            }
        }
    },
    Cameras = { -- Configurando as cameras cinematograficas, é recomendado que se use apenas 2 por vez para uma animação mais fluida
        {
            Duration = 12000, -- Rempo que vai demorar para a transição de uma camera para outra
            List = { -- Coordenadas de onde ela vai começar e onde vai apontar e em seguida coloque a da camera que ela vai ir em direção, tanto a coordenada quanto o apontamento
                {
                    Coords = { x = -797.09, y = 335.62, z = 201.41 },
                    Point = { x = -796.04, y = 342.89, z = 201.41 }
                },
                {
                    Coords = { x = -786.35, y = 336.11, z = 201.41 },
                    Point = { x = -787.09, y = 341.61, z = 201.41 }
                }
            }
        },
        {
            Duration = 20000,
            List = {
                {
                    Coords = { x = -779.52, y = 341.71, z = 207.62 },
                    Point = { x = -787.66, y = 338.35, z = 206.21 }
                },
                {
                    Coords = { x = -800.83, y = 334.5, z = 206.21 },
                    Point = { x = -797.68, y = 328.24, z = 206.21 }
                }
            }
        }
    }
}
```

### Modulo - Criação de Personagem

Utilize o arquivo `config/Creator.lua` para modificar os dados do sistema

```
Config.Creator = {
    Coords = { x = -793.42, y = 326.06, z = 210.79, h = 357.17 }, -- Coordenadas de onde o jogador vai entrar na criação
    Spawn = { x = -1038.18, y = -2738.68, z = 13.82, h = 330.54}, -- Coordenadas de onde o jogador vai spawnar ao ele terminar
    Cutscene = false,

    Default = {
        Appearance = { -- Aparência default ao entrar na criação
            eyesColor = 0, eyesOpening = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0,
            noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0,
            cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0,
            jawHeight = 0, chinLength = 0, chinPosition = 0,
            chinWidth = 0, chinShape = 0, neckWidth = 0,
            hair = -1, hairColor = 0, hairSecondColor = 0, eyebrow = 0, eyebrowColor = 0,
            beard = -1, beardColor = 0, chest = -1, chestColor = 0, blush = -1, blushColor = 0, lipstick = -1, lipstickColor = 0,
            blemishes = -1, ageing = -1, complexion = -1, sundamage = -1, freckles = -1, makeup = -1
        },
        Clothes = { -- Roupas default ao entrar na criação
            ["mask"] = { ["m"] = { item = -1, texture = 0}, ["f"] = { item = -1, texture = 0} },
            ["arms"] = { ["m"] = { item = 15, texture = 0}, ["f"] = { item = 15, texture = 0} },
            ["pants"] = { ["m"] = { item = 61, texture = 0}, ["f"] = { item = 17, texture = 0} },
            ["backpack"] = { ["m"] = { item = 0,  texture =0}, ["f"] = { item = 0, texture = 0} },  
            ["shoes"] = { ["m"] = { item = 34, texture = 0}, ["f"] = { item = 35, texture = 0} },
            ["accessory"] = { ["m"] = { item = 0,  texture =0}, ["f"] = { item = 0, texture = 0} }, 
            ["tshirt"] = { ["m"] = { item = 15, texture = 0}, ["f"] = { item = 15, texture = 0} }, 
            ["vest"] = { ["m"] = { item = 0,  texture =0}, ["f"] = { item = 0, texture = 0} },
            ["torso"] = { ["m"] = { item = 15, texture = 0}, ["f"] = { item = 18, texture = 0} },
            ["hat"] = { ["m"] = { item = 8,  texture =0}, ["f"] = { item = 57, texture = 0} },  
            ["glass"] = { ["m"] = { item = 0,  texture =0}, ["f"] = { item = 12, texture = 0} }
        }
    },

    Fathers = { -- Todos os pais com o index, ID e nome
        [1] = { id = 0, name = 'benjamin' },
        [2] = { id = 1, name = 'daniel' },
        [3] = { id = 2, name = 'joshua' },
        [4] = { id = 3, name = 'noah' },
        [5] = { id = 4, name = 'andrew' },
        [6] = { id = 5, name = 'joan' },
        [7] = { id = 6, name = 'alex' },
        [8] = { id = 7, name = 'isaac' },
        [9] = { id = 8, name = 'evan' },
        [10] = { id = 9, name = 'ethan' },
        [11] = { id = 10, name = 'vincent' },
        [12] = { id = 11, name = 'angel' },
        [13] = { id = 12, name = 'diego' },
        [14] = { id = 13, name = 'adrian' },
        [15] = { id = 14, name = 'gabriel' },
        [16] = { id = 15, name = 'michael' },
        [17] = { id = 16, name = 'santiago' },
        [18] = { id = 17, name = 'kevin' },
        [19] = { id = 18, name = 'louis' },
        [20] = { id = 19, name = 'samuel' },
        [21] = { id = 20, name = 'anthony' },
        [22] = { id = 42, name = 'claude' },
        [23] = { id = 43, name = 'niko' },
        [24] = { id = 44, name = 'john' },
    },

    Mothers = { -- Todos as mães com o index, ID e nome
        [1] = { id = 21, name = 'hannah' },
        [2] = { id = 22, name = 'audrey' },
        [3] = { id = 23, name = 'jasmine' },
        [4] = { id = 24, name = 'giselle' },
        [5] = { id = 25, name = 'amelia' },
        [6] = { id = 26, name = 'isabella' },
        [7] = { id = 27, name = 'zoe' },
        [8] = { id = 28, name = 'ava' },
        [9] = { id = 29, name = 'camila' },
        [10] = { id = 30, name = 'violet' },
        [11] = { id = 31, name = 'sophia' },
        [12] = { id = 32, name = 'evelyn' },
        [13] = { id = 33, name = 'nicole' },
        [14] = { id = 34, name = 'ashley' },
        [15] = { id = 35, name = 'grace' },
        [16] = { id = 36, name = 'brianna' },
        [17] = { id = 37, name = 'natalie' },
        [18] = { id = 38, name = 'olivia' },
        [19] = { id = 39, name = 'elizabeth' },
        [20] = { id = 40, name = 'charlotte' },
        [21] = { id = 41, name = 'emma' },
        [22] = { id = 45, name = 'misty' },
    },  

    -- Todos os valores abaixo, adicione o ID da modificação, o titulo, valor minimo, valor maximo, step e a camera, caso não queira camera apenas tirar

    Characteristics = {
        ["noseWidth"] = {
            title = "Largura do Nariz",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "nose"
        },
        ["noseLength"] = {
            title = "Comprimento do Nariz",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "nose"
        },
        ["noseBridge"] = {
            title = "Curvatura do Nariz",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "nose"
        },
        ["noseTip"] = {
            title = "Ponta do Nariz",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "nose"
        },
        ["noseShift"] = {
            title = "Deslocamento do Nariz",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "nose"
        },
        ["noseHeight"] = {
            title = "Altura do Nariz",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "nose"
        },
        ["cheekboneHeight"] = {
            title = "Altura das Bochechas",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "hair"
        },
        ["cheekboneWidth"] = {
            title = "Largura das Bochechas",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "hair"
        },
        ["cheeksWidth"] = {
            title = "Tamanho das Bochechas",
            min = 0.0,
            max = 0.99,
            step = 0.01,
            camera = "hair"
        },
        ["lips"] = {
            title = "Labios",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "lips"
        },
        ["jawWidth"] = {
            title = "Largura da Mandibula",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "hair"
        },
        ["jawHeight"] = {
            title = "Altura da Mandibula",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "hair"
        },
        ["chinLength"] = {
            title = "Tamanho do Queixo",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "chin"
        },
        ["chinPosition"] = {
            title = "Posição do Queixo",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "chin"
        },
        ["chinWidth"] = {
            title = "Largura do Queixo",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "chin"
        },
        ["chinShape"] = {
            title = "Forma do Queixo",
            min = 0.0,
            max = 0.99,
            step = 0.01,
            camera = "chin"
        },
        ["neckWidth"] = {
            title = "Largura do Pescoço",
            min = 0,
            max = 0.99,
            step = 0.01,
            camera = "neck"
        }
    },

    Appearance = {
        ["eyesColor"] = {
            title = "Cor dos Olhos",
            min = 0,
            max = 31,
            step = 1,
            camera = "eyes"
        },
        ["eyesOpening"] = {
            title = "Abertura dos Olhos",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "eyes"
        },
        ["eyebrowsHeight"] = {
            title = "Altura da Sobrancelha",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "eyes"
        },
        ["eyebrowsWidth"] = {
            title = "Largura da Sobrancelha",
            min = -0.99,
            max = 0.99,
            step = 0.01,
            camera = "eyes"
        },
        ["eyebrow"] = {
            title = "Sombrancelhas",
            min = 0,
            max = 33,
            step = 1,
            camera = "eyes"
        }, 
        ["eyebrowColor"] = {
            title = "Cor das Sombrancelhas",
            min = 0,
            max = 63,
            step = 1,
            camera = "eyes"
        }
    },

    Hair = {
        ["hair"] = {
            title = "Corte de Cabelo",
            min = 0,
            max = 79,
            step = 1,
            camera = "hair"
        },
        ["hairColor"] = {
            title = "Cor do Cabelo",
            min = 0,
            max = 63,
            step = 1,
            camera = "hair"
        },
        ["hairSecondColor"] = {
            title = "Luzes do Cabelo",
            min = 0,
            max = 63,
            step = 1,
            camera = "hair"
        },
        ["beard"] = {
            title = "Corte de Barba",
            min = -1,
            max = 28,
            step = 1,
            camera = "hair"
        },
        ["beardColor"] = {
            title = "Cor da Barba",
            min = -1,
            max = 63,
            step = 1,
            camera = "hair"
        },
        ["chest"] = {
            title = "Pelos Corporais",
            min = -1,
            max = 16,
            step = 1,
            camera = "torso"
        },
        ["chestColor"] = {
            title = "Cor dos Pelos Corporais",
            min = 0,
            max = 63,
            step = 1,
            camera = "torso"
        },
    }
}
```

### Modulo - Seleção de Spawn

Utilize o arquivo `config/Spawn.lua` para modificar os dados do sistema

```lua
Config.Spawn = {
    Locations = { -- Adicione o ID que deve ser o mesmo nome da imagem, o nome do spawn e a coordenada dele
        {
            id = "policedepartament",
            name = "DEPARTAMENTO DE POLICIA",
            coords = vec3(414.56, -988.81, 29.42)
        },
        {
            id = "pillboxhospital",
            name = "HOSPITAL PILLBOX",
            coords = vec3(290.97, -612.31, 43.39)
        },
        {
            id = "delperopier",
            name = "DEL PERO PIER",
            coords = vec3(-1646.09, -996.11, 13.01)
        },
        {
            id = "vinewoodgarage",
            name = "GARAGEM VINEWOOD",
            coords = vec3(364.7, 296.08, 103.47)
        }
    },

    CamHeights = { -- Adicione aqui quanto a camera vai descer a cada tempo, no caso do primeiro por exemplo vai ficar com 1500 de altura, no segundo 1000 enfim.
        [1] = 1500,
        [2] = 1000,
        [3] = 750,
        [4] = 400,
        [5] = 100 
    }
}
```

### Modulo - Loja de Roupas

Utilize o arquivo `config/Skinshop.lua` para modificar os dados do sistema

```lua
Config.Skinshop = {
    MarkerTitle = "LOJA DE ROUPAS", -- Adicione o titulo que aparecerá no marcador
	Command = { -- Adicione o comando e as permissões para abrir a loja de roupas em qualquer lugar
		Name = "skinshop",
		Permissions = {
			["Admin"] = 1
		}
	},

    Map = { -- Aqui serão as categorias que irão aparecer na loja de roupas, porem também serve como mapping, então não remova
        ["arms"] = { 
            id = "3",
            price = 300,
            camera = "torso"
        },
        ["backpack"] = { 
            id = "5",
            price = 300,
            camera = "torso"
        },
        ["tshirt"] = { 
            id = "8",
            price = 300,
            camera = "torso"
        },
        ["torso"] = { 
            id = "11",
            price = 300,
            camera = "torso"
        },
        ["pants"] = { 
            id = "4",
            price = 300,
            camera = "feet",
        },
        ["vest"] = { 
            id = "9",
            price = 300,
            camera = "torso"
        },
        ["shoes"] = { 
            id = "6",
            price = 300,
            camera = "feet"
        },
        ["mask"] = { 
            id = "1",
            price = 500,
            camera = "face"
        },
        ["hat"] = { 
            id = "p0",
            price = 300,
            camera = "face"
        },
        ["glass"] = { 
            id = "p1",
            price = 150,
            camera = "face"
        },
        ["ear"] = { 
            id = "p2",
            price = 130,
            camera = "face"
        },
        ["watch"] = { 
            id = "p6",
            price = 700,
            camera = "torso"
        },
        ["bracelet"] = { 
            id = "p8",
            price = 250,
            camera = "torso"
        },
        ["accessory"] = { 
            id = "7",
            price = 100,
            camera = "torso"
        },
        ["decals"] = { 
            id = "10",
            price = 300,
            camera = "torso"
        }
    },

    Locations = { -- Localizações das lojas de roupas, de coordenada e em seguida o raio de onde ele pode apertar para entrarla
        [1] = { x = 71.29, y = -1398.68, z = 29.37, radius = 2.0, viewRadius = 10.0 },
        [2] = { x = -708.56, y = -160.5, z = 37.41, radius = 2.0, viewRadius = 10.0 },
        [3] = { x = -158.76, y = -296.94, z = 39.73, radius = 2.0, viewRadius = 10.0 },
        [4] = { x = -829.08, y = -1073.27, z = 11.32, radius = 2.0, viewRadius = 10.0 },
        [5] = { x = -1192.23, y = -771.74, z = 17.32, radius = 2.0, viewRadius = 10.0 },
        [6] = { x = -1456.98, y = -241.17, z = 49.81, radius = 2.0, viewRadius = 10.0 },
        [7] = { x = 11.87, y = 6513.59, z = 31.88, radius = 2.0, viewRadius = 10.0 },
        [8] = { x = 1696.92, y = 4829.24, z = 42.06, radius = 2.0, viewRadius = 10.0 },
        [9] = { x = 122.93, y = -221.48, z = 54.56, radius = 2.0, viewRadius = 10.0 },
        [10] = { x = 617.77, y = 2761.81, z = 42.09, radius = 2.0, viewRadius = 10.0 },
        [11] = { x = 1190.79, y = 2714.29, z = 38.22, radius = 2.0, viewRadius = 10.0 },
        [12] = { x = -3173.28, y = 1046.04, z = 20.86, radius = 2.0, viewRadius = 10.0 },
        [13] = { x = -1108.61, y = 2709.59, z = 19.11, radius = 2.0, viewRadius = 10.0 },
        [14] = { x = 429.67, y = -800.14, z = 29.49, radius = 2.0, viewRadius = 10.0 }    
    }
}
```

### Modulo - Barbearia

Utilize o arquivo `config/Barbershop.lua` para modificar os dados do sistema

```lua
Config.Barbershop = {
    MarkerTitle = "BARBEARIA", -- Adicione o titulo que aparecerá no marcador
	Command = { -- Adicione o comando e as permissões para abrir a barbearia em qualquer lugar
		Name = "barbershop",
		Permissions = {
			["Admin"] = 1
		}
	},
    Map = { -- Aqui serão as categorias que irão aparecer na barbearia
        ["hair"] = {
            ["hair"] = {
                price = 250,
            },
            ["hairColor"] = {
                title = "Cor do Cabelo",
                min = 0,
                max = 63,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["hairSecondColor"] = {
                title = "Luzes do Cabelo",
                min = 0,
                max = 63,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["beard"] = {
                title = "Corte de Barba",
                min = -1,
                max = 28,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["beardColor"] = {
                title = "Cor da Barba",
                min = -1,
                max = 63,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["chest"] = {
                title = "Pelos Corporais",
                min = -1,
                max = 16,
                step = 1,
                price = 250,
                camera = "torso"
            },
            ["chestColor"] = {
                title = "Cor dos Pelos Corporais",
                min = 0,
                max = 63,
                step = 1,
                price = 250,
                camera = "torso"
            }
        },
        ["makeup"] = {
            ["blush"] = {
                title = "Blush",
                min = -1,
                max = 33,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["blushColor"] = {
                title = "Cor do Blush",
                min = 0,
                max = 63,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["lipstick"] = {
                title = "Batom",
                min = 0,
                max = 63,
                step = 1,
                price = 250,
                camera = "lips"
            },
            ["blemishes"] = {
                title = "Manchas",
                min = -1,
                max = 23,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["makeup"] = {
                title = "Maquiagem",
                min = -1,
                max = 81,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["ageing"] = {
                title = "Envelhecimento",
                min = -1,
                max = 14,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["complexion"] = {
                title = "Aspecto",
                min = -1,
                max = 11,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["complexion"] = {
                title = "Dano Solar",
                min = -1,
                max = 10,
                step = 1,
                price = 250,
                camera = "hair"
            },
            ["freckles"] = {
                title = "Sardas",
                min = -1,
                max = 17,
                step = 1,
                price = 250,
                camera = "hair"
            }
        }
    },

    Locations = { -- Aqui serão as categorias que irão aparecer na loja de roupas, porem também serve como mapping, então não remova
        [1] = { x = -815.59, y = -182.16, z = 37.56, radius = 2.0, viewRadius = 10.0 },
        [2] = { x = 138.72, y = -1705.26, z = 29.3, radius = 2.0, viewRadius = 10.0 },
        [3] = { x = -1282.00, y = -1118.86, z = 7.00, radius = 2.0, viewRadius = 10.0 },
        [4] = { x = 1934.11, y = 3730.73, z = 32.85, radius = 2.0, viewRadius = 10.0 },
        [5] = { x = 1211.07, y = -475.00, z = 66.21, radius = 2.0, viewRadius = 10.0 },
        [6] = { x = -34.97, y = -150.90, z = 57.08, radius = 2.0, viewRadius = 10.0 },
        [7] = { x = -280.37, y = 6227.01, z = 31.70, radius = 2.0, viewRadius = 10.0 },
        [8] = { x = -1740.94, y = 225.48, z = 60.31, radius = 2.0, viewRadius = 10.0 },
    }
}
```

### Modulo - Tattooshop

Utilize o arquivo `config/Tattooshop.lua` para modificar os dados do sistema

```lua
Config.Tattooshop = {
    MarkerTitle = "ESTUDIO DE TATUAGENS", -- Adicione o titulo que aparecerá no marcador
	Command = { -- Adicione o comando e as permissões para abrir o estudio de tatuagens em qualquer lugar
		Name = "tattooshop",
		Permissions = {
			["Admin"] = 1
		}
	},
    
	Map = {
		["m"] = { -- Coloque "m" ou "f" sinalizando para macho ou femea
			["head"] = { -- Adicione o ID da categoria
				Price = 250, -- Preço de cada item da categoria
				Camera = "face", -- Para qual camera essa categoria vai apontar
				List = {
					{ overlay = "MP_Gunrunning_Tattoo_003_M", collection = "mpgunrunning_overlays" },
					{ overlay = "MP_Buis_M_Neck_000", collection = "mpbusiness_overlays" },
					{ overlay = "MP_Buis_M_Neck_001", collection = "mpbusiness_overlays" },
					{ overlay = "MP_Buis_M_Neck_002", collection = "mpbusiness_overlays" },
					{ overlay = "MP_Buis_M_Neck_003", collection = "mpbusiness_overlays" },
					{ overlay = "MP_Smuggler_Tattoo_011_M", collection = "mpsmuggler_overlays" },
					{ overlay = "MP_Smuggler_Tattoo_012_M", collection = "mpsmuggler_overlays" },
					{ overlay = "mpHeist3_Tat_000_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_001_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_002_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_003_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_004_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_005_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_006_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_007_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_008_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_009_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_010_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_011_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_012_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_013_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_014_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_015_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_016_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_017_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_018_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_019_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_020_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_021_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_022_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_042_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_043_M", collection = "mpheist3_overlays" },
					{ overlay = "mpHeist3_Tat_044_M", collection = "mpheist3_overlays" },
					{ overlay = "MP_Xmas2_M_Tat_007", collection = "mpchristmas2_overlays" },
					{ overlay = "MP_Xmas2_M_Tat_024", collection = "mpchristmas2_overlays" },
					{ overlay = "MP_Xmas2_M_Tat_025", collection = "mpchristmas2_overlays" },
					{ overlay = "MP_Xmas2_M_Tat_029", collection = "mpchristmas2_overlays" },
					{ overlay = "MP_Bea_M_Head_000", collection = "mpbeach_overlays" },
					{ overlay = "MP_Bea_M_Head_001", collection = "mpbeach_overlays" },
					{ overlay = "MP_Bea_M_Head_002", collection = "mpbeach_overlays" },
					{ overlay = "MP_Bea_M_Neck_000", collection = "mpbeach_overlays" },
					{ overlay = "MP_Bea_M_Neck_001", collection = "mpbeach_overlays" },
					{ overlay = "MP_MP_Biker_Tat_009_M", collection = "mpbiker_overlays" },
					{ overlay = "MP_MP_Biker_Tat_038_M", collection = "mpbiker_overlays" },
					{ overlay = "MP_MP_Biker_Tat_051_M", collection = "mpbiker_overlays" },
					{ overlay = "FM_Hip_M_Tat_005", collection = "mphipster_overlays" },
					{ overlay = "FM_Hip_M_Tat_021", collection = "mphipster_overlays" },
					{ overlay = "FM_Tat_Award_M_000", collection = "multiplayer_overlays" },
					{ overlay = "MP_MP_Stunt_Tat_000_M", collection = "mpstunt_overlays" },
					{ overlay = "MP_MP_Stunt_tat_004_M", collection = "mpstunt_overlays" },
					{ overlay = "MP_MP_Stunt_tat_006_M", collection = "mpstunt_overlays" },
					{ overlay = "MP_MP_Stunt_tat_017_M", collection = "mpstunt_overlays" },
					{ overlay = "MP_MP_Stunt_tat_042_M", collection = "mpstunt_overlays" }
				},

                ...
```