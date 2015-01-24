#!/bin/sh -x
SRC_DIR="."
WEB_DIR="../where-is-my-date-publish"

dir=`dirname $0`

pushd "$dir/$WEB_DIR"
git pull origin gh-pages
popd

cp "$dir/$SRC_DIR/out/production/where-is-my-date/Main.swf" "$dir/$WEB_DIR"

pushd "$dir/$WEB_DIR"
git add .
git commit -m "Update swf"
git push origin gh-pages
popd
