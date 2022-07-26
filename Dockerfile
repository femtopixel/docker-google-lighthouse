FROM femtopixel/google-chrome-headless

ARG VERSION=v9.6.4

LABEL maintainer="Jay MOULIN <https://jaymoulin.me/femtopixel/docker-google-lighthouse> <http://twitter.com/MoulinJay>"
LABEL version="${VERSION}"

USER root

# Install deps + add Chrome Stable + purge all the things
RUN rm -rf /var/lib/apt/lists/* && \
  apt-get update && \
  apt-get remove gnupg -y && apt-get install --reinstall gnupg2 dirmngr --allow-unauthenticated -y && \
  apt-get autoclean && apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg --no-install-recommends && \
  curl -sSL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs --no-install-recommends && \
  npm --global install npm && \
  npm --global install yarn && \
  apt-get purge --auto-remove -y curl gnupg && \
  rm -rf /var/lib/apt/lists/* && \
  npm install --global lighthouse && \
  mkdir -p /home/chrome/reports && chown -R chrome:chrome /home/chrome

# some place we can mount and view lighthouse reports
VOLUME /home/chrome/reports
WORKDIR /home/chrome/reports

COPY entrypoint.sh /usr/bin/entrypoint

# Run Chrome non-privileged
USER chrome

ENV CHROME_FLAGS="--headless --disable-gpu --no-sandbox"

VOLUME /home/chrome/reports

# Drop to cli
ENTRYPOINT ["entrypoint"]
