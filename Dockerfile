FROM golang:1.23.5-alpine AS builder

WORKDIR /build

RUN apk add --no-cache gcc musl-dev sqlite-dev

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN GOOS=linux go build -o main

FROM alpine:3.21.3

RUN apk add --no-cache sqlite

WORKDIR /app

COPY --from=builder /build/main ./

COPY tracker.db ./

CMD ["./main"]
