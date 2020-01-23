###
### Builder for frontend
###
FROM node:slim as builder

WORKDIR /web
COPY ./frontend/package* /web
RUN cd /web && \
    yarn install

COPY ./frontend ./
RUN yarn build

###
### Runner
###
FROM node:alpine

WORKDIR /web
COPY ./backend/package* ./
RUN cd /web && \
    yarn install

COPY ./backend ./

COPY --from=builder /web/build /web/src/client/build

ENTRYPOINT [ "yarn", "production" ]