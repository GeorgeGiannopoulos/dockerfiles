# Python Dockerfile (with virtual environment)

## How it Works

- An `python` image is used

- An environmental variable named `PROJECT_HOME` is used to keep the path of the project inside the image

- An environmental variable named `VIRTUAL_ENV` is used to export the python's virtual environmental to the image

- A python virtual environmental is created at `VIRTUAL_ENV` directory

- The `VIRTUAL_ENV` directory is added at the beginning of the `PATH` environmental variable to shadow the default python executables

- The virtual environmental's `pip` is updaded to latest version

- The python `wheel` package is installed to ensure better package installation proccess

- Change working directory to where the project's code will be reside

- The project's python dependencies are copied to the project's home directory and are installed

- The project's source code is copied inside the image

- Placeholder for exporting ports exists in the `Dockerfile`

- Placeholder for mounting volumes exists in the `Dockerfile`

- An entrypoint using python command and a cmd command that runs the expected main script of the project (replace **run.py** accordingly) are executed

## How to Configure

1. Select a `python` image version that matches the one used to develop the project (replace `latest`)

2. Add a text file named `requirements.txt` with all the project's python dependencies

## How to Use

Build Image

```shell
docker build -t app:latest .
```

Run container
```shell
docker run -idt -p XXXX:XXXX --name app app:latest
```

**NOTES:**

- An official python image is used. Use an `-alpine` version to reduce the size of the image, if needed

- Replace CMD command's argument with the project's corresponding one

- Add to **.dockerignore** any directory/file that needs to be excluded from docker image to keep the image size as small as possible
