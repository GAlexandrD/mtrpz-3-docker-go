FROM golang:1.20-alpine as build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

RUN go build -o ./build/fizzbuzz

FROM gcr.io/distroless/static-debian11
COPY --from=build /app/build/fizzbuzz /fizzbuzz
COPY --from=build /app/templates /templates

CMD [ "./fizzbuzz", "serve" ]