FROM node:10.15.0-alpine AS builder

ARG ISSUER
ARG CLIENT_HOST

COPY ./app/ /app
COPY ./config/auth.clientConfiguration.json /app/src/assets/
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /app/src/assets/auth.clientConfiguration.json && \
    sed -i "s#ISSUER#$ISSUER#g" /app/src/assets/auth.clientConfiguration.json

WORKDIR /app
RUN npm i
RUN $(npm bin)/ng build --prod

################################################################################
# Image
################################################################################
FROM nginx:1.17.10-alpine

RUN apk update \
    && apk add ca-certificates \
    && rm -rf /var/cache/apk/*

COPY --from=builder /app/dist/angular-auth-oidc-sample-client /usr/share/nginx/html

ARG CONTROLLER_URL
ARG CLIENT_HOST

ARG CA_DIR="/certs"
ARG CA_CERT="oidc-ca.crt"
VOLUME ["$CA_DIR"]

COPY config/default.conf /etc/nginx/conf.d/default.conf
RUN sed -i "s#CLIENT_HOST#$CLIENT_HOST#g" /etc/nginx/conf.d/default.conf

RUN echo "https://$CONTROLLER_URL" > /usr/share/nginx/html/.professos

EXPOSE 80
EXPOSE 443

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
