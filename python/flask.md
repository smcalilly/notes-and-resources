# flask


## session
[from this guide, the best one](https://flask.palletsprojects.com/en/1.1.x/quickstart/#sessions)

flask has an object called `session` where you can store information specific to a user from one request to the next. this is implemented on top of the cookies for you. cookies are signed cryptographically. this means that the user could look at the contents of your cookie but not modify it, unless they know the secret key used for signing. in order to use sessions you have to set a secret key.
