FROM golang:1.23.5

WORKDIR /usr/src/app

COPY . .

RUN go mod tidy

RUN apt-get update && apt-get install -y sqlite3

RUN go run .