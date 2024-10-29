# Stage 1: Build the application
FROM node:latest as build

# Set working directory
WORKDIR /app


# Install dependencies
RUN yarn install

# Build the project
RUN yarn build

# Stage 2: Serve the application
FROM node:latest

# Set working directory
WORKDIR /app

# Copy the built files and node_modules from the build stage
COPY --from=build /app ./

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["yarn", "start"]
