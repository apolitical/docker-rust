Docker Rust
===========

[![GitHub release](https://img.shields.io/github/release/apolitical/docker-rust.svg)](https://github.com/apolitical/docker-rust/releases)
[![GitHub license](https://img.shields.io/github/license/apolitical/docker-rust.svg)](https://github.com/apolitical/docker-rust/blob/master/LICENSE)

A base to build Rust based docker images from.

Usage
-----

Use a multistage docker file to produce slimmer docker images:

```dockerfile
#################
# BUILDER STAGE #
#################

FROM apolitical/rust as builder

# Add any libraries you need. Anything added here must be added in the second section.
RUN apt-get update \
 && apt-get install -y \
    default-libmysqlclient-dev

# Copy in project files
COPY src src
COPY Cargo.toml .
COPY Cargo.lock .
COPY diesel.toml .

RUN cargo build --release


################
# RUNNER STAGE #
################

# Same as base image for apolitical/rust
FROM debian:stable-slim

# Add in the same additional dependencies as above.
RUN apt-get update \
 && apt-get install -y \
    default-libmysqlclient-dev

# Copy binary from builder to runner
WORKDIR /app
COPY --from=builder /target/release/webserver webserver

EXPOSE 80

CMD ["/app/webserver"]

```

ToDo
----

Figure out static linking (specifically rustc, musl, libmysqlclient) as it should be possible to build tiny images


Contributing
------------

If you want to help, that's brilliant! Have a look at our [Contributing Guide](CONTRIBUTING.md). We also adhere to a
[Code of Conduct](CODE_OF_CONDUCT.md), so please check that out, it includes details on who to contact if you have any
concerns.
