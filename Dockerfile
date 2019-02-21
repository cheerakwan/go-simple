ARG GO_VERSION=1.11

FROM golang:${GO_VERSION} AS build-env

WORKDIR /usr/local/go/src/github.com/go-simple
COPY . .

RUN go build \
        -mod vendor \
        -o goapp \
        main.go

##################################################

FROM alpine:latest

WORKDIR /app

COPY --from=build-env /usr/local/go/src/github.com/go-simple/goapp ./goapp

EXPOSE 8080
ENTRYPOINT [ "./goapp" ]