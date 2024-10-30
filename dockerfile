# Use an official Node.js image as the base
FROM node:latest

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container's working directory
COPY . .

# Environment variables for Medusa, Strapi, and other configurations
ENV NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_2a03247a9bba676354504f257ebf79cd734e6f16384bdbb4d724db5b9ff8e8ea
ENV NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://backend-backend-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_DEMO_MODE=false
ENV MEDUSA_BACKEND_URL=https://backend-backend-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_BASE_URL=https://backend-storefront-secretgreen9-v2.xcbkmg.easypanel.host

ENV NEXT_PUBLIC_STRAPI_URL=https://common-strapi2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_STRAPI_READ_TOKEN=acffe74ba302205606ee1de34d1a09455022f844a265635ed440b07269f06dc30e736fdcb8acdcfea68d1e59969f32c30fdd11ea516a0b9be70060bd1647135dafc6625613decd1cb754f5ed9c26fa3a3cf4b09937a104ce7dc27ddb668af71c05a9d08931608ff96c45119f92e257cc4f9a81da919917fb4b97031e4e6e532a

ENV NEXT_PUBLIC_CDN_SPACE_DOMAIN=secretgreen9.s3.ap-southeast-2.amazonaws.com
ENV NEXT_PUBLIC_SPACE_DOMAIN=backend-storefront-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_SPACE_ENDPOINT=s3.ap-southeast-2.amazonaws.com

ENV STRAPI_WEBHOOK_REVALIDATION_SECRET=09876fedcba54321fedcba09876fedcba54321fedcba09876fedcba54321fedc

# Enable Corepack and install the specified Yarn version
RUN corepack enable && corepack prepare yarn@3.2.3 --activate

# Install dependencies
RUN yarn install

# Expose the port your application will run on (adjust if necessary)
EXPOSE 8000

# Start the application in development mode
CMD ["yarn", "dev"]
