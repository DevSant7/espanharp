Config = {}
------------------------------------------------------------------------
-------------------[CONFIGURAÇÕES GLOBAIS DO SCRIPT]--------------------
------------------------------------------------------------------------
Config.Global = {
    ["MinimumLife"] = 101, -- Por padrão a vida é 101
    ["TimeToDominate"] = 15 * 60, -- Em segundos 15 * 60
    ["BoostDrugs"] = 2, -- Multiplica pelo valor da droga
    ["Clock"] = { -- Horário que poderá ser feita a dominação (start: Hora inicial do prazo | finish: Hora final do prazo )  
        start  = 18, -- 18 horas
        finish = 06  -- 00 horas (meia-noite)
    } 
}
------------------------------------------------------------------------
---------------[CONFIGURAÇÕES DOS BLIPS SEM PADRÕES]--------------------
------------------------------------------------------------------------
Config.Blips = {
  ["colorNeutral"] = 39, -- Cor do blip sem dominação
  ["sizeBlip"] = 60.0 -- Tamanho do blip do mapa
}
------------------------------------------------------------------------
---------------[LOCALIZAÇÕES DAS AREAS DE DOMINAÇÃO]--------------------
------------------------------------------------------------------------
Config.Locales = {
  ['21'] = {-1716.23,-1119.61,13.14}, --Pier
  ['24'] = {293.44,180.12,104.86}, --Cinema
  ['25'] = {-1137.79,-1634.62,4.33}, --Cinema
  ['26'] = {261.06,-1997.67,19.26}, --Cinema

}
------------------------------------------------------------------------
-------------------------[CB = COLOR BLIP]------------------------------
--------[https://docs.fivem.net/docs/game-references/blips/]------------
-----------------------[GC = GRAPHITE COLOR]----------------------------
------------------[Lista + Modificação logo a baixo]--------------------
------------------------------------------------------------------------
Config.ColorsGroup = {
    ["KDQ"] = {["CB"] = 3, ["GC"] = 4},
    ["Families"] = {["CB"] = 3, ["GC"] = 4},
    ["Livic"] = {["CB"] = 47, ["GC"] = 7},
    ["TheLost"] = {["CB"] = 85, ["GC"] = 10},
    ["Raijin"] = {["CB"] = 49, ["GC"] = 2},
    ["Bahamas"] = {["CB"] = 61, ["GC"] = 9},
    ["Rodo"] = {["CB"] = 52, ["GC"] = 6},
    ["Roxos"] = {["CB"] = 50, ["GC"] = 9},
    ["Ballas"] = {["CB"] = 50, ["GC"] = 9},
    ["Fazenda"] = {["CB"] = 26, ["GC"] = 2},
    ["Vanilla"] = {["CB"] = 50, ["GC"] = 9},
    ["God"] = {["CB"] = 29, ["GC"] = 4},
    ["Bennys"] = {["CB"] = 6, ["GC"] = 2}
}
------------------------------------------------------------------------
-------------[CONFIGURAÇÃO DE PICHAÇÃO + MENSAGENS DE ERRO]-------------
------------------------------------------------------------------------
Config.Grafite = {
    SPRAY_PROGRESSBAR_DURATION = 20000,
    SPRAY_REMOVE_DURATION = 5 * 60 * 1000,
    SPRAY_FONT = 2, 
    SPRAY_SCALE = 1, -- MIN = 1 | MAX = 29
    DISTANCE_AT_WALL = 3.0,

    Keys = {
        CANCEL = {code = 167, label = 'INPUT_F6', Text = 'Para cancelar'},
        PICK = {code = 38, label = 'INPUT_PICKUP', Text = 'Para pichar'}
    },

    Text = {
        SPRAY_ERRORS = {
            NOT_FLAT = 'Essa parede não é regular suficiente.',
            TOO_FAR = 'Você está longe de mais.',
            INVALID_SURFACE = 'Isso não é pintavel.',
            AIM = 'Mire na parede para pichar.',
        },
        NO_SPRAY_NEARBY = 'Sem spray para remover as proximidades'
    }
}
------------------------------------------------------------------------
---------------------[CONFIGURAÇÃO DE FONTE DA PICHAÇÃO]----------------
------------------------------------------------------------------------
FONTS = {
  { --[ 1 ]
      font = 'graffiti1',
      label = 'Fonte 01',
      allowed = '^[A-Z0-9\\-.]+$',
      forceUppercase = true,
      allowedInverse = '[^A-Z0-9\\-.]+',
      sizeMult = 0.35,
  },
  { --[ 2 ]
      font = 'graffiti2', 
      label = 'Fonte 02',
      forceUppercase = true,
      allowed = '^[A-Za-z0-9\\-.$+-*/=%"\'#@&();:,<>!_~]+$',
      allowedInverse = '[^A-Za-z0-9\\-.$+-*/=%"\'#@&();:,<>!_~]+',
      sizeMult = 1.0,
  },
  { --[ 3 ]
      font = 'graffiti3', 
      label = 'Fonte 03',
      allowed = '^[A-Z]+$',
      forceUppercase = true,
      allowedInverse = '[^A-Z]+',
      sizeMult = 0.45,
  },
  { --[ 4 ]
      font = 'graffiti4',
      label = 'Fonte 04',
      forceUppercase = true,
      allowed = '^[A-Za-z\\-.$+-*/=%"\'#@&();:,<>!_~]+$',
      allowedInverse = '[^A-Za-z\\-.$+-*/=%"\'#@&();:,<>!_~]+',
      sizeMult = 0.3,
  },
  { --[ 5 ]
      font = 'graffiti5',
      label = 'Fonte 05',
      allowed = '^[A-Z0-9]+$',
      forceUppercase = true,
      allowedInverse = '[^A-Z0-9]+',
      sizeMult = 0.3,
  },
  { --[ 6 ]
      font = 'PricedownGTAVInt', 
      label = 'Fonte 06',
      forceUppercase = true,
      allowed = '^[A-Za-z0-9]+$',
      allowedInverse = '[^A-Za-z0-9]+',
      sizeMult = 0.75,
  },
  { --[ 7 ]
      font = 'Chalet-LondonNineteenSixty', -- 7
      label = 'Fonte 07',
      forceUppercase = true,
      allowed = '^[A-Za-z0-9]+$',
      allowedInverse = '[^A-Za-z0-9]+',
      sizeMult = 0.6,
  },
  { --[ 8 ]
      font = 'SignPainter-HouseScript',
      label = 'Fonte 08',
      forceUppercase = true,
      allowed = '^[A-Za-z0-9]+$',
      allowedInverse = '[^A-Za-z0-9]+',
      sizeMult = 0.85,
  }
}
------------------------------------------------------------------------
---------------------[CRIAÇÃO E MODIFICAÇÃO DE CORES]-------------------
------------------------------------------------------------------------ 
COLORS = {
  { --[ 1 ]
      basic = 'BRANCA',
      color = {
          hex = 'ffffff',
          rgb = {255, 255, 255},
      },
      colorDarker = {
          hex = 'b3b3b3',
          rgb = {179, 179, 179},
      },
      colorDarkest = {
          hex = '4d4d4d',
          rgb = {77, 77, 77},
      },
  },
  { --[ 2 ]
      basic = 'VERMELHA', -- 2
      color = {
          hex = 'c81912',
          rgb = {200, 25, 18},
      },
      colorDarker = {
          hex = '8c120d',
          rgb = {140, 18, 13},
      },
      colorDarkest = {
          hex = '3c0806',
          rgb = {60, 8, 6},
      },
  },
  { --[ 3 ]
      basic = 'ROSA', 
      color = {
          hex = 'f76a8c',
          rgb = {247, 106, 140},
      },
      colorDarker = {
          hex = 'ea0c42',
          rgb = {234, 12, 66},
      },
      colorDarkest = {
          hex = '64051c',
          rgb = {100, 5, 28},
      },
  },
  { --[ 4 ]
      basic = 'AZUL', 
      color = {
          hex = '000839',
          rgb = {0, 8, 57},
      },
      colorDarker = {
          hex = '000627',
          rgb = {0, 6, 39},
      },
      colorDarkest = {
          hex = '000211',
          rgb = {0, 2, 17},
      },
  },
  { --[ 5 ]
      basic = 'AMARELA', 
      color = {
          hex = 'ffd31d',
          rgb = {255, 211, 29},
      },
      colorDarker = {
          hex = 'c8a100',
          rgb = {200, 161, 0},
      },
      colorDarkest = {
          hex = '564500',
          rgb = {86, 69, 0},
      },
  },
  { --[ 6 ]
      basic = 'VERDE', 
      color = {
          hex = '2b580c',
          rgb = {43, 88, 12},
      },
      colorDarker = {
          hex = '1f3f09',
          rgb = {31, 63, 9},
      },
      colorDarkest = {
          hex = '0d1b04',
          rgb = {13, 27, 4},
      },
  },
  { --[ 7 ]
      basic = 'LARANJA', 
      color = {
          hex = 'ffa41b',
          rgb = {255, 164, 27},
      },
      colorDarker = {
          hex = 'c47600',
          rgb = {196, 118, 0},
      },
      colorDarkest = {
          hex = '543300',
          rgb = {84, 51, 0},
      },
  },
  { --[ 8 ]
      basic = 'MARROM', 
      color = {
          hex = '9c5518',
          rgb = {156, 85, 24},
      },
      colorDarker = {
          hex = '6c3b11',
          rgb = {108, 59, 17},
      },
      colorDarkest = {
          hex = '2e1907',
          rgb = {46, 25, 7},
      },
  },
  { --[ 9 ]
      basic = 'ROXA', 
      color = {
          hex = '7500ff',
          rgb = {117, 0, 255},
      },
      colorDarker = {
          hex = '7500ff',
          rgb = {117, 0, 255},
      },
      colorDarkest = {
          hex = '7500ff',
          rgb = {117, 0, 255},
      },
  },
  { --[ 10 ]
      basic = 'CINZA', 
      color = {
          hex = 'cccccc',
          rgb = {204, 204, 204},
      },
      colorDarker = {
          hex = '8f8f8f',
          rgb = {143, 143, 143},
      },
      colorDarkest = {
          hex = '3d3d3d',
          rgb = {61, 61, 61},
      },
  },
}


