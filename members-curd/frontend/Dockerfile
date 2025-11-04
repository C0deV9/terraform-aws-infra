# Build Stage
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci
COPY . .

# Build the optimized production version
RUN npm run build

# Serve Stage (using nginx)
FROM nginx:1.25-alpine

# Copy built files from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Run nginx
CMD ["nginx", "-g", "daemon off;"]
