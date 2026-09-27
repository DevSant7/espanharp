
thn_disabletrigger "yes"
thn_newnatives "yes"

fx_version "bodacious"
game "gta5"

files {
  "client-side/nui/**",
}

ui_page "client-side/nui/index.html"

shared_scripts {
  "@vrp/lib/utils.lua",
  "shared/module.lua"
}

client_scripts {
  "lib/utils.lua",
  "@vrp/lib/vehicles.lua",
  "client-side/shared_client.lua",
  "client-side/*.lua"
}

server_scripts {
  "lib/utils.lua",
  "@vrp/lib/vehicles.lua",
  "@vrp/modules/bk.lua",
  "server-side/shared_server.lua",
  "server-side/server.lua"
}