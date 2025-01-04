RELEASE := "1.0.3"

# something so that `just` doesn't do a bunch of stuff
passthrough:
  @echo "ERROR: Requires a step, like 'all'"

# download the tar.gz of the specified release and unpack it
download:
  rm -rf upstream
  wget https://github.com/ZTL-ARTCC/scheddy/archive/refs/tags/v{{RELEASE}}.tar.gz
  tar -xzf v{{RELEASE}}.tar.gz
  rm v{{RELEASE}}.tar.gz
  mv scheddy-{{RELEASE}} upstream

# set up JS dependencies
[working-directory: './upstream']
install:
  bun install

# copy in the .env file and build everything
[working-directory: './upstream']
build:
  cp ../.env .
  bun run build

# take the built files and put them into a Docker ontainer
dockerize:
  docker build -t celeo/scheddy .

# do everything
all: download install build dockerize
