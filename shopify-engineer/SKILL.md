---
name: "Shopify Engineer"
description: "Shopify specialist expert in product management, blog post creation, inventory sync, and automation via MCP integration and n8n workflows. Handles bulk operations, SEO optimization, metafields, and integrates with external systems for automated content publishing and product updates."
version: "1.0.0"
dependencies: "n8n-mcp"
---

# Shopify Engineer

Expert Shopify engineer specializing in product management, content creation, automation workflows, and integration with external systems via MCP and n8n.

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

### Automation with n8n

#### Product Upload Workflow
```json
{
  "name": "AI Product Description to Shopify",
  "nodes": [
    {
      "name": "Webhook Trigger",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "path": "new-product",
        "responseMode": "responseNode"
      }
    },
    {
      "name": "Generate Description (OpenAI)",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "operation": "create",
        "model": "gpt-4",
        "prompt": "Generate SEO-optimized product description for: {{$json.product_name}}"
      }
    },
    {
      "name": "Generate Keywords",
      "type": "n8n-nodes-base.code",
      "parameters": {
        "jsCode": "return { tags: extractKeywords($json.description) }"
      }
    },
    {
      "name": "Create Shopify Product",
      "type": "n8n-nodes-base.shopify",
      "parameters": {
        "operation": "create",
        "resource": "product",
        "title": "={{$json.product_name}}",
        "bodyHtml": "={{$json.description}}",
        "tags": "={{$json.tags}}"
      }
    },
    {
      "name": "Send Confirmation",
      "type": "n8n-nodes-base.slack",
      "parameters": {
        "message": "✅ Product created: {{$json.title}}"
      }
    }
  ]
}
```

#### Blog Post from Content Calendar
```json
{
  "name": "Auto-Publish Blog Posts",
  "nodes": [
    {
      "name": "Schedule Trigger",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "triggerTimes": {
          "hour": 9,
          "minute": 0,
          "dayOfWeek": [1, 3, 5]
        }
      }
    },
    {
      "name": "Get Scheduled Posts (Airtable)",
      "type": "n8n-nodes-base.airtable",
      "parameters": {
        "operation": "list",
        "filterByFormula": "AND(IS_SAME({Publish Date}, TODAY()), {Status} = 'Ready')"
      }
    },
    {
      "name": "Generate SEO Meta (AI)",
      "type": "n8n-nodes-base.openAi",
      "parameters": {
        "prompt": "Create SEO-optimized meta description (max 160 chars) for: {{$json.title}}"
      }
    },
    {
      "name": "Upload to Shopify Blog",
      "type": "n8n-nodes-base.shopify",
      "parameters": {
        "resource": "article",
        "operation": "create",
        "blogId": "{{$json.blog_id}}",
        "title": "={{$json.title}}",
        "bodyHtml": "={{$json.content}}",
        "author": "={{$json.author}}",
        "tags": "={{$json.tags}}",
        "published": true
      }
    },
    {
      "name": "Update Airtable Status",
      "type": "n8n-nodes-base.airtable",
      "parameters": {
        "operation": "update",
        "id": "={{$json.record_id}}",
        "fields": {
          "Status": "Published",
          "Shopify URL": "={{$json.url}}"
        }
      }
    }
  ]
}
```

### Inventory Sync Workflow

```json
{
  "name": "Sync Inventory from Supplier API",
  "nodes": [
    {
      "name": "Schedule Every Hour",
      "type": "n8n-nodes-base.cron",
      "parameters": {
        "triggerTimes": {
          "minute": 0
        }
      }
    },
    {
      "name": "Fetch Supplier Inventory",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://supplier-api.com/inventory",
        "authentication": "headerAuth",
        "method": "GET"
      }
    },
    {
      "name": "Transform Data",
      "type": "n8n-nodes-base.code",
      "parameters": {
        "jsCode": `
          const items = [];
          for (const item of $input.all()) {
            items.push({
              sku: item.json.product_sku,
              inventory_quantity: item.json.stock_count,
              inventory_item_id: item.json.shopify_inventory_id
            });
          }
          return items;
        `
      }
    },
    {
      "name": "Update Shopify Inventory",
      "type": "n8n-nodes-base.shopify",
      "parameters": {
        "resource": "inventoryLevel",
        "operation": "update",
        "inventoryItemId": "={{$json.inventory_item_id}}",
        "available": "={{$json.inventory_quantity}}"
      }
    },
    {
      "name": "Log Changes",
      "type": "n8n-nodes-base.supabase",
      "parameters": {
        "operation": "insert",
        "table": "inventory_sync_log",
        "data": {
          "sku": "={{$json.sku}}",
          "old_quantity": "={{$json.old_qty}}",
          "new_quantity": "={{$json.inventory_quantity}}",
          "synced_at": "={{$now}}"
        }
      }
    }
  ]
}
```

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
```json
{
  "name": "Send Personalized Product Emails",
  "nodes": [
    {
      "name": "Get Customer Segments (Klaviyo)",
      "type": "n8n-nodes-base.httpRequest"
    },
    {
      "name": "Fetch Recommended Products (Shopify)",
      "type": "n8n-nodes-base.shopify",
      "parameters": {
        "operation": "getAll",
        "resource": "product",
        "filters": "={{$json.recommended_tags}}"
      }
    },
    {
      "name": "Send via Klaviyo",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://a.klaviyo.com/api/campaigns",
        "method": "POST",
        "body": {
          "template_id": "xyz",
          "products": "={{$json.products}}"
        }
      }
    }
  ]
}
```

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
- n8n workflow creation for Shopify
- MCP integration setup
- SEO optimization
- Metafield management

Provides production-ready Shopify integrations and automations.
