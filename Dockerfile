## SYSTEM

FROM hexpm/elixir:1.11.2-erlang-23.2.2-ubuntu-focal-20201008 AS builder

ENV LANG=C.UTF-8 \
    LANGUAGE=C:en \
    LC_ALL=C.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    MIX_ENV=prod \
    REFRESH_AT=20210119

RUN apt-get update && apt-get install -y \
      git

ARG USER_ID
ARG GROUP_ID

RUN groupadd --gid $GROUP_ID user && \
    useradd -m --gid $GROUP_ID --uid $USER_ID user

USER user
RUN mkdir /home/user/app
WORKDIR /home/user/app

RUN mix local.rebar --force && \
    mix local.hex --if-missing --force

COPY --chown=user:user mix.* ./
COPY --chown=user:user config ./config
RUN mix do deps.get, deps.compile

## FRONTEND

FROM node:14.4.0-alpine AS frontend

RUN mkdir -p /home/user/app
WORKDIR /home/user/app
# PurgeCSS needs to see the Elixir stuff
COPY lib ./lib
COPY assets/package.json assets/package-lock.json ./assets/
COPY --from=builder /home/user/app/deps/phoenix ./deps/phoenix
COPY --from=builder /home/user/app/deps/phoenix_html ./deps/phoenix_html
COPY --from=builder /home/user/app/deps/phoenix_live_view ./deps/phoenix_live_view
RUN npm --prefix ./assets i --progress=false --no-audit --loglevel=error

COPY assets ./assets
RUN npm --prefix ./assets run build

## APP
FROM builder AS app
USER user
COPY --from=frontend --chown=user:user /home/user/app/priv/static ./priv/static
COPY --chown=user:user lib ./lib
RUN mix phx.digest

CMD ["/bin/bash"]
