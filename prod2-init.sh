#!/bin/sh
apk update
apk add keepalived

# Старт Keepalived
keepalived -n -l

tail -f /dev/null
