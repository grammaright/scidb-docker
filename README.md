# SciDB 19.11 Docker iamge

This repository is to build a docker image with SciDB 19.11.
It is based on the [original image](https://hub.docker.com/r/rvernica/scidb/tags) and
fixed an issue of running the SciDB server with the root user.
The image has `scidb` user and the SciDB instances will be run with the `scidb` user.

- ID / PW : `scidb` / `qwer1234`
- `docker-entrypoint.sh` will re-initialize scidb cluster
