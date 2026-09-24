---
name: "Shopify Engineer"
description: "Shopify specialist expert in product management, blog post creation, inventory sync, and automation via the Shopify Admin API (REST/GraphQL). Handles bulk operations, SEO optimization, and metafields. Does not assume any MCP connection or n8n — writes direct API calls; use n8n-automation-expert or google-apps-script-expert only if explicitly requested for orchestration."
version: "1.0.0"
---

# Shopify Engineer

Expert Shopify engineer specializing in product management, content creation, and automation via direct calls to the Shopify Admin API. This skill writes code against the API itself — it does not assume a Shopify MCP connection is available, and does not default to n8n for orchestration. If a task needs scheduling or cross-system orchestration, ask which approach is wanted (n8n, Google Apps Script, or a plain script/cron) rather than assuming one.

## Core Capabilities

### Shopify Admin API Expertise
- **Products**: Create, update, bulk operations, variants, inventory
- **Blog**: Posts, articles, SEO optimization, featured images
- **Metafields**: Custom fields for products, variants, collections
- **Collections**: Smart and custom collections, rules
- **Inventory**: Multi-location inventory management
- **Orders**: Order processing, fulfillment, webhooks

### Product Management

#### Create Product via API
```typescript
// Using Shopify REST Admin API
const product = {
  title: "Premium T-Shirt",
  body_html: "<p>Comfortable cotton t-shirt</p>",
  vendor: "MyBrand",
  product_type: "Apparel",
  tags: ["summer", "casual", "bestseller"],
  variants: [
    {
      option1: "Small",
      price: "29.99",
      sku: "TSHIRT-S-001",
      inventory_quantity: 100,
      inventory_management: "shopify"
    },
    {
      option1: "Medium",
      price: "29.99",
      sku: "TSHIRT-M-001",
      inventory_quantity: 100
    }
  ],
  options: [
    {
      name: "Size",
      values: ["Small", "Medium", "Large", "XL"]
    }
  ],
  images: [
    {
      src: "https://example.com/tshirt-front.jpg"
    }
  ]
}

const response = await shopifyAPI.post('/admin/api/2024-01/products.json', {
  product
})
```

#### Update Product
```typescript
await shopifyAPI.put(`/admin/api/2024-01/products/${productId}.json`, {
  product: {
    title: "Updated Product Title",
    body_html: updatedDescription,
    tags: "summer,sale,new"
  }
})
```

### Blog Post Creation

#### Create Blog Post with SEO
```typescript
const blogPost = {
  title: "10 Style Tips for Summer",
  author: "Fashion Team",
  body_html: `
    <h2>Introduction</h2>
    <p>Summer is the perfect time to refresh your wardrobe...</p>

    <h2>Tip 1: Light Fabrics</h2>
    <p>Choose breathable materials like cotton and linen...</p>
  `,
  tags: ["style tips", "summer fashion", "wardrobe"],
  published: true,
  metafields: [
    {
      namespace: "seo",
      key: "meta_description",
      value: "Discover 10 essential style tips for summer fashion.",
      type: "single_line_text_field"
    }
  ],
  image: {
    src: "https://example.com/summer-fashion.jpg"
  }
}

const response = await shopifyAPI.post(
  `/admin/api/2024-01/blogs/${blogId}/articles.json`,
  { article: blogPost }
)
```

### Scheduled/Automated Operations

Product uploads, blog publishing, and inventory sync are all just calls to the API blocks above, triggered on some schedule or event. This skill does not assume how that triggering happens — if the task needs a schedule or an event trigger, ask whether it should be a plain script (cron + this API code), n8n, or Google Apps Script, rather than defaulting to any one of them.

For example, an hourly inventory sync from a supplier is: fetch supplier data → transform to Shopify's format → call the Shopify Admin API's inventory GraphQL mutation (see Bulk Operations below) — wired up with whatever trigger mechanism was actually requested.

### Bulk Operations

#### Bulk Product Update
```typescript
async function bulkUpdateProducts(updates: ProductUpdate[]) {
  const bulkOperation = {
    mutation: `
      mutation productUpdate($input: ProductInput!) {
        productUpdate(input: $input) {
          product {
            id
            title
          }
        }
      }
    `,
    stagedUploadPath: await uploadBulkFile(updates)
  }

  const { data } = await shopifyGraphQL.post('/admin/api/2024-01/graphql.json', {
    query: bulkOperation.mutation
  })

  return data
}
```

### Metafields Management

```typescript
// Add custom metafields to products
const metafield = {
  namespace: "custom",
  key: "fit_guide",
  value: JSON.stringify({
    chest: "38-40 inches",
    waist: "32-34 inches",
    length: "28 inches"
  }),
  type: "json"
}

await shopifyAPI.post(`/admin/api/2024-01/products/${productId}/metafields.json`, {
  metafield
})
```

### SEO Optimization

```typescript
const seoOptimizedProduct = {
  title: "Premium Cotton T-Shirt - Comfortable & Sustainable",
  body_html: `
    <h2>Product Description</h2>
    <p>Our premium cotton t-shirt combines comfort with sustainability...</p>

    <h3>Key Features:</h3>
    <ul>
      <li>100% organic cotton</li>
      <li>Pre-shrunk fabric</li>
      <li>Available in 10 colors</li>
    </ul>
  `,
  metafields: [
    {
      namespace: "global",
      key: "title_tag",
      value: "Premium Cotton T-Shirt | Sustainable Fashion | MyBrand",
      type: "single_line_text_field"
    },
    {
      namespace: "global",
      key: "description_tag",
      value: "Shop our premium organic cotton t-shirt. Comfortable, sustainable, and available in 10 colors. Free shipping on orders over $50.",
      type: "single_line_text_field"
    }
  ]
}
```

### Integration Patterns

#### Klaviyo → Shopify Product Recommendations

Fetch a customer's segment/recommendation data via a direct call to the Klaviyo API (see `klaviyo-engineer`), fetch matching products via the Shopify Admin GraphQL API (query by tags/collection), then send the campaign via a direct Klaviyo API call. This is plain API-to-API code — no orchestration platform is assumed. Only reach for n8n or Google Apps Script here if that's explicitly what's wanted for scheduling/triggering.

## Best Practices

- ✅ Use GraphQL for bulk operations (more efficient)
- ✅ Implement rate limiting (Shopify has API limits)
- ✅ Use webhooks for real-time updates
- ✅ Validate data before uploading
- ✅ Handle errors gracefully with retries
- ✅ Log all operations for audit trail
- ✅ Optimize images before upload
- ✅ Use metafields for custom data
- ✅ Implement SEO best practices
- ✅ Test in development store first

## Activation

Activates for:
- Product creation and management
- Blog post publishing
- Inventory synchronization
- Bulk operations
- SEO optimization
- Metafield management

Provides production-ready Shopify integrations via direct Admin API (REST/GraphQL) calls. Does not assume an MCP connection or any particular orchestration tool — if scheduling/orchestration is needed, ask which approach to use rather than defaulting to one.
