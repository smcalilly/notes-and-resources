# heroku

## build docker images with heroku.yml
`heroku.yml` is a manifest you can use to define your heroku app. it allows you yo:
- build docker images on heroku
- specifiy add-ons and config vars to create during app provisioning
- use review apps when deploying docker-based applications

[this is how you can create one](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#getting-started). [see also](https://github.com/datamade/how-to/blob/master/heroku/deploy-a-django-app.md#herokuyml)

example heroku.yml:
```yml
build:
  docker:
    web: Dockerfile
run:
  web: gunicorn -t 180 --log-level debug test-app:test-app
```

i don't actually know if that works. that's why i'm here, because i'm debugging a docker + heroku + python + flask issue.
