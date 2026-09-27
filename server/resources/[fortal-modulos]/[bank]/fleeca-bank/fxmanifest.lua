fx_version "cerulean"

game "gta5"
ui_page "client/nui/index.html"

shared_scripts {
    "@vrp/lib/utils.lua",
    "config/*.lua",
    "utils/*.lua",
    "db/*.lua"
} 

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@vrp/modules/bk.lua',
    'server/*.lua'
}

files {
    "client/nui/*",
    "client/nui/**"
}

