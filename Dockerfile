FROM node:18-alpine

# Install pnpm with the specific version from package.json
RUN npm install -g pnpm@8.15.5

WORKDIR /app

# Copy root configuration files
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./

# Create directory structure for workspaces
RUN mkdir -p apis packages

# Copy package.json files for workspace packages
COPY apis/*/package.json ./apis/
COPY packages/*/package.json ./packages/

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy the rest of the source code
COPY . .

# Build the project
RUN pnpm build

# Expose the port
EXPOSE 3000

# Start the Vercel API (which is the most suitable for standalone deployment)
CMD ["pnpm", "--filter", "braintrust-proxy", "start"]
