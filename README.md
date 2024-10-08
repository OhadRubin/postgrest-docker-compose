Postgres-PostgREST Example
=================

A sample Postgres, PostgREST, PGAdmin, Nginx and Swagger development environment.

## Usage

Replace the shell or SQL scripts in the the initdb folder to populate the database with your own data, if you wish or use the sample data already provided.

## Deployment

### Deploy the containers

```bash
docker-compose up -d --detach
```

### Tear down the deployment

```bash
docker-compose down --remove-orphans 
```

To remove the created Docker volumes that data is persisted to use the following command:

```bash
docker-compose down --remove-orphans --volumes
```

To remove the created Docker images and volumes that data is persisted to use the following command:

```bash
docker-compose down --remove-orphans --volumes --rmi all
```

### Windows Docker Compose Debugging:

Some issues have been reported with running this example on Windows. There two culprits. 

1. Make sure that the scripts in the folder intidb are in *nix format with only LF and not the default Windows CRFL. You can remedy this by using dos2unix command line program or most editors will allow for the translation.

2. Next issue is the pathing issues with how Windows resolves them. Recommended work around is to use Windows Subsystem for Linux (WSL) to run the docker-compose command and to change the `./initdb` entry in the `db` container specification for volumes in the`docker-compose.yml` file to the fully pathed WSL folder name.  See example below:

```yaml
    volumes:
      # anything in initdb directory is created in the database
      # see "How to extend this image" section at https://hub.docker.com/r/_/postgres/
      - "/mnt/c/Users/MyUserName/MyDirectory/postgrest-docker-compose/initdb:/docker-entrypoint-initdb.d"
      #- "./initdb:/docker-entrypoint-initdb.d"
      - local_pgdata:/var/lib/postgresql/data
```

Try the above two solutions together if you get a cannot load initd log message in the db container or invalid format error in the db container log messages.

## Demo Application

[Test out the web application that is driven by the PostgREST API calls](http://localhost) This is served from the Nginx server Postgres-demo (using port 80) in the docker-compose file to serve up a simple web application that uses the rest calls.

Now test the REST Get statements:

* [Get the cities in the database](http://localhost:3000/city)
* [Get the countries in the database](http://localhost:3000/country)
* [Get the languages in the database](http://localhost:3000/countrylanguage)
* [Get cities named Springfield from the database](http://localhost:3000/city?name=eq.Springfield)
* [Get cities in the USA city view with 'ie' in the name from the database](http://localhost:3000/v_usa_city?name=like.*ie*)
* [Get cities with a population greater than or equal to 3,000,000](http://localhost:3000/city?population=gte.3000000)
* [Get cities tha end in "Island"](http://localhost:3000/city?district=like.*Island)
* [Get cities where the district like Island and the population is less than 1000; selecting only the city name](http://localhost:3000/city?district=like.*Island&population=lt.1000&select=id,name)

**NOTE**: All calls to port 3000 are routed through the Nginx reverse proxy. You can find the description of the reverse proxy in the `nginx` section of the `docker-compose` and `Dockerfile` scripts in the repository. 

## Swagger

 [Show the REST API endpoints for Get, Post, Delete and Patch](http://localhost:8080)

## PgAdmin

Navigate to [the PgAdmin URL](http://localhost:8888) to open up PGAdmin (you might need to give it a minute or two to be ready).

Use the values `PGADMIN_USER` and `PGADMIN_PASSWORD` in the .env file to log into PgAdmin.

Under the section `Quick Links` click on `Add New Server` to open up the database connection dialog.

![pgadmin_connect](./documentation_images/pgadmin_connect.png)

1. The value should be `db`, the same name as the database service in the docker-compose script.
2. Leave as port `5432` (unless you changed the database port in the docker-compose script).
3. Use the value in `POSTGRES_DB` in the .env file.
4. Use the value in `POSTGRES_USER` in the .env file.
5. Use the value in `POSTGRES_PASSWORD` in the .env

Once successully logged into the database, you should be able to navigate the tree on the left down to tables.

![tables_created](./documentation_images/tables_created.png)

1. You should see the tables `CITY`, `COUNTRY` and `COUNTRYLANGUAGE` has been created from the code in the `initdb` folder of this repository.

Right click on one of the tables and select `View/Edit Data >  First 100 Rows` you should get a result like this:

![select_city_tables](./documentation_images/select_city_tables.png)

## Documentation

[PostgREST Documentation](https://postgrest.org/en/v8.0/index.html)
[Swagger Documentation](https://swagger.io/docs/)
[Postgresql Documentation](https://www.postgresql.org/docs/)
[Nginx Documentation](https://nginx.org/en/docs/)
[PGAdmin Documetation](https://www.pgadmin.org/docs/)
[PostgREST-py](https://github.com/supabase-community/postgrest-py)


<!-- https://gist.github.com/oofnikj/4ee432033421f34b548ae2891067efcf -->