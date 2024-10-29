# Stage 1: Build the application
FROM node:latest as build


# Install dependencies
RUN yarn install


# Expose the application port
EXPOSE 3000

# Start the application
CMD ["yarn", "dev"]
