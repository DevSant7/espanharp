

fx_version "bodacious"
game "gta5"

ui_page "web-side/build/index.html"

shared_scripts {
	"@vrp/lib/utils.lua",
	"@vrp/lib/items.lua",
	"shared/config.lua"
}

client_scripts {
	"client-side/shared_client.lua",
	"client-side/client.lua"
}

server_scripts {
	"server-side/shared_server.lua",
	"server-side/server.lua"
}

files {
	"web-side/build/*",
	"web-side/build/**/*"
}
