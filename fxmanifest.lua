fx_version 'bodacious'
game 'gta5'

description 'vSyncRevamped'
version '1.0.2'

server_scripts {
	'config.lua',
	'locale.lua',
	'locales/*.lua', -- Thanks to raphapt https://github.com/raphapt, thegambid https://github.com/thegambid and Richards0nd https://github.com/Richards0nd
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'locale.lua',
	'locales/*.lua', -- Thanks to raphapt https://github.com/raphapt, thegambid https://github.com/thegambid and Richards0nd https://github.com/Richards0nd
	'client/client.lua'
}
