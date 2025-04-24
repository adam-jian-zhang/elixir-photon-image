ARG FROM_NAME=photon
ARG FROM_TAG=5.0-20250420


FROM ${FROM_NAME}:${FROM_TAG}

ARG BUILD_DATE

LABEL build-date=$BUILD_DATE

LABEL maintainer="adam.jian.zhang@gmail.com"
LABEL name="Elixir Image based on Photon OS x86_64/5.0"

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.17.3" \
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
    git \
    && rm -rf /var/cache/tdnf

RUN groupadd --gid 999 --system default; \
    useradd --uid 999 --system --home-dir "$HOME" --gid default default

RUN mkdir -p "$HOME" && chown -R default:default /opt/app

RUN set -xe \
    && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/refs/tags/${ELIXIR_VERSION}.tar.gz" \
    && ELIXIR_DOWNLOAD_SHA256="6116c14d5e61ec301240cebeacbf9e97125a4d45cd9071e65e0b958d5ebf3890" \
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
