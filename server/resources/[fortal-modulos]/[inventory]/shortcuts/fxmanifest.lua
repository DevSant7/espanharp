 

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/items.lua",
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/vehicles.lua",
	"@vrp/lib/items.lua",
	"@vrp/lib/utils.lua",
	"server/*"
}

files {
	"web/*"
}