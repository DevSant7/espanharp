 
thn_disabletrigger "yes"

fx_version "bodacious"
game "gta5"

files {
  "client-side/nui/**",
}

ui_page "client-side/nui/index.html"

shared_scripts {
  "@vrp/lib/utils.lua",
  "@vrp/lib/items.lua",
  "shared/module.lua"
}

client_scripts {
  "lib/utils.lua",
  "client-side/shared_client.lua",
  "client-side/*.lua"
}

server_scripts {
  "lib/utils.lua",
  "@vrp/modules/bk.lua",
  "updater.lua",
  "server-side/shared_server.lua",
  "server-side/*.lua"
}
