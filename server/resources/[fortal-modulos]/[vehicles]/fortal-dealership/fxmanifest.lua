fx_version 'cerulean'
game 'gta5'

ui_page 'client/nui/index.html' -- PROD
-- ui_page 'http://82.24.40.124:3000' -- DEV

shared_scripts { 
    "@vrp/lib/utils.lua",
    "Config.lua"
}

server_scripts {
    "@vrp/lib/vehicles.lua",
    'server/*.lua'
}

client_scripts {
    'client/*.lua'
}

files {
    'client/nui/*',
    'client/nui/**/*'
}