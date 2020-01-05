FROM node:lts-alpine as build-stage

WORKDIR /app
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "deamon off"]