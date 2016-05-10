# Debian

This creates deb files to install the current version of
FreeTDS on Debian stable.

At the tiem this was created Debian stable included FreeTDS .91
and the current FreeTDS reelase was .95

This was necessary because the current version of the tiny_tds
Gem expects at least version .95 of FreeTDS

The build process is done inside a docker container to ensure
consistency.
