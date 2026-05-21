FROM alpine:latest AS builder
RUN apk add --no-cache imagemagick imagemagick-webp
WORKDIR /assets
COPY . .
RUN for file in *.png; do convert "$file" "${file%.png}.webp" && rm "$file"; done

FROM caddy:alpine
COPY --from=builder /assets /srv
COPY Caddyfile /etc/caddy/Caddyfile
