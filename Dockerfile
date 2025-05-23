# Stage 1: Build the React frontend
FROM node:20 AS frontend_builder
WORKDIR /app/frontend
COPY my-react-router-app/package*.json ./
RUN npm install
COPY my-react-router-app/ .
RUN npm run build # This will create the 'dist' folder

# Stage 2: Build the Node.js Express backend
FROM node:20 AS backend_builder
WORKDIR /app/backend
COPY server/package*.json ./
RUN npm install --production
COPY server/ .

# Stage 3: Combine with Nginx
FROM nginx:latest AS final
# Install Node.js runtime for the backend
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built React app to Nginx static serve directory
COPY --from=frontend_builder /app/frontend/dist /usr/share/nginx/html

# Copy Node.js backend
COPY --from=backend_builder /app/backend /app/backend

# Expose the port Nginx is listening on
EXPOSE 8080

# Start Nginx and Node.js backend using a custom entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]