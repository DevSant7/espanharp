fx_version "bodacious"
game "gta5"

ui_page "web-side/build/index.html"


shared_script "shared/config.lua"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/items.lua",
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/build/*",
	"web-side/build/**/*"
}
