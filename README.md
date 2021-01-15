# heroku-docker-automuteus
Unofficial AutoMuteUs docker image for Heroku deployment

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/k-tahiro/heroku-docker-automuteus&env[DISCORD_BOT_TOKEN]=)

## How to use

### Requirements

- Configured [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
- heroku-config plugin (will be installed automatically)

### Steps

1. Create `.env` file in this directory. Basically you can copy `sample.env` file and edit `DISCORD_BOT_TOKEN`.
2. Run `$ ./deploy.sh APP_NAME`. You should specify you own `APP_NAME`. For example, `$ ./deploy.sh my-own-muteus`.

## Structure

There are 4 components to deploy AutoMuteUs.
Here is the correspondence of these components.

- automuteus: web dyno
- galactus: same as automuteus's web dyno
- redis: heroku addon
- postgres: heroku addon

All of these heroku services can be used as free!

But web dyno goes to sleep when there is no access to application.  
To prevent this behavier, we can use other services to request application periodically.
