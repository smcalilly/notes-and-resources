# content security policy
https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP

default is set to only allow a webpage to download from the page's source. if you need to get stuff from like a third-party cdn, then you'll need to whitelist that with your csp.

>To enable CSP, you need to configure your web server to return the Content-Security-Policy HTTP header. (Sometimes you may see mentions of the X-Content-Security-Policy header, but that's an older version and you don't need to specify it anymore.)
> Alternatively, the <meta> element can be used to configure a policy, for example: <meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src https://*; child-src 'none';"> 
