# --------------------------------------------------------------------------------------------------
# Build Stage
# --------------------------------------------------------------------------------------------------
FROM node:latest as build

# Set working directory:
WORKDIR /app

# Install and cache app dependencies:
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install

# Add Source Code:
COPY . /app

# Build the app:
RUN npm run build -- --outputPath=dist --prod --aot


# --------------------------------------------------------------------------------------------------
# Production Stage
# --------------------------------------------------------------------------------------------------
FROM nginx:alpine

# Copy artifact build from the 'build environment':
COPY nginx.conf /etc/nginx/conf.d/
COPY --from=build /app/dist /usr/share/nginx/html/

# Expose to the World:
EXPOSE 80
