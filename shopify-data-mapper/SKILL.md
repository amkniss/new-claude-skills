---
name: "Shopify Data Mapper & Upload Specialist"
description: "Expert data mapping specialist for Shopify bulk uploads. Maps mismatched columns from any source (CSV, scraper, API) to Shopify's exact format for products, variants, blog posts, and more. Handles data transformation, validation, image URLs, SEO fields, and ensures clean uploads even without API connections."
version: "1.0.0"
dependencies: ""
---

# Shopify Data Mapper & Upload Specialist

Expert in transforming messy data into perfectly formatted Shopify bulk upload files for products, blog posts, collections, and more.

## Core Purpose

Take data from ANY source (scraped data, competitor exports, suppliers, spreadsheets) and map it to Shopify's exact CSV format requirements, even when column names don't match.

## Shopify Upload Methods

### Method 1: CSV Bulk Upload (No API Needed)
**Best for**: Initial imports, large datasets, no developer setup

**Steps**:
1. Map data to Shopify CSV format
2. Validate all required fields
3. Upload via Shopify Admin → Products → Import
4. Review and publish

### Method 2: Shopify API
**Best for**: Ongoing sync, automation, programmatic updates

**Requires**: Custom app with API credentials

### Method 3: Shopify Apps (e.g., Matrixify)
**Best for**: Complex imports, ongoing automation

**Paid apps** with advanced mapping features

## Shopify Product CSV Format

### Required Columns

```csv
Handle,Title,Body (HTML),Vendor,Type,Tags,Published,Option1 Name,Option1 Value,Variant SKU,Variant Grams,Variant Inventory Tracker,Variant Inventory Qty,Variant Inventory Policy,Variant Fulfillment Service,Variant Price,Variant Compare At Price,Variant Requires Shipping,Variant Taxable,Variant Barcode,Image Src,Image Position,Image Alt Text,Gift Card,SEO Title,SEO Description,Google Shopping / Google Product Category,Google Shopping / Gender,Google Shopping / Age Group,Google Shopping / MPN,Google Shopping / AdWords Grouping,Google Shopping / AdWords Labels,Google Shopping / Condition,Google Shopping / Custom Product,Google Shopping / Custom Label 0,Google Shopping / Custom Label 1,Google Shopping / Custom Label 2,Google Shopping / Custom Label 3,Google Shopping / Custom Label 4,Variant Image,Variant Weight Unit,Variant Tax Code,Cost per item,Status
```

### Minimal Working Example

```csv
Handle,Title,Body (HTML),Vendor,Published,Option1 Name,Option1 Value,Variant Price,Variant Inventory Qty,Status
blue-widget,Blue Widget,"<p>Great product!</p>",My Store,TRUE,Title,Default Title,29.99,100,active
```

### Field Descriptions

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| `Handle` | Yes | URL-safe unique ID | `blue-widget-large` |
| `Title` | Yes | Product name | `Blue Widget - Large` |
| `Body (HTML)` | No | Description (HTML allowed) | `<p>Amazing widget</p>` |
| `Vendor` | No | Brand/manufacturer | `ACME Corp` |
| `Type` | No | Product category | `Widgets` |
| `Tags` | No | Comma-separated | `blue, widget, best-seller` |
| `Published` | No | TRUE/FALSE | `TRUE` |
| `Option1 Name` | If variants | Size, Color, etc. | `Size` |
| `Option1 Value` | If variants | Small, Medium, Large | `Large` |
| `Variant Price` | Yes | Price in dollars | `29.99` |
| `Variant Compare At Price` | No | Original price (for sale) | `39.99` |
| `Variant SKU` | No | Stock keeping unit | `BW-LG-001` |
| `Variant Inventory Qty` | No | Stock quantity | `100` |
| `Image Src` | No | Full image URL | `https://cdn.example.com/img.jpg` |
| `SEO Title` | No | Meta title | `Buy Blue Widget - Large` |
| `SEO Description` | No | Meta description | `Best widget on the market` |
| `Status` | No | active/draft/archived | `active` |

## Product Upload Examples

### Example 1: Simple Product (No Variants)

**Source Data (from scraper):**
```json
{
  "name": "Organic Face Cream",
  "description": "Natural ingredients, vegan, cruelty-free",
  "price": 34.99,
  "compare_price": 49.99,
  "sku": "OFC-001",
  "stock": 50,
  "image_url": "https://example.com/cream.jpg",
  "brand": "Nature Co"
}
```

**Mapped to Shopify CSV:**
```csv
Handle,Title,Body (HTML),Vendor,Published,Option1 Name,Option1 Value,Variant Price,Variant Compare At Price,Variant SKU,Variant Inventory Qty,Image Src,Status
organic-face-cream,Organic Face Cream,"<p>Natural ingredients, vegan, cruelty-free</p>",Nature Co,TRUE,Title,Default Title,34.99,49.99,OFC-001,50,https://example.com/cream.jpg,active
```

### Example 2: Product with Variants (Size)

**Source Data:**
```json
[
  {"name": "Blue T-Shirt", "size": "Small", "price": 19.99, "sku": "BTS-S", "stock": 20},
  {"name": "Blue T-Shirt", "size": "Medium", "price": 19.99, "sku": "BTS-M", "stock": 30},
  {"name": "Blue T-Shirt", "size": "Large", "price": 19.99, "sku": "BTS-L", "stock": 25}
]
```

**Mapped to Shopify CSV:**
```csv
Handle,Title,Body (HTML),Vendor,Published,Option1 Name,Option1 Value,Variant Price,Variant SKU,Variant Inventory Qty,Status
blue-t-shirt,Blue T-Shirt,"<p>Comfortable cotton t-shirt</p>",My Store,TRUE,Size,Small,19.99,BTS-S,20,active
blue-t-shirt,Blue T-Shirt,"",,,Size,Medium,19.99,BTS-M,30,
blue-t-shirt,Blue T-Shirt,"",,,Size,Large,19.99,BTS-L,25,
```

**Key Rules for Variants:**
- First row has full product details
- Subsequent rows for same product have SAME handle, leave other fields empty
- Each variant row specifies Option1 Value (size)

### Example 3: Product with Multiple Variant Options (Size + Color)

**Source Data:**
```json
[
  {"name": "T-Shirt", "size": "Small", "color": "Blue", "price": 19.99, "sku": "TS-S-BLU"},
  {"name": "T-Shirt", "size": "Small", "color": "Red", "price": 19.99, "sku": "TS-S-RED"},
  {"name": "T-Shirt", "size": "Large", "color": "Blue", "price": 19.99, "sku": "TS-L-BLU"},
  {"name": "T-Shirt", "size": "Large", "color": "Red", "price": 19.99, "sku": "TS-L-RED"}
]
```

**Mapped to Shopify CSV:**
```csv
Handle,Title,Option1 Name,Option1 Value,Option2 Name,Option2 Value,Variant Price,Variant SKU,Status
t-shirt,T-Shirt,Size,Small,Color,Blue,19.99,TS-S-BLU,active
t-shirt,T-Shirt,Size,Small,Color,Red,19.99,TS-S-RED,
t-shirt,T-Shirt,Size,Large,Color,Blue,19.99,TS-L-BLU,
t-shirt,T-Shirt,Size,Large,Color,Red,19.99,TS-L-RED,
```

## Common Data Mapping Scenarios

### Scenario 1: Mismatched Column Names

**Your Data:**
```csv
product_name,product_desc,cost,inventory_count,image_link
Blue Widget,Great product,29.99,100,https://example.com/img.jpg
```

**Mapping Rules:**
```javascript
const mapping = {
  'product_name': 'Title',
  'product_desc': 'Body (HTML)',
  'cost': 'Variant Price',
  'inventory_count': 'Variant Inventory Qty',
  'image_link': 'Image Src'
};
```

**Transformation Script:**
```javascript
function mapToShopify(sourceData) {
  return sourceData.map(row => ({
    'Handle': row.product_name.toLowerCase().replace(/\s+/g, '-'),
    'Title': row.product_name,
    'Body (HTML)': `<p>${row.product_desc}</p>`,
    'Vendor': 'My Store',
    'Published': 'TRUE',
    'Option1 Name': 'Title',
    'Option1 Value': 'Default Title',
    'Variant Price': row.cost,
    'Variant Inventory Qty': row.inventory_count,
    'Image Src': row.image_link,
    'Status': 'active'
  }));
}
```

### Scenario 2: HTML in Descriptions

**Source (plain text):**
```
Great product! Features:
- Feature 1
- Feature 2
- Feature 3
```

**Transform to HTML:**
```javascript
function textToHTML(text) {
  // Convert newlines to <br>
  text = text.replace(/\n/g, '<br>');

  // Convert bullet points
  text = text.replace(/^- (.+)$/gm, '<li>$1</li>');

  // Wrap lists in <ul>
  if (text.includes('<li>')) {
    text = text.replace(/(<li>.*<\/li>)/s, '<ul>$1</ul>');
  }

  // Wrap in <p>
  return `<p>${text}</p>`;
}
```

**Result:**
```html
<p>Great product! Features:<br><ul><li>Feature 1</li><li>Feature 2</li><li>Feature 3</li></ul></p>
```

### Scenario 3: Price Formatting

**Common Issues:**
- Dollar signs: `$29.99` → `29.99`
- Commas: `1,234.56` → `1234.56`
- Cents missing: `30` → `30.00`

**Cleaning Script:**
```javascript
function cleanPrice(price) {
  // Remove currency symbols and commas
  price = String(price).replace(/[$,]/g, '');

  // Parse as float
  price = parseFloat(price);

  // Ensure 2 decimal places
  return price.toFixed(2);
}

// Examples
cleanPrice('$29.99');    // "29.99"
cleanPrice('1,234');     // "1234.00"
cleanPrice('30');        // "30.00"
```

## Shopify Blog Post CSV Format

### Required Columns

```csv
Title,Body (HTML),Author,Tags,Published At,Metafield: title_tag [string],Metafield: description_tag [string]
```

### Blog Post Example

**Source Data:**
```json
{
  "title": "10 Tips for Better Skin",
  "content": "Here are 10 tips...",
  "author": "Amy",
  "category": "skincare",
  "published_date": "2024-10-29"
}
```

**Mapped to Shopify CSV:**
```csv
Title,Body (HTML),Author,Tags,Published At,Metafield: title_tag [string],Metafield: description_tag [string]
10 Tips for Better Skin,"<h2>Introduction</h2><p>Here are 10 tips...</p>",Amy,skincare,2024-10-29 09:00:00,10 Tips for Better Skin - Skincare Guide,Learn the best skincare tips from experts
```

### Blog Post Field Descriptions

| Field | Required | Description |
|-------|----------|-------------|
| `Title` | Yes | Post title |
| `Body (HTML)` | Yes | Full HTML content |
| `Author` | No | Author name |
| `Tags` | No | Comma-separated |
| `Published At` | No | YYYY-MM-DD HH:MM:SS |
| `Metafield: title_tag` | No | SEO title |
| `Metafield: description_tag` | No | SEO description |

## Data Validation Checks

### Before Upload Checklist

```javascript
function validateShopifyData(products) {
  const errors = [];

  products.forEach((product, index) => {
    const row = index + 1;

    // Required fields
    if (!product.Handle) {
      errors.push(`Row ${row}: Missing Handle`);
    }
    if (!product.Title) {
      errors.push(`Row ${row}: Missing Title`);
    }
    if (!product['Variant Price']) {
      errors.push(`Row ${row}: Missing Variant Price`);
    }

    // Handle format (lowercase, hyphens only)
    if (product.Handle && !/^[a-z0-9-]+$/.test(product.Handle)) {
      errors.push(`Row ${row}: Invalid Handle format (use lowercase and hyphens only)`);
    }

    // Price format
    if (product['Variant Price'] && isNaN(parseFloat(product['Variant Price']))) {
      errors.push(`Row ${row}: Invalid price format`);
    }

    // Image URL
    if (product['Image Src'] && !product['Image Src'].startsWith('http')) {
      errors.push(`Row ${row}: Invalid image URL`);
    }

    // Published field
    if (product.Published && !['TRUE', 'FALSE'].includes(product.Published)) {
      errors.push(`Row ${row}: Published must be TRUE or FALSE`);
    }
  });

  return errors;
}
```

## Common Mapping Patterns

### Pattern 1: Scraped Data → Shopify

**Typical scraper output:**
```javascript
{
  "product": {
    "name": "Blue Widget",
    "details": "Great product with features",
    "pricing": {
      "current": 29.99,
      "original": 39.99
    },
    "availability": {
      "in_stock": true,
      "quantity": 100
    },
    "media": {
      "images": ["https://example.com/1.jpg", "https://example.com/2.jpg"]
    },
    "metadata": {
      "sku": "BW001",
      "brand": "ACME"
    }
  }
}
```

**Transformation:**
```javascript
function scraperToShopify(scraped) {
  const product = scraped.product;

  return {
    'Handle': product.name.toLowerCase().replace(/\s+/g, '-'),
    'Title': product.name,
    'Body (HTML)': `<p>${product.details}</p>`,
    'Vendor': product.metadata.brand,
    'Published': product.availability.in_stock ? 'TRUE' : 'FALSE',
    'Option1 Name': 'Title',
    'Option1 Value': 'Default Title',
    'Variant Price': product.pricing.current.toFixed(2),
    'Variant Compare At Price': product.pricing.original.toFixed(2),
    'Variant SKU': product.metadata.sku,
    'Variant Inventory Qty': product.availability.quantity,
    'Image Src': product.media.images[0],
    'Status': product.availability.in_stock ? 'active' : 'draft'
  };
}
```

### Pattern 2: Supplier CSV → Shopify

**Supplier format:**
```csv
ItemNumber,ItemName,Description,UnitPrice,InStock,ImageURL
12345,Blue Widget,Great product,29.99,Yes,https://supplier.com/img.jpg
```

**Mapping:**
```javascript
function supplierToShopify(supplierData) {
  return supplierData.map(item => ({
    'Handle': item.ItemNumber,
    'Title': item.ItemName,
    'Body (HTML)': `<p>${item.Description}</p>`,
    'Vendor': 'Supplier Name',
    'Published': item.InStock === 'Yes' ? 'TRUE' : 'FALSE',
    'Option1 Name': 'Title',
    'Option1 Value': 'Default Title',
    'Variant Price': item.UnitPrice,
    'Variant SKU': item.ItemNumber,
    'Image Src': item.ImageURL,
    'Status': item.InStock === 'Yes' ? 'active' : 'draft'
  }));
}
```

## Advanced: Handling Multiple Images

Shopify allows multiple images per product. Format:

```csv
Handle,Title,Image Src,Image Position,Image Alt Text
blue-widget,Blue Widget,https://example.com/1.jpg,1,Blue Widget Front View
blue-widget,,https://example.com/2.jpg,2,Blue Widget Side View
blue-widget,,https://example.com/3.jpg,3,Blue Widget Back View
```

**Script to generate multiple image rows:**
```javascript
function generateImageRows(product, images) {
  const rows = [];

  // First row with product details + first image
  rows.push({
    'Handle': product.handle,
    'Title': product.title,
    'Body (HTML)': product.description,
    'Variant Price': product.price,
    'Image Src': images[0],
    'Image Position': 1,
    'Image Alt Text': `${product.title} - Main`,
    'Status': 'active'
  });

  // Additional image rows
  for (let i = 1; i < images.length; i++) {
    rows.push({
      'Handle': product.handle,
      'Image Src': images[i],
      'Image Position': i + 1,
      'Image Alt Text': `${product.title} - Image ${i + 1}`
    });
  }

  return rows;
}
```

## SEO Optimization During Mapping

### Auto-generate SEO Fields

```javascript
function generateSEO(product) {
  // SEO Title (max 60 chars)
  const seoTitle = `${product.title} - Buy Online | Store Name`
    .substring(0, 60);

  // SEO Description (max 160 chars)
  const seoDescription = `${product.description.substring(0, 120)}. Free shipping. Best prices.`
    .substring(0, 160);

  return {
    'SEO Title': seoTitle,
    'SEO Description': seoDescription
  };
}
```

### Generate Optimized Handles

```javascript
function generateHandle(title, sku = null) {
  let handle = title
    .toLowerCase()
    .replace(/[^a-z0-9\s-]/g, '') // Remove special chars
    .replace(/\s+/g, '-')          // Spaces to hyphens
    .replace(/-+/g, '-')           // Multiple hyphens to one
    .substring(0, 50);             // Max 50 chars

  // Append SKU if available (for uniqueness)
  if (sku) {
    handle += `-${sku.toLowerCase()}`;
  }

  return handle;
}

// Examples
generateHandle('Blue Widget (Large)');           // "blue-widget-large"
generateHandle('Best Product Ever!!!', 'BP001'); // "best-product-ever-bp001"
```

## Export to CSV (JavaScript)

```javascript
function exportToCSV(products, filename = 'shopify-products.csv') {
  const headers = [
    'Handle', 'Title', 'Body (HTML)', 'Vendor', 'Type', 'Tags',
    'Published', 'Option1 Name', 'Option1 Value', 'Variant SKU',
    'Variant Price', 'Variant Compare At Price', 'Variant Inventory Qty',
    'Image Src', 'SEO Title', 'SEO Description', 'Status'
  ];

  const csv = [
    headers.join(','),
    ...products.map(p => headers.map(h => {
      const value = p[h] || '';
      // Escape commas and quotes
      return `"${String(value).replace(/"/g, '""')}"`;
    }).join(','))
  ].join('\n');

  // Save to file (Node.js)
  const fs = require('fs');
  fs.writeFileSync(filename, csv);

  console.log(`✅ Exported ${products.length} products to ${filename}`);
}
```

## Python Version

```python
import csv
import re

def map_to_shopify(source_data):
    """Map source data to Shopify format"""
    shopify_products = []

    for item in source_data:
        product = {
            'Handle': generate_handle(item.get('name', '')),
            'Title': item.get('name', ''),
            'Body (HTML)': f"<p>{item.get('description', '')}</p>",
            'Vendor': item.get('brand', 'My Store'),
            'Published': 'TRUE',
            'Option1 Name': 'Title',
            'Option1 Value': 'Default Title',
            'Variant Price': clean_price(item.get('price', 0)),
            'Variant Inventory Qty': item.get('stock', 0),
            'Image Src': item.get('image', ''),
            'Status': 'active'
        }
        shopify_products.append(product)

    return shopify_products

def generate_handle(title):
    """Generate URL-safe handle"""
    handle = title.lower()
    handle = re.sub(r'[^a-z0-9\s-]', '', handle)
    handle = re.sub(r'\s+', '-', handle)
    handle = re.sub(r'-+', '-', handle)
    return handle[:50]

def clean_price(price):
    """Clean price format"""
    price = str(price).replace('$', '').replace(',', '')
    return f"{float(price):.2f}"

def export_to_csv(products, filename='shopify-products.csv'):
    """Export to CSV file"""
    if not products:
        print("No products to export")
        return

    # Get all unique keys across products
    fieldnames = list(products[0].keys())

    with open(filename, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(products)

    print(f"✅ Exported {len(products)} products to {filename}")

# Usage
source_data = [
    {
        'name': 'Blue Widget',
        'description': 'Great product',
        'price': '$29.99',
        'stock': 100,
        'image': 'https://example.com/img.jpg',
        'brand': 'ACME'
    }
]

shopify_data = map_to_shopify(source_data)
export_to_csv(shopify_data)
```

## Troubleshooting Common Issues

### Issue 1: "Handle already exists"
**Solution**: Append SKU or unique ID to handle
```javascript
handle = `${baseHandle}-${sku}`;
```

### Issue 2: Images not loading
**Solutions**:
- Ensure URLs start with `https://`
- Check image is publicly accessible
- Use CDN URLs (not localhost)
- Compress large images (<5MB)

### Issue 3: HTML rendering incorrectly
**Solutions**:
- Escape quotes in CSV: `"<p>Text</p>"`
- Use HTML entities: `&amp;` instead of `&`
- Test HTML in preview before upload

### Issue 4: Variants not grouping
**Solutions**:
- Ensure exact same `Handle` for all variants
- First row must have full product details
- Subsequent rows leave non-variant fields empty

### Issue 5: Inventory not updating
**Solutions**:
- Set `Variant Inventory Tracker` to `shopify`
- Ensure `Variant Inventory Policy` is set
- Check warehouse/location settings in Shopify

## Complete Workflow Example

### Step 1: Source Data (from scraper)
```json
[
  {
    "title": "Organic Face Cream - Hydrating",
    "description": "Natural ingredients. Vegan. Cruelty-free. Suitable for all skin types.",
    "price": "34.99",
    "compare_at": "49.99",
    "sku": "OFC-HYD-50ML",
    "quantity": 50,
    "images": [
      "https://cdn.example.com/cream-front.jpg",
      "https://cdn.example.com/cream-side.jpg"
    ],
    "vendor": "Nature Beauty Co",
    "tags": ["skincare", "vegan", "organic"]
  }
]
```

### Step 2: Transform Script
```javascript
const sourceData = [...]; // From above

const shopifyProducts = sourceData.map(item => ({
  'Handle': generateHandle(item.title),
  'Title': item.title,
  'Body (HTML)': formatDescription(item.description),
  'Vendor': item.vendor,
  'Type': 'Skincare',
  'Tags': item.tags.join(', '),
  'Published': 'TRUE',
  'Option1 Name': 'Title',
  'Option1 Value': 'Default Title',
  'Variant SKU': item.sku,
  'Variant Price': cleanPrice(item.price),
  'Variant Compare At Price': cleanPrice(item.compare_at),
  'Variant Inventory Qty': item.quantity,
  'Image Src': item.images[0],
  'SEO Title': `${item.title} - Buy Online`,
  'SEO Description': item.description.substring(0, 160),
  'Status': 'active'
}));

exportToCSV(shopifyProducts, 'skincare-products.csv');
```

### Step 3: Validate
```javascript
const errors = validateShopifyData(shopifyProducts);
if (errors.length > 0) {
  console.error('Validation errors:', errors);
} else {
  console.log('✅ All products valid!');
}
```

### Step 4: Upload
1. Go to Shopify Admin → Products → Import
2. Upload `skincare-products.csv`
3. Review preview
4. Click "Import"
5. Check for errors
6. Publish products

## Best Practices

1. **Always validate** before uploading
2. **Test with 1-2 products** first
3. **Backup existing data** before bulk updates
4. **Use consistent naming** for handles, tags
5. **Optimize images** before upload (<1MB)
6. **Write clear descriptions** with HTML formatting
7. **Set proper inventory tracking** from the start
8. **Use meaningful SKUs** for inventory management
9. **Add alt text** to all images (for SEO)
10. **Review imported products** before publishing

## Quick Reference

### Shopify Product Import Limits
- Max file size: 15MB
- Max products per import: 50,000
- Max images per product: 250
- Max variants per product: 100

### Key Field Formats
- **Handle**: lowercase, hyphens, no spaces
- **Price**: decimal, no symbols (29.99)
- **Published**: TRUE or FALSE (all caps)
- **Images**: Full HTTPS URL
- **Inventory**: Integer (no decimals)
- **Tags**: Comma-separated

---

**Remember**: Data mapping is about understanding both your source format and Shopify's requirements. When in doubt, export a sample product from Shopify to see the exact format expected!
