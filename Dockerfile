FROM golang:1.16-alpine3.13 as builder

WORKDIR $GOPATH/src/getpubip
COPY . .

RUN apk add --no-cache git && set -x && \
    go mod init && go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -o /getpubip getpubip.go
RUN CGO_ENABLED=0 GOOS=linux go build -o /sshs sshs.go




FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /

WORKDIR /
RUN apt-get update \
  && apt-get install -y curl openssh-server zip unzip net-tools inetutils-ping iproute2 tcpdump git vim mysql-client redis-tools tmux tzdata\
  && echo "Asia/Shanghai" > /etc/timezone &&  rm -f /etc/localtime   && dpkg-reconfigure -f noninteractive tzdata \
  && rm -rf /var/lib/apt/lists/* 

COPY --from=builder /getpubip .
COPY --from=builder /sshs .
copy . .
RUN  chmod +x /getpubip  && chmod 777 /entrypoint.sh
ENTRYPOINT  /entrypoint.sh 

EXPOSE 8080
