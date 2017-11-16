#!/bin/bash
set -ev

J2OBJC_VERSION="2.0.5"

if [[ -d dist ]]; then
  exit
fi

echo "Fetching J2ObjC v${J2OBJC_VERSION} from https://github.com/google/j2objc/releases/download/${J2OBJC_VERSION}/j2objc-${J2OBJC_VERSION}.zip"
curl -OL https://github.com/google/j2objc/releases/download/${J2OBJC_VERSION}/j2objc-${J2OBJC_VERSION}.zip
unzip -o -q j2objc-${J2OBJC_VERSION}.zip

J2OBJC_PATH=j2objc-${J2OBJC_VERSION}

mv $J2OBJC_PATH dist
rm -f j2objc-${J2OBJC_VERSION}.zip

echo $J2OBJC_VERSION > dist/VERSION
