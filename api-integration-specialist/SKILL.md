---
name: "API Integration Specialist"
description: "Expert API integration engineer specializing in lead enrichment, data fetching, and external service connections. Master of Apollo.io, Hunter.io, Clearbit, ZoomInfo, LinkedIn API, and more. Handles rate limiting, caching, error handling, and data transformation for seamless integrations."
version: "1.0.0"
dependencies: ""
---

# API Integration Specialist

Elite API integration engineer who connects external services, enriches data, and builds robust API clients with proper error handling, rate limiting, and caching.

## Core Purpose

Transform raw lead data into enriched, actionable information by integrating with best-in-class data providers.

## Supported APIs

### 1. Apollo.io (B2B Data Enrichment)
**Best for**: Company data, contact information, employee data

**Capabilities**:
- Find email addresses
- Get company information
- Search for people
- Get employee count
- Technology stack data
- Revenue estimates

**Pricing**: 50 free credits/month, then $49/month

### 2. Hunter.io (Email Finding & Verification)
**Best for**: Finding and verifying email addresses

**Capabilities**:
- Domain search (find emails at company)
- Email finder (specific person)
- Email verification
- Bulk verification
- Domain search patterns

**Pricing**: 25 free searches/month, then $49/month

### 3. Clearbit (Company Intelligence)
**Best for**: Company enrichment, tech stack, firmographics

**Capabilities**:
- Company enrichment from domain
- Logo API
- Technology detection
- Employee count, revenue
- Social profiles
- Company category

**Pricing**: Free tier available, paid plans from $99/month

### 4. ZoomInfo (Contact & Company Data)
**Best for**: Enterprise B2B data, intent signals

**Capabilities**:
- Contact information
- Company profiles
- Intent data (buying signals)
- Org charts
- Direct dials

**Pricing**: Enterprise pricing (expensive)

### 5. LinkedIn API (Professional Data)
**Best for**: Professional profiles, job postings, company pages

**Capabilities**:
- Profile data
- Company information
- Job postings
- Connection data
- Posts and engagement

**Pricing**: Partner program required

### 6. Google Maps API (Location Data)
**Best for**: Business listings, reviews, locations

**Capabilities**:
- Place search
- Place details (address, phone, website)
- Reviews and ratings
- Photos
- Opening hours

**Pricing**: $200 free credit/month, then pay-as-you-go

### 7. Slack API (Notifications)
**Best for**: Team notifications, alerts, updates

**Capabilities**:
- Send messages
- Create channels
- File uploads
- Interactive messages
- Slash commands

**Pricing**: Free

### 8. Anthropic API (AI Processing)
**Best for**: Content analysis, lead scoring, data extraction

**Capabilities**:
- Text analysis
- Sentiment detection
- Data extraction from unstructured text
- Lead qualification
- Content generation

**Pricing**: Pay-as-you-go (~$3 per million input tokens)

## Apollo.io Integration

### Setup

```javascript
const axios = require('axios');

const apolloClient = axios.create({
  baseURL: 'https://api.apollo.io/v1',
  headers: {
    'X-Api-Key': process.env.APOLLO_API_KEY,
    'Content-Type': 'application/json',
  },
});
```

### Find Email by Person & Company

```javascript
async function findEmail(firstName, lastName, domain) {
  try {
    const response = await apolloClient.post('/people/match', {
      first_name: firstName,
      last_name: lastName,
      organization_name: domain,
    });

    return {
      email: response.data.person.email,
      confidence: response.data.person.email_status,
      jobTitle: response.data.person.title,
      linkedin: response.data.person.linkedin_url,
    };
  } catch (error) {
    console.error('Apollo API error:', error.response?.data);
    return null;
  }
}

// Usage
const contact = await findEmail('John', 'Doe', 'acme.com');
console.log(contact);
```

### Enrich Company Data

```javascript
async function enrichCompany(domain) {
  try {
    const response = await apolloClient.post('/organizations/enrich', {
      domain: domain,
    });

    const company = response.data.organization;

    return {
      name: company.name,
      domain: company.website_url,
      employeeCount: company.estimated_num_employees,
      industry: company.industry,
      revenue: company.annual_revenue,
      techStack: company.technologies,
      founded: company.founded_year,
      location: {
        city: company.city,
        state: company.state,
        country: company.country,
      },
      socialProfiles: {
        linkedin: company.linkedin_url,
        twitter: company.twitter_url,
        facebook: company.facebook_url,
      },
    };
  } catch (error) {
    console.error('Company enrichment failed:', error.response?.data);
    return null;
  }
}

// Usage
const company = await enrichCompany('stripe.com');
console.log(company);
```

### Search for People

```javascript
async function searchPeople(criteria) {
  try {
    const response = await apolloClient.post('/people/search', {
      person_titles: criteria.titles, // ['CEO', 'Founder']
      organization_locations: criteria.locations, // ['United States']
      organization_num_employees_ranges: criteria.companySize, // ['11-50', '51-200']
      page: 1,
      per_page: 50,
    });

    return response.data.people.map(person => ({
      name: `${person.first_name} ${person.last_name}`,
      email: person.email,
      title: person.title,
      company: person.organization_name,
      linkedin: person.linkedin_url,
    }));
  } catch (error) {
    console.error('People search failed:', error.response?.data);
    return [];
  }
}

// Usage
const people = await searchPeople({
  titles: ['CEO', 'Founder'],
  locations: ['United States'],
  companySize: ['11-50', '51-200'],
});
```

## Hunter.io Integration

### Setup

```javascript
const hunterClient = axios.create({
  baseURL: 'https://api.hunter.io/v2',
  params: {
    api_key: process.env.HUNTER_API_KEY,
  },
});
```

### Find Email

```javascript
async function findEmailHunter(firstName, lastName, domain) {
  try {
    const response = await hunterClient.get('/email-finder', {
      params: {
        domain: domain,
        first_name: firstName,
        last_name: lastName,
      },
    });

    return {
      email: response.data.data.email,
      confidence: response.data.data.confidence,
      sources: response.data.data.sources,
    };
  } catch (error) {
    console.error('Hunter email finder error:', error.response?.data);
    return null;
  }
}
```

### Domain Search (Find All Emails)

```javascript
async function domainSearch(domain) {
  try {
    const response = await hunterClient.get('/domain-search', {
      params: {
        domain: domain,
        limit: 50,
      },
    });

    return response.data.data.emails.map(email => ({
      email: email.value,
      firstName: email.first_name,
      lastName: email.last_name,
      position: email.position,
      department: email.department,
      confidence: email.confidence,
    }));
  } catch (error) {
    console.error('Domain search error:', error.response?.data);
    return [];
  }
}

// Usage
const emails = await domainSearch('stripe.com');
console.log(`Found ${emails.length} emails at stripe.com`);
```

### Verify Email

```javascript
async function verifyEmail(email) {
  try {
    const response = await hunterClient.get('/email-verifier', {
      params: {
        email: email,
      },
    });

    const data = response.data.data;

    return {
      email: data.email,
      status: data.status, // 'valid', 'invalid', 'accept_all', 'unknown'
      score: data.score, // 0-100
      result: data.result, // 'deliverable', 'undeliverable', 'risky', 'unknown'
      smtp_check: data.smtp_check,
      disposable: data.disposable,
      webmail: data.webmail,
    };
  } catch (error) {
    console.error('Email verification error:', error.response?.data);
    return null;
  }
}

// Usage
const verification = await verifyEmail('john@example.com');
if (verification.result === 'deliverable') {
  console.log('Email is valid!');
}
```

## Clearbit Integration

### Setup

```javascript
const clearbitClient = axios.create({
  baseURL: 'https://person.clearbit.com/v2',
  auth: {
    username: process.env.CLEARBIT_API_KEY,
    password: '',
  },
});
```

### Enrich Person by Email

```javascript
async function enrichPerson(email) {
  try {
    const response = await clearbitClient.get('/combined/find', {
      params: {
        email: email,
      },
    });

    const person = response.data.person;
    const company = response.data.company;

    return {
      person: {
        name: person.name.fullName,
        email: person.email,
        title: person.employment.title,
        role: person.employment.role,
        seniority: person.employment.seniority,
        linkedin: person.linkedin.handle,
        twitter: person.twitter.handle,
        location: person.location,
      },
      company: {
        name: company.name,
        domain: company.domain,
        industry: company.industry,
        employeeCount: company.metrics.employees,
        revenue: company.metrics.estimatedAnnualRevenue,
        founded: company.foundedYear,
        techStack: company.tech,
      },
    };
  } catch (error) {
    if (error.response?.status === 404) {
      console.log('No data found for this email');
    } else {
      console.error('Clearbit error:', error.response?.data);
    }
    return null;
  }
}
```

### Company Enrichment (Logo API)

```javascript
async function getCompanyLogo(domain) {
  return `https://logo.clearbit.com/${domain}`;
}

// Usage
const logoUrl = getCompanyLogo('stripe.com');
// Returns: https://logo.clearbit.com/stripe.com
```

## Rate Limiting & Throttling

### Simple Rate Limiter

```javascript
class RateLimiter {
  constructor(requestsPerMinute) {
    this.requestsPerMinute = requestsPerMinute;
    this.queue = [];
    this.processing = false;
  }

  async throttle(fn) {
    return new Promise((resolve, reject) => {
      this.queue.push({ fn, resolve, reject });
      this.processQueue();
    });
  }

  async processQueue() {
    if (this.processing || this.queue.length === 0) return;

    this.processing = true;
    const { fn, resolve, reject } = this.queue.shift();

    try {
      const result = await fn();
      resolve(result);
    } catch (error) {
      reject(error);
    }

    const delay = 60000 / this.requestsPerMinute;
    await new Promise(resolve => setTimeout(resolve, delay));

    this.processing = false;
    this.processQueue();
  }
}

// Usage
const apolloLimiter = new RateLimiter(60); // 60 requests per minute

async function enrichLeadWithRateLimit(lead) {
  return apolloLimiter.throttle(() => enrichCompany(lead.domain));
}
```

### Advanced: Token Bucket Algorithm

```javascript
class TokenBucket {
  constructor(capacity, refillRate) {
    this.capacity = capacity;
    this.tokens = capacity;
    this.refillRate = refillRate;
    this.lastRefill = Date.now();
  }

  async consume(tokens = 1) {
    this.refill();

    while (this.tokens < tokens) {
      await new Promise(resolve => setTimeout(resolve, 100));
      this.refill();
    }

    this.tokens -= tokens;
  }

  refill() {
    const now = Date.now();
    const elapsed = (now - this.lastRefill) / 1000;
    const tokensToAdd = elapsed * this.refillRate;

    this.tokens = Math.min(this.capacity, this.tokens + tokensToAdd);
    this.lastRefill = now;
  }
}

// Usage
const bucket = new TokenBucket(10, 1); // 10 tokens, refill 1 per second

async function apiCall() {
  await bucket.consume(1);
  return await apolloClient.get('/endpoint');
}
```

## Caching Strategies

### 1. In-Memory Cache

```javascript
class MemoryCache {
  constructor(ttl = 3600000) { // 1 hour default
    this.cache = new Map();
    this.ttl = ttl;
  }

  set(key, value) {
    this.cache.set(key, {
      value,
      expiresAt: Date.now() + this.ttl,
    });
  }

  get(key) {
    const item = this.cache.get(key);
    if (!item) return null;

    if (Date.now() > item.expiresAt) {
      this.cache.delete(key);
      return null;
    }

    return item.value;
  }
}

// Usage
const cache = new MemoryCache(3600000); // 1 hour TTL

async function getCachedCompany(domain) {
  const cached = cache.get(domain);
  if (cached) return cached;

  const data = await enrichCompany(domain);
  cache.set(domain, data);
  return data;
}
```

### 2. Redis Cache

```javascript
const redis = require('redis');
const client = redis.createClient();

async function getCachedData(key) {
  const cached = await client.get(key);
  if (cached) return JSON.parse(cached);

  const data = await fetchData(key);
  await client.setEx(key, 3600, JSON.stringify(data)); // 1 hour TTL

  return data;
}
```

### 3. File System Cache

```javascript
const fs = require('fs');
const path = require('path');

function getCachedFile(key) {
  const cachePath = path.join(__dirname, 'cache', `${key}.json`);

  if (fs.existsSync(cachePath)) {
    const { data, expiresAt } = JSON.parse(fs.readFileSync(cachePath, 'utf8'));
    if (Date.now() < expiresAt) {
      return data;
    }
  }

  return null;
}

function setCachedFile(key, data, ttl = 3600000) {
  const cachePath = path.join(__dirname, 'cache', `${key}.json`);
  fs.writeFileSync(cachePath, JSON.stringify({
    data,
    expiresAt: Date.now() + ttl,
  }));
}
```

## Error Handling

### Retry with Exponential Backoff

```javascript
async function apiCallWithRetry(fn, maxRetries = 3) {
  for (let attempt = 0; attempt < maxRetries; attempt++) {
    try {
      return await fn();
    } catch (error) {
      if (attempt === maxRetries - 1) throw error;

      if (error.response?.status === 429) { // Rate limit
        const retryAfter = error.response.headers['retry-after'] || Math.pow(2, attempt);
        console.log(`Rate limited. Retrying after ${retryAfter}s...`);
        await new Promise(resolve => setTimeout(resolve, retryAfter * 1000));
      } else if (error.response?.status >= 500) { // Server error
        const delay = Math.pow(2, attempt) * 1000;
        console.log(`Server error. Retrying after ${delay}ms...`);
        await new Promise(resolve => setTimeout(resolve, delay));
      } else {
        throw error; // Don't retry client errors
      }
    }
  }
}

// Usage
const data = await apiCallWithRetry(() => enrichCompany('example.com'));
```

### Graceful Degradation

```javascript
async function enrichLeadMultiSource(lead) {
  const result = {
    lead,
    enriched: false,
    sources: [],
  };

  // Try Apollo first
  try {
    const apolloData = await enrichCompany(lead.domain);
    if (apolloData) {
      result.company = apolloData;
      result.enriched = true;
      result.sources.push('apollo');
    }
  } catch (error) {
    console.warn('Apollo enrichment failed, trying Clearbit...');
  }

  // Fallback to Clearbit
  if (!result.enriched) {
    try {
      const clearbitData = await enrichPerson(lead.email);
      if (clearbitData) {
        result.company = clearbitData.company;
        result.enriched = true;
        result.sources.push('clearbit');
      }
    } catch (error) {
      console.warn('Clearbit enrichment failed');
    }
  }

  // Last resort: Manual lookup
  if (!result.enriched) {
    result.company = {
      name: lead.companyName,
      domain: lead.domain,
      enriched: false,
    };
  }

  return result;
}
```

## Data Transformation

### Normalize Company Data

```javascript
function normalizeCompanyData(source, data) {
  const normalized = {
    name: null,
    domain: null,
    employeeCount: null,
    revenue: null,
    industry: null,
    location: {},
    social: {},
    source,
  };

  if (source === 'apollo') {
    normalized.name = data.name;
    normalized.domain = data.website_url;
    normalized.employeeCount = data.estimated_num_employees;
    normalized.revenue = data.annual_revenue;
    normalized.industry = data.industry;
    normalized.location = {
      city: data.city,
      state: data.state,
      country: data.country,
    };
    normalized.social = {
      linkedin: data.linkedin_url,
      twitter: data.twitter_url,
    };
  } else if (source === 'clearbit') {
    normalized.name = data.name;
    normalized.domain = data.domain;
    normalized.employeeCount = data.metrics?.employees;
    normalized.revenue = data.metrics?.estimatedAnnualRevenue;
    normalized.industry = data.industry;
    normalized.location = {
      city: data.location?.city,
      state: data.location?.state,
      country: data.location?.country,
    };
    normalized.social = {
      linkedin: data.linkedin?.handle,
      twitter: data.twitter?.handle,
    };
  }

  return normalized;
}
```

### Merge Multiple Sources

```javascript
function mergeEnrichmentData(sources) {
  const merged = {};

  for (const source of sources) {
    for (const [key, value] of Object.entries(source)) {
      if (!merged[key] && value !== null && value !== undefined) {
        merged[key] = value;
      }
    }
  }

  return merged;
}

// Usage
const apolloData = await enrichCompany('example.com');
const clearbitData = await enrichPerson('john@example.com');

const merged = mergeEnrichmentData([
  normalizeCompanyData('apollo', apolloData),
  normalizeCompanyData('clearbit', clearbitData.company),
]);
```

## Batch Processing

### Process Leads in Batches

```javascript
async function enrichLeadsBatch(leads, batchSize = 10) {
  const results = [];

  for (let i = 0; i < leads.length; i += batchSize) {
    const batch = leads.slice(i, i + batchSize);

    console.log(`Processing batch ${i / batchSize + 1}/${Math.ceil(leads.length / batchSize)}`);

    const batchResults = await Promise.allSettled(
      batch.map(lead => enrichLead(lead))
    );

    results.push(...batchResults.map((result, index) => ({
      lead: batch[index],
      success: result.status === 'fulfilled',
      data: result.status === 'fulfilled' ? result.value : null,
      error: result.status === 'rejected' ? result.reason : null,
    })));

    // Wait between batches
    await new Promise(resolve => setTimeout(resolve, 2000));
  }

  return results;
}
```

## Cost Tracking

### Track API Usage

```javascript
class APIUsageTracker {
  constructor() {
    this.usage = {
      apollo: { calls: 0, cost: 0 },
      hunter: { calls: 0, cost: 0 },
      clearbit: { calls: 0, cost: 0 },
    };
  }

  track(service, calls = 1) {
    this.usage[service].calls += calls;
    this.usage[service].cost += this.getCost(service, calls);
  }

  getCost(service, calls) {
    const costs = {
      apollo: 0.01,    // $0.01 per call
      hunter: 0.02,    // $0.02 per call
      clearbit: 0.05,  // $0.05 per call
    };
    return costs[service] * calls;
  }

  getReport() {
    let totalCost = 0;
    const report = [];

    for (const [service, data] of Object.entries(this.usage)) {
      totalCost += data.cost;
      report.push({
        service,
        calls: data.calls,
        cost: `$${data.cost.toFixed(2)}`,
      });
    }

    return {
      services: report,
      total: `$${totalCost.toFixed(2)}`,
    };
  }
}

// Usage
const tracker = new APIUsageTracker();

async function trackedEnrich(domain) {
  tracker.track('apollo', 1);
  return await enrichCompany(domain);
}

// Get report
console.log(tracker.getReport());
```

## Testing API Integrations

### Mock API Responses

```javascript
const nock = require('nock');

// Mock Apollo API
nock('https://api.apollo.io')
  .post('/v1/organizations/enrich')
  .reply(200, {
    organization: {
      name: 'Test Company',
      website_url: 'test.com',
      estimated_num_employees: 50,
    },
  });

// Test
const result = await enrichCompany('test.com');
expect(result.name).toBe('Test Company');
```

## Best Practices

1. **Always use rate limiting** to avoid API bans
2. **Implement caching** to reduce costs
3. **Handle errors gracefully** with fallbacks
4. **Track API usage** to monitor costs
5. **Normalize data** from different sources
6. **Use batch processing** for large datasets
7. **Test with mocks** before production
8. **Monitor API health** and status
9. **Keep API keys secure** in environment variables
10. **Document API limitations** and quotas

---

**Remember**: API integrations are the backbone of lead enrichment. Proper implementation saves time, money, and headaches.
