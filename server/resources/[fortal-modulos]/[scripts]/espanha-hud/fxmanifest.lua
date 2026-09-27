fx_version 'bodacious'
game 'gta5'

lua54 'yes'

ui_page 'web-side/dist/index.html'

shared_scripts {
    '@vrp/lib/utils.lua',
    'shared-side/*'
}

client_scripts {
    'client-side/*'
}

server_scripts {
    'server-side/*'
}

files {
    "web-side/dist/*",
    "web-side/dist/**/*"
}