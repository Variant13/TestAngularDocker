#Create the node stage
FROM node:latest as builder
#Set the working directory
WORKDIR /app
#Copy frthe file from the current directory
COPY . . 
#Run npm install & build the application
RUN npm install && npm run ng build
#Create the nginx stage for the serving the content
FROM nginx:alpine
#Set the working directory to nginx assets directory
WORKDIR /usr/share/nginx/html
#Remove the default nginx static files
RUN rm -rf ./*
#Copy the static content from builder stage
COPY --from=builder /app/dist/testdocker .
#Container run the nginx with global directive and Daemon off
ENTRYPOINT ["nginx" , "-g" , "daemon off;"]