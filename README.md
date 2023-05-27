# Docker Files

This repo contains docker files for basic projects

Each docker file follows some rules based on best practices:

1. Create ephemeral containers, so the image defined by the Dockerfile should generate containers that can be stopped and destroyed, then rebuilt and replaced with an absolute minimum set up and configuration.

2. Exclude with .dockerignore, files not relevant to the build.

3. Use multi-stage builds to drastically reduce the size of the final image, without struggling to reduce the number of intermediate layers and files.

4. Minimize the number of layers by knowing that only the instructions RUN, COPY, ADD create layers. Other instructions create temporary intermediate images, and do not increase the size of the build.

5. Install dependencies prior to coping the source code to the docker image, so the dependencies layer is not executed each time a change in the source code is deployed.

