#!/bin/bash

wget https://github.com/gohugoio/hugo/releases/download/v$HUGO_VERSION/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
tar -xf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
mv ./hugo ../bin/
chmod +x ../bin/hugo

echo "Hugo $HUGO_VERSION installed"