# MailCatcher

MailCatcher - is a ruby powered alpine image, based on https://mailcatcher.me. Its purpose is to provide a way of testing applications wich uses emails (i.e. sign in with email or email confirmation)


## Features

1. Full featured SMTP server
2. simple WEB interface

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
