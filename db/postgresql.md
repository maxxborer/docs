## Postresql

Параметры:
- __%PG_NAME%__ - (прим. "myproject-pgdocker") - имя Postresql;
- __%POSTGRES_PASSWORD%__ - (прим. "12345") - password db;
- __%POSTGRES_USER%__ - (прим. "myproject-user") - username db;
- __%DB_NAME%__ - (прим. "myproject-db") - имя db;
- __%PATH_TO_DB%__ - (прим. "$HOME/db/myproject") - путь к локальной db.

### Запуск

`docker run --rm --name %PG_NAME% -e POSTGRES_PASSWORD=%POSTGRES_PASSWORD% -e POSTGRES_USER=t%POSTGRES_USER% -e POSTGRES_DB=%DB_NAME% -d -p 5432:5432 -v %PATH_TO_DB%:/var/lib/postgresql/data postgres`

### Вход в db
`docker exec -it %PG_NAME% psql -d %DB_NAME% -U %POSTGRES_USER% --password`
Ввести __%POSTGRES_PASSWORD%__
