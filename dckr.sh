#! /bin/bash

docker pull $3;
docker build . \
    --file=package.Dockerfile \
    --tag=pack-$1d:temp \
    --target=llvm-package \
    --build-arg BUILD_IMAGE_TAG=$3 \
    --build-arg X=$1 \
    --build-arg R=$2;
docker run \
    --rm \
    --tty \
    --detach \
    --interactive \
    --name=cntnr-$1d pack-$1d:temp bash;
docker cp cntnr-$1d:$2/$1t.xz ./;
ls -hls $1t.xz;
docker stop cntnr-$1d;
