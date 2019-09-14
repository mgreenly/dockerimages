# Alpine Ruby Base

This image was derived from the official 'ruby-alpine' images.  The primary
change was to move to Alpine 3.6 which uses LibreSSL instead of OpenSSL. it
also removes the customized bundler configuration.

This is a minimal image that does not include development tools or libraries
and is used as a base to build on.
