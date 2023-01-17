#!/bin/bash

# installing node-10.24.1 if not installed
if [ ! -d "${1}/10.24.1" ]; then
    asdf install nodejs 10.24.1
fi

# installing node-12.22.12 if not installed
if [ ! -d "${1}/12.22.12" ]; then
    asdf install nodejs 12.22.12
fi

# installing node-14.20.1 if not installed
if [ ! -d "${1}/14.20.1" ]; then
    asdf install nodejs 14.20.1
fi

# installing node-16.18.0 if not installed
if [ ! -d "${1}/16.18.0" ]; then
    asdf install nodejs 16.18.0
fi

# installing node-18.11.0 if not installed
if [ ! -d "${1}/18.11.0" ]; then
    asdf install nodejs 18.11.0
fi
