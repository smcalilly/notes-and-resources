# Back to the Django Basics

I just picked up a dusty app and I'm confused about the state in which I left the app, only 2.5 months ago. If I could access the admin site and look at the models, then I might be able to see what I was thinking about the models. But I can't access my admin site, and I'm not sure why. Is something wrong with my admin site/URL confs? 

I don't know. I don't know enough about the admin site. So I'm going back to the basics to fill in knowledge gaps — maybe I'll find an answer through the process.

## admin site
[Notes from reading here](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/)

powerful part of Django is the automatic admin interface. It reads metadata from your models to provide a quick, model-centric interface where trusted users can manage content on the site. The admin's recommended use is limited to an organization's internal management tool. It's not intended for building your entire front end.

admin has a bunch of hooks for customization, but beware trying to use those hooks exclusively

the admin is enabled in the default project template used by `startproject`. if you're not using the default project template, [you can do it manually](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/#overview):
1. add Add `django.contrib.admin` and its dependencies to your `INSTALLED_APPS` setting
2. configure a DjangoTemplates backend in your `TEMPLATES`
3. might need to do something with the `MIDDLEWARE` setting
4. [Hook the admin's URLs into your URLconf](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/#hooking-adminsite-to-urlconf)

I'm closer to answering my question about why I can't access my admin site, but I haven't answered it.

## urls
