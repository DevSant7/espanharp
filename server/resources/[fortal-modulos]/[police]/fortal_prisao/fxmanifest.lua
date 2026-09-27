fx_version 'cerulean'
game 'gta5'

shared_scripts {
    'shared/config.lua'
}

client_scripts {
    "@vrp/lib/utils.lua",
    'client/*.lua'
}

server_scripts {
    "@vrp/lib/utils.lua",
    'server/*.lua'
}

ui_page 'web-side/build/index.html'

files {
    'web-side/build/index.html',
    'web-side/build/**/*'
} 