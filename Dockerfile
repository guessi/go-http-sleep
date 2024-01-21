FROM public.ecr.aws/docker/library/golang:1.21-alpine3.19 as BUILDER
RUN apk add --no-cache git
WORKDIR ${GOPATH}/src/go-http-sleep
COPY main.go go.mod ./
RUN CGO_ENABLED=0 go build -o /go/bin/go-http-sleep

FROM scratch
COPY --from=BUILDER /go/bin/go-http-sleep /opt/
EXPOSE 8080
ENTRYPOINT ["/opt/go-http-sleep"]
