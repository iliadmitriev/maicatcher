# MailCatcher

MailCatcher - is a ruby powered alpine image, based on https://mailcatcher.me. Its purpose is to provide a way of testing applications wich uses emails (i.e. sign in with email or email confirmation)

For amd64(x86_64) and arm64(aarch64)

## Features

1. Simple SMTP server
2. WEB interface

# Usage

## Build

Build image from `Dockerfile`

```shell
docker build -t mailcatcher -f Dockerfile ./
```

## Run


Create and run docker container from image

You need two tcp ports:
* 1080 - web interface port
* 1025 - smtp port

```shell
docker run -d -p 1080:1080 -p 1025:1025 --name mailcatcher mailcatcher
```

## Test

```shell  
curl \
    -F '=(;type=multipart/alternative' \
        -F '=<sample.txt;type=text/plain' \
        -F '=<sample.html;type=text/html' \
    -F '=)' \
    -F '=@sample.png;encoder=base64;headers="Content-ID: sample.png"' \
    --url 'smtp://localhost:1025' \
    -H "Subject: Test message of 3 parts" \
    --mail-from 'sender@example.com' \
    --mail-rcpt 'recipient@example.com'
```

## Logs

```shell
docker logs -f mailcatcher
```

## Web interface

Address http://localhost:1080/

* HTML - html view of email
* Plain text - plain text email alternative
* Source - source code of email
* Download - download email in eml format
* Clear - delete all emails


# build  multiplatform

1. create buildx context and set is as default

```shell
docker buildx create --use --name mybuild
```

2. build and push to repository

```shell
docker buildx build --platform linux/amd64,linux/arm64 \
 -t iliadmitriev/mailcatcher:latest --push ./
```

3. stop context and switch to default

```shell
docker buildx stop
docker buildx use default
```

GitHub Action
https://github.com/docker/build-push-action/blob/master/docs/advanced/multi-platform.md
