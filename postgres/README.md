# PostgreSQL Dockerfile

## How it Works

- A `postgres` image is used

- PostgreSQL environmental variables are used to set default root user

- An initialization `.sql` is copied to docker entrypoint init directory to initialize the database with users/tables e.t.c.. An example .sql is located inside **init** directory

- The port 5432 is exposed

- To ensure persistence of the database volumes are mounted

## How to Configure

1. Select a `postgres` image version that matches the one used to develop the project (replace `latest`)

2. Change the default `username`, `password` and `DB's name`. (This consider a **security leak**. There are other approaches)

3. Remove or Modify or add more `.sql` file(s) according to project's requirements

## How to Use

Build Image:

```shell
docker build -t db:latest .
```

Run container:

```shell
docker run -idt -p 5432:5432 --name db db:latest
```

Enter `psql` shell, by running the following and enter the password `astrongpassword`:

```shell
docker exec -it db psql -U defaultusername -W -d data
```

## Backup Data (works on Linux)
```shell
docker exec -i -e POSTGRES_PASSWORD="<DB_PASSWORD>" db /usr/bin/pg_dump -U "<DB_USERNAME>" <DB-NAME> |
    gzip -9 > "<BACKUP_DIR>/postgres-backup-data-$(date +"%Y%m%d_%H%M%S").sql.gz"
```

## Restore Data (works on Linux)
```shell
gzip -dc "<path/to/backedup/sql.gz>" | docker exec -i -e POSTGRES_PASSWORD="<DB_PASSWORD>" d psql -U "<DB_USERNAME>" <DB-NAME>
```

**NOTES:**

- Use the correct postgres version on build stage

- Volumes are used to ensure persistence of data. Mount them to specific paths to ensure they stay the same during container re-creation
