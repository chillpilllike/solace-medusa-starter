# Use the latest Node.js image
FROM node:latest

# Set working directory
WORKDIR /app

# Install Git
RUN apt-get update && apt-get install -y git

# Clone the repository
RUN git clone https://github.com/rigby-sh/solace-medusa-starter.git .

ENV NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_2a03247a9bba676354504f257ebf79cd734e6f16384bdbb4d724db5b9ff8e8ea
ENV BACKEND_URL=https://backend-backend-secretgreen9-v2.xcbkmg.easypanel.host

ENV NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://backend-backend-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_DEMO_MODE=false
ENV MEDUSA_BACKEND_URL=https://backend-backend-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_BASE_URL=https://backend-storefront-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://backend-backend-secretgreen9-v2.xcbkmg.easypanel.host

ENV NEXT_PUBLIC_STRAPI_URL=https://common-strapi2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_STRAPI_READ_TOKEN=40e5142ae1e8517fff421b6a1000063cc3e3efd3b1f90a6a42c0040058a3e649fa5ab0f35d9332a5bf03601d3189e17408f2680e75858b63bb3e9c3030b18847e71bb366e2bd2ce98fd85c9ef77bf346d30ada5d7db351d9cacfe6d2b52173058fd016caa37e66fdb825c60d99abd24147ce3d2a9989b274349338c0dd074196

ENV NEXT_PUBLIC_CDN_SPACE_DOMAIN=secretgreen9.s3.ap-southeast-2.amazonaws.com
ENV NEXT_PUBLIC_SPACE_DOMAIN=backend-storefront-secretgreen9-v2.xcbkmg.easypanel.host
ENV NEXT_PUBLIC_SPACE_ENDPOINT=s3.ap-southeast-2.amazonaws.com

ENV STRAPI_WEBHOOK_REVALIDATION_SECRET=8b9690ddb9e2202278d872a7e375451b95adb5283e4c31adffd8fd9edb3612df20b8cc90a373ddf171fdd287ee69bb0ea55b3a9deab64aad7290dde5beb87ce99a95f5bdbb45ce7f31dc5eae38276ac96813650818e619b424868a1d803ca834f5b395e9d95791f4888b4cdd9a93705a48248de0cec349d29522ae77c60d5abe
ENV REACT_EDITOR=atom
# Install dependencies
RUN yarn install

RUN yarn build

# Expose application port
EXPOSE 3000

# Start the development server
CMD ["yarn", "dev"]
