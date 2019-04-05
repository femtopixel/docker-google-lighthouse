#!/bin/sh
set -e

CHROME_FLAGS=${CHROME_FLAGS:-"--headless --disable-gpu --no-sandbox"}

# first arg is `-f` or `--some-option`
if [ "${1#http}" != "$1" ]; then
    set -- lighthouse --enable-error-reporting --chrome-flags="${CHROME_FLAGS}" "$@"
fi

exec "$@"
