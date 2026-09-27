Config.Selector = { 
    Main = vec3(-777.54,331.47,211.4),
    Command = {
        Name = "spawn"
    },

    Vip = {
        Groups = { "Diamante", "Ouro", "Prata", "Bronze", "Streamer", "Booster" },
        Time = 30 -- Em dias
    },

    Spawns = {
        { -- SENTADO TOMANDO VINHO
            Coords = { x = -792.79, y = 332.97, z = { ["m"] = 206.62, ["f"] = 206.52 }, h = 187.09 },
            Anim = {
                Dict = "anim_casino_a@amb@casino@games@insidetrack@ped_male@regular@02b@base",
                Name = "base"
            },
            Camera = {
                Coords = { x = -792.09, y = 331.96, z = 206.62 },
                Point = { x = -792.29, y = 332.26, z = 206.62 },
            }
        },
        { -- MEDITANDO
            Coords = { x = -802.27, y = 338.63, z = 206.21, h = 85.04 },
            Anim = {
                Dict = "amb@world_human_yoga@male@base",
                Name = "base_a"
            },
            Camera = {
                Coords = { x = -803.51, y = 337.79, z = 206.21 },
                Point = { x = -802.27, y = 338.63, z = 206.42 },
            }
        },
        { -- SENTADO NA POLTRONA
            Coords = { x = -793.43, y = 341.39, z = 206.21, h = 238.12 },
            Anim = {
                Dict = "timetable@ron@ig_5_p3",
                Name = "ig_5_p3_base"
            },
            Camera = {
                Coords = { x = -793.23, y = 340.8, z = 206.21 },
                Point = { x = -793.43, y = 341.39, z = 206.21 }
            }
        },
        { -- DEITADO NA CAMA
            Coords = { x = -795.9, y = 338.4, z = 202.15, h = 87.88 },
            Anim = {
                Dict = "amb@world_human_sunbathe@male@back@idle_a",
                Name = "idle_a"
            },
            Camera = {
                Coords = { x = -796.31, y = 338.4, z = 202.45 },
                Point = { x = -796.55, y = 338.4, z = 201.15 },
            }
        },
        { -- CORTANDO ALGO NA COZINHA
            Coords = { x = -789.3, y = 330.43, z = 206.21, h = 0.0 },
            Anim = {
                Dict = "amb@prop_human_bbq@male@idle_b",
                Name = "idle_e"
            },
            Camera = {
                Coords = { x = -789.8, y = 331.33, z = 206.71 },
                Point = { x = -789.3, y = 330.43, z = 206.71 }
            }
        }
    },
    Cameras = {
        {
            Duration = 12000,
            List = {
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
        },
        {
            Duration = 13000,
            List = {
                {
                    Coords = { x = -798.0, y = 326.99, z = 207.51 },
                    Point = { x = -781.95, y = 336.55, z = 207.62 }
                },
                {
                    Coords = { x = -790.06, y = 334.79, z = 206.21 },
                    Point = { x = -795.0, y = 343.17, z = 206.21 }
                }
            }
        },
        {
            Duration = 12000,
            List = {
                {
                    Coords = { x = -778.91, y = 336.73, z = 203.82 },
                    Point = { x = -795.25, y = 337.09, z = 201.41 }
                },
                {
                    Coords = { x = -795.25, y = 337.09, z = 201.41 },
                    Point = { x = -792.76, y = 342.49, z = 201.41 }
                }
            }
        },
        {
            Duration = 10000,
            List = {
                {
                    Coords = { x = -803.85, y = 342.2, z = 207.21 },
                    Point = { x = -796.07, y = 342.08, z = 207.21 }
                },
                {
                    Coords = { x = -796.07, y = 342.08, z = 207.21 },
                    Point = { x = -798.8, y = 334.84, z = 206.21 }
                }
            }
        }
    }
}
