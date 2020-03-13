![logo](logo.png)

Google Lighthouse - Docker Image
================================

[![latest release](https://img.shields.io/github/release/femtopixel/docker-google-lighthouse.svg "latest release")](http://github.com/femtopixel/docker-google-lighthouse/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/femtopixel/google-lighthouse.svg)](https://hub.docker.com/r/femtopixel/google-lighthouse/)
[![Docker Stars](https://img.shields.io/docker/stars/femtopixel/google-lighthouse.svg)](https://hub.docker.com/r/femtopixel/google-lighthouse/)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)
[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png "Buy me a coffee")](https://www.buymeacoffee.com/3Yu8ajd7W)
[![Become a Patron](https://badgen.net/badge/become/a%20patron/F96854 "Become a Patron")](https://patreon.com/jaymoulin)

(This product is available under a free and permissive license, but needs financial support to sustain its continued improvements. In addition to maintenance and stability there are many desirable features yet to be added.)

THIS REPOSITORY IS AUTO-UPDATED BY [GITHUB-RELEASE-NOTIFIER](https://github.com/femtopixel/github-release-notifier) (https://github.com/femtopixel/github-release-notifier)

[Lighthouse](https://developers.google.com/web/tools/lighthouse/) analyzes web apps and web pages, collecting modern performance metrics and insights on developer best practices.

This image is greatly inspired from [Justin RIBEIRO's work](https://github.com/justinribeiro/dockerfiles/tree/master/lighthouse)

Usage
-----

```
docker run --rm --name lighthouse -it -v /path/to/your/report:/home/chrome/reports femtopixel/google-lighthouse <your_site_url> <optional_args>
```

With `<you_site_url>` url to your site (e.g. http://www.google.com). You can pass args **AFTER** the `url` if you want to.

For example, you can export as json with this command:

```
docker run --rm --name lighthouse -it -v /path/to/your/report:/home/chrome/reports femtopixel/google-lighthouse http://www.google.com --output json
```

You can specify `CHROME_FLAGS` environment variable (`-e` parameter in your docker command) to be used in chrome-flags parameter. (default: `--headless --disable-gpu --no-sandbox`)

Further reading on [Google Lighthouse](https://github.com/GoogleChrome/lighthouse/blob/master/docs/readme.md#using-programmatically)

FAQ
---

* Error while writing files
```
Runtime error encountered: { Error: EACCES: permission denied, open '/home/chrome/reports/myawesome_site_admin_heavypage.report.json'
errno: -13,
code: 'EACCES',
syscall: 'open',
path: '/home/chrome/reports/myawesome_site_admin_heavypage.report.json' }
```
Make sure your folder has the write right for others (chmod o+w)
