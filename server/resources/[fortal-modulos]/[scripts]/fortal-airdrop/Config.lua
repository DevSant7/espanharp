Config = {  
    Drop = {
        Times = {
            Start = {12, 0},
            Decrease = 15,
            Plane = 5,
            Delete = 15
        },
        DangerZone = {
            Radius = 100.0,
            Alpha = 128,
            Color = { 152, 0, 0 }
        },
        Days = {"Monday", "Wednesday", "Friday"},
        Height = 500,
        Plane = "titan",
        Distance = 2000,
        Decrease = 0.01,
        Object = {
            Box = "gr_prop_gr_rsply_crate04a",
            Parachute = "p_cargo_chute_s",
            Flare = "prop_flare_01"
        }
    },
    Alert = {
        Chat = {
            Start = {
                Title = "AirDrop",
                Message = "O EVENTO DE AIRDROP COMEÇOU, ELE CAIRÁ EM BREVE!"
            },
            Dropping = {
                Title = "AirDrop",
                Message = "O AIRDROP COMEÇOU A CAIR AGORA, VÁ ATÉ O LOCAL PARA COLETÁ-LO!"
            }
        },

        Sound = {
            Name = "airdrop",
            Volume = 0.1
        }
    },

    Blips = {
        Delay = {
            Sprite = 478,
            Colour = 1,
            Text = "AirDrop a Caminho"
        },
        OnDrop = {
            Sprite = 478,
            Colour = 1,
            Text = "AirDrop"
        },
        Dropped = {
            Sprite = 478,
            Colour = 1,
            Text = "AirDrop"
        }
    },

    Particle = {
        Dict = "core", 
        Name = "exp_grd_flare"
    },

    Locations = {
        { x = -1141.16, y = -525.81, z = 32.77 },
        { x = 552.49, y = -2981.32, z = 6.05 },
        { x = 851.5, y = -2342.5,  z =30.33 },
        { x = 860.71, y = -2189.86, z = 30.53 },
        { x = 1720.91, y = -1630.89, z = 112.49 },
        { x = 2794.45, y = 1528.04, z = 24.52 },
        { x = 2953.96, y = 2795.89, z = 40.93 },
        { x = 2397.72, y = 3109.63, z = 48.14 },
        { x = 1471.01, y = 3611.86, z = 34.85 },
        { x = 2271.78, y = 4843.93, z = 40.54 },
        { x = -190.86, y = 6291.05, z = 31.44 },
        { x = -710.82, y = 5309.98, z = 71.75 },
        { x = -1092.64, y = 4915.96, z = 215.27 },
        { x = -1370.22, y = 4299.67, z = 2.51 },
        { x = -422.5, y = 1134.72, z = 325.86 }
    },

    Items = {
        { spawn = "WEAPON_RIFLE_AMMO", amount = 250 },
        { spawn = "vest", amount = 1 },
        { spawn = "WEAPON_SNSPISTOL_MK2", amount = 4 }
    }
}