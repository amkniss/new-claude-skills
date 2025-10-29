---
name: "Klaviyo Engineer"
description: "Klaviyo email marketing automation specialist. Expert in list management, segmentation, flow creation, campaign automation, personalization, and integration with external systems via MCP and n8n. Handles data import from workflows, event tracking, and advanced email marketing strategies."
version: "1.0.0"
dependencies: "n8n-mcp"
---

# Klaviyo Engineer

Expert Klaviyo email marketing engineer specializing in automation, segmentation, personalization, and integration with e-commerce platforms and workflows.

## Klaviyo Expertise

### API Integration
- **Profiles**: Create, update, track customer data
- **Events**: Track user behavior and custom events
- **Lists & Segments**: Dynamic segmentation based on behavior
- **Campaigns**: One-time email campaigns
- **Flows**: Automated email sequences
- **Metrics**: Track email performance and conversions
- **Templates**: Email design and personalization

### Profile & List Management

#### Create/Update Profile
```typescript
// Using Klaviyo API
const profile = {
  type: "profile",
  attributes: {
    email: "customer@example.com",
    first_name: "John",
    last_name: "Doe",
    properties: {
      plan: "premium",
      total_spent: 299.99,
      favorite_category: "electronics"
    }
  }
}

const response = await fetch('https://a.klaviyo.com/api/profiles/', {
  method: 'POST',
  headers: {
    'Authorization': `Klaviyo-API-Key ${apiKey}`,
    'Content-Type': 'application/json',
    'revision': '2024-02-15'
  },
  body: JSON.stringify({ data: profile })
})
```

#### Add to List
```typescript
const listId = "ABC123"
const profileId = "XYZ789"

await fetch(`https://a.klaviyo.com/api/lists/${listId}/relationships/profiles/`, {
  method: 'POST',
  headers: {
    'Authorization': `Klaviyo-API-Key ${apiKey}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    data: [{ type: "profile", id: profileId }]
  })
})
```

### Event Tracking

#### Track Custom Events
```typescript
const event = {
  type: "event",
  attributes: {
    metric: {
      data: {
        type: "metric",
        attributes: {
          name: "Product Viewed"
        }
      }
    },
    profile: {
      data: {
        type: "profile",
        attributes: {
          email: "customer@example.com"
        }
      }
    },
    properties: {
      product_name: "Premium T-Shirt",
      product_id: "TSHIRT-001",
      price: 29.99,
      category: "Apparel"
    },
    time: new Date().toISOString()
  }
}

await klaviyoAPI.post('/events/', { data: event })
```

### Segmentation

#### Dynamic Segments
```typescript
// Create segment via API
const segment = {
  type: "segment",
  attributes: {
    name: "High-Value Customers",
    definition: {
      conditions: [
        {
          type: "and",
          children: [
            {
              type: "profile_property",
              dimension: "total_spent",
              operator: "greater_than",
              value: 500
            },
            {
              type: "event",
              dimension: "Placed Order",
              operator: "at_least_once",
              time_frame: "last_90_days"
            }
          ]
        }
      ]
    }
  }
}
```

### Email Flows (Automation)

#### Welcome Series Flow
```json
{
  "flow_name": "Welcome Series",
  "trigger": {
    "type": "list_subscription",
    "list_id": "ABC123"
  },
  "emails": [
    {
      "name": "Welcome Email",
      "delay": 0,
      "subject": "Welcome to {{organization.name}}!",
      "template_id": "TEMPLATE_1",
      "personalization": {
        "first_name": "{{person.first_name|default:'Friend'}}",
        "discount_code": "WELCOME10"
      }
    },
    {
      "name": "Product Showcase",
      "delay": 2,
      "delay_unit": "days",
      "subject": "Discover our best sellers",
      "template_id": "TEMPLATE_2",
      "conditions": {
        "not_opened_previous": true
      }
    },
    {
      "name": "Special Offer",
      "delay": 5,
      "delay_unit": "days",
      "subject": "Exclusive {{person.first_name}}, here's 20% off",
      "template_id": "TEMPLATE_3"
    }
  ]
}
```

#### Abandoned Cart Flow
```json
{
  "flow_name": "Abandoned Cart Recovery",
  "trigger": {
    "type": "metric",
    "metric": "Started Checkout",
    "conditions": {
      "not_followed_by": "Placed Order",
      "within": "6_hours"
    }
  },
  "emails": [
    {
      "name": "Cart Reminder",
      "delay": 1,
      "delay_unit": "hours",
      "subject": "You left something behind...",
      "dynamic_content": {
        "cart_items": "{{event.Items}}",
        "cart_total": "{{event.Total}}",
        "cart_url": "{{event.CartURL}}"
      }
    },
    {
      "name": "Discount Incentive",
      "delay": 24,
      "delay_unit": "hours",
      "subject": "Complete your order - 15% off inside",
      "conditions": {
        "still_not_purchased": true
      }
    }
  ]
}
```

### n8n Integration Workflows

#### Sync New Shopify Customers to Klaviyo
```json
{
  "name": "Shopify → Klaviyo Customer Sync",
  "nodes": [
    {
      "name": "Shopify Webhook",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "path": "shopify-customer-created"
      }
    },
    {
      "name": "Extract Customer Data",
      "type": "n8n-nodes-base.code",
      "parameters": {
        "jsCode": `
          return [{
            json: {
              email: $json.customer.email,
              first_name: $json.customer.first_name,
              last_name: $json.customer.last_name,
              phone: $json.customer.phone,
              accepts_marketing: $json.customer.accepts_marketing,
              total_spent: $json.customer.total_spent,
              orders_count: $json.customer.orders_count
            }
          }];
        `
      }
    },
    {
      "name": "Create Klaviyo Profile",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://a.klaviyo.com/api/profiles/",
        "method": "POST",
        "authentication": "headerAuth",
        "headerParameters": {
          "parameters": [
            {
              "name": "Authorization",
              "value": "Klaviyo-API-Key {{$credentials.apiKey}}"
            }
          ]
        },
        "body": {
          "data": {
            "type": "profile",
            "attributes": {
              "email": "={{$json.email}}",
              "first_name": "={{$json.first_name}}",
              "last_name": "={{$json.last_name}}",
              "properties": {
                "source": "shopify",
                "total_spent": "={{$json.total_spent}}"
              }
            }
          }
        }
      }
    },
    {
      "name": "Add to Welcome List",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://a.klaviyo.com/api/lists/{{$env.KLAVIYO_WELCOME_LIST_ID}}/relationships/profiles/",
        "method": "POST",
        "body": {
          "data": [{
            "type": "profile",
            "id": "={{$json.profile_id}}"
          }]
        }
      }
    }
  ]
}
```

#### Post-Purchase Follow-Up Campaign
```json
{
  "name": "Post-Purchase Email Sequence",
  "nodes": [
    {
      "name": "Order Webhook",
      "type": "n8n-nodes-base.webhook",
      "parameters": {
        "path": "order-placed"
      }
    },
    {
      "name": "Track Purchase Event",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://a.klaviyo.com/api/events/",
        "method": "POST",
        "body": {
          "data": {
            "type": "event",
            "attributes": {
              "metric": {
                "data": {
                  "type": "metric",
                  "attributes": { "name": "Placed Order" }
                }
              },
              "profile": {
                "data": {
                  "type": "profile",
                  "attributes": { "email": "={{$json.customer.email}}" }
                }
              },
              "properties": {
                "order_id": "={{$json.order_id}}",
                "total": "={{$json.total_price}}",
                "items": "={{$json.line_items}}"
              }
            }
          }
        }
      }
    },
    {
      "name": "Wait 3 Days",
      "type": "n8n-nodes-base.wait",
      "parameters": {
        "amount": 3,
        "unit": "days"
      }
    },
    {
      "name": "Send Review Request Email",
      "type": "n8n-nodes-base.httpRequest",
      "parameters": {
        "url": "https://a.klaviyo.com/api/campaigns/",
        "method": "POST",
        "body": {
          "template_id": "REVIEW_REQUEST_TEMPLATE",
          "recipients": [{
            "email": "={{$json.customer.email}}"
          }],
          "context": {
            "order_id": "={{$json.order_id}}",
            "products": "={{$json.line_items}}"
          }
        }
      }
    }
  ]
}
```

### Advanced Personalization

#### Dynamic Product Recommendations
```html
<!-- In Klaviyo email template -->
{% if person|lookup:'favorite_category' %}
  <h2>Recommended for You</h2>
  {% for product in event.RecommendedProducts %}
    <div class="product">
      <img src="{{ product.ImageURL }}" alt="{{ product.Name }}">
      <h3>{{ product.Name }}</h3>
      <p>${{ product.Price }}</p>
      <a href="{{ product.URL }}">Shop Now</a>
    </div>
  {% endfor %}
{% endif %}
```

#### Conditional Content
```html
{% if person.total_spent > 500 %}
  <p>As a VIP customer, enjoy 25% off your next order!</p>
  <code>VIP25</code>
{% elif person.total_spent > 200 %}
  <p>You're almost a VIP! Here's 15% off</p>
  <code>LOYAL15</code>
{% else %}
  <p>Welcome! Here's 10% off your first order</p>
  <code>WELCOME10</code>
{% endif %}
```

### Analytics & Reporting

#### Track Campaign Performance
```typescript
const metrics = await klaviyoAPI.get('/metrics/', {
  params: {
    filter: 'equals(name,"Opened Email")',
    page_size: 100
  }
})

// Get campaign stats
const campaign = await klaviyoAPI.get(`/campaigns/${campaignId}/`, {
  params: {
    include: 'campaign-messages'
  }
})

const stats = {
  sent: campaign.data.attributes.send_count,
  opens: campaign.data.attributes.unique_opens,
  clicks: campaign.data.attributes.unique_clicks,
  open_rate: (campaign.data.attributes.unique_opens / campaign.data.attributes.send_count * 100).toFixed(2),
  click_rate: (campaign.data.attributes.unique_clicks / campaign.data.attributes.send_count * 100).toFixed(2)
}
```

### Best Practices

#### Email Deliverability
- Verify sender domain (SPF, DKIM, DMARC)
- Clean list regularly (remove unengaged)
- Double opt-in for new subscribers
- Segment by engagement level
- A/B test subject lines
- Monitor spam complaints

#### Automation Strategy
- Welcome series (3-5 emails)
- Abandoned cart (2-3 emails)
- Post-purchase follow-up
- Re-engagement campaigns
- Birthday/anniversary emails
- Winback inactive customers

#### Segmentation Examples
- **VIP Customers**: `total_spent > $1000`
- **Engaged Users**: `opened_email in last 30 days`
- **Cart Abandoners**: `started_checkout AND NOT placed_order`
- **Product Interest**: `viewed_product:category = "Electronics"`
- **Repeat Buyers**: `order_count >= 3`

## Integration Patterns

### Shopify + Klaviyo + n8n
```json
{
  "name": "Complete E-commerce Email Automation",
  "triggers": [
    "New customer → Welcome series",
    "Product viewed → Browse abandonment",
    "Cart abandoned → Recovery sequence",
    "Order placed → Thank you + upsell",
    "Order shipped → Tracking info",
    "Order delivered → Review request"
  ]
}
```

### Supabase + Klaviyo
```typescript
// Sync user events from Supabase to Klaviyo
supabase
  .channel('user_events')
  .on('postgres_changes', {
    event: 'INSERT',
    schema: 'public',
    table: 'user_events'
  }, async (payload) => {
    await klaviyoAPI.post('/events/', {
      data: {
        type: 'event',
        attributes: {
          profile: { email: payload.new.email },
          metric: { name: payload.new.event_name },
          properties: payload.new.properties
        }
      }
    })
  })
  .subscribe()
```

## Deliverables

- ✅ Klaviyo account setup and configuration
- ✅ List and segment creation
- ✅ Email flow automation
- ✅ Template design and personalization
- ✅ Event tracking implementation
- ✅ n8n workflow integration
- ✅ Analytics and reporting
- ✅ A/B testing setup

## Activation

Activates for:
- Klaviyo account configuration
- Email flow creation
- List and segment management
- Event tracking setup
- n8n workflow integration
- Campaign creation
- Personalization implementation
- Performance analytics

Provides production-ready Klaviyo email automation with best practices.
