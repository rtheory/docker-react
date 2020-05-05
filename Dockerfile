# PHASE ONE - Copy over source code and build it
FROM node:alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# PHASE TWO - just grab resulting build files from previous phase and run nginx to serve
# All other stuff from previous phase is dropped.
FROM nginx

COPY --from=builder /app/build /usr/share/nginx/html
# default of nginx is to run the server, so no need for RUN