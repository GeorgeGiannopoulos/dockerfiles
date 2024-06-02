# MongoDB Dockerfile

## How it Works

- A `mongo` image is used

- Mongo environmental variables are used to set default root user

- A default version of a mongo configuration is copied to mongo installation directory

- An initialization `.js` is copied to docker entrypoint init directory to initialize the database with users/tables e.t.c.. An example .js is located inside **init** directory

- The port 27017 is exposed

- To ensure persistence of the database volumes are mounted

## How to Configure

1. Select a `mongo` image version that matches the one used to develop the project (replace `latest`)

2. Change the default `username`, `password` and `DB's name`. (This consider a **security leak**. There are other approaches)

3. Change the configuration file according to project's requirements

4. Remove or Modify the `.js` file according to project's requirements

## How to Use

Build Image:

```shell
docker build -t db:latest .
```

Run container:

```shell
docker run -idt -p 27017:27017 --name db db:latest
```

Enter `mongod` shell, by running the following and enter the password `astrongpassword`:

```shell
docker exec -it db bash
```

**NOTES:**

- Use the correct mongo version on build stage

- Volumes are used to ensure persistence of data. Mount them to specific paths to ensure they stay the same during container re-creation
