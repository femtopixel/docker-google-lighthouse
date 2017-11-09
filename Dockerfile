FROM femtopixel/google-chrome-headless

MAINTAINER Jay MOULIN <jaymoulin@gmail.com> <http://twitter.com/moulinjay>

USER root

# Install deps + add Chrome Stable + purge all the things
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg --no-install-recommends && \
  curl -sSL https://deb.nodesource.com/setup_9.x | bash -  && \
  apt-get update && apt-get install -y nodejs --no-install-recommends && \
  npm --global install yarn && \
  apt-get purge --auto-remove -y curl gnupg && \
  rm -rf /var/lib/apt/lists/* && \
  yarn global add lighthouse && \
  mkdir -p /home/chrome/reports && chown -R chrome:chrome /home/chrome

# some place we can mount and view lighthouse reports
VOLUME /home/chrome/reports
WORKDIR /home/chrome/reports

COPY entrypoint.sh /usr/bin/entrypoint

# Run Chrome non-privileged
USER chrome

VOLUME /home/chrome/reports

# Drop to cli
ENTRYPOINT ["entrypoint"]
