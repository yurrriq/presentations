# Presentations

## Development Environment

This repo is built on [devenv](https://devenv.sh/) and
[direnv](https://direnv.net/). With both tools installed, run `direnv allow` to
get started.

Next, run `devenv processes up` to start the `watchman` and `watchman-make`
processes. To run them in the background, use `devenv processes up
--detach`. The logs will be aggregated in `.devenv/processes.log`.
