#!/bin/bash

# installing node-10.24.1 if not installed
if [ ! -d "${1}/10.24.1" ]; then
    asdf install nodejs 10.24.1
fi

# installing node-12.22.10 if not installed
if [ ! -d "${1}/12.22.10" ]; then
    asdf install nodejs 12.22.10
fi

# installing node-14.19.0 if not installed
if [ ! -d "${1}/14.19.0" ]; then
    asdf install nodejs 14.19.0
fi

# installing node-16.14.0 if not installed
if [ ! -d "${1}/16.14.0" ]; then
    asdf install nodejs 16.14.0
fi
