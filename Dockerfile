FROM golang:1.19.9-alpine3.17 as builder

WORKDIR $GOPATH/src/getpubip
COPY . .

RUN apk add --no-cache git && set -x && go mod init  && go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -o /server server.go
RUN CGO_ENABLED=0 GOOS=linux go build -o /sshs sshs.go

FROM alpine
RUN apk update && apk add --no-cache \
  curl  zip unzip net-tools  iputils iproute2 tcpdump git vim bash mysql-client redis 
  
WORKDIR /
COPY --from=builder /server .
COPY --from=builder /sshs .
copy . .
RUN  chmod +x /server  && chmod 777 /entrypoint.sh
ENTRYPOINT  /entrypoint.sh 

EXPOSE 80
