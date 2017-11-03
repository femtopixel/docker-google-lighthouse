Google Lighthouse - Docker Image
================================

[![Docker Pulls](https://img.shields.io/docker/pulls/femtopixel/google-lighthouse.svg)](https://hub.docker.com/r/femtopixel/google-lighthouse/)

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

Further reading on [Google Lighthouse](https://github.com/GoogleChrome/lighthouse#using-programmatically)

Usage : Improved
----------------

Using the ever-awesome [Jessie Frazelle](https://twitter.com/jessfraz) SECCOMP profile for Chrome, we don't have to use the hammer that is SYS_ADMIN:

```
wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -O ~/chrome.json
docker run --rm --name lighthouse -it -v /path/to/your/report:/home/chrome/reports --security-opt seccomp=$HOME/chrome.json femtopixel/google-lighthouse <your_site_url>
```
