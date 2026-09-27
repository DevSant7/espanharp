fx_version "bodacious"
game "gta5"
lua54 "yes"

name "fortal_admin"

ui_page "web/build/index.html"

shared_scripts {
	"@vrp/lib/utils.lua",
	"shared/*.lua"
}

client_scripts {
	"client/*"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@vrp/lib/items.lua",
    "@vrp/lib/vehicles.lua",
    "server/*"
}

files {
	"web/*",
	"web/build/**/*"
}
