fx_version 'cerulean'
game 'gta5'

description 'MXD Teleport'
version '1.0.0'

shared_script {
	'config.lua',
}

server_script {
	'server/*.lua',
    '@oxmysql/lib/MySQL.lua',
}
