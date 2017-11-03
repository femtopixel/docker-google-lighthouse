FROM bitnami/minideb

MAINTAINER Jay MOULIN <jaymoulin@gmail.com> <http://twitter.com/moulinjay>

# Install deps + add Chrome Stable + purge all the things
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg --no-install-recommends && \
  curl -sSL https://deb.nodesource.com/setup_9.x | bash -  && \
  curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -  && \
  echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list  && \
  apt-get update && apt-get install -y google-chrome-stable nodejs --no-install-recommends && \
  npm --global install yarn && \
  apt-get purge --auto-remove -y curl gnupg && \
  rm -rf /var/lib/apt/lists/* && \
  yarn global add lighthouse && \
  groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && \
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
