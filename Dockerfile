#------Build

FROM gcc:latest AS build

WORKDIR /build

RUN apt-get update && \
    apt-get install -y cmake

COPY . .

RUN g++ -o helloworld src/main.cpp -static

#------Start

FROM alpine:latest

WORKDIR /app

COPY --from=build /build/helloworld .

RUN addgroup -S sample && adduser -S -D sample -G sample && chown sample helloworld
USER sample

CMD ["./helloworld"]