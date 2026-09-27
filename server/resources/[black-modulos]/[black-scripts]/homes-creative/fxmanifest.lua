

fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web-side/index.html"

shared_scripts {
	"@vrp/lib/utils.lua",
	"shared/config.lua"
}

client_scripts {
	"client-side/client.lua",
	"server-side/mansions.lua"
}

server_scripts {
	"server-side/server.lua"
}

files {
	"web-side/*",
	"web-side/**/*"
}
