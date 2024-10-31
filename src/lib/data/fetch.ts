import {
  AboutUsData,
  BlogData,
  BlogPost,
  CollectionsData,
  ContentPageData,
  FAQData,
  HeroBannerData,
  MidBannerData,
  VariantColorData,
} from 'types/strapi'

export const fetchStrapiClient = async (
  endpoint: string,
  params?: RequestInit
) => {
  const strapiUrl = process.env.NEXT_PUBLIC_STRAPI_URL;
  const strapiToken = process.env.NEXT_PUBLIC_STRAPI_READ_TOKEN;

  // Log Strapi URL and token availability for debugging
  console.log("Strapi URL:", strapiUrl);
  console.log("Strapi Token exists:", !!strapiToken);

  const response = await fetch(
    `${strapiUrl}${endpoint}`,
    {
      headers: {
        Authorization: `Bearer ${strapiToken}`,
      },
      ...params,
    }
  );

  if (!response.ok) {
    const errorData = await response.json().catch(() => ({})); // Attempt to parse JSON error, fallback to empty object
    console.error(`Failed to fetch data from ${endpoint}: ${response.status} - ${errorData.message || "No message"}`);
    throw new Error(`Failed to fetch data: ${response.statusText}`);
  }

  return response;
}

// Helper function to parse response JSON with error handling
const parseResponse = async (res: Response) => {
  try {
    return await res.json();
  } catch (error) {
    console.error("Error parsing JSON response:", error);
    throw new Error("Failed to parse JSON data");
  }
}

// Homepage data
export const getHeroBannerData = async (): Promise<HeroBannerData> => {
  const res = await fetchStrapiClient(
    `/api/homepage?populate[1]=HeroBanner&populate[2]=HeroBanner.CTA&populate[3]=HeroBanner.Image`,
    {
      next: { tags: ['hero-banner'] },
    }
  );
  return parseResponse(res);
}

export const getMidBannerData = async (): Promise<MidBannerData> => {
  const res = await fetchStrapiClient(
    `/api/homepage?populate[1]=MidBanner&populate[2]=MidBanner.CTA&populate[3]=MidBanner.Image`,
    {
      next: { tags: ['mid-banner'] },
    }
  );
  return parseResponse(res);
}

export const getCollectionsData = async (): Promise<CollectionsData> => {
  const res = await fetchStrapiClient(`/api/collections?&populate=*`, {
    next: { tags: ['collections-main'] },
  });
  return parseResponse(res);
}

export const getExploreBlogData = async (): Promise<BlogData> => {
  const res = await fetchStrapiClient(
    `/api/blogs?populate[1]=FeaturedImage&sort=createdAt:desc&pagination[start]=0&pagination[limit]=3`,
    {
      next: { tags: ['explore-blog'] },
    }
  );
  return parseResponse(res);
}

// Products
export const getProductVariantsColors = async (): Promise<VariantColorData> => {
  const res = await fetchStrapiClient(
    `/api/product-variants-colors?populate[1]=Type&populate[2]=Type.Image&pagination[start]=0&pagination[limit]=100`,
    {
      next: { tags: ['variants-colors'] },
    }
  );
  return parseResponse(res);
}

// About Us
export const getAboutUs = async (): Promise<AboutUsData> => {
  const res = await fetchStrapiClient(
    `/api/about-us?populate[1]=Banner&populate[2]=OurStory.Image&populate[3]=OurCraftsmanship.Image&populate[4]=WhyUs.Tile.Image&populate[5]=Numbers`,
    {
      next: { tags: ['about-us'] },
    }
  );
  return parseResponse(res);
}

// FAQ
export const getFAQ = async (): Promise<FAQData> => {
  const res = await fetchStrapiClient(
    `/api/faq?populate[1]=FAQSection&populate[2]=FAQSection.Question`,
    {
      next: { tags: ['faq'] },
    }
  );
  return parseResponse(res);
}

// Content Page
export const getContentPage = async (
  type: string,
  tag: string
): Promise<ContentPageData> => {
  const res = await fetchStrapiClient(`/api/${type}?populate=*`, {
    next: { tags: [tag] },
  });
  return parseResponse(res);
}

// Blog
export const getBlogPosts = async ({
  sortBy = 'createdAt:desc',
  query,
  category,
}: {
  sortBy: string
  query?: string
  category?: string
}): Promise<BlogData> => {
  const baseUrl = `/api/blogs?populate[1]=FeaturedImage&populate[2]=Categories&sort=${sortBy}&pagination[limit]=1000`;
  let urlWithFilters = baseUrl;

  if (query) {
    urlWithFilters += `&filters[Title][$contains]=${query}`;
  }

  if (category) {
    urlWithFilters += `&filters[Categories][Slug][$eq]=${category}`;
  }

  const res = await fetchStrapiClient(urlWithFilters, {
    next: { tags: ['blog'] },
  });
  return parseResponse(res);
}

export const getBlogPostCategories = async (): Promise<BlogData> => {
  const res = await fetchStrapiClient(
    `/api/blog-post-categories?sort=createdAt:desc&pagination[limit]=100`,
    {
      next: { tags: ['blog-categories'] },
    }
  );
  return parseResponse(res);
}

// Blog by Slug
export const getBlogPostBySlug = async (
  slug: string
): Promise<BlogPost | null> => {
  const res = await fetchStrapiClient(
    `/api/blogs?filters[Slug][$eq]=${slug}&populate=*`,
    {
      next: { tags: [`blog-${slug}`] },
    }
  );

  const data = await parseResponse(res);

  if (data.data && data.data.length > 0) {
    return data.data[0];
  }

  return null;
}

export const getAllBlogSlugs = async (): Promise<string[]> => {
  const res = await fetchStrapiClient(`/api/blogs?populate=*`, {
    next: { tags: ['blog-slugs'] },
  });

  const data = await parseResponse(res);
  return data.data.map((post: BlogPost) => post.Slug);
}
