# Use the official Node.js 20 LTS image as the base image
# This image includes Node.js and npm pre-installed.
FROM node:20-alpine

# Set the working directory inside the container
# All subsequent commands will be executed in this directory.
WORKDIR /app

# Copy package.json and package-lock.json (if it exists) to the working directory.
# This step is done separately to leverage Docker's build cache.
# If these files don't change, npm install won't be re-run on subsequent builds.
COPY package*.json ./

# Install project dependencies
# The --omit=dev flag is typically used for production builds to skip dev dependencies.
# However, for hot-reloading during development, we need dev dependencies (like nodemon).
# So, we'll install all dependencies, including dev dependencies, here.
RUN npm install

# Copy the rest of the application code to the working directory.
# This includes your server.js file and any other source code.
COPY . .

# Expose the port that your Express app listens on (default is 3000)
# This tells Docker that the container will listen on this port at runtime.
EXPOSE 3000

# Define the command to run the application using nodemon.
# nodemon will watch for file changes in the /app directory and restart the server.
# This is the command that will be executed when the container starts.
CMD ["npm", "start"]

# Instructions to build and run this Dockerfile for hot-reloading:
# 1. Ensure you have Docker installed on your machine.
# 2. Save the code above as `Dockerfile` (no file extension) in the root of your project directory,
#    alongside your `server.js` and `package.json` files.
# 3. Make sure your `package.json` has the "start" script configured for nodemon:
#    "scripts": {
#      "start": "nodemon server.js"
#    }
# 4. Build the Docker image from your project directory:
#    `docker build -t node-express-app .`
#    (Replace `node-express-app` with your desired image name)
# 5. Run the Docker container with a volume mount for hot-reloading:
#    `docker run -p 3000:3000 -v "$(pwd):/app" node-express-app`
#    - `-p 3000:3000`: Maps port 3000 on your host to port 3000 in the container.
#    - `-v "$(pwd):/app"`: This is the crucial part for hot-reloading.
#      It mounts your current host directory (`$(pwd)` on Linux/macOS, use `%cd%` on Windows cmd or `${PWD}` on Windows PowerShell)
#      into the `/app` directory inside the container.
#      This means any changes you make to your files on your host machine will be immediately visible
#      inside the container, and nodemon will detect them and restart the server.
# 6. Open your web browser and go to `http://localhost:3000`.
#    Now, if you modify and save `server.js` (or other source files), nodemon inside the container
#    will automatically restart the Node.js application.
