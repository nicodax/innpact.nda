# Project

Innpact is a fund management tool.

## Architecture
The application architecture follows Rails principles.
On top of it, there are:
* Interactors: Can be called "Use Case". They implement the business logic triggered by a user action.
* Services: Object that include block of logic. They can be called by different interactors.
* Policies: They ensure the access controls for each available actions at controller level
* Validators: They are used to define complex validations to the models
* Decorators: They are used to enrich objects with useful functions to ease the rendering

### Important points 
An interactor, as it is called by the user, must ensure its input are valid.

A service, as it is called only by internal layers, should not validate its inputs.

### Users
http://localhost:3000/users/sign_in


# Belighted

## Resources
* [Product page on Notion](https://www.notion.so/belighted/MEF-Platform-a7725020ef0d455cb595560bf07eae24)
* [VPN access setup](https://www.notion.so/belighted/How-to-configure-VPN-client-8e664b7acb5c4e76b5a80835f4a12c42)
* [MSQL Data Structure of innpact and link between the tables](https://www.notion.so/belighted/MEF-Platform-innpact-a7725020ef0d455cb595560bf07eae24#c496649dfdae41c0bdd0faa9cf68456e)

# Tech

## System Dependencies

* ruby version manager ([rbenv](https://github.com/rbenv/rbenv) / [asdf](https://asdf-vm.com/) / [chruby](https://github.com/postmodern/chruby))
* [nvm](https://github.com/nvm-sh) - managing nodejs versions
* Docker (https://docs.docker.com/get-docker/)
* Freetds (`brew install freetds`)
* SQL Server - available via Docker (`docker pull mcr.microsoft.com/mssql/server:2017-latest`)

On  Ubuntu, to install Freetds:
```
sudo apt-get update -y
sudo apt-get install -y freetds-dev
```

## Setup Development environment

### Rails server

Unicorn used to run the dev server, as well as the production environment's 
servers, but is not well supported anymore.

The dev rails server is ran using `webrick` instead at the moment.

This has no impact on the way the application is started locally.

### With Docker

A Docker/docker-compose configuration is provided so that you can run the application or the tests locally without
having to setup the whole environment manually. To use it, see [ops/README.md](ops/README.md);
otherwise, follow the instructions below.

### Without Docker

* install all the system dependencies (see above)
* install ruby version (check `.ruby-version`) via your ruby version manager
* install nodejs version defined in the `.nvmrc`
* install ruby deps - `bundle install`
* install nodejs deps - `yarn install`
* Locally, copy `config/version.json.example` to a file name `config/version.json`
* Locally, copy `PROJECT_ROOT/.env.example` to `PROJECT_ROOT/.env`
* Run `docker run --env-file .env -p 1433:1433 -v ./ops/dev/db_data:/var/opt/mssql mcr.microsoft.com/mssql/server:2017-latest` to start db container
If you want to develop on the seed data, you can setup the db by running:
``` shell
bundle exec rails db:setup
```
If you want to develop on the migrated data, you can setup the db by running the data migration ([more informations on the data migration](#database-migration)):
``` shell
bundle exec rails db:drop db:create db:migrate
bundle exec rails db:data_migration
```

## Using
Running the app with Docker:
```shell script
cd PROJECT_DIR/ops/dev
docker-compose up
```

### Commands

* Start the mssql container - `cd ./ops/dev && docker-compose up -d`
* Run app server - `bundle exec rails s`
* Run data migration from legacy access db - `bundle exec rails db:data_migration`
* Run brakeman audit - `bundle exec brakeman`
* Run rubocop audit - `bundle exec rubocop`
* In a PR, for interactive ignoring - `bundle exec rubocop -I`
* Run rubocop autocorrect - `bundle exec rubocop -a`
* Run rubycritic audit - `bundle exec rubycritic`
* Run eslint audit - `yarn run lint`

### Info

The app uses role based system with following options:

* Administrator - ability to add a new user with any role, access to all funds resources
* General Manager - ability to add a new user with general manager / investment manager / reader role, access to all funds resources
* Investment Manager - ability to access to funds based on assigment to the IM group
* Reader

Besides user roles there is also option to assign investment managers into groups at the fund level
The application uses [Rolify](https://github.com/RolifyCommunity/rolify) gem to manage roles.

### Test files

In the app there are some options to load the data via imports xlsx files. There are following places with test data:

* In the repo `PROJECT_ROOT/example_files`
* [Google drive](https://drive.google.com/drive/folders/1O5yFWTiTqx7gQH16f6O4hGWDjbjMA-56?usp=sharing)

## Production environment

### Setup

The application setup on the staging / uat / production requires following utils on the server:

* [rbenv](https://github.com/rbenv/rbenv) - for managing the ruby version
  (install ruby version based on the `.ruby-version`)
* [rbenv-vars](https://github.com/rbenv/rbenv-vars) - rbenv plugin to set env vars
* [nvm](https://github.com/nvm-sh) - managing nodejs versions
* [nginx](https://www.nginx.com/) - as a reverse proxy for rails app
* SQL Server - managed by the GroupLab

Open a Rails console in the server: `bundle exec rails console`
Create an Admin user:

```ruby
admin = User.new({
  email: 'admin@innpact.com',
  password: 'password',
  password_confirmation: 'password',
  firstname: 'Admin',
  lastname: 'Innpact'
})
admin.add_role(:administrator)
admin.save
```

### How to deploy

The deployment process is based on the capistrano workflow.
To access the servers, you need to be connected on the [VPN](https://www.notion.so/belighted/How-to-configure-VPN-client-8e664b7acb5c4e76b5a80835f4a12c42).

The application can be deployed into following environments:

* staging - QA process by QLeap, deploy the *staging* branch
* uat - pre-production env, deploy the *uat* branch
* production - deploy the *production* branch

Those utils should be installed for the deploy user context.

The ENV vars for each capistrano stage should be at `$HOME/innpact.com/__capistrano_stage__/.rbenv-vars`.

The application requires also vhost setup for the nginx.

The deployment requires active session via VPN (see more at PulseSecure note in the Bitwarden's Innpact space).

The deployment requires a private ssh-key linked to your ssh-agent to give you access to Belighted github content.
You can follow [this tutorial](https://www.freecodecamp.org/news/git-ssh-how-to/) to create an ssh key for github access then run this command in your linux/Mac terminal to add the key to the shh-agent:

```bash
$ ssh-add
```
If the command above doesn't work, it could mean that your ssh-agent is not running. To start the ssh-agent service, run this command. 

```bash
$ eval `ssh-agent -s`
$ ssh-add
```

Each environment has own dedicated branch: staging / uat / production.
When you want to deploy to staging / uat / production, you need to merge master to stage branch.
Before merging master to uat / production, please apply a tag e.g `git tag 1.0.3` and
push the tag to the origin.
The version information for uat / production will be updated via capistrano task.

```bash
$ bundle exec cap staging|uat|production deploy
```

In case of the deployment for staging environment, you can deploy specific branch:

```bash
$ BRANCH=YOUR_BRANCH_NAME bundle exec cap staging deploy
```

You can see all option from the capistrano CLI:

```bash
$ bundle exec cap -T
```

### Restarting Unicorn
Due to the collaboration with an external provider for the Infrastructure of the application. 

We often had to manually *start/restart Unicorn* after they perform updates/fixes on the servers. 

Here are a few usefull commands: 

From  `/innpact.com/`**`ENV`**`/current`, you may run the following commands:
- to start: 
`bundle exec unicorn -c config/unicorn/`**`ENV`**`.rb -E `**`ENV`**` -D`

- to stop: ``kill -9 `cat tmp/pids/unicorn.pid` ``

where **`ENV`** is equal to: *staging/uat/production* depending on the environment and the server.

# Contributing

## Pull Requests

Take a look on the [Belighted guide](https://www.notion.so/belighted/How-to-work-with-Pull-Request-6a489680e31d42378bcd8238b4126069)
for more details.

## Tests

* Backend tests: `bundle exec rspec` or go to ops/test folder and run `docker-compose up`

# Database Migration
## Script location in the project

* The script is located in lib/tasks/db.rake.
* The data used by the script are CSV files located in db/csv_files/

## Before Running the scripts

The script is based on CSV files containing a header, with each elements separated by ";" and with decimals number separated by ".". Before starting the script, you need to make sure all the TAB to be exported in the script are located in the folder csv_files.
* TAB_COUNTRY.csv
* TAB_RATING_COUNTRY.csv
* TAB_REGION.csv
* TAB_CCY.csv
* TAB_MFI.csv
* TAB_GROUP.csv
* TAB_STATUS.csv
* TAB_FX_RATE.csv
* TAB_POSITION.csv
* TAB_BOND.csv
* TAB_INTEREST_RATE_TYPE.csv
* TAB_TYPEOFLOAN.csv
* TAB_REPAYMENT_TYPE.csv
* TAB_POOL.csv
* TAB_VRR_LOAN.csv
* TAB_VRR_TYPE.csv
* TAB_PROVISION.csv
* TAB_CALENDAR.csv

## Run the data migration script

First you need to clear the database. (You could run the script without but it has not been designed with this purpose and would double data already existing)
### In development
```bash
$ rake db:reset
```
### In Staging, UAT and production
Dropping the database could not work due to the configuration (login will fail if default db is dropped)
You can use the script on the server (look at the end of the README for more information).

#### In Staging

Go to the "/innpact.com/staging" folder.
Run this command line.
```
sqlcmd -S 172.20.7.103 -U fmi-test -i reset-staging-db.sql -o output.log
```

Go to the "/innpact.com/staging/current" folder.

```bash
$ RAILS_ENV=staging bundle exec rake db:schema:load
$ RAILS_ENV=staging bundle exec rake db:data_migration
```

#### In UAT

Go to the "/innpact.com/uat" folder.
Run this command line.
```
sqlcmd -S 172.20.7.103 -U fmi-uat -i reset-uat-db.sql -o output.log
```

Go to the "/innpact.com/uat/current" folder.

```bash
$ RAILS_ENV=uat bundle exec rake db:schema:load
$ RAILS_ENV=uat bundle exec rake db:data_migration
```

#### In Production

Go to the "/innpact.com/production" folder.
Run this command line.
```
sqlcmd -S 172.20.7.102 -U fmi-prod -d fmi-prod -i reset-production-db.sql -o output.log
```

Go to the "/innpact.com/production/current" folder.

```bash
$ RAILS_ENV=production bundle exec rake db:schema:load
$ RAILS_ENV=production bundle exec rake db:data_migration
```

While running the script, you will see on the console all the data which have not been able to be transfered or which are incomplete.

## Setup Automatic snapshot of database
We have a tool to automatically create a snapshot of the database every month for data anylisis purpose. This snapshot works using a crontab job executed by linux each month at 0:00 the first day of the month.
Here is the procedure to verify the deployment of teh crontab has been done correctly:

```bash
$ crontab -l
```

# MSSQL Tools for linux

You can install tools for MSSQL.

[Installation procedure](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver15)

To dump the database
```
sqlcmd -S 172.20.7.103 -U fmi-test  -Q "BACKUP DATABASE [fmi-test] TO DISK = N'/home/inn-admin/stagingdb.bak' WITH NOFORMAT, NOINIT, NAME = 'fmi_test_full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"
```

Drop database content
The first query drops contraints.
The second one drops the tables.

```
-- use database
USE [fmi-test]
GO

-- drop constraints
DECLARE @DropConstraints NVARCHAR(max) = ''
SELECT @DropConstraints += 'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + '.'
                        +  QUOTENAME(OBJECT_NAME(parent_object_id)) + ' ' + 'DROP CONSTRAINT' + QUOTENAME(name)
FROM sys.foreign_keys
EXECUTE sp_executesql @DropConstraints;
GO

-- drop tables
DECLARE @DropTables NVARCHAR(max) = ''
SELECT @DropTables += 'DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)
FROM INFORMATION_SCHEMA.TABLES
EXECUTE sp_executesql @DropTables;
GO
```
To run it, use the command line
```
sqlcmd -S 172.20.7.103 -U fmi-test -i reset-staging-db.sql -o output.log
```
Where:
* _172.20.7.103_ is the MSSQL server IP
* _reset-staging-db.sql_ is the file containing the script
* _fmi-test_ is the username
