# Use lightweight Node image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package files first for efficient caching
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy all app source code
COPY . .

# Expose backend port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
