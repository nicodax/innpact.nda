# Docker configurations

## Preamble: logins

### Belighted's Github container registry

In order to build the base image, the `ruby-jemalloc` image needs to be pulled from Belighted's registry on Github.
For that you need to be logged in:

* In your Github settings go to "Developer settings > Personal access tokens", and click on "Generate a new token".
* Select the "write:packages" scope, then click "Generate token".
* In your console, run `docker login ghcr.io` and log in using your Github username and the previously generated token as password.

To push the image, you will also need to be logged in on AWS ECR (see above).

## Base image ([ops/base](./base))

The purpose of the base image is mostly to speed up the building of the working images.
It contains dependencies (binaries, gems,...) common to the various environments
(local development/test, feature, staging, production).

It must be rebuilt and pushed to the Docker registry when the base Dockerfile is modified (e.g. when Ruby version is
updated, or when binaries are added). It is also a good idea to rebuilt and push a new version from time to time in
order to install new or updated gems in the base image (this is not mandatory, but as explained above it will speed up
the building of the working images).

The base imaged can be built and pushed using the following command:

```shell
TAG=new_tag PROJECT_DIR/ops/base/build
```

When doing that, the base image tag in the Dockerfiles that use it has to be updated accordingly.

Note that most of the time, developers should not worry about the base image as an up-to-date version should be available
on AWS ECR and will be pulled automatically when building the dev and test images.

## Development ([ops/dev](./dev))

This directory contains all that should be needed to run the application stack locally with Docker.

### Setup

#### Environment variables
Create an empty `app_env.secrets` file in the directory. This files is ignored by Git and will allow you to override
the environment variables defined by default in `app_env` if needed.

#### Database config
Create (or modify) the `config/database.yml` file of the application so that its content is the same as
in the `config/database.docker.yml` file.

### Create docker-compose.override.yml
Create a `docker-compose.override.yml` file in the directory `./ops/dev` by copy/paste the `docker-compose.override.example.yml` and change the name. This file is ignored by Git and will allow you to override the default configuration from `docker-compose.yml` file.
The default file is :
```yaml
services:
  db:
    ports:
      - 1433:1433
  app:
    ports:
      - 3000:3000
```

### Create Docker container
Fetch, Build and launch all the services needed for the application in docker containers:
```shell
cd PROJECT_DIR/ops/dev
docker-compose up --build
```

### Create and populate database
#### With seed data
TODO: SEED DOESN'T CONTAIN ANY DATA FOR NOW. TO INVESTIGATE
Simply run:
```shell
cd PROJECT_DIR
rake db:drop db:create db:schema:load db:seed
```

#### With migrated data
Simply run:
```shell
cd PROJECT_DIR
rake db:drop db:create db:schema:load db:data_migration
```
(Note: you will need to run that again if you wipe out the db_data volume)

### Access the application
You can now access the application in your browser: http://localhost:3000 (if the ports has been kept to 3000 by default) and connect using the following credentials:
username: admin@innpact.com
password: password

### Running the application
Running:
```shell script
cd PROJECT_DIR/ops/dev
docker-compose up
```
will start all the needed services for the app to run.
Note that the very first time, an empty file named `app_env.secrets` should be created in
the `ops/dev` directory. This files is ignored by Git and will allow the developer to override the environment
variables defined by default in `app_env`.

If you have [dnsdock](https://github.com/aacebedo/dnsdock) running, the application will be available on
http://innpact.docker. If not, see the "Override configuration" section below.

### Override configuration

If for some reason you want to tweak the provided docker-compose configuration in order to better suit your local setup,
the recommended way is to create in the same directory a `docker-compose.override.yml` file in which you can specify your
own configuration. This file is ignored by Git and is automatically taken into account by docker-compose. You do not
need to rewrite everything, only the things that change (see https://docs.docker.com/compose/extends/#understanding-multiple-compose-files).

For example, if you don't have [dnsdock](https://github.com/aacebedo/dnsdock) running and want the Rails application
available on http://localhost:3000 as usual, create a `docker-compose.override.yml` file with the following content:

```yaml
services:
  db:
    ports:
      - 1433:1433
  app:
    ports:
      - 3000:3000
```

### Running Capistrano from the container

When deploying the application from inside the container you should use the ssh-agent.

First you need to make sure that it's running with `eval $(ssh-agent -s)` and add the ssh key to be used with `ssh-add ~/.ssh/id_rsa`.

You can run a container with a link to the running `ssh-agent` with this command.
```
docker-compose run --rm -v "$SSH_AUTH_SOCK:$SSH_AUTH_SOCK" -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK  app /bin/bash
```

From there you can run the Capistrano the usual way.

## Test ([ops/test](./test))

This directory contains all that should be needed to run the tests locally with Docker.

### Setup
The setup is the same as for the development environment.

### Running the test suite

Running:
```shell script
cd PROJECT_DIR/ops/test
docker-compose up --build
```
will launch the tests suite.
