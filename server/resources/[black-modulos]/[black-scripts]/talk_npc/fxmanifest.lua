
fx_version "adamant"
game "gta5"


shared_script {
   "@vrp/lib/utils.lua",
   "config.lua"
}

server_scripts {
   "@vrp/modules/bk.lua",
   "server.lua"
}
client_scripts {
   "client.lua"
}
