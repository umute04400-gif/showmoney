fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author '13hilvar'
description 'VORP Money Display System'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/fonts/GalaCondensed-Medium.woff2'
}

dependencies {
    'vorp_core'
}