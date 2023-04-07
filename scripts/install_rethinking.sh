#!/bin/bash

set -e

export DOWNLOAD_STATIC_LIBV8=1

## build ARGs
NCPUS=${NCPUS:--1}

# Install RStan
install2.r --error --skipinstalled -n "$NCPUS" --deps TRUE -r https://cloud.r-project.org/ \
    rstan

# Install CmdStanR
install2.r --error --skipinstalled -n "$NCPUS" -r https://mc-stan.org/r-packages/ -r getOption \
    cmdstanr

# Install CmdStan

# Install additional libraries
install2.r --error --skipmissing --skipinstalled -n "$NCPUS" \
    loo \
    coda \
    mvtnorm \
    loo \
    dagitty \
    shape

# Install rethinking
installGithub.r rmcelreath/rethinking

# Cleanup
rm -rf /tmp/downloaded_packages
