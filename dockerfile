# Use the latest Node.js image
FROM node:latest

# Install dependencies
RUN yarn install

RUN yarn build

# Expose application port
EXPOSE 3000

# Start the development server
CMD ["yarn", "start"]
