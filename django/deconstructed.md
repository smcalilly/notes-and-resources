## deconstructing requests: how http requests get from the internet to django

- the web server
	- a long running program on a computer that monitors the computers network ports listening for some type of network request
	- apache and nginx are two examples
	- once the request is received, it's responsible for serving up some type of resource
- the application server
	- web server hands off the request to the application serve to generate the response
	- it's a program running on a computer
	- gunicorn is an example
	- it may or may not be the same computer that runs the web server, that's based on the infra design
	- the app server is responsible for calling the django code and generating a response
	- you don't have to have the web and app server separate, but separating them has a few advantages:
		- lets you use different computers for different pieces of you rstack. common for on ecomputer to run the web server then route requests to one of multiple computers running the app server to process the request fully.
			- this improves site performance and stability at scale, at lower scale using multiple computers can slow things down bc of the additonal network requests
		- we servers like nginx are better at specific pieces of request handling than applicaiton servers. rahter than using a single genralized server, we can use two servers that excel in their respective areas
		- how does the app server know how to call django and handle the returned value? WSGI
- web server gateway interface (WSGI)
	- python app servers want to be able to run any type of python framework. frameworks want to run any type of python app server
	- you can swap out a django app for flask and still use wsgi. you can swap wsgi with uwsgi and it will still work
	- WSGI is a formally accepted PEP

### wsgi.py
django automatically creates this file when you run `startproject`. the application server explicitly looks for this file. it returns the WSGI compliant django callable

when a request is received by the app server, it passes the request to this callable, knowing that it will receive a valid HTTP response, which it can then return to the web server and thus the internet/client

## how a request becomes a response: diving deeper into WSGI

https://djangodeconstructed.com/2018/02/15/how-a-request-becomes-a-response-diving-deeper-into-wsgi/

> According to the official spec, WSGI is “a proposed standard interface between web servers and Python web applications or frameworks, to promote web application portability across a variety of web servers.”

allows python developers to pick a python framework without worrying about underlying infrastructure, and vice versa for infra engineers

wsgi-compatible server -> wsgi-compatible application (django)

wsgi's job is to define how two programs interact with one another. this allows for something called "middleware-chaining". middleware is a program that sits between the server and django, and adds additional functionality based on the request or response

as long as the middleware fits with wsgi, then it can serve as the application from the server's perspective and the server from django's perspective. no part of this path is aware of any of the other's, it just knows it's interfacing with a wsgi-compatible program

### how the server first access django
server is expecting to access the framework and get back some sort of callable (named `application ` in the spec). the callable accepts two arguments from the server:
1. a dictionary of environment variables (`environ`)
	1. includes request data (query string, method, headers, content length, etc), os env variables (like private keys), WSGI variables, and additional server variables
2. another callable (`start_response`)

django will use the data in `environ` to complete the request, and will use `start_response` to pass the response back to the server
