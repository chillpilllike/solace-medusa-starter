# Use an official Node.js image as the base
FROM node:latest

# Set the working directory in the container
WORKDIR /app

# Clone the repository
RUN git clone https://github.com/rigby-sh/solace-medusa-starter.git .

# Install dependencies
RUN yarn install

# Expose the development port (3000 is common for dev setups, but adjust if needed)
EXPOSE 8000

# Start the application in development mode
CMD ["yarn", "dev"]
