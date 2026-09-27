fx_version "cerulean"
game "gta5"
author "Pickle Mods"
description "The best system for player-owned casinos."
version "v1.3.9"

ui_page "nui/index.html"

files {
  "nui/index.html",
  "nui/images/*.*",
  "nui/images/**/*.*",
  "nui/audio/*.*",
  "nui/audio/**/*.*",
  "nui/assets/**/*.*",
  "nui/debug.js",
  -- "components/**/*.*", -- REMOVIDO (não existe e dá warning)
  "peds.meta"
}

shared_scripts {
  "config.lua",
  "core/shared.lua",
  "templates/*.lua",
  "locales/locale.lua",
  "locales/translations/*.lua",
  "modules/**/shared.lua",
}

client_scripts {
  "bridge/**/**/client.lua",  -- bridge (inclui vrp) primeiro
  "core/client.lua",          -- depois o core
  "modules/**/client.lua"     -- por fim os módulos
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "bridge/**/**/server.lua",      -- bridge (inclui vrp) primeiro
  "core/server.lua",
  "core/server_callbacks.lua",    -- garante que callbacks base estão carregados
  "modules/**/server.lua",
  "config_sv.lua",
}

data_file 'PED_METADATA_FILE' 'peds.meta'
data_file 'DLC_ITYP_REQUEST' 'fury_p_wheeloff.ytyp'
data_file 'DLC_ITYP_REQUEST' 'fury_p_poker_table.ytyp'
data_file 'DLC_ITYP_REQUEST' 'fury_picklegamblingprops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'npds_bettingmachine_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'fury_p_slots.ytyp'

lua54 'yes'

escrow_ignore {
  "config.lua",
  "config_sv.lua",
  "templates.lua",
  "templates/*.lua",
  "__INSTALL/**/*.*",
  "core/*.*",
  "bridge/**/**/*.*",
  "bridge/**/*.*",
  "locales/locale.lua",
  "locales/translations/*.lua",
}

dependency '/assetpacks'
