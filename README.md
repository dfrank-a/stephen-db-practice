# A Practice Database for my Mans <3 

## Installation of requirements

__Note: This setup script assumes you are using Ubuntu or a derivative of it!__

Open terminal and execute from this directory: `sudo sh install-docker.sh`

## Startup and shutdown

To start the containers in the background, use `docker-compose up -d`

To stop containers in the background, use `docker-compose down`

## Accessing the database admin

Once the containers are started, the admin utility is available by typing `localhost:5050`
in your preferred browser. The default username and password are:

User: `admin@pgadmin.org`

Pass: `admin`

Once you have logged into the utility. The practice database is in the `local` group. 
It will ask for a password to open `practice_db` for the first time. 
The password is `postgres_pass`. 

## Using the practice database

Open up the `Databases` dropdown and select `postgres > schemas`. 
The `public` schema was automatically created when the container was initialized. 

You can right click the `public` schema and select `Query Tool` to open a query editor. 

### Saving queries for reuse in database initialization

It's nice to be able to start from scratch, but if you'd like to restart the database with some
tables or other database entities already created, you can place those queries in the 
`postgres13/initdb.d` directory.

Save them as `.sql` files. These files will be executed in alphabetical order, so it's a good idea 
to prefix them with numbers, so you have freedom to give them descriptive names.

These files only get executed when the database is rebuilt from scratch. 

### Starting the database from scratch

To start from scratch, run `docker-compose down --volumes` to stop the containers and remove all 
persistent data. Then start the containers again via `docker-compose up` or `docker-compose up -d`

This will cause all data to be erased, but any scripts placed in initdb.d will be executed when the 
containers are started again. 

## Troubleshooting

To start the containers and watch log output, execute `docker-compose up`

#PGAdmin4 Configuration files
## `server.json`
Mapped to `/pgadmin4/servers.json` inside the pgadmin container. 
From the [pgadmin documentation](https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html#mapped-files-and-directories)

>If this file is mapped, server definitions found in it will be loaded at launch 
time. This allows connection information to be pre-loaded into the instance of 
pgAdmin in the container. Note that server definitions are only loaded on first 
launch, i.e. when the configuration database is created, and not on subsequent 
launches using the same configuration database.
