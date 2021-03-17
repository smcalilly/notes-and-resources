# flask


## session
[from this guide, the best one](https://flask.palletsprojects.com/en/1.1.x/quickstart/#sessions)

flask has an object called `session` where you can store information specific to a user from one request to the next. this is implemented on top of the cookies for you. cookies are signed cryptographically. this means that the user could look at the contents of your cookie but not modify it, unless they know the secret key used for signing. in order to use sessions you have to set a secret key.

[from the flask API document](https://flask.palletsprojects.com/en/1.1.x/api/#sessions)
the user can look at the session contents, but can't modify it unless they know the secret key
 
to access the current session you can use the `session` object. works pretty much like an ordinary dict, with the difference that it keeps track of modifications.
 
 if you want to modify the session in your code, you need to set `session.modified = True`. their example:
```python
# this change is not picked up because a mutable object (here
# a list) is changed.
session['objects'].append(42)
# so mark it as modified yourself
session.modified = True
```
