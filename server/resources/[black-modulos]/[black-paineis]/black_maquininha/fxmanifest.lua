dependency 'maquininhaStream'

fx_version "bodacious"
game "gta5"

ui_page "client-side/nui/index.html"

shared_scripts {
    "@vrp/lib/utils.lua",
}

client_script {
    "client-side/shared_client.lua",
    "client-side/client.lua"
}

server_script {
    "server-side/shared_server.lua",
    "server-side/server.lua"
}

files {
    "client-side/nui/*.html",
    "client-side/nui/*.png",
    "client-side/nui/assets/*.js",
    "client-side/nui/assets/*.css",
}