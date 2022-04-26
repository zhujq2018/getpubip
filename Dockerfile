FROM golang:1.16-alpine3.13 as builder

WORKDIR $GOPATH/src/getpubip
COPY . .

RUN apk add --no-cache git && set -x && \
    go mod init && go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -o /getpubip getpubip.go



FROM alpine:latest
WORKDIR /
COPY --from=builder /getpubip .
copy . .
RUN  chmod +x /getpubip  && chmod 777 /entrypoint.sh
ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080