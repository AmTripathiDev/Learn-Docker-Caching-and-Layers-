# Use the Alpine-based Node.js image maintained by mhart. 
# Alpine is a lightweight Linux distribution, and mhart's images are optimized for Node.js applications.
FROM mhart/alpine-node:latest

# Set the working directory inside the container to /user/app.
WORKDIR /user/app

# Copy package.json and package-lock.json (if exists) from the host into the container.
# This step is separated to leverage Docker's layer caching mechanism. 
# If there are no changes in package.json|yarn.lock, Docker can reuse the cached layer 
# rather than re-downloading and re-installing dependencies on every build.
COPY package*.json ./

# Install dependencies defined in package.json.
RUN npm install

# Copy the rest of the application files from the host into the container.
COPY . .

# Expose port 3000 to allow incoming connections to your Node.js application.
EXPOSE 3000

# Command to start the Node.js application.
CMD ["node", "index.js"]
