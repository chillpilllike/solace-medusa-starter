# Use the latest Node.js image
FROM node:latest

# Install dependencies
RUN yarn install

# Expose application port
EXPOSE 3000

# Start the development server
CMD ["yarn", "dev"]
