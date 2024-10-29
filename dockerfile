# Stage 1: Build the application
FROM node:latest as build

# Set working directory
WORKDIR /app


# Install dependencies
RUN yarn install


# Expose the application port
EXPOSE 3000

# Start the application
CMD ["yarn", "dev"]
