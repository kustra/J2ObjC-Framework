#!/bin/bash
set -euo pipefail

J2OBJC_VERSION="2.2"
J2OBJC_ZIP="j2objc-${J2OBJC_VERSION}.zip"
J2OBJC_URL="https://github.com/google/j2objc/releases/download/${J2OBJC_VERSION}/${J2OBJC_ZIP}"

if [ -d dist ]
then
  exit
fi

if [ -f "$J2OBJC_ZIP" ]
then
    echo "$J2OBJC_ZIP found"
else
    echo "Fetching J2ObjC v${J2OBJC_VERSION} from ${J2OBJC_URL}"
    curl -OL "${J2OBJC_URL}"
fi
unzip -o -q "${J2OBJC_ZIP}"

J2OBJC_PATH=j2objc-${J2OBJC_VERSION}

mv "${J2OBJC_PATH}" dist
rm -f "${J2OBJC_ZIP}"

echo "${J2OBJC_VERSION}" > dist/VERSION
