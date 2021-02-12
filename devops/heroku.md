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

### heroku.yml overview
a heroku.yml manifest has 4 top-level sections:
- `setup`: specifies the add-ons and config vars to create during app provisioning -- this is for heroku add-ons
- `build`: specifies the dockerfile to build -- where you build your docker image
- `release`: specifies the release phase tasks to execute -- where you might run tasks like sending css/js/assets to a cdn, run database migrations, etc
- `run`: specifies process types and the commands to run for each -- run the app

Here’s an example that illustrates using a heroku.yml manifest to build Docker images:

```yaml
setup:
  addons:
    - plan: heroku-postgresql
      as: DATABASE
  config:
    S3_BUCKET: my-example-bucket
build:
  docker:
    web: Dockerfile
    worker: worker/Dockerfile
  config:
    RAILS_ENV: development
    FOO: bar
release:
  command:
    - ./deployment-tasks.sh
  image: worker
run:
  web: bundle exec puma -C config/puma.rb
  worker: python myworker.py
  asset-syncer:
    command:
      - python asset-syncer.py
    image: worker
```

- [here are some ways to setup your app's environment](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#setup-defining-your-app-s-environment)
- [how to define your build](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#setup-defining-your-app-s-environment)
- [configure your release phase](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#release-configuring-release-phase)
- [run command](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#release-configuring-release-phase)

### review apps and app.json
an app.json file is required when using review apps with the heroku.yml manifest. [this will show you how that works.](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#release-configuring-release-phase)
