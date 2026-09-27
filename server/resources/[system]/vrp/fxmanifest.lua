 
fx_version "bodacious"
game "gta5"
lua54 "yes"
ui_page "gui/index.html"

loadscreen "loading/index.html"
loadscreen_manual_shutdown "yes"

shared_scripts {
	"@config/global.lua",
	"@vrp/lib/vehicles.lua",
	"@config/group.lua",
	"@vrp/lib/items.lua",
	"lib/utils.lua",
	"config/*",
}

client_scripts {
	"client/*"
}

server_scripts {
	"modules/bk.lua",
	"modules/*"
}

files {
	"loading/*",
	"lib/*",
	"gui/*",
	"config/*",
	"config/**/*"
}
