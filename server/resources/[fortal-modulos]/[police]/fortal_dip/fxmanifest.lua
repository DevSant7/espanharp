fx_version 'cerulean'
game 'gta5'

ui_page 'web-side/build/index.html'

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

files {
    'web-side/build/index.html',
    'web-side/build/assets/**/*',
    'web-side/build/*.png'
}

lua54 'yes'
