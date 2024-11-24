#!/bin/sh

sudo sh -c 'while true; do ./write_this.py "$(date +%Y-%m-%d\ \ %H:%M:%S)"; sleep 1; done'
