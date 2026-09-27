
fx_version "bodacious"
game "gta5"

ui_page "web-side/build/index.html"

shared_script "shared/config.lua"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"@vrp/lib/items.lua",
	"server-side/shared_server.lua",
	"server-side/server.lua" 
}

files {
	"web-side/build/**/*"
}