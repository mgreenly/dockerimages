# Debian

This is an everything and the kitchen sink image that I use as a
base image for quite a lot of different utilities.

The idea is that if I install pretty much everything in the base
image and all the utilities build on that same base image layer
the individual untilities will have smaller unique layers even
if the common base is quite fat.

Debian's FreeTDS package is out of date.  This image includes
a source built current version of FreeTDS.  See the freetds
subfolder for details.
