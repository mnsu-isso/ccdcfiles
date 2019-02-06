# before running this script, establish a username and password and create the otrs database.
# run this file from the same directory as otrs-5.0.7.zip

$user="configureme"
$password="configureme"

stop-service cron

mv c:\otrs\otrs c:\otrs-old-3.3.5 -recurse

Add-Type -assembly “system.io.compression.filesystem”
[io.compression.zipfile]::ExtractToDirectory("otrs-5.0.7.zip", "c:\otrs\otrs")

get-content c:\otrs\otrs\scripts\database\otrs-schema.mysql.sql | mysql --user=$user --password=$password otrs
get-content c:\otrs\otrs\scripts\database\otrs-initialinsert.mysql.sql | mysql --user=$user --password=$password otrs
get-content c:\otrs\otrs\scripts\database\otrs-schema-post.mysql.sql | mysql --user=$user --password=$password otrs

start-service cron
