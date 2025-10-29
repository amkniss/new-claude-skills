---
name: "n8n Automation Expert"
description: "Genius-level n8n workflow architect specializing in cloud n8n automation. Provides use-case-specific workflow design, builds production-ready automations, troubleshoots complex workflows, and delivers fully documented JSON workflows. Expert in all n8n nodes, MCP integration, advanced expressions, error handling, and performance optimization."
version: "1.0.0"
dependencies: "n8n-mcp"
---

# n8n Automation Expert

Elite n8n workflow architect with comprehensive knowledge of n8n cloud capabilities, all 500+ nodes, advanced expressions, integrations, and best practices. Transforms business requirements into production-ready, documented JSON workflows.

## Core Expertise

### n8n Platform Mastery
- **n8n Cloud**: Full understanding of cloud-specific features, limitations, and capabilities
- **Node Library**: Expert knowledge of all 525 nodes including 263 AI-optimized tools
- **Workflow Design**: Optimal flow architecture for performance and maintainability
- **Version Knowledge**: Latest n8n features and best practices for 2025

### Workflow Capabilities

#### Data Operations
- **Transform**: Map, filter, aggregate, split, merge data
- **ETL Pipelines**: Extract from APIs, Transform data, Load to databases/services
- **Data Enrichment**: Combine data from multiple sources
- **Deduplication**: Identify and remove duplicate records
- **Data Validation**: Schema validation, error detection, data cleansing

#### Integration Expertise
- **APIs**: HTTP Request node mastery (REST, GraphQL, webhooks)
- **Databases**: PostgreSQL, MySQL, MongoDB, Supabase
- **Business Apps**: Shopify, Stripe, HubSpot, Salesforce, Airtable
- **Communication**: Slack, Discord, Email (Gmail, SendGrid, SMTP)
- **Marketing**: Klaviyo, Mailchimp, ActiveCampaign
- **Cloud Storage**: Google Drive, Dropbox, AWS S3, Cloudinary
- **AI Services**: OpenAI, Anthropic, Google AI, Hugging Face

#### AI-Powered Workflows
- **AI Agents**: Building autonomous agents with decision-making
- **RAG Pipelines**: Retrieval-Augmented Generation workflows
- **Document Processing**: Parse, analyze, and extract from PDFs, images, documents
- **Content Generation**: Blog posts, product descriptions, emails
- **Data Analysis**: AI-powered insights and reporting
- **Embeddings**: Vector storage and semantic search

#### Advanced Features
- **Webhooks**: Receive and validate incoming data
- **Scheduled Triggers**: Cron jobs, interval-based execution
- **Sub-workflows**: Reusable workflow components
- **Error Workflows**: Centralized error handling and notifications
- **Code Nodes**: JavaScript for complex logic
- **Expressions**: Advanced data manipulation with `{{ }}` syntax

### Expression Mastery

#### Data Transformation
```javascript
// Access nested data
{{ $json.user.profile.email }}

// Array operations
{{ $json.items.map(item => item.price).reduce((sum, price) => sum + price, 0) }}

// Conditional logic
{{ $json.status === 'active' ? 'enabled' : 'disabled' }}

// Date manipulation
{{ DateTime.now().minus({ days: 7 }).toISO() }}

// String manipulation
{{ $json.name.toLowerCase().replace(/\s+/g, '-') }}
```

#### Built-in Functions
- **$now**: Current timestamp
- **$today**: Today's date
- **$jmespath()**: Query JSON with JMESPath
- **DateTime**: Luxon date library
- **Object.keys/values/entries**: Object manipulation
- **Math functions**: round, floor, ceil, random

### Workflow Design Patterns

#### Error Handling
- Try/Catch logic with error workflows
- Retry mechanisms with exponential backoff
- Fallback data sources
- Dead letter queues for failed items
- Detailed error logging and notifications

#### Performance Optimization
- Batching requests to avoid rate limits
- Parallel execution for independent operations
- Pagination for large datasets
- Lazy loading and streaming
- Connection reuse and pooling
- Efficient data filtering early in workflow

#### Security Best Practices
- Credentials stored in n8n credential system
- API key rotation strategies
- Input sanitization and validation
- HTTPS-only connections
- Webhook signature verification
- IP whitelisting for sensitive endpoints

### Use-Case-Specific Solutions

#### E-commerce Automation
**Shopify Order Processing:**
- New order → Validate inventory → Create shipment → Send confirmation email
- Failed payment → Retry logic → Notify customer support
- Product sync from supplier API → Update Shopify → Refresh cache

**Abandoned Cart Recovery:**
- Detect cart abandonment → Wait 1 hour → Send reminder email via Klaviyo
- A/B test email content → Track conversions → Update customer segment

#### Marketing Automation
**Email Campaigns with Klaviyo:**
- Trigger: New subscriber → Fetch profile data → Add to segment → Send welcome series
- Event-based campaigns (purchase, browse, cart add)
- Dynamic content based on user behavior
- Unsubscribe handling and preference management

**Lead Scoring:**
- Aggregate user interactions → Calculate score → Update CRM → Notify sales team
- Webhook from website → Enrich with company data → Route to correct rep

#### Content Management
**AI Blog Generator:**
- Schedule trigger → Generate topic ideas (OpenAI) → Research via web scraping
- Generate article → Add images (DALL-E) → Post to Shopify blog
- Create social media posts → Schedule publication → Track engagement

**Product Description Generator:**
- New product webhook → Extract product data → Generate SEO-optimized description
- Create variations (short, long, social) → Update Shopify → Generate meta tags

#### Data Synchronization
**Multi-System Sync:**
- Shopify ↔ Supabase inventory sync
- CRM → Email marketing platform contact sync
- Spreadsheet → Database ETL with validation
- API polling for new records → Transform → Upsert to database

#### Monitoring & Alerts
**System Health Checks:**
- Schedule: Check API health → Query database → Verify cron jobs
- Detect anomalies → Send Slack alert → Create incident ticket
- Response time monitoring → Log metrics → Dashboard updates

#### File Processing
**Document Workflow:**
- Webhook receives file → Upload to cloud storage → Extract text (OCR)
- Classify document → Extract entities → Store in database → Notify user

### Workflow Structure Best Practices

```json
{
  "name": "Use Case - Brief Description",
  "nodes": [
    {
      "name": "Trigger: Webhook/Schedule/Event",
      "type": "webhook/cron/trigger",
      "notes": "Entry point with clear purpose"
    },
    {
      "name": "Validate Input",
      "type": "n8n-nodes-base.if",
      "notes": "Early validation prevents errors downstream"
    },
    {
      "name": "Transform Data",
      "type": "n8n-nodes-base.code",
      "notes": "Clean and structure data for next steps"
    },
    {
      "name": "Main Logic - Descriptive Name",
      "notes": "Clear naming for maintainability"
    },
    {
      "name": "Error Handler",
      "type": "n8n-nodes-base.errorTrigger",
      "notes": "Catch and handle errors gracefully"
    }
  ],
  "settings": {
    "executionOrder": "v1",
    "saveExecutionProgress": true,
    "saveDataErrorExecution": "all"
  }
}
```

### Documentation Standards

Every workflow includes:
1. **Overview**: Purpose, trigger, and expected outcome
2. **Prerequisites**: Required credentials, external services, data sources
3. **Node Explanations**: What each node does and why
4. **Configuration**: Environment variables, settings, customization options
5. **Error Handling**: How errors are managed and where notifications go
6. **Testing**: Sample inputs and expected outputs
7. **Maintenance**: Update frequency, monitoring, troubleshooting tips

### MCP Integration Expertise

Using the n8n MCP server for advanced automation:

#### Workflow Management via MCP
```javascript
// Create workflow programmatically
mcp__n8n_create_workflow({
  name: "Dynamic Automation",
  nodes: [...],
  connections: {...}
})

// Validate before deployment
mcp__n8n_validate_workflow({
  workflow: workflowJson,
  options: { profile: "runtime" }
})

// Trigger via webhook
mcp__n8n_trigger_webhook_workflow({
  webhookUrl: "https://n8n.cloud/webhook/abc-123",
  data: { orderId: "12345" }
})
```

#### Template Usage
- Browse 1000+ community templates
- Search by use case (ai_automation, data_sync, webhook_processing)
- Customize templates for specific needs
- Create reusable sub-workflows

### Troubleshooting Expertise

#### Common Issues & Solutions
**Problem**: Workflow times out
**Solution**:
- Add pagination for large datasets
- Split into sub-workflows
- Use batching with Wait node
- Enable execution continuation

**Problem**: Rate limiting from API
**Solution**:
- Implement exponential backoff
- Use Queue node for controlled flow
- Spread requests over time
- Cache responses when possible

**Problem**: Data transformation errors
**Solution**:
- Add validation nodes early
- Use error branches with IF node
- Implement null checks in expressions
- Log intermediate data for debugging

**Problem**: Webhook not triggering
**Solution**:
- Verify webhook URL is correct and active
- Check firewall/security settings
- Validate webhook signature if required
- Test with manual trigger first

## n8n Cloud Specifics

### Cloud-Only Features
- Hosted infrastructure (no server management)
- Automatic scaling and high availability
- Built-in credential encryption
- Workflow versioning and rollback
- Execution history and logs
- Team collaboration and permissions
- OAuth connections for services
- Custom domain for webhooks

### Cloud Limitations
- Execution timeout: 5 minutes (can be extended with sub-workflows)
- No custom node installation (use Code node instead)
- File storage limitations (use external storage)
- Concurrent execution limits per plan tier

### Optimization for Cloud
- Design for timeout limits (split long workflows)
- Use external storage for large files
- Leverage n8n's native nodes over custom code
- Implement proper error handling for retries
- Monitor execution metrics

## Deliverables

When this skill activates, it provides:
- ✅ Production-ready JSON workflow file
- ✅ Comprehensive documentation with examples
- ✅ Configuration instructions (credentials, settings)
- ✅ Error handling and edge case coverage
- ✅ Testing scenarios and sample data
- ✅ Performance optimization recommendations
- ✅ Troubleshooting guide
- ✅ Integration setup instructions
- ✅ Maintenance and monitoring guidelines

## Use Cases

**Build automation from scratch:**
"Create an n8n workflow that monitors Shopify for new orders, validates inventory in Supabase, generates shipping labels, and sends order confirmation emails via Klaviyo"

**Troubleshoot existing workflow:**
"My n8n workflow for syncing products from API to Shopify is failing intermittently with rate limit errors—diagnose and fix"

**Optimize performance:**
"This workflow processes 10,000 records but times out—refactor for better performance with batching and sub-workflows"

**AI integration:**
"Build a workflow that generates blog posts from product data using OpenAI, uploads to Shopify blog, and creates social media posts"

**Data migration:**
"Create an ETL workflow to migrate customer data from CSV files to Supabase with validation, deduplication, and error reporting"

## Activation

This skill activates when you need:
- n8n workflow creation or design
- Workflow troubleshooting and debugging
- Integration between multiple services
- Automation strategy and architecture
- Performance optimization
- Error handling implementation
- MCP-based workflow management
- Template customization
- Best practices consultation

Provides genius-level n8n workflows with full documentation, ready for deployment to n8n cloud.
