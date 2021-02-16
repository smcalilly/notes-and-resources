# more advanced stuff

## signals
i have come across this in the past and now i'm reading about using a signal to extend the user form: https://simpleisbetterthancomplex.com/tutorial/2017/02/18/how-to-create-user-sign-up-view.html

### what is a signal?
[from the documentation](https://docs.djangoproject.com/en/3.1/topics/signals/): "Django includes a “signal dispatcher” which helps allow decoupled applications get notified when actions occur elsewhere in the framework. In a nutshell, signals allow certain senders to notify a set of receivers that some action has taken place. They’re especially useful when many pieces of code may be interested in the same events."

[the following notes from reading this](https://simpleisbetterthancomplex.com/tutorial/2016/07/28/how-to-create-django-signals.html)

### when should i use a signal?
- when many pieces of code may be interested in the same events
- when you need to interact with a decoupled application, like:
  - a django core model (like the user model)
  - a model defined by a third party app (interesting!)

### how it works?
it's kind of like [the observer pattern](https://refactoring.guru/design-patterns/observer/python/example).

two key elements in the signals machcinary:
- senders: responsible to dispatch a signal. must be a python object or None
- receivers: one who will receive this signal and then do something. must be a function or an instance method

the connection between senders and receivers is done through "signal dispatcher", which are instances of `Signal`, via the `connect` method.

django core also defines `ModelSignal`, which is a subclass of `Signal` that allows the sender to be lazily specified as a string. but generally, you will always want to use the `Signal` class to create custom signals.

so to receive a signal, you need to register a receiver function that gets called when the signal is sent


### usage
looking at the `post_save` built-in signal. this signal fires right after a model executes its `save` method.

```python
from django.contrib.auth.models import User
from django.db.models.signals import post_save

def save_profile(sender, instance, **kwargs):
    instance.profile.save()

post_save.connect(save_profile, sender=User)
```

in that example, `save_profile` is the **receiver** function, `User` is the **sender** and `post_save` is the **signal**. every time a User instance finishes executing its `save` method, the `save_profile` function will be executed.

if you don't included the sender argument like this: `post_save.connect(save_profile)`, the `save_profile` function will be executed after any django model executes the save method.

another way to register a signal: use the `@receiver` decorator
```python
def receiver(signal, **kwargs)
```

might use like this:
```python
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

@receiver(post_save, sender=User)
def save_profile(sender, instance, **kwargs):
    instance.profile.save()
```

you can register the receiver function with several signals, if you want:
```python
@receiver([post_save, post_delete], sender=User)
```

### where should the code live?
[this blog post and the django docs](https://simpleisbetterthancomplex.com/tutorial/2016/07/28/how-to-create-django-signals.html#where-should-the-code-live) say that there might be some side-effects depending on where this code lives, because you might import a module with the code and cause some problems.

they show a way to do this to avoid that. it requires some django know-how and might be confusing to somebody who has never encountered signals.

### django built-in signals
[see some commonly used signals](https://simpleisbetterthancomplex.com/tutorial/2016/07/28/how-to-create-django-signals.html#django-built-in-signals)

## questions
- [read about the observer pattern](https://refactoring.guru/design-patterns/observer/python/example)
