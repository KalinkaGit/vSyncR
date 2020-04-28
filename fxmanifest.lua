fx_version 'bodacious'
game 'gta5'

disable_lazy_natives 'yes'

description 'vSyncRevamped'
version '1.0.0'

server_scripts {
	'config.lua',
	'locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pt.lua', -- Thanks to raphapt https://github.com/raphapt
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/pt.lua', -- Thanks to raphapt https://github.com/raphapt
	'client/client.lua'
}
