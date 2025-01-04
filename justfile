RELEASE := "1.0.3"

passthrough:
  echo "Requires a step, like `just all`"

download:
  rm -rf upstream
  wget https://github.com/ZTL-ARTCC/scheddy/archive/refs/tags/v{{RELEASE}}.tar.gz
  tar -xzf v{{RELEASE}}.tar.gz
  rm v{{RELEASE}}.tar.gz
  mv scheddy-{{RELEASE}} upstream

[working-directory: './upstream']
install:
  bun install

[working-directory: './upstream']
build:
  cp ../.env .
  bun run build

dockerize:
  docker build -t celeo/scheddy .

all: download install build dockerize
