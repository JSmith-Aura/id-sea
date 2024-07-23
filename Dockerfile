FROM golang:1.19

WORKDIR /app
COPY go.mod go.sum /app/
RUN go mod download
COPY . /app/

RUN CGO_ENABLED=0 go build -o id-sea main.go

FROM scratch
WORKDIR /app
COPY --from=0 /app/id-sea /app/id-sea
COPY --from=0 /usr/share/zoneinfo /usr/share/zoneinfo
ENV TZ=Pacific/Auckland  

ENTRYPOINT [ "/app/id-sea" ]