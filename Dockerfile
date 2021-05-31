FROM ruby:2.4.10-alpine3.11
COPY ./certs/* /etc/ssl/certs/
ENV SSL_CERT_DIR=/etc/ssl/certs
RUN apk add --update --no-cache openssl ca-certificates && \
    update-ca-certificates