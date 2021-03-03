[django-compressor](https://django-compressor.readthedocs.io/en/latest/quickstart/)

compresses linked and inline javascript or css into a single cached file.

## offline compression
can run the compression "offline", outside of the request/response loop. if offline compression is enabled, no new files are generated during a request and the `{% compress %}` tag simply inserts links to the files in the offline cache.

to use offline compression, enable the `django.conf.settings.COMPRESS_OFFLINE` setting and then run the `compress` management command to compress your assets and update the offline cache.

the command parses all templates that can be found with the template loader (as specified in the template loaders setting) and looks for `{% compress%}` blocks. it will then use the context as defined in `django.conf.settings.COMPRESS_OFFLINE_CONTEXT` to render its content. so if you use any variables inside the `{% compress %} blocks, make sure to list all values you require in `COMPRESS_OFFLINE_CONTEXT`. it's similar to a template context and should be used if a variable is unded in the blocks:
```
{% load compress %}
{% compress js %}
<script type="text/javascript">
    alert("{{ greeting }}");
</script>
{% endcompress %}
```

since this template requires a variable `greeting` you need to specify thisi n your settings before using the `compress` managemnet command:
```
COMPRESS_OFFLINE_CONTEXT = {
    'greeting': 'Hello there!',
}
```

the result of running the compress command will be cached in a file called `manifest.json` using the `configured storage` to be able to be transferred from your development computer to the server easily.
