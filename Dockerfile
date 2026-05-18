FROM ubuntu:latest AS builder
RUN apt-get update && apt-get install -y imagemagick && rm -rf /var/lib/apt/lists/*
WORKDIR /assets
COPY . .
RUN for file in *.png; do convert "$file" "${file%.png}.webp" && rm "$file"; done

FROM caddy:alpine
COPY --from=builder /assets /srv
COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 80
