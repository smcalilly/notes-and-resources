# content security policy
https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP

designed to protect from attacks like XSS and data injecting.

backwards compatible -- browsers that don't support it will still work with servers that use it.

default is set to only allow a webpage to download from the page's source. if you need to get stuff from like a third-party cdn, then you'll need to whitelist that with your csp.

>To enable CSP, you need to configure your web server to return the Content-Security-Policy HTTP header. (Sometimes you may see mentions of the X-Content-Security-Policy header, but that's an older version and you don't need to specify it anymore.)
>
> Alternatively, the `<meta>` element can be used to configure a policy, for example: `<meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src https://*; child-src 'none';">`

## cross site scripting
primary goal of CSP is to mitigate and report XSS attacks. XSS exploits the browsers trust of the content received from the server. malicious scripts are executed by the victim's browser because the browser trusts the source of content.

CSP cuts down on attack vector because you whitelist the origins from which your webpage can run scripts.

## resources
- [unsafe-hashes](https://content-security-policy.com/unsafe-hashes/)
- [allow inline styles](https://content-security-policy.com/examples/allow-inline-style/)
