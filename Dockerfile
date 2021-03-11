FROM alpine:3.12

RUN apk add --no-cache ca-certificates openssl

RUN apk add --no-cache \
        ruby \
        ruby-bigdecimal \
        ruby-etc \
        ruby-json \
        libstdc++ \
        sqlite-libs
        
ARG MAILCATCHER_VERSION=0.7.1

RUN apk add --no-cache --virtual .build-deps \
            ruby-dev \
            make \
            g++ \
            sqlite-dev \
        && gem install -v $MAILCATCHER_VERSION mailcatcher \
        && apk del .build-deps
        
        
EXPOSE 1080 1025

CMD ["mailcatcher", "--ip=0.0.0.0", "--foreground"]
