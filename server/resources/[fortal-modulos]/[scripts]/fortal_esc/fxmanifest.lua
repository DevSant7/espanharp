

fx_version "adamant"
game "gta5" 
lua54 "yes"

ui_page "web-side/build/index.html"

shared_scripts {
   "@PolyZone/client.lua",
   "@vrp/lib/utils.lua",
   "shared/config.lua",
   "__vRP__.lua"
}

server_scripts {
   "server-side/shared_server.lua",
   "server-side/server.lua"
}

client_scripts {
   "client-side/shared_client.lua",
   "client-side/client.lua"
}

files {
   "web-side/build/**/*",
}