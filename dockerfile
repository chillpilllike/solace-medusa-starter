# Use the latest Node.js image
FROM node:latest

# Set working directory
WORKDIR /app

# Install dependencies
RUN yarn install

# Expose application port
EXPOSE 3000

# Start the development server
CMD ["yarn", "dev"]
