Config = {
    Color = {0, 140, 234},
    Images = "https://cdn.blacknetwork.com.br/conce/",
    DefaultStock = 25,
    Peds = {
        -- Concessionária Normal
        {
            Distance = 30,
            Model = "ig_paper",
            Anim = { dict = "anim@heists@heist_corona@single_team", set = "single_team_loop_boss" },
            Coords = { x = -56.51, y = -1098.55, z = 26.42, h = 31.19 },
            Type = "normal" -- Tipo da concessionária
        },
        {
            Distance = 30,
            Model = "ig_paper",
            Anim = { dict = "anim@heists@heist_corona@single_team", set = "single_team_loop_boss" },
            Coords = { x = -347.47, y = -133.41, z = 39.01, h = 249.45 },
            Type = "normal"
        },
        -- Concessionária VIP
        {
            Distance = 30,
            Model = "ig_paper",
            Anim = { dict = "anim@heists@heist_corona@single_team", set = "single_team_loop_boss" },
            Coords = { x =  -54.1, y = 67.64, z = 71.97, h = 70.87 },
            Type = "vip"
        }
    },
    Show = {
        Coords = {
        { x = -44.82, y = -1097.48, z = 26.42, h = 68.04 }, -- Normal 1
        { x = -336.39, y = -137.31, z = 39.01, h = 68.04 }, -- Normal 2
        { x = 224.91, y = 1171.81, z = 225.99, h = 243.78 },   -- VIP
        },
        Colors = {
        { rgb = {218, 25, 24}, id = 28 },
        { rgb = {102, 184, 31}, id = 55 },
        { rgb = {11, 156, 241}, id = 70 },
        { rgb = {255, 255, 255}, id = 134 },
        { rgb = {13, 17, 22}, id = 0 }
        }
    },
    -- Test Drive Configuration
    TestDrive = {
        Duration = 120, -- 2 minutes in seconds
        SpawnCoords = {
            normal = { x = -30.36, y = -1090.31, z = 26.42, h = 62.37 }, -- Test drive normal
            vip = { x =  -68.87, y = 83.15, z = 71.51, h = 62.37 } -- Test drive VIP
        },
        ReturnCoords = {
        { x = -31.66, y = -1091.52, z = 26.42 }, -- Return to dealership 1 (padrão)
        { x = -347.47, y = -133.41, z = 39.01 }, -- Return to dealership 2
        { x =  -54.1, y = 67.64, z = 71.97 }   -- Return to VIP dealership
        }
    },
    -- Tipos por concessionária
    DealershipTypes = {
        normal = {"comum", "motos", "super"},
        vip = {"blindado", "CLASSE S+", "CLASSE S", "CLASSE A", "CLASSE B", "CLASSE C", "CLASSE D", "MOTOS", "SUV"}
    },
    Types = {"comum", "motos", "super","blindado", "CLASSE S+", "CLASSE S", "CLASSE A", "CLASSE B", "CLASSE C", "CLASSE D", "MOTOS", "SUV"},
    Vehicles = {
        -- MOTOS (apenas dinheiro)
        {
        section = "motos",
            name = "Akuma",
            spawn = "akuma",
            price = {290000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Bagger",
            spawn = "bagger",
            price = {280000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Bati",
            spawn = "bati",
            price = {280000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Bati 2",
            spawn = "bati2",
            price = {285000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "BF400",
            spawn = "bf400",
            price = {275000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Carbon RS",
            spawn = "carbonrs",
            price = {320000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Cliffhanger",
            spawn = "cliffhanger",
            price = {295000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Daemon",
            spawn = "daemon",
            price = {270000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Daemon 2",
            spawn = "daemon2",
            price = {275000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Defiler",
            spawn = "defiler",
            price = {285000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Double T",
            spawn = "double",
            price = {300000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Enduro",
            spawn = "enduro",
            price = {265000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Faggio",
            spawn = "faggio",
            price = {150000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Faggio 2",
            spawn = "faggio2",
            price = {155000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Faggio 3",
            spawn = "faggio3",
            price = {160000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "FCR",
            spawn = "fcr",
            price = {305000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "FCR 2",
            spawn = "fcr2",
            price = {310000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Gargoyle",
            spawn = "gargoyle",
            price = {290000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Hakuchou",
            spawn = "hakuchou",
            price = {310000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Hakuchou 2",
            spawn = "hakuchou2",
            price = {315000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Hexer",
            spawn = "hexer",
            price = {280000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Innovation",
            spawn = "innovation",
            price = {285000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Lectro",
            spawn = "lectro",
            price = {295000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Manchez",
            spawn = "manchez",
            price = {270000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Nemesis",
            spawn = "nemesis",
            price = {275000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Nightblade",
            spawn = "nightblade",
            price = {300000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "PCJ",
            spawn = "pcj",
            price = {265000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Ruffian",
            spawn = "ruffian",
            price = {270000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Sanchez",
            spawn = "sanchez",
            price = {260000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Sanchez 2",
            spawn = "sanchez2",
            price = {265000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Sovereign",
            spawn = "sovereign",
            price = {295000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Thrust",
            spawn = "thrust",
            price = {285000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Vader",
            spawn = "vader",
            price = {275000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Vindicator",
            spawn = "vindicator",
            price = {280000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Vortex",
            spawn = "vortex",
            price = {290000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Wolfsbane",
            spawn = "wolfsbane",
            price = {305000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Zombiea",
            spawn = "zombiea",
            price = {285000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "motos",
            name = "Zombieb",
            spawn = "zombieb",
            price = {290000},
            stats = {
                trunk = {15, 30}
            }
        },
        -- COMUM (apenas dinheiro)
        {
        section = "comum",
            name = "Panto",
            spawn = "panto",
            price = {5000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Blista",
            spawn = "blista",
            price = {85000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Brioso R/A",
            spawn = "brioso",
            price = {95000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Dilettante",
            spawn = "dilettante",
            price = {75000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Issi",
            spawn = "issi2",
            price = {80000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Prairie",
            spawn = "prairie",
            price = {90000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Rhapsody",
            spawn = "rhapsody",
            price = {70000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Cognoscenti Cabrio",
            spawn = "cogcabrio",
            price = {180000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Exemplar",
            spawn = "exemplar",
            price = {200000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "F620",
            spawn = "f620",
            price = {180000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Felon",
            spawn = "felon",
            price = {190000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Felon GT",
            spawn = "felon2",
            price = {195000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Jackal",
            spawn = "jackal",
            price = {175000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Oracle",
            spawn = "oracle",
            price = {170000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Oracle XS",
            spawn = "oracle2",
            price = {175000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Sentinel",
            spawn = "sentinel",
            price = {185000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Sentinel XS",
            spawn = "sentinel2",
            price = {190000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Windsor",
            spawn = "windsor",
            price = {220000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Windsor Drop",
            spawn = "windsor2",
            price = {225000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Zion",
            spawn = "zion",
            price = {165000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Zion Cabrio",
            spawn = "zion2",
            price = {170000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Blade",
            spawn = "blade",
            price = {160000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Buccaneer",
            spawn = "buccaneer",
            price = {140000},
            stats = {
                trunk = {45, 90}
            }
        },
        {
        section = "comum",
            name = "Buccaneer Custom",
            spawn = "buccaneer2",
            price = {145000},
            stats = {
                trunk = {45, 90}
            }
        },
        {
        section = "comum",
            name = "Chino",
            spawn = "chino",
            price = {135000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Chino Custom",
            spawn = "chino2",
            price = {140000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Coquette Classic",
            spawn = "coquette2",
            price = {195000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Dominator",
            spawn = "dominator",
            price = {185000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Dukes",
            spawn = "dukes",
            price = {175000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "STAFFORD",
            spawn = "stafford",
            price = {200000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Gauntlet",
            spawn = "gauntlet",
            price = {180000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Hotknife",
            spawn = "hotknife",
            price = {200000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Phoenix",
            spawn = "phoenix",
            price = {170000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Picador",
            spawn = "picador",
            price = {120000},
            stats = {
                trunk = {50, 100}
            }
        },
        {
        section = "comum",
            name = "Ruiner",
            spawn = "ruiner",
            price = {155000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Sabre Turbo",
            spawn = "sabregt",
            price = {165000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Sabre Turbo Custom",
            spawn = "sabregt2",
            price = {170000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Stallion",
            spawn = "stallion",
            price = {150000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Stallion Custom",
            spawn = "stallion2",
            price = {155000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Tampa",
            spawn = "tampa",
            price = {175000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Vigero",
            spawn = "vigero",
            price = {165000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Virgo",
            spawn = "virgo",
            price = {145000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Virgo Classic",
            spawn = "virgo2",
            price = {150000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Virgo Classic Custom",
            spawn = "virgo3",
            price = {155000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Voodoo",
            spawn = "voodoo",
            price = {130000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Voodoo Custom",
            spawn = "voodoo2",
            price = {135000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Bifta",
            spawn = "bifta",
            price = {125000},
            stats = {
                trunk = {20, 40}
            }
        },
        {
        section = "comum",
            name = "Blazer",
            spawn = "blazer",
            price = {115000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "comum",
            name = "Blazer 4",
            spawn = "blazer4",
            price = {120000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "comum",
            name = "Bodhi",
            spawn = "bodhi2",
            price = {135000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Brawler",
            spawn = "brawler",
            price = {195000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rebel",
            spawn = "rebel2",
            price = {140000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Trophy Truck",
            spawn = "trophytruck",
            price = {200000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Trophy Truck 2",
            spawn = "trophytruck2",
            price = {205000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Asea",
            spawn = "asea",
            price = {65000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Asterope",
            spawn = "asterope",
            price = {75000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Fugitive",
            spawn = "fugitive",
            price = {85000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Glendale",
            spawn = "glendale",
            price = {70000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Ingot",
            spawn = "ingot",
            price = {60000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Intruder",
            spawn = "intruder",
            price = {80000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Premier",
            spawn = "premier",
            price = {75000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Primo",
            spawn = "primo",
            price = {65000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Primo Custom",
            spawn = "primo2",
            price = {70000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Regina",
            spawn = "regina",
            price = {55000},
            stats = {
                trunk = {45, 90}
            }
        },
        {
        section = "comum",
            name = "Schafter",
            spawn = "schafter2",
            price = {95000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Stanier",
            spawn = "stanier",
            price = {70000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Stratum",
            spawn = "stratum",
            price = {80000},
            stats = {
                trunk = {45, 90}
            }
        },
        {
        section = "comum",
            name = "Stretch",
            spawn = "stretch",
            price = {120000},
            stats = {
                trunk = {50, 100}
            }
        },
        {
        section = "comum",
            name = "Super Diamond",
            spawn = "superd",
            price = {130000},
            stats = {
                trunk = {45, 90}
            }
        },
        {
        section = "comum",
            name = "Surge",
            spawn = "surge",
            price = {85000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Tailgater",
            spawn = "tailgater",
            price = {90000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Warrener",
            spawn = "warrener",
            price = {85000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Washington",
            spawn = "washington",
            price = {75000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Alpha",
            spawn = "alpha",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Banshee",
            spawn = "banshee",
            price = {180000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Bestia GTS",
            spawn = "bestiagts",
            price = {200000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Buffalo",
            spawn = "buffalo",
            price = {160000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Buffalo S",
            spawn = "buffalo2",
            price = {165000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Buffalo 3",
            spawn = "buffalo3",
            price = {170000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Carbonizzare",
            spawn = "carbonizzare",
            price = {190000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Comet",
            spawn = "comet2",
            price = {185000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Coquette",
            spawn = "coquette",
            price = {175000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Elegy RH8",
            spawn = "elegy2",
            price = {190000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Feltzer",
            spawn = "feltzer2",
            price = {180000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Fusilade",
            spawn = "fusilade",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Futo",
            spawn = "futo",
            price = {110000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Jester",
            spawn = "jester",
            price = {195000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Jester Racecar",
            spawn = "jester2",
            price = {200000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Kuruma",
            spawn = "kuruma",
            price = {185000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Lynx",
            spawn = "lynx",
            price = {205000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Massacro",
            spawn = "massacro",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Massacro Racecar",
            spawn = "massacro2",
            price = {195000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Omnis",
            spawn = "omnis",
            price = {175000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Penumbra",
            spawn = "penumbra",
            price = {155000},
            stats = {
                trunk = {35, 70}
            }
        },
        {
        section = "comum",
            name = "Rapid GT",
            spawn = "rapidgt",
            price = {180000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rapid GT Cabrio",
            spawn = "rapidgt2",
            price = {185000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Schafter V12",
            spawn = "schafter3",
            price = {200000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Sultan",
            spawn = "sultan",
            price = {190000},
            stats = {
                trunk = {40, 80}
            }
        },
        {
        section = "comum",
            name = "Surano",
            spawn = "surano",
            price = {175000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Tropos",
            spawn = "tropos",
            price = {185000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "comum",
            name = "Verlierer",
            spawn = "verlierer2",
            price = {195000},
            stats = {
                trunk = {25, 50}
            }
        },
        -- SUPER (apenas dinheiro)
        {
        section = "super",
            name = "Adder",
            spawn = "adder",
            price = {800000},
            defaultColors = {
                primary = { rgb = {255, 255, 255}, id = 134 },
                secondary = { rgb = {48, 76, 126}, id = 63 }
            },
            stats = {
                trunk = {20, 40}
            }
        },
        {
        section = "super",
            name = "Banshee 900R",
            spawn = "banshee2",
            price = {800000},
            stats = {
                trunk = {20, 40}
            }
        },
        {
        section = "super",
            name = "Bullet",
            spawn = "bullet",
            price = {800000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Cheetah",
            spawn = "cheetah",
            price = {800000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Entity XF",
            spawn = "entityxf",
            price = {800000},
            stats = {
                trunk = {20, 40}
            }
        },
        {
        section = "super",
            name = "FMJ",
            spawn = "fmj",
            price = {800000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Infernus",
            spawn = "infernus",
            price = {800000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Osiris",
            spawn = "osiris",
            price = {500000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "RE-7B",
            spawn = "le7b",
            price = {600000},
            stats = {
                trunk = {10, 20}
            }
        },
        {
        section = "super",
            name = "Reaper",
            spawn = "reaper",
            price = {550000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Sultan RS",
            spawn = "sultanrs",
            price = {800000},
            stats = {
                trunk = {25, 50}
            }
        },
        {
        section = "super",
            name = "T20",
            spawn = "t20",
            price = {900000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Turismo R",
            spawn = "turismor",
            price = {800000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Tyrus",
            spawn = "tyrus",
            price = {650000},
            stats = {
                trunk = {10, 20}
            }
        },
        {
        section = "super",
            name = "Vacca",
            spawn = "vacca",
            price = {800000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "Voltic",
            spawn = "voltic",
            price = {800000},
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "super",
            name = "X80 Proto",
            spawn = "prototipo",
            price = {800000},
            stats = {
                trunk = {10, 20}
            }
        },
        {
        section = "super",
            name = "Zentorno",
            spawn = "zentorno",
            price = {900000},
            stats = {
                trunk = {20, 40}
            }
        },
        {
        section = "comum",
            name = "Asbo",
            spawn = "asbo",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Autarch",
            spawn = "autarch",
            price = {390000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "motos",
            name = "Avarus",
            spawn = "avarus",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Baller3",
            spawn = "baller3",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Baller4",
            spawn = "baller4",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Blazer3",
            spawn = "blazer3",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Blista2",
            spawn = "blista2",
            price = {70000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Blista3",
            spawn = "blista3",
            price = {70000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Bobcatxl",
            spawn = "bobcatxl",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Brioso2",
            spawn = "brioso2",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Btype",
            spawn = "btype",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Btype2",
            spawn = "btype2",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Btype3",
            spawn = "btype3",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Calico",
            spawn = "calico",
            price = {290000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Caracara2",
            spawn = "caracara2",
            price = {230000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Casco",
            spawn = "casco",
            price = {120000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Cheburek",
            spawn = "cheburek",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "motos",
            name = "Chimera",
            spawn = "chimera",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Clique",
            spawn = "clique",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Club",
            spawn = "club",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Cog55",
            spawn = "cog55",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Cognoscenti",
            spawn = "cognoscenti",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Comet3",
            spawn = "comet3",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Comet4",
            spawn = "comet4",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Comet5",
            spawn = "comet5",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Comet6",
            spawn = "comet6",
            price = {300000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Contender",
            spawn = "contender",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Coquette3",
            spawn = "coquette3",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Cyclone",
            spawn = "cyclone",
            price = {330000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Cypher",
            spawn = "cypher",
            price = {310000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Deviant",
            spawn = "deviant",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Diablous",
            spawn = "diablous",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Diablous2",
            spawn = "diablous2",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Dominator3",
            spawn = "dominator3",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Dominator7",
            spawn = "dominator7",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Drafter",
            spawn = "drafter",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Dubsta",
            spawn = "dubsta",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Dubsta2",
            spawn = "dubsta2",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Dubsta3",
            spawn = "dubsta3",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Dynasty",
            spawn = "dynasty",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Elegy",
            spawn = "elegy",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Ellie",
            spawn = "ellie",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Emerus",
            spawn = "emerus",
            price = {660000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Entity2",
            spawn = "entity2",
            price = {400000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "motos",
            name = "Esskey",
            spawn = "esskey",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Euros",
            spawn = "euros",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Everon",
            spawn = "everon",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Fagaloa",
            spawn = "fagaloa",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Feltzer3",
            spawn = "feltzer3",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Flashgt",
            spawn = "flashgt",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Fq2",
            spawn = "fq2",
            price = {70000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Freecrawler",
            spawn = "freecrawler",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Furia",
            spawn = "furia",
            price = {1000000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Furoregt",
            spawn = "furoregt",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Futo2",
            spawn = "futo2",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Gauntlet3",
            spawn = "gauntlet3",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Gauntlet4",
            spawn = "gauntlet4",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Gauntlet5",
            spawn = "gauntlet5",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Gb200",
            spawn = "gb200",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Gburrito",
            spawn = "gburrito",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Glendale2",
            spawn = "glendale2",
            price = {95000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Gp1",
            spawn = "gp1",
            price = {350000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Granger",
            spawn = "granger",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Gresley",
            spawn = "gresley",
            price = {70000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Growler",
            spawn = "growler",
            price = {300000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Gt500",
            spawn = "gt500",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Guardian",
            spawn = "guardian",
            price = {400000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Hellion",
            spawn = "hellion",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Hermes",
            spawn = "hermes",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Hotring",
            spawn = "hotring",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Hustler",
            spawn = "hustler",
            price = {95000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Imorgon",
            spawn = "imorgon",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Impaler",
            spawn = "impaler",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Infernus2",
            spawn = "infernus2",
            price = {600000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Issi7",
            spawn = "issi7",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Italigtb",
            spawn = "italigtb",
            price = {900000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Italigtb2",
            spawn = "italigtb2",
            price = {950000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Italigto",
            spawn = "italigto",
            price = {1400000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Italirsx",
            spawn = "italirsx",
            price = {1500000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Jester3",
            spawn = "jester3",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Jester4",
            spawn = "jester4",
            price = {300000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Jugular",
            spawn = "jugular",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Kanjo",
            spawn = "kanjo",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Khamelion",
            spawn = "khamelion",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Komoda",
            spawn = "komoda",
            price = {350000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Krieger",
            spawn = "krieger",
            price = {800000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Landstalker2",
            spawn = "landstalker2",
            price = {120000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Locust",
            spawn = "locust",
            price = {280000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Mamba",
            spawn = "mamba",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Manana2",
            spawn = "manana2",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Mesa",
            spawn = "mesa",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Mesa3",
            spawn = "mesa3",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Michelli",
            spawn = "michelli",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Minivan",
            spawn = "minivan",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Monroe",
            spawn = "monroe",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Moonbeam",
            spawn = "moonbeam",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Moonbeam2",
            spawn = "moonbeam2",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Mule",
            spawn = "mule",
            price = {500000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Nebula",
            spawn = "nebula",
            price = {115000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Neo",
            spawn = "neo",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Neon",
            spawn = "neon",
            price = {290000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Nero",
            spawn = "nero",
            price = {900000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Nero2",
            spawn = "nero2",
            price = {1000000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Nightshade",
            spawn = "nightshade",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Ninef",
            spawn = "ninef",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Ninef2",
            spawn = "ninef2",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Novak",
            spawn = "novak",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Outlaw",
            spawn = "outlaw",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Paradise",
            spawn = "paradise",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Paragon",
            spawn = "paragon",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Pariah",
            spawn = "pariah",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Patriot2",
            spawn = "patriot2",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Penetrator",
            spawn = "penetrator",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Penumbra2",
            spawn = "penumbra2",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Peyote2",
            spawn = "peyote2",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Peyote3",
            spawn = "peyote3",
            price = {95000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Pfister811",
            spawn = "pfister811",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Pigalle",
            spawn = "pigalle",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Pony2",
            spawn = "pony2",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Raiden",
            spawn = "raiden",
            price = {600000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rancherxl",
            spawn = "rancherxl",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rapidgt3",
            spawn = "rapidgt3",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Ratloader2",
            spawn = "ratloader2",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rebel",
            spawn = "rebel",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rebla",
            spawn = "rebla",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Remus",
            spawn = "remus",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Retinue",
            spawn = "retinue",
            price = {70000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Retinue2",
            spawn = "retinue2",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Riata",
            spawn = "riata",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Romero",
            spawn = "romero",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rt3000",
            spawn = "rt3000",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Rumpo2",
            spawn = "rumpo2",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Ruston",
            spawn = "ruston",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "motos",
            name = "Sanctus",
            spawn = "sanctus",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Sandking",
            spawn = "sandking",
            price = {180000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Sandking2",
            spawn = "sandking2",
            price = {180000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Savestra",
            spawn = "savestra",
            price = {170000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Sc1",
            spawn = "sc1",
            price = {700000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Schafter4",
            spawn = "schafter4",
            price = {120000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Schlagen",
            spawn = "schlagen",
            price = {200000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Schwarzer",
            spawn = "schwarzer",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Seminole2",
            spawn = "seminole2",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Sentinel3",
            spawn = "sentinel3",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Seven70",
            spawn = "seven70",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Sheava",
            spawn = "sheava",
            price = {500000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Shinobi",
            spawn = "shinobi",
            price = {320000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Slamvan",
            spawn = "slamvan",
            price = {80000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Slamvan2",
            spawn = "slamvan2",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Slamvan3",
            spawn = "slamvan3",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Specter",
            spawn = "specter",
            price = {240000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Specter2",
            spawn = "specter2",
            price = {230000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Stalion",
            spawn = "stalion",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Stalion2",
            spawn = "stalion2",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Stinger",
            spawn = "stinger",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Stingergt",
            spawn = "stingergt",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Sugoi",
            spawn = "sugoi",
            price = {500000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Sultan2",
            spawn = "sultan2",
            price = {700000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Sultan3",
            spawn = "sultan3",
            price = {750000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Surfer",
            spawn = "surfer",
            price = {70000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Swinger",
            spawn = "swinger",
            price = {160000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Tailgater2",
            spawn = "tailgater2",
            price = {210000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Taipan",
            spawn = "taipan",
            price = {650000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Tampa2",
            spawn = "tampa2",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Tempesta",
            spawn = "tempesta",
            price = {700000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Tezeract",
            spawn = "tezeract",
            price = {700000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Thrax",
            spawn = "thrax",
            price = {900000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Tigon",
            spawn = "tigon",
            price = {310000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Tornado",
            spawn = "tornado",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Tornado2",
            spawn = "tornado2",
            price = {90000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Tornado5",
            spawn = "tornado5",
            price = {110000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Toros",
            spawn = "toros",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Tulip",
            spawn = "tulip",
            price = {100000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Turismo2",
            spawn = "turismo2",
            price = {550000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Tyrant",
            spawn = "tyrant",
            price = {600000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Vagner",
            spawn = "vagner",
            price = {640000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Vagrant",
            spawn = "vagrant",
            price = {290000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Vamos",
            spawn = "vamos",
            price = {80000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Vectre",
            spawn = "vectre",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Visione",
            spawn = "visione",
            price = {410000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Vstr",
            spawn = "vstr",
            price = {230000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Weevil",
            spawn = "weevil",
            price = {95000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "super",
            name = "Xa21",
            spawn = "xa21",
            price = {750000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Xls",
            spawn = "xls",
            price = {300000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Yosemite",
            spawn = "yosemite",
            price = {150000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Yosemite2",
            spawn = "yosemite2",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Yosemite3",
            spawn = "yosemite3",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Z190",
            spawn = "z190",
            price = {130000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Zion3",
            spawn = "zion3",
            price = {95000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Zorrusso",
            spawn = "zorrusso",
            price = {1500000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Zr350",
            spawn = "zr350",
            price = {190000},
            stats = {
                trunk = {30, 60}
            }
        },
        {
        section = "comum",
            name = "Ztype",
            spawn = "ztype",
            price = {250000},
            stats = {
                trunk = {30, 60}
            }
        },
        -- BLINDADO VIP (apenas gemas - 250 💎)
        {
        section = "blindado",
            name = "Amarok BL",
            spawn = "amarokBL",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Armored GLE",
            spawn = "armoredgle",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Armored M3 G80C",
            spawn = "armoredm3g80c",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Armored Porsche Macan",
            spawn = "armoredporschemacan",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Armored RS5",
            spawn = "armoredrs5",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Armored Velar",
            spawn = "armoredvelar",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Armored X7 M60i",
            spawn = "armoredx7m60i",
            price = 500,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "DBX BL",
            spawn = "dbxBL",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Masters X6",
            spawn = "mastersx6",
            price = 500,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Purosangue BL",
            spawn = "PurosangueBL",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "Urus RS",
            spawn = "urusrs",
            price = 350,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "blindado",
            name = "X3 RAM TRX 21",
            spawn = "X3RAMTRX21",
            price = 500,
            stats = {
                trunk = {60, 120}
            }
        },
        -- CLASSE S+ (apenas gemas - 250 💎)
        {
        section = "CLASSE S+",
            name = "Evo Hycade GG",
            spawn = "evohycadegg",
            price = 250,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S+",
            name = "GTT B4",
            spawn = "BNModsGTT34",
            price = 250,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S+",
            name = "Ikx3 GT3 RS 23",
            spawn = "ikx3gt3rs23",
            price = 250,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S+",
            name = "Lamborghini LP570",
            spawn = "lp570",
            price = 250,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S+",
            name = "Oyc CSP300",
            spawn = "oyccsp300",
            price = 250,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S+",
            name = "Nivus FT V2",
            spawn = "ftnivusv2",
            price = 250,
            stats = {
                trunk = {60, 120}
            }
        },
        -- CLASSE S (apenas gemas - 180 💎)
        {
        section = "CLASSE S",
            name = "BNR34",
            spawn = "bnr34",
            price = 200,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S",
            name = "Supra",
            spawn = "mk5aimgain",
            price = 200,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S",
            name = "Silvia",
            spawn = "silvia",
            price = 200,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE S",
            name = "WRX 15",
            spawn = "wrx15",
            price = 200,
            stats = {
                trunk = {60, 120}
            }
        },
        -- CLASSE A (apenas gemas - 180 💎)
        {
        section = "CLASSE A",
            name = "404 Illegal M2",
            spawn = "404illegal_m2",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "T86 JDM",
            spawn = "BNGt86jdm",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "BN Type R 2024",
            spawn = "BNTypeR2024",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "GTR",
            spawn = "gtr",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "Lancer Evolution X",
            spawn = "lancerevolutionx",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "LC500 WB",
            spawn = "lc500wb",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "LFA 2011",
            spawn = "lfa2011",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "MK5 Aim Gain",
            spawn = "mk5amgain",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "Nissan R33",
            spawn = "nissanr33tbk",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "Porsche GT3",
            spawn = "pgt3",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "Playaricky C6",
            spawn = "playarickyc6",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "Golf 75R",
            spawn = "golf75r",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "Golf R18",
            spawn = "golfr18",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "RMod Passat",
            spawn = "rmodpassat",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "VW Golf GTI",
            spawn = "vwgolfgti",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "VW Jetta",
            spawn = "vwjetta",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE A",
            name = "RX7 Asuka",
            spawn = "rx7asuka",
            price = 180,
            stats = {
                trunk = {60, 120}
            }
        },
        -- CLASSE B (apenas gemas - 120 💎)
        {
        section = "CLASSE B",
            name = "22M4PAK",
            spawn = "22m4pak",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "765LT",
            spawn = "765lt",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "A45",
            spawn = "a45",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Audi R8",
            spawn = "adr8",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Subaru BRZ",
            spawn = "brz",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Corvette C8 ZR1",
            spawn = "c8zr1",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Flt Zentorno",
            spawn = "ftlzentorno",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Hellcat",
            spawn = "hellcat",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Maserati",
            spawn = "maser",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Mercedes GT63",
            spawn = "mercedesgt63",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Rev Autentica 24",
            spawn = "rev_autentica24",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Mercedes C63 Darwin Pro",
            spawn = "vc_c63darwinpro",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE B",
            name = "Nissan 350z",
            spawn = "350z",
            price = 120,
            stats = {
                trunk = {60, 120}
            }
        },
        -- CLASSE C (apenas gemas - 80 💎)
        {
        section = "CLASSE C",
            name = "16 Grover SC",
            spawn = "16GroverSC",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "20 Roma",
            spawn = "20roma",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "488 HRS",
            spawn = "488hrs",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "540i 18MD",
            spawn = "540i18md",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "ALCDH25",
            spawn = "alcdh25",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "M3 G80C",
            spawn = "m3g80c",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "M330i 21",
            spawn = "m330i21",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "Mercedes E63 AMG 2022 WB",
            spawn = "mercedese63samg2022wb",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE C",
            name = "Plaid",
            spawn = "plaid",
            price = 80,
            stats = {
                trunk = {60, 120}
            }
        },
        -- CLASSE D (apenas gemas - 60 💎)
        {
        section = "CLASSE D",
            name = "EG6",
            spawn = "eg6",
            price = 60,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE D",
            name = "Gol CL",
            spawn = "golcl",
            price = 60,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE D",
            name = "Gol GTI 2",
            spawn = "golgti2",
            price = 60,
            stats = {
                trunk = {60, 120}
            }
        },
        {
        section = "CLASSE D",
            name = "MK3 VR6",
            spawn = "mk3vr6",
            price = 60,
            stats = {
                trunk = {60, 120}
            }
        },
        -- MOTOS VIP (apenas gemas - 120 💎)
        {
        section = "MOTOS",
            name = "ATWIN 2023",
            spawn = "atwin2024",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "MOTOS",
            name = "CB Hornet 750",
            spawn = "cbhornet750",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "MOTOS",
            name = "Hornet 2014",
            spawn = "hornet2014",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "MOTOS",
            name = "R 1200 GS",
            spawn = "R1200GS",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "MOTOS",
            name = "R 1250",
            spawn = "r1250",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "MOTOS",
            name = "S 1000 RR",
            spawn = "s1000rr",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "MOTOS",
            name = "Tenere 1200",
            spawn = "tenere1200",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        {
        section = "MOTOS",
            name = "XJ6",
            spawn = "xj6",
            price = 120,
            stats = {
                trunk = {15, 30}
            }
        },
        -- SUV VIP (apenas gemas - 100 💎)
        {
        section = "SUV",
            name = "Corolla Cross 2020",
            spawn = "corollacross20",
            price = 100,
            stats = {
                trunk = {80, 160}
            }
        },
        {
        section = "SUV",
            name = "Diff Hawk",
            spawn = "diffhawk",
            price = 100,
            stats = {
                trunk = {80, 160}
            }
        },
        {
        section = "SUV",
            name = "Durango CRB",
            spawn = "durangocrb",
            price = 100,
            stats = {
                trunk = {80, 160}
            }
        },
        {
        section = "SUV",
            name = "GLE 53",
            spawn = "GLE53",
            price = 100,
            stats = {
                trunk = {80, 160}
            }
        },
        {
        section = "SUV",
            name = "GLS Mansory 850",
            spawn = "glsmansory850",
            price = 100,
            stats = {
                trunk = {80, 160}
            }
        }
    }
}
Config.Webhooks = {
    VehiclesNormal = "https://discord.com/api/webhooks/1370944796092272711/Q6vTHF2fY7nr04Ck5fs2GTJXwbcLdD-GvSjBy6BzeHs2cTNllURN7nccQ6nipQF2hQhU",
    VehiclesVip = "https://discord.com/api/webhooks/1392593357854871592/HUAc2p2-m_X4qabRg83ZQy0MRYM_pEJfRV9UUw9T8fZlTjZ5xkLA35kNVgbjzGCM4zxM"
}