FROM node:18-alpine

WORKDIR /app

# Copy package.json first (without requiring package-lock.json)
COPY package.json ./

# Check if yarn.lock exists and use yarn if it does, otherwise use npm
COPY yarn.lock* package-lock.json* ./
RUN if [ -f yarn.lock ]; then \
      yarn install --frozen-lockfile; \
    elif [ -f package-lock.json ]; then \
      npm ci; \
    else \
      npm install; \
    fi

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Expose the port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]
