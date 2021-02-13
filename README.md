# heroku-docker-automuteus
Unofficial AutoMuteUs docker image for Heroku deployment

Forked from [k-tahiro/heroku-docker-automuteus](https://github.com/k-tahiro/heroku-docker-automuteus)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## How to use

1. Click `Deploy to Heroku` button.
2. Enter your own App name.
3. Enter 2 environment variables.
   - `DISCORD_BOT_TOKEN`: Token for Discord Bot.
   - `HEROKU_APP_NAME`: App name. Please copy from the app name you entered at step 2.
4. Click `Deploy app`.

## Structure

There are 4 components to deploy AutoMuteUs.
Here is the correspondence of these components.

Difference between original one and this is supported automuteus-v7 👍

- automuteus: web dyno
- galactus: same as automuteus's web dyno
- wingman: same as automuteus's web dyno
- redis: heroku addon
- postgres: heroku addon

All of these heroku services can be used as free!

But web dyno goes to sleep when there is no access to application.  
To prevent this behavier, we can use other services to request application periodically.
