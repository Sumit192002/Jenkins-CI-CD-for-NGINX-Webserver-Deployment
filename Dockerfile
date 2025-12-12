# Use the official Nginx image as the base image
FROM nginx:stable-alpine

# Copy the custom index.html to the Nginx default HTML directory
COPY index.html /usr/share/nginx/html/
COPY style.css /usr/share/nginx/html/
COPY index.js /usr/share/nginx/html/


# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
