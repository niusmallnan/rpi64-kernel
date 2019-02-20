#!/bin/bash
set -ex

VERSION=$(cat ./version)

for file in $(ls builds/); do
    github-release upload  --user niusmallnan --repo rpi64-kernel --tag ${VERSION} --file ./builds/${file} --name ${file}
done
