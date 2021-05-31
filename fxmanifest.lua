
fx_version 'adamant'

game 'gta5'

ui_page 'html/form.html'

files {
	'html/form.html',
    'html/form.js',

    -- Manage
    'html/manage/manage.html',
    'html/manage/manage.js',
    'html/manage/manage.css',

    -- Application
    'html/application/application.html',
    'html/application/application.js',
    'html/application/application.css',
}

client_scripts{
    'configuration/config.lua',
    'client/main.lua',
}

server_scripts{
    'configuration/secrets.lua',
    'configuration/config.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
}