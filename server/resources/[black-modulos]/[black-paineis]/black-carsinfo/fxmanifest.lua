 
fx_version "adamant"
game "gta5" 
lua54 "yes"

ui_page "client-side/nui/index.html"

shared_scripts {
   "@PolyZone/client.lua",
   "@vrp/lib/utils.lua",
}

client_scripts {
   "client-side/client.lua",
}

server_scripts {
   "@vrp/modules/bk.lua",
   "server-side/server.lua",
}

files {
   "client-side/nui/**/*",
}