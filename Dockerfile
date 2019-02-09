FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
COPY yarn.lock .
RUN yarn install
COPY . .
RUN yarn build

FROM nginx

# Very important for port mapping on AWS ElasticBenstalk
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
