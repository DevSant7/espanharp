


fx_version "bodacious"
game "gta5"

ui_page "web-side/build/index.html"

client_scripts {
	"@vrp/lib/vehicles.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/utils.lua",
	"config/config_client.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/items.lua",
	"@vrp/lib/utils.lua",
	"config/config_server.lua",
	"server-side/*",
}

files {
	"web-side/build/images/*",
	"web-side/build/*",
	"web-side/build/**/*"
}
