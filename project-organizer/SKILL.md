---
name: "Project Organizer"
description: "Intelligent project scaffolding agent that creates production-ready project structures using templates from /Users/amy/Development/project-templates. Automatically sets up Next.js, Supabase, n8n automation projects, and more with proper configuration, directory structure, and AI assistant rules."
version: "1.0.0"
dependencies: ""
---

# Project Organizer

Autonomous project scaffolding specialist that transforms "let's start a new project" into fully-configured, production-ready codebases.

## Core Purpose

When a user says "let's start a new project", this skill:
1. Determines project type (Next.js app, n8n automation, scraper, dashboard, etc.)
2. Uses templates from `/Users/amy/Development/project-templates/`
3. Creates proper directory structure with all configuration files
4. Sets up AI assistant rules (codex.config, .cursor/rules.md)
5. Initializes git repository with initial commit
6. Provides clear next steps

## Project Types Supported

### 1. Full-Stack Web Application (Next.js)
**Template**: `/Users/amy/Development/project-templates/create-project.sh`

**Includes**:
- Next.js 14 with App Router
- TypeScript configuration
- Tailwind CSS + PostCSS
- Supabase integration (client + migrations + edge functions)
- NextAuth.js authentication
- Environment templates with common API keys
- Git + .gitignore + .cursorignore
- AI assistant rules (codex.config + .cursor/rules.md)
- Verification scripts
- Comprehensive README

**Directory Structure**:
```
project-name/
├── .cursor/           # AI rules and configuration
├── docs/              # Public, internal, API docs
├── src/               # App, components, lib, hooks, types, styles
├── supabase/          # Functions, migrations
├── scripts/           # Utility scripts
├── tests/             # Test files
├── internal/          # Private data, archives
└── public/            # Static assets
```

### 2. n8n Automation Project
**Use Case**: Lead generation, data scraping, workflow automation

**Includes**:
- n8n workflow templates
- Configuration for n8n Cloud API
- Environment setup for n8n webhooks
- Data storage structure (Google Sheets, Supabase, etc.)
- Testing protocol docs
- Search term strategy templates
- Lead scoring prompts

**Directory Structure**:
```
project-name/
├── workflows/         # n8n workflow JSONs
├── prompts/           # Claude AI prompts for filtering
├── config/            # n8n configuration
├── data/              # Test data and results
├── docs/              # Strategy and setup docs
└── scripts/           # Helper scripts
```

### 3. Web Scraping Project (Playwright)
**Use Case**: Job scraping, lead research, competitor analysis

**Includes**:
- Playwright configuration
- Apify Actor integration setup
- Rate limiting and proxy configuration
- Data storage and deduplication
- Error handling and retry logic
- Monitoring and logging

**Directory Structure**:
```
project-name/
├── scrapers/          # Playwright scripts
├── apify/             # Apify Actor configurations
├── data/              # Scraped data output
├── logs/              # Error logs
├── config/            # Scraper configuration
└── tests/             # Scraper tests
```

### 4. Dashboard/Analytics Project
**Use Case**: Client dashboards, data visualization, admin panels

**Includes**:
- Next.js + React
- Chart.js / Recharts / Plotly
- Supabase real-time subscriptions
- Data fetching and caching
- Responsive layouts
- Export functionality (CSV, PDF)

**Directory Structure**:
```
project-name/
├── src/
│   ├── components/    # Dashboard components
│   ├── charts/        # Chart components
│   ├── api/           # Data fetching
│   ├── hooks/         # Custom hooks
│   └── utils/         # Helper functions
└── docs/              # Dashboard documentation
```

### 5. API Integration Project
**Use Case**: Apollo.io, Hunter.io, Clearbit integration

**Includes**:
- API client configurations
- Rate limiting
- Caching strategies
- Error handling
- Data transformation
- Testing setup

**Directory Structure**:
```
project-name/
├── src/
│   ├── clients/       # API clients
│   ├── transforms/    # Data transformers
│   ├── cache/         # Caching logic
│   └── types/         # TypeScript types
├── tests/             # API tests
└── docs/              # API documentation
```

## Usage Patterns

### Pattern 1: User Says "Let's Start a New Project"

**Steps**:
1. **Ask clarifying questions**:
   - "What type of project? (web app, automation, scraper, dashboard, API)"
   - "What's the project name?"
   - "What are the key features?"
   - "Any specific integrations needed?"

2. **Select appropriate template**:
   - Web app → `create-project.sh`
   - Automation → n8n template
   - Scraper → Playwright template
   - Dashboard → dashboard template
   - API → integration template

3. **Execute project creation**:
   ```bash
   cd /Users/amy/Development
   ./project-templates/create-project.sh <project-name>
   ```

4. **Customize for specific needs**:
   - Add project-specific dependencies
   - Configure environment variables
   - Update README with project description
   - Add initial features/components

5. **Provide next steps**:
   - Environment setup instructions
   - API key requirements
   - First tasks to complete
   - Testing checklist

### Pattern 2: User Provides Specific Requirements

**Example**: "I need a lead generation system with Upwork scraping"

**Steps**:
1. **Identify project type**: n8n automation + Playwright scraping
2. **Create hybrid structure**:
   - Use n8n template for workflows
   - Add Playwright scrapers
   - Include data storage
   - Set up Claude AI filtering

3. **Pre-configure**:
   - Upwork Apify Actor configuration
   - n8n workflow with scraper node
   - Lead scoring prompts
   - Google Sheets connection

4. **Document strategy**:
   - Search term recommendations
   - Filtering criteria
   - Expected results
   - Cost estimates

### Pattern 3: Cursor Template Integration

**When Relevant**: User wants to use Cursor's built-in templates

**Steps**:
1. **Check Cursor templates**: Look in `/Users/amy/Development/project-templates/.cursor/`
2. **Merge with custom templates**: Combine Cursor templates with Amy's custom setup
3. **Preserve Amy's structure**: Keep codex.config, .cursor/rules.md, internal/ folder
4. **Add Cursor-specific features**: Use Cursor's AI configuration if beneficial

## Smart Defaults

### For Web Apps:
- Next.js 14 (latest)
- TypeScript (strict mode)
- Tailwind CSS
- Supabase for backend
- NextAuth.js for auth
- Vercel for deployment

### For Automation:
- n8n Cloud (not self-hosted)
- Claude API for filtering
- Google Sheets for storage
- Slack for notifications
- Scheduled triggers (daily)

### For Scrapers:
- Playwright (not Puppeteer)
- Apify Actors (managed)
- Rate limiting (10 req/min)
- Error retry (3 attempts)
- JSON output format

### For Dashboards:
- Recharts (for charts)
- Supabase real-time
- Tailwind for styling
- Responsive design
- Dark mode support

## Environment Variables Template

**Always include in .env.template**:

```bash
# Project-Specific
PROJECT_NAME=
ENVIRONMENT=development

# Supabase (if applicable)
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# Authentication (if applicable)
NEXTAUTH_URL=
NEXTAUTH_SECRET=

# API Keys
ANTHROPIC_API_KEY=
OPENAI_API_KEY=
RESEND_API_KEY=

# n8n (if applicable)
N8N_API_KEY=
N8N_WEBHOOK_URL=
N8N_WEBHOOK_SECRET=

# Data Enrichment (if applicable)
APOLLO_API_KEY=
HUNTER_API_KEY=
CLEARBIT_API_KEY=

# Scraping (if applicable)
APIFY_API_KEY=
PROXY_URL=
RATE_LIMIT=10

# External Services
SLACK_WEBHOOK_URL=
GOOGLE_SHEETS_API_KEY=
```

## AI Assistant Rules Setup

**Always create these files**:

### 1. codex.config
**Location**: `<project-root>/codex.config`

**Includes**:
- Project metadata (name, description, tech stack)
- Security rules (secrets, env vars)
- Development rules (build, test, lint)
- AI assistant rules (file access, code standards)
- Workflow rules (pre/post change checks)
- Post-change verification checklist

### 2. .cursor/rules.md
**Location**: `<project-root>/.cursor/rules.md`

**Includes**:
- Core principles
- Tech stack standards
- Pre-change checklist
- Post-change checklist
- Security requirements
- Performance standards
- Documentation standards
- Code quality standards
- Error handling
- Workflow requirements

### 3. .cursorignore
**Location**: `<project-root>/.cursorignore`

**Excludes**:
- Environment files (.env.*)
- Build outputs (.next/, dist/)
- Dependencies (node_modules/)
- Internal data (internal/data/)
- Large media files
- Client data
- Secrets and keys

## Verification Script

**Always include**: `scripts/verify-rules.sh`

**Checks**:
- Configuration files exist
- No secrets in code
- Build passes
- Linting passes
- TypeScript passes
- No high-severity vulnerabilities
- Supabase functions valid

**Usage**:
```bash
npm run verify
# or
./scripts/verify-rules.sh
```

## Initial Commit Message

**Format**:
```
feat: initial project setup with standard structure and configuration

- Next.js 14 with TypeScript
- Tailwind CSS styling
- Supabase backend integration
- NextAuth.js authentication
- AI assistant rules (codex.config, .cursor/rules.md)
- Standard directory structure
- Environment template
- Verification scripts
```

## Post-Creation Checklist

**Immediately after creation**:

1. **Environment Setup**
   - [ ] Copy .env.template to .env.local
   - [ ] Fill in required API keys
   - [ ] Add to Cursor Secrets if applicable

2. **Dependency Installation**
   - [ ] Run `npm install`
   - [ ] Verify no errors
   - [ ] Check for security vulnerabilities

3. **Build Verification**
   - [ ] Run `npm run build`
   - [ ] Fix any TypeScript errors
   - [ ] Verify build output

4. **Documentation**
   - [ ] Update README with project description
   - [ ] Add setup instructions
   - [ ] Document key features
   - [ ] List environment variables

5. **Git Setup**
   - [ ] Verify initial commit
   - [ ] Create repository on GitHub
   - [ ] Push initial commit
   - [ ] Set up branch protection

## Project-Specific Customizations

### For Lead Generation:
- Add `workflows/lead-generation.json`
- Add `prompts/lead-scoring.txt`
- Add `docs/search-strategy.md`
- Configure Apify Actors
- Set up Google Sheets connection

### For E-commerce:
- Add `src/components/products/`
- Add `src/lib/stripe.ts`
- Add `supabase/migrations/001_products.sql`
- Configure Shopify integration
- Set up payment processing

### For SaaS:
- Add `src/app/dashboard/`
- Add `src/lib/subscription.ts`
- Add `supabase/migrations/001_users.sql`
- Configure billing system
- Set up user authentication

### For Content Platform:
- Add `src/components/editor/`
- Add `src/lib/content.ts`
- Add `supabase/migrations/001_content.sql`
- Configure media storage
- Set up content workflow

## Common Project Patterns

### Pattern: Automation + Scraping
**Example**: Lead generation from job boards

**Setup**:
1. Create hybrid project structure
2. Add n8n workflow template
3. Add Playwright scrapers
4. Configure Claude AI filtering
5. Set up data storage (Supabase + Sheets)
6. Add monitoring (Slack notifications)

### Pattern: Dashboard + Real-time Data
**Example**: Client analytics dashboard

**Setup**:
1. Create Next.js project
2. Add Supabase real-time subscriptions
3. Add chart components (Recharts)
4. Configure data fetching
5. Set up refresh intervals
6. Add export functionality

### Pattern: API Integration + Data Transformation
**Example**: Lead enrichment with Apollo.io

**Setup**:
1. Create integration project
2. Add API client (Apollo.io)
3. Add rate limiting
4. Add data transformation
5. Set up caching (Redis)
6. Add error handling

## Quick Start Examples

### Example 1: "Create a lead generation system"

```bash
cd /Users/amy/Development
mkdir lead-generation-system
cd lead-generation-system

# Use n8n template
mkdir -p workflows prompts config data docs scripts
# Copy n8n workflow template
# Add Claude prompts
# Create documentation
```

### Example 2: "Create a client dashboard"

```bash
cd /Users/amy/Development
./project-templates/create-project.sh client-dashboard

# Customize for dashboard
cd client-dashboard
npm install recharts lucide-react
# Add dashboard components
# Configure Supabase real-time
```

### Example 3: "Create a web scraper"

```bash
cd /Users/amy/Development
mkdir competitor-scraper
cd competitor-scraper

# Use Playwright template
npm init -y
npm install playwright @apify/client
mkdir -p scrapers config data logs
# Add scraper scripts
```

## Success Metrics

### Week 1:
- Project created in < 2 minutes
- All configuration files present
- Build passes on first try
- Environment properly configured

### Week 2:
- First feature implemented
- Tests passing
- Documentation complete
- Deployed to staging

### Month 1:
- Production-ready
- All integrations working
- Monitoring in place
- Client feedback incorporated

## Best Practices

1. **Always use templates** - Don't create from scratch
2. **Customize after creation** - Start with defaults, then modify
3. **Verify immediately** - Run build/lint/type-check after creation
4. **Document as you go** - Update README with changes
5. **Use environment variables** - Never hardcode secrets
6. **Follow naming conventions** - kebab-case for projects
7. **Initialize git early** - First commit should be setup
8. **Test templates regularly** - Ensure they still work
9. **Update templates** - Keep dependencies current
10. **Leverage Cursor templates** - Use when beneficial

## Integration with Other Skills

- **Lead Generation Skill**: Automatically create lead generation projects
- **Web Scraping Skill**: Set up scraper projects
- **n8n Automation Skill**: Create n8n workflow projects
- **Supabase Skill**: Configure Supabase integration
- **Dashboard Builder Skill**: Set up dashboard projects

## Next Steps After Project Creation

1. **User onboarding**:
   - Explain project structure
   - Show where to add features
   - Highlight key files

2. **First feature**:
   - Implement core functionality
   - Add tests
   - Update documentation

3. **Deployment setup**:
   - Configure Vercel/Netlify
   - Set up environment variables
   - Test production build

4. **Monitoring**:
   - Add error tracking
   - Set up analytics
   - Configure alerts

## Emergency Recovery

**If project creation fails**:

1. **Cleanup**:
   ```bash
   rm -rf <project-name>
   ```

2. **Check template**:
   - Verify script exists
   - Check permissions
   - Test on simple project

3. **Manual creation**:
   - Create directory
   - Copy files manually
   - Initialize git

4. **Report issue**:
   - Note error message
   - Check script logs
   - Update template

## Maintenance

**Monthly**:
- Update template dependencies
- Check for security vulnerabilities
- Test all project types
- Update documentation

**Quarterly**:
- Review project patterns
- Add new templates
- Deprecate old patterns
- Gather user feedback

---

**Remember**: The goal is to make "let's start a new project" a 30-second operation, not a 30-minute setup process.
