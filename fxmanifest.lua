fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Cadburry'
description 'Communication device with channels (Intercom)'
version '0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'language.lua',
    'config.lua',
}

client_scripts {
    'modules/**/client.lua',
}

server_scripts {
    'modules/**/server.lua',
}

dependencies {
    'ox_lib',
    'ox_inventory'
}

escrow_ignore {
    'modules/editable/*',
    'language.lua',
    'config.lua',
}