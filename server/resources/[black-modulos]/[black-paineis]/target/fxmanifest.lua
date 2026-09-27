

fx_version "bodacious"
game "gta5"
lua54 "yes"
dependencies {
    "PolyZone"
}

ui_page "client-side/nui/index.html"

shared_scripts {
	"@vrp/lib/utils.lua",
	"shared/module.lua"
}

client_scripts {
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client-side/*"
}

server_scripts {
	"server-side/*"
}

files {
	"client-side/nui/**/*",
}