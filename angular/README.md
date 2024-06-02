# Angular Dockerfile

## How it Works

- A Multi-Stage build is used in this `Dockerfile`. One stage for building the app and another to deploying it

- For the `build` stage a `node` image is used

- A directory **/app** is used during `build` stage

- The project's dependencies are copied inside **/app** and are installed using `npm`

- The project's source code is also copied inside  **/app**

- Build the app using `production` flag (production `env` if exist) (build directory is **/app/dist**)

- For the final stage an `nginx` image to deploy the app (an `-alpine` is selected to reduce the final image)

- A simple `nginx.conf` is copied to nginx image's configuration directory that handles all requests to the `app`

- The artifacts from the `build` image is copied to the final image

- The port 80 is exposed

## How to Configure

1. Select a `node` image version that matches the one used to develop the project (replace `latest`)

2. The default building behavior of the app must be the production on (environment wise)

3. Select a `nginx` image version in case the latest `alpine` does not meet the project's requirements

## How to Use

Build Image

```shell
docker build -t app:latest .
```

Run container
```shell
docker run -idt -p 80:80 --name app app:latest
```

**NOTES:**

- Use the correct node version on build stage

- `Ahead-of-time (AOT) compilation` is used during the building phase to provide a faster rendering in the browser. Configure the app accordingly or remove the `--aot` argument from the `npm run build` command

- The `nginx.conf` handles only requests to frontend. A seperate reverse-proxy should be used for anything else

- This image supports only HTTP requests. To add support for HTTPS encryption than a separate reverse-proxy with HTTP certificates must be used
