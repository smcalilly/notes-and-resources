# Back to the Django Basics

I just picked up a dusty app and I'm confused about the state in which I left the app, only 2.5 months ago. It's a huge mess. If I could access the admin site and look at the models, then I might be able to see what I was thinking about the models. But I can't access my admin site, and I'm not sure why. Is something wrong with my admin site/URL confs? 

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

### how does it know?
when you put `django.contrib.admin` in your `INSTALLED_APPS` setting, **Django automatically looks for an admin module in each application and imports it.** [see this section](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/#discovery-of-admin-files)

in my own words: if i have an app called `/counties`, then i register the models in `/counties/admin.py`. those should be recognized in the project's admin interface. (doucble check that this is true)

- [you can override the default admin site](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/#overriding-the-default-admin-site). this is not my problem today.
- [more urlconf tricks](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/#multiple-admin-sites-in-the-same-urlconf)
- good to know: [you can add a password reset feature](https://docs.djangoproject.com/en/3.1/ref/contrib/admin/#adding-a-password-reset-feature)

## urls
- how to list all the routes? is there a way to do `rake routes` in django? https://stackoverflow.com/questions/2092608/is-there-something-similar-to-rake-routes-in-django
