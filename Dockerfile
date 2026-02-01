# Use the lightweight NGINX image as our base
FROM nginx:alpine

# Copy our local HTML file into the folder NGINX uses to serve web content
COPY index.html /usr/share/nginx/html/index.html