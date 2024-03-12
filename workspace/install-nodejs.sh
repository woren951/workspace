#!/bin/bash

# installing node-10.24.1 if not installed
if [ ! -d "${1}/10.24.1" ]; then
    asdf install nodejs 10.24.1
fi

# installing node-12.22.12 if not installed
if [ ! -d "${1}/12.22.12" ]; then
    asdf install nodejs 12.22.12
fi

# installing node-14.21.3 if not installed
if [ ! -d "${1}/14.21.3" ]; then
    asdf install nodejs 14.21.3
fi

# installing node-16.20.2 if not installed
if [ ! -d "${1}/16.20.2" ]; then
    asdf install nodejs 16.20.2
fi

# installing node-18.19.0 if not installed
if [ ! -d "${1}/18.19.0" ]; then
    asdf install nodejs 18.19.0
fi

# installing node-20.10.0 if not installed
if [ ! -d "${1}/20.10.0" ]; then
    asdf install nodejs 20.10.0
fi
