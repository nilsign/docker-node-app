# Selects node.js with version as base image from public Docker repository.
FROM node:15

# Defines (and creates) a working directory within our container.
# Any commands are running from this directory, it is the default path.
WORKDIR /app

# Copy package.json into the working directory of the container.
COPY package.json .

# Install express and the all other dependencies from the package.json
# (including the dev-dependencies) for development, but only install the
# none dev-dependencies for production.
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
    then npm install; \
    else npm install --only=production; \
    fi

# Copies any file from the local node-docker-app folder to the working
# dir of the container (including again the package.json).
# This is an optimization. As the steps/layers/commands are cached and
# are not executed again, when nothing has changed. Depencies do only
# change sometimes, whereas the code in the /app dir usually changes often.
COPY . ./

# Exposes the port without effect (this line is just for documentation)
EXPOSE $PORT

# Runs the application entry point index.js (runtime) when the
# container starts.
CMD ["npm", "run", "dev"]
