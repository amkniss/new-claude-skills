---
name: "Web Scraping Specialist"
description: "Expert web scraping engineer specializing in Playwright, Beautiful Soup, and Apify. Builds ethical, robust scrapers that respect robots.txt and rate limits. Perfect for market research, lead generation, competitor analysis, and data collection with proper error handling and anti-detection."
version: "1.0.0"
dependencies: ""
---

# Web Scraping Specialist

Elite web scraping engineer who builds production-ready, ethical web scrapers using Playwright, Beautiful Soup, and Apify Actors.

## Core Expertise

### 1. Playwright (JavaScript/TypeScript)
**Best for**: Modern web apps with JavaScript, SPAs, dynamic content

**Capabilities**:
- Headless browser automation
- Handle JavaScript rendering
- Interact with dynamic elements
- Screenshot/PDF generation
- Network request interception
- Cookie management
- Multi-browser support (Chromium, Firefox, WebKit)

**Example Use Cases**:
- Job boards (LinkedIn, Indeed, Upwork)
- Social media (Twitter,Instagram, Reddit)
- E-commerce sites (Shopify, Amazon)
- SaaS dashboards
- Dynamic pricing data

### 2. Beautiful Soup (Python)
**Best for**: Static HTML sites, simple scraping, data parsing

**Capabilities**:
- HTML/XML parsing
- CSS selectors
- Tree navigation
- Content extraction
- Fast and lightweight
- Works with requests library

**Example Use Cases**:
- Blog content
- Static listings
- News articles
- Documentation
- Simple product pages

### 3. Apify Platform
**Best for**: Managed scraping, pre-built actors, scale operations

**Capabilities**:
- Pre-built scrapers (Instagram, Google Maps, LinkedIn)
- Managed infrastructure
- Proxy rotation
- CAPTCHA solving
- Data storage
- Scheduled runs
- API access

**Example Use Cases**:
- Google Search results
- Google Maps businesses
- Instagram profiles
- LinkedIn jobs/profiles
- Website crawling
- Store scraping

## Ethical Scraping Principles

### 1. Respect robots.txt
**Always check**: `https://example.com/robots.txt`

**Follow directives**:
```
User-agent: *
Disallow: /private/
Disallow: /admin/
Crawl-delay: 10
```

**Implementation**:
```python
from urllib.robotparser import RobotFileParser

rp = RobotFileParser()
rp.set_url("https://example.com/robots.txt")
rp.read()

if rp.can_fetch("*", "https://example.com/page"):
    # OK to scrape
    pass
```

### 2. Rate Limiting
**Best practices**:
- Wait 1-2 seconds between requests
- Use exponential backoff on errors
- Implement request queues
- Respect Crawl-delay directive

**Implementation**:
```javascript
// Playwright
await page.goto(url);
await page.waitForTimeout(2000); // 2 second delay

// With retry logic
async function scrapeWithRetry(url, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    try {
      await page.goto(url);
      return await page.content();
    } catch (error) {
      const delay = Math.pow(2, i) * 1000; // Exponential backoff
      await page.waitForTimeout(delay);
    }
  }
  throw new Error(`Failed after ${maxRetries} retries`);
}
```

### 3. User-Agent Headers
**Always set**:
```javascript
const browser = await chromium.launch({
  headless: true,
});
const context = await browser.newContext({
  userAgent: 'Mozilla/5.0 (compatible; YourBot/1.0; +https://yourdomain.com/bot)',
});
```

### 4. Terms of Service
**Check**:
- Website Terms of Service
- API Terms (if applicable)
- Data usage restrictions
- Commercial use allowance

**Avoid**:
- Scraping private/authenticated data without permission
- Bypassing paywalls
- Scraping copyrighted content for redistribution
- Overloading servers

## Playwright Mastery

### Basic Setup

```javascript
const { chromium } = require('playwright');

async function scrape(url) {
  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (compatible; Bot/1.0)',
  });
  const page = await context.newPage();

  try {
    await page.goto(url, { waitUntil: 'networkidle' });
    const data = await page.evaluate(() => {
      // Extract data here
      return {
        title: document.title,
        content: document.body.innerText,
      };
    });
    return data;
  } finally {
    await browser.close();
  }
}
```

### Advanced Techniques

#### 1. Wait for Dynamic Content
```javascript
// Wait for specific element
await page.waitForSelector('.product-list');

// Wait for network to be idle
await page.goto(url, { waitUntil: 'networkidle' });

// Wait for custom condition
await page.waitForFunction(() => {
  return document.querySelectorAll('.item').length > 10;
});
```

#### 2. Handle Infinite Scroll
```javascript
async function scrollToBottom(page) {
  let previousHeight = 0;
  let currentHeight = await page.evaluate('document.body.scrollHeight');

  while (previousHeight !== currentHeight) {
    previousHeight = currentHeight;
    await page.evaluate('window.scrollTo(0, document.body.scrollHeight)');
    await page.waitForTimeout(2000);
    currentHeight = await page.evaluate('document.body.scrollHeight');
  }
}
```

#### 3. Extract Pagination
```javascript
async function scrapeAllPages(baseUrl) {
  const allData = [];
  let pageNum = 1;
  let hasNextPage = true;

  while (hasNextPage) {
    const url = `${baseUrl}?page=${pageNum}`;
    await page.goto(url);

    const data = await page.evaluate(() => {
      return Array.from(document.querySelectorAll('.item')).map(el => ({
        title: el.querySelector('.title')?.textContent,
        price: el.querySelector('.price')?.textContent,
      }));
    });

    allData.push(...data);

    // Check if next page exists
    hasNextPage = await page.locator('a.next-page').count() > 0;
    pageNum++;
  }

  return allData;
}
```

#### 4. Handle Authentication
```javascript
async function loginAndScrape(page, username, password) {
  await page.goto('https://example.com/login');
  await page.fill('input[name="username"]', username);
  await page.fill('input[name="password"]', password);
  await page.click('button[type="submit"]');
  await page.waitForNavigation();

  // Now scrape authenticated pages
  await page.goto('https://example.com/dashboard');
  const data = await page.evaluate(() => {
    return document.body.innerText;
  });

  return data;
}
```

### Anti-Detection Techniques

#### 1. Stealth Mode
```javascript
const { chromium } = require('playwright-extra');
const StealthPlugin = require('puppeteer-extra-plugin-stealth');

chromium.use(StealthPlugin());

const browser = await chromium.launch({ headless: true });
```

#### 2. Random User-Agents
```javascript
const userAgents = [
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64)...',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)...',
  'Mozilla/5.0 (X11; Linux x86_64)...',
];

const randomUA = userAgents[Math.floor(Math.random() * userAgents.length)];
const context = await browser.newContext({ userAgent: randomUA });
```

#### 3. Proxy Rotation
```javascript
const proxies = [
  'http://proxy1.example.com:8080',
  'http://proxy2.example.com:8080',
];

const proxy = proxies[Math.floor(Math.random() * proxies.length)];
const context = await browser.newContext({
  proxy: { server: proxy },
});
```

## Apify Integration

### Using Apify Actors

#### 1. Google Search Scraper
```javascript
const { ApifyClient } = require('apify-client');

const client = new ApifyClient({
  token: process.env.APIFY_API_KEY,
});

const input = {
  queries: 'automation consultant remote',
  maxPagesPerQuery: 2,
  resultsPerPage: 100,
};

const run = await client.actor('apify/google-search-scraper').call(input);
const { items } = await client.dataset(run.defaultDatasetId).listItems();

console.log(items);
```

#### 2. LinkedIn Jobs Scraper
```javascript
const input = {
  searches: [
    {
      keywords: 'zapier expert',
      location: 'United States',
      datePosted: 'week',
    },
  ],
  maxResults: 50,
};

const run = await client.actor('apify/linkedin-jobs-scraper').call(input);
const { items } = await client.dataset(run.defaultDatasetId).listItems();
```

#### 3. Instagram Profile Scraper
```javascript
const input = {
  usernames: ['competitor1', 'competitor2'],
  resultsLimit: 100,
  includeRecentPosts: true,
};

const run = await client.actor('apify/instagram-profile-scraper').call(input);
const { items } = await client.dataset(run.defaultDatasetId).listItems();
```

### Cost Optimization

**Apify Credits**:
- 1 credit = $1
- Most actors cost $0.10-$2 per run
- Set max runtime to control costs
- Use `resultsLimit` to cap results

**Example**:
```javascript
const input = {
  queries: 'automation services',
  maxPagesPerQuery: 1, // Limit pages
  resultsPerPage: 50,   // Limit results
  maxRequestRetries: 1, // Limit retries
};
```

## Data Storage & Deduplication

### 1. In-Memory (Small datasets)
```javascript
const seenUrls = new Set();
const results = [];

function addResult(item) {
  if (!seenUrls.has(item.url)) {
    seenUrls.add(item.url);
    results.push(item);
  }
}
```

### 2. File System (Medium datasets)
```javascript
const fs = require('fs');

function saveResults(data, filename) {
  const existing = fs.existsSync(filename)
    ? JSON.parse(fs.readFileSync(filename, 'utf8'))
    : [];

  const merged = [...existing, ...data];
  const deduped = Array.from(
    new Map(merged.map(item => [item.url, item])).values()
  );

  fs.writeFileSync(filename, JSON.stringify(deduped, null, 2));
}
```

### 3. Database (Large datasets)
```javascript
// Supabase
const { createClient } = require('@supabase/supabase-js');
const supabase = createClient(url, key);

async function saveToSupabase(data) {
  const { data: inserted, error } = await supabase
    .from('scraped_data')
    .upsert(data, { onConflict: 'url' }); // Dedupe by URL

  if (error) console.error(error);
  return inserted;
}
```

## Error Handling

### Robust Error Handling
```javascript
async function scrapeWithErrorHandling(url) {
  let browser;
  try {
    browser = await chromium.launch();
    const page = await browser.newPage();

    // Set timeout
    page.setDefaultTimeout(30000);

    // Handle navigation errors
    await page.goto(url, { waitUntil: 'networkidle' })
      .catch(err => {
        console.error(`Navigation failed: ${err.message}`);
        throw err;
      });

    // Extract data
    const data = await page.evaluate(() => {
      return {
        title: document.title,
        content: document.body.innerText,
      };
    });

    return data;

  } catch (error) {
    console.error(`Scraping failed for ${url}:`, error);

    // Log error details
    await logError({
      url,
      error: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString(),
    });

    // Return null or default value
    return null;

  } finally {
    if (browser) {
      await browser.close();
    }
  }
}
```

### Retry Logic
```javascript
async function scrapeWithRetry(url, maxRetries = 3) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await scrape(url);
    } catch (error) {
      console.log(`Attempt ${attempt} failed: ${error.message}`);

      if (attempt === maxRetries) {
        throw error;
      }

      // Exponential backoff
      const delay = Math.pow(2, attempt) * 1000;
      console.log(`Retrying in ${delay}ms...`);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
}
```

## Common Scraping Patterns

### Pattern 1: Job Board Scraping
**Target**: Indeed, LinkedIn, Upwork

**Strategy**:
1. Search by keywords
2. Extract job postings
3. Get company information
4. Extract contact details (if available)
5. Score by relevance

**Implementation**:
```javascript
async function scrapeJobs(keywords) {
  const url = `https://www.indeed.com/jobs?q=${encodeURIComponent(keywords)}`;
  await page.goto(url);

  const jobs = await page.evaluate(() => {
    return Array.from(document.querySelectorAll('.job_seen_beacon')).map(el => ({
      title: el.querySelector('.jobTitle')?.textContent,
      company: el.querySelector('.companyName')?.textContent,
      location: el.querySelector('.companyLocation')?.textContent,
      description: el.querySelector('.job-snippet')?.textContent,
      url: el.querySelector('a')?.href,
    }));
  });

  return jobs;
}
```

### Pattern 2: E-commerce Product Scraping
**Target**: Amazon, Shopify stores

**Strategy**:
1. Navigate to category or search
2. Extract product listings
3. Get pricing and availability
4. Collect reviews
5. Monitor changes

**Implementation**:
```javascript
async function scrapeProducts(categoryUrl) {
  await page.goto(categoryUrl);

  const products = await page.evaluate(() => {
    return Array.from(document.querySelectorAll('.product-item')).map(el => ({
      name: el.querySelector('.product-name')?.textContent,
      price: el.querySelector('.price')?.textContent,
      rating: el.querySelector('.rating')?.textContent,
      inStock: !el.querySelector('.out-of-stock'),
      url: el.querySelector('a')?.href,
      image: el.querySelector('img')?.src,
    }));
  });

  return products;
}
```

### Pattern 3: Social Media Monitoring
**Target**: Twitter, Reddit, LinkedIn

**Strategy**:
1. Search by keywords/hashtags
2. Extract posts and engagement
3. Get user profiles
4. Analyze sentiment
5. Identify leads

**Implementation**:
```javascript
async function scrapeReddit(subreddit, query) {
  const url = `https://www.reddit.com/r/${subreddit}/search/?q=${encodeURIComponent(query)}`;
  await page.goto(url);

  const posts = await page.evaluate(() => {
    return Array.from(document.querySelectorAll('[data-testid="post-container"]')).map(el => ({
      title: el.querySelector('h3')?.textContent,
      author: el.querySelector('[data-testid="post_author_link"]')?.textContent,
      subreddit: el.querySelector('[data-click-id="subreddit"]')?.textContent,
      score: el.querySelector('[data-click-id="upvote"]')?.textContent,
      url: el.querySelector('a[data-click-id="body"]')?.href,
      timestamp: el.querySelector('time')?.getAttribute('datetime'),
    }));
  });

  return posts;
}
```

## Monitoring & Logging

### 1. Progress Logging
```javascript
console.log(`[${new Date().toISOString()}] Starting scrape for ${url}`);
console.log(`[${new Date().toISOString()}] Extracted ${items.length} items`);
console.log(`[${new Date().toISOString()}] Scrape completed`);
```

### 2. Error Tracking
```javascript
async function logError(error) {
  const log = {
    timestamp: new Date().toISOString(),
    url: error.url,
    message: error.message,
    stack: error.stack,
  };

  // Save to file
  fs.appendFileSync('errors.log', JSON.stringify(log) + '\n');

  // Or send to monitoring service
  await sendToSlack(`Scraper error: ${error.message}`);
}
```

### 3. Performance Metrics
```javascript
const startTime = Date.now();
const result = await scrape(url);
const duration = Date.now() - startTime;

console.log(`Scraped ${result.length} items in ${duration}ms`);
console.log(`Average: ${duration / result.length}ms per item`);
```

## Testing Scrapers

### 1. Unit Tests
```javascript
const { test, expect } = require('@jest/globals');

test('extractTitle should return page title', async () => {
  const html = '<html><head><title>Test Page</title></head></html>';
  const title = extractTitle(html);
  expect(title).toBe('Test Page');
});
```

### 2. Integration Tests
```javascript
test('scrape should return data', async () => {
  const data = await scrape('https://example.com');
  expect(data).toBeDefined();
  expect(data.title).toBeTruthy();
});
```

### 3. Smoke Tests
```javascript
// Quick test on small sample
const sampleUrls = ['https://example.com/1', 'https://example.com/2'];
for (const url of sampleUrls) {
  const result = await scrape(url);
  console.log(`${url}: ${result ? 'OK' : 'FAIL'}`);
}
```

## Best Practices

1. **Always check robots.txt** before scraping
2. **Implement rate limiting** (1-2 seconds between requests)
3. **Use proper User-Agent** headers
4. **Handle errors gracefully** with retries
5. **Deduplicate data** to avoid duplicates
6. **Save progress regularly** to avoid data loss
7. **Monitor scraper health** with logging
8. **Test on small samples** before full runs
9. **Respect ToS** and legal boundaries
10. **Use managed services** (Apify) when possible

## Common Issues & Solutions

### Issue: CAPTCHA Blocking
**Solution**:
- Use Apify (has CAPTCHA solving)
- Slow down requests
- Use residential proxies
- Add random delays

### Issue: Dynamic Content Not Loading
**Solution**:
- Use Playwright instead of requests
- Wait for specific elements
- Check network tab for AJAX calls
- Increase timeout

### Issue: IP Getting Banned
**Solution**:
- Implement rate limiting
- Use proxy rotation
- Add random delays
- Rotate User-Agents

### Issue: Data Inconsistent
**Solution**:
- Validate data structure
- Add fallback selectors
- Handle missing fields gracefully
- Log parsing errors

## Integration with Other Tools

### n8n Workflow
```json
{
  "nodes": [
    {
      "name": "Playwright Scraper",
      "type": "n8n-nodes-base.executeCommand",
      "parameters": {
        "command": "node scraper.js"
      }
    },
    {
      "name": "Filter Data",
      "type": "n8n-nodes-base.filter"
    },
    {
      "name": "Save to Supabase",
      "type": "n8n-nodes-base.supabase"
    }
  ]
}
```

### Claude AI Filtering
```javascript
async function filterWithClaude(items) {
  const prompt = `Analyze these scraped items and filter out spam/irrelevant content:\n${JSON.stringify(items)}`;

  const response = await anthropic.messages.create({
    model: 'claude-3-5-sonnet-20241022',
    messages: [{ role: 'user', content: prompt }],
  });

  return JSON.parse(response.content[0].text);
}
```

---

**Remember**: Web scraping is powerful but must be done ethically and legally. Always respect website terms, rate limits, and data privacy.
