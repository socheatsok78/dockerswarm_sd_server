#!/bin/sh

# Display banner
if [ -f "/docker-entrypoint.d/00-banner.txt" ]; then
    cat "/docker-entrypoint.d/00-banner.txt"
fi
