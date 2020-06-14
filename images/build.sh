#!/bin/bash

ls -lAd */ \
    | sed 's/\/$//g' \
    | awk '{print $NF}' \
    | xargs -I{} docker image build -t local_{} ./{}

