# AUTOGENERATED FILE
FROM #{FROM}

ENV NODE_VERSION #{NODE_VERSION}
ENV YARN_VERSION #{YARN_VERSION}

RUN buildDeps='curl build-essential python' \
	&& set -x \
	&& for key in \
	6A010C5166006599AA17F08146C2130DFD2497F5 \
	; do \
		gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
		gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
	done \
	&& apt-get update && apt-get install -y $buildDeps --no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& curl -SLO "#{BINARY_URL}" \
	&& echo "#{CHECKSUM}" | sha256sum -c - \
	&& tar -xzf "node-v$NODE_VERSION-linux-#{TARGET_ARCH}.tar.gz" -C /usr/local --strip-components=1 \
	&& rm "node-v$NODE_VERSION-linux-#{TARGET_ARCH}.tar.gz" \
	&& npm install mraa@$MRAA_VERSION \
	&& npm cache clear \
	&& curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
	&& curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
	&& gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
	&& mkdir -p /opt/yarn \
	&& tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
	&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
	&& ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
	&& rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
	&& npm config set unsafe-perm true -g --unsafe-perm \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -rf /tmp/*

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: http://docs.resin.io/deployment/dockerfile"]
