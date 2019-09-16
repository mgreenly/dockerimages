#!/bin/sh

unset BUNDLE_PATH
unset BUNDLE_APP_CONFIG
PATH=/usr/local/bundle/bin:/usr/local/bundle/gems/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
exec "$@"
