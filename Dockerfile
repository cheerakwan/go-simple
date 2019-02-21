############################
# STEP 1 build executable binary
############################
ARG GO_VERSION=1.11

FROM golang:${GO_VERSION} AS build-env

WORKDIR /usr/local/go/src/github.com/go-simple
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build \
        -mod vendor \
        -o goapp \
        main.go

############################
# STEP 2 build a small image
############################

FROM alpine:latest

WORKDIR /app

# Copy our static executable
COPY --from=build-env /usr/local/go/src/github.com/go-simple/goapp ./goapp

EXPOSE 8080
ENTRYPOINT [ "./goapp" ]