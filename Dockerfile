FROM femtopixel/google-chrome-headless:0.2.0

MAINTAINER Jay MOULIN <jaymoulin@gmail.com> <http://twitter.com/moulinjay>

ARG ARM=0
USER root

# Install deps + add Chrome Stable + purge all the things
RUN apt-get remove gnupg -y && apt-get install --reinstall gnupg2 dirmngr -y && \
  if [ ${ARM-0} = 1 ]; then apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 40976EAF437D05B5; \ 
  apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 3B4FE6ACC0B21F32; fi && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get autoclean && apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg --no-install-recommends && \
  curl -sSL https://deb.nodesource.com/setup_9.x | bash - && \
  apt-get update && apt-get install -y nodejs --no-install-recommends && \
  if [ ${ARM-0} = 1 ]; then npm config set unsafe-perm true; fi && \
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

VOLUME /home/chrome/reports

# Drop to cli
ENTRYPOINT ["entrypoint"]
