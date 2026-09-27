

fx_version "bodacious"
author 'Felp <contato@blacknetwork.com.br>'
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/*.lua"
}

server_scripts {
	"@vrp/lib/items.lua",
	"@vrp/lib/utils.lua",
	"server/*.lua"
}

shared_scripts {
	"config.lua",
}
