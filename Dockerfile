ARG FROM_NAME=photon
ARG FROM_TAG=4.0-20220520 

FROM ${FROM_NAME}:${FROM_TAG}

LABEL maintainer "adam.jian.zhang@gmail.com"

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.13.4" \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8\
    HOME=/opt/app/ \
    TERM=xterm \
    PATH=/usr/local/bin:$PATH

RUN tdnf install -y erlang \
    tar \
    gzip \
    make \
    shadow \
    && rm -rf /var/cache/tdnf

RUN groupadd --gid 999 --system default; \
    useradd --uid 999 --system --home-dir "$HOME" --gid default default

RUN mkdir -p "$HOME" && chown -R default:default /opt/app

RUN set -xe \
    && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
    && ELIXIR_DOWNLOAD_SHA256="95daf2dd3052e6ca7d4d849457eaaba09de52d65ca38d6933c65bc1cdf6b8579" \
    && curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
    && echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
    && mkdir -p /usr/local/src/elixir \
    && tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
    && rm elixir-src.tar.gz \
    && cd /usr/local/src/elixir \
    && make install clean

RUN chage -I -1 -m 0 -M 99999 -E -1 root
RUN chage -I -1 -m 0 -M 99999 -E -1 default

# USER default

# CMD ["iex"]
