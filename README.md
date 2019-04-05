![logo](logo.png)

Google Lighthouse - Docker Image
================================

[![latest release](https://img.shields.io/github/release/femtopixel/docker-google-lighthouse.svg "latest release")](http://github.com/femtopixel/docker-google-lighthouse/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/femtopixel/google-lighthouse.svg)](https://hub.docker.com/r/femtopixel/google-lighthouse/)
[![Docker Stars](https://img.shields.io/docker/stars/femtopixel/google-lighthouse.svg)](https://hub.docker.com/r/femtopixel/google-lighthouse/)
[![Bitcoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/btc.png "Bitcoin donation")](https://m.freewallet.org/id/374ad82e/btc)
[![Litecoin donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ltc.png "Litecoin donation")](https://m.freewallet.org/id/374ad82e/ltc)
[![PayPal donation](https://github.com/jaymoulin/jaymoulin.github.io/raw/master/ppl.png "PayPal donation")](https://www.paypal.me/jaymoulin)
[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png "Buy me a coffee")](https://www.buymeacoffee.com/3Yu8ajd7W)

[Lighthouse](https://developers.google.com/web/tools/lighthouse/) analyzes web apps and web pages, collecting modern performance metrics and insights on developer best practices.

This image is greatly inspired from [Justin RIBEIRO's work](https://github.com/justinribeiro/dockerfiles/tree/master/lighthouse)

Usage
-----

```
docker run --rm --name lighthouse -it -v /path/to/your/report:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse <your_site_url> <optional_args>
```

With `<you_site_url>` url to your site (e.g. http://www.google.com). You can pass args **AFTER** the `url` if you want to.

For example, you can export as json with this command:

```
docker run --rm --name lighthouse -it -v /path/to/your/report:/home/chrome/reports --cap-add=SYS_ADMIN femtopixel/google-lighthouse http://www.google.com --output json
```

You can specify `CHROME_FLAGS` environment variable (`-e` parameter in your docker command) to be used in chrome-flags parameter. (default: `--headless --disable-gpu --no-sandbox`)

Further reading on [Google Lighthouse](https://github.com/GoogleChrome/lighthouse#using-programmatically)

Usage : Improved
----------------

Using the ever-awesome [Jessie Frazelle](https://twitter.com/jessfraz) SECCOMP profile for Chrome, we don't have to use the hammer that is SYS_ADMIN:

```
wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json
docker run --rm --name lighthouse -it -v /path/to/your/report:/home/chrome/reports --security-opt seccomp=$HOME/chrome.json femtopixel/google-lighthouse <your_site_url>
```

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
