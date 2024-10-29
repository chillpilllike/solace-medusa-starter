# Use the latest Node.js image
FROM node:latest

# Set working directory
WORKDIR /app

# Copy package.json and yarn.lock to the container
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Expose application port
EXPOSE 3000

# Start the development server
CMD ["yarn", "dev"]
