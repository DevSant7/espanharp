Config.Barbershop = {
    MarkerTitle = "BARBEARIA",
	Command = {
		Name = "barbershop",
		Permissions = {
			["Admin"] = 3
		}
	},

    Map = {
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
    
    Locations = {
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

    