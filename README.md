# SciDB 19.11 Docker Image

This repository is to build a docker image with SciDB 19.11.
It is based on the [original image](https://hub.docker.com/r/rvernica/scidb/tags) and
fixed an issue of running a SciDB server with the root user.
Running a SciDB server with root account causes MPI error.
The image has `scidb` user and SciDB instances will be run with the `scidb` user.

- ID / PW : `scidb` / `qwer1234`
- `docker-entrypoint.sh` will re-initialize scidb cluster
