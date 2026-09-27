fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/build/index.html"

dependencies {
	"vrp"
}

shared_scripts {
	"@vrp/lib/utils.lua",
	"shared/*.lua"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/utils.lua",
	"server/core.lua"
}

files {
	"web/*",
	"web/build/**/*"
}