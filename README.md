# New Claude Skills

Custom skills for Claude Code to enhance automation, web scraping, API integration, and project management.

## Standing rule: no MCP, no default orchestration tool

None of these skills assume an MCP connection for Shopify, Klaviyo, or any Google product (Sheets, Drive, Apps Script, Analytics, Ads, etc.). Every integration is written as direct API calls (REST/GraphQL). Similarly, n8n and Google Apps Script are both opt-in orchestration engines — a skill that needs scheduling/triggering asks which one is wanted (or defaults to a plain script/cron) rather than assuming either.

## Skills Included

### Lead Generation & Automation
- **lead-generation** - Automated lead generation system builder with Apify and Claude AI filtering, via direct API calls (n8n only if explicitly requested)
- **web-scraping-specialist** - Playwright, Beautiful Soup, and Apify expert for ethical web scraping
- **api-integration-specialist** - Apollo.io, Hunter.io, Clearbit integration for lead enrichment

### Marketing & E-commerce
- **marketing-automation-specialist** - Email campaigns, lead nurturing, and client acquisition funnels via direct Klaviyo/Resend API calls
- **shopify-data-mapper** - Map and upload data to Shopify (products, variants, blog posts)
- **shopify-engineer** - Shopify product management and automation via the Shopify Admin API directly (no MCP assumed)
- **klaviyo-engineer** - Email marketing automation with Klaviyo via the Klaviyo API directly (no MCP assumed)

### Development & Infrastructure
- **project-organizer** - Intelligent project scaffolding with templates
- **senior-engineer-coder** - Elite-level software engineering across all languages
- **senior-project-planner** - Project planning and architecture
- **senior-project-creator** - Production-ready project setup

### Automation & Integration
- **n8n-automation-expert** - n8n workflow architecture and automation; invoke explicitly, not a default
- **google-apps-script-expert** - Google Apps Script automation and spreadsheet-driven tools; invoke explicitly, not a default
- **cicd-devops-engineer** - DevOps and CI/CD automation
- **supabase-database-expert** - Supabase database design and optimization
- **supabase-edge-functions-specialist** - Supabase Edge Functions deployment

### Data & Analytics
- **data-mapper** - Intelligent data mapping and field analysis
- **data-visualization-expert** - Charts, dashboards, and data stories
- **dashboard-builder** - Interactive dashboards with real-time updates

### Quality & Testing
- **debugging-troubleshooting-expert** - Systematic issue diagnosis and resolution
- **qa-engineer-team** - Comprehensive testing across all languages
- **frontend-qa-specialist** - Frontend testing with Playwright and Vitest

### Specialized
- **react-expert** - Advanced React patterns and optimization
- **tailwind-expert** - Tailwind CSS design systems
- **web-app-builder** - Full-stack web application development
- **prixflow-platform-specialist** - PrixFlow platform-specific expertise
- **backup-disaster-recovery** - Backup strategies and recovery procedures

### Meta-skills (not installed by default — see below)
- **meta-skills/skill-agent-factory** - Describes itself as an autonomous skill/agent generator that acts without being asked. Kept in the repo for reference, deliberately excluded from the normal install so it can't run unsupervised. Only move it into your active skills directory if you specifically want that behavior and plan to supervise it closely.

## Installation

### For Claude Code (CLI)

1. Clone this repository:
```bash
git clone https://github.com/amkniss/new-claude-skills.git
```

2. Symlink or copy to Claude skills directory — note the glob only covers top-level skill folders, so `meta-skills/` (and anything inside it) is **not** picked up:
```bash
# Symlink (recommended)
ln -s /path/to/new-claude-skills/* ~/.claude/skills/

# Or copy
cp -r new-claude-skills/* ~/.claude/skills/
```

3. Skills are automatically loaded by Claude Code. To deliberately enable a meta-skill, symlink/copy it individually: `ln -s /path/to/new-claude-skills/meta-skills/skill-agent-factory ~/.claude/skills/skill-agent-factory`

### For Claude Desktop

Add the skills directory to your MCP configuration:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/new-claude-skills"]
    }
  }
}
```

## Usage

Skills are automatically referenced by Claude Code based on your requests:

- "Create a new lead generation project" → Uses `lead-generation` + `project-organizer`
- "Scrape Indeed for jobs" → Uses `web-scraping-specialist`
- "Map CSV to Shopify" → Uses `shopify-data-mapper`
- "Build an email sequence" → Uses `marketing-automation-specialist`
- "Automate this with n8n" / "Write this as an Apps Script" → Uses `n8n-automation-expert` / `google-apps-script-expert` (only when named explicitly)

## Contributing

These are personal skills for my workflow. Feel free to fork and customize for your needs!

## License

MIT License - Feel free to use and modify
