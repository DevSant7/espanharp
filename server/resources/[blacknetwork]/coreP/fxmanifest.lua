



thn_disabletrigger "yes"

fx_version "cerulean"
game { "gta5" }

use_fxv2_oal "yes"
lua54 "yes"

dependecy "vrp"

client_scripts {
    "@vrp/lib/utils.lua",
    "src/common/*.lua",
    "src/cl_init.lua",
    "src/client/*"
}

server_scripts {
    "@config/commands.lua",
    "@vrp/lib/items.lua",
    "@vrp/lib/vehicles.lua",
	"@vrp/lib/utils.lua",
    "src/common/*.lua",
    "src/sv_init.lua",
    "src/server/*"
}