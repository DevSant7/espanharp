Config.Creator = {
    Coords = { x = -793.42, y = 326.06, z = 210.79, h = 357.17 },
    Spawn = { x = -1038.18, y = -2738.68, z = 13.82, h = 330.54},
    Cutscene = true,

    Default = {
        Appearance = {
            eyesColor = 0, eyesOpening = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0,
            noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0,
            cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0,
            jawHeight = 0, chinLength = 0, chinPosition = 0,
            chinWidth = 0, chinShape = 0, neckWidth = 0,
            hair = -1, hairColor = 0, hairSecondColor = 0, eyebrow = 0, eyebrowColor = 0,
            beard = -1, beardColor = 0, chest = -1, chestColor = 0, blush = -1, blushColor = 0, lipstick = -1, lipstickColor = 0,
            blemishes = -1, ageing = -1, complexion = -1, sundamage = -1, freckles = -1, makeup = -1
        },
        Clothes = { 
            ["mask"] = { ["m"] = { item = -1, texture = 0}, ["f"] = { item = -1, texture = 0} },
            ["arms"] = { ["m"] = { item = 15, texture = 0}, ["f"] = { item = 15, texture = 0} },
            ["pants"] = { ["m"] = { item = 61, texture = 0}, ["f"] = { item = 17, texture = 0} },
            ["backpack"] = { ["m"] = { item = 0, texture = 0}, ["f"] = { item = 0, texture = 0} },  
            ["shoes"] = { ["m"] = { item = 34, texture = 0}, ["f"] = { item = 35, texture = 0} },
            ["accessory"] = { ["m"] = { item = 0, texture = 0}, ["f"] = { item = 0, texture = 0} }, 
            ["tshirt"] = { ["m"] = { item = 15, texture = 0}, ["f"] = { item = 6, texture = 0} }, 
            ["vest"] = { ["m"] = { item = 0,  texture =0}, ["f"] = { item = 0, texture = 0} },
            ["torso"] = { ["m"] = { item = 15, texture = 0}, ["f"] = { item = 18, texture = 0} },
            ["hat"] = { ["m"] = { item = 8,  texture =0}, ["f"] = { item = 57, texture = 0} },  
            ["glass"] = { ["m"] = { item = 0,  texture =0}, ["f"] = { item = 12, texture = 0} }
        }
    }, 

    Fathers = {
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

    Mothers = {
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
