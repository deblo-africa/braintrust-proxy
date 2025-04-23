FROM node:18-alpine

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Expose the port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
