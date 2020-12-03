#!/bin/bash

ls -lAd */ \
    | sed 's/\/$//g' \
    | awk '{print $NF}' \
    | xargs -I{} bash ./{}/build.sh

