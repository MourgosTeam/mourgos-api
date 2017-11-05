# mourgos-api
The HTTP API for mourgos.gr.

[![Build Status](https://travis-ci.org/MourgosTeam/mourgos-api.svg?branch=master)](https://travis-ci.org/MourgosTeam/mourgos-api)

Pushes to master are deployed via TravisCI.

## Development

1. Set up the database
First you need to start a MariaDB instance (by default on your localhost:32770, see `db/config/development.json`). If you have Docker installed, run:

```bash
./start_development_db.sh
```

This will start MariaDB in a docker container and expose port 32770.

You then need to run `db/backup.sql` to set up the database. You could do this by connecting to the databse using the MySQL client:
```bash
mysql --port 32770 --password development --user root
```

And then running

```sql
source db/backup.sql
```

2. Install dependencies:

```bash
npm install
```

3. Start the API:

```
npm start
```

By default, the API will bind to port 3000.
