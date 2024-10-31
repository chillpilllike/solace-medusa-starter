# Use an official Node.js image as the base
FROM node:latest

# Set the working directory in the container
WORKDIR /app


# Environment variables for Medusa, Strapi, and other configurations
ENV NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_2a03247a9bba676354504f257ebf79cd734e6f16384bdbb4d724db5b9ff8e8ea
ENV NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://backend-backend-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_DEMO_MODE=false

# Strapi-specific values
ENV NEXT_PUBLIC_STRAPI_URL=https://common-strapi2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_STRAPI_READ_TOKEN=8828d81ee52346556de6128557d32becc5cc00c9391ff6817495927e8f557ccd15ad5a79c942ff78534f852f91c5cb1b67edca5502e1db949e073e81290075ee4d7f0c3829319ffcaa3c0562cf5241eb0c8f07ff703a83a5d088ebab45164f93be851603a794f6bc9a0ce61bb61556d37e1e4180769dc19cb2c4669583e331b0
ENV STRAPI_WEBHOOK_REVALIDATION_SECRET=155f1e4372952a46bd56e6b2797383d9d0a910c7c9e929da2dc6c6195541687e


# CDN or Static Asset Hosting values
ENV NEXT_PUBLIC_CDN_SPACE_DOMAIN=secretgreen9.s3.ap-southeast-2.amazonaws.com
ENV NEXT_PUBLIC_SPACE_DOMAIN=backend-storefront-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_SPACE_ENDPOINT=s3.ap-southeast-2.amazonaws.com





# Copy the rest of the code into the container
COPY . .

# Install dependencies
RUN yarn install


# Run the build command
RUN yarn build

# Expose the port your application will run on (adjust if necessary)
EXPOSE 8000

# Start the application in development mode
CMD ["yarn", "start"]

