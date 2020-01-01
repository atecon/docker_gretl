#!/bin/bash

# moin src-folder as /app, starte container named "gretl" and execute gretl script
docker run --rm -v /home/at/git/docker_gretl/src:/app gretl gretlcli -e -b ./app/print_data.inp
