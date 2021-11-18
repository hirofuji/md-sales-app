#!/bin/sh

docker info > /dev/null 2>&1

# Ensure that Docker is running...
if [ $? -ne 0 ]; then
    echo "Docker is not running."

    exit 1
fi

docker run --rm \
    -v "$(pwd)":/opt \
    -w /opt \
    laravelsail/php80-composer:latest \
    bash -c "composer install"

#create initial env
cp .env.example .env

#start container
./vendor/bin/sail up -d

#create app key
./vendor/bin/sail artisan key:generate
