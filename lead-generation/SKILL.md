---
name: "Lead Generation System Builder"
description: "Automated lead generation specialist that designs and builds systems to scrape job postings, service requests, and pain point discussions from multiple platforms. Expert in n8n workflows, Apify integration, Claude AI filtering, and lead enrichment with Apollo.io/Hunter.io."
version: "1.0.0"
dependencies: ""
---

# SKILL: Automated Lead Generation System Builder

## Purpose
This skill enables Claude to design, build, and deploy automated lead generation systems that scrape job postings, service requests, and pain point discussions from multiple platforms to identify businesses actively seeking automation or content creation services.

## Core Competencies

### 1. Lead Source Analysis
- **Job Platforms**: Indeed, LinkedIn, Upwork, Freelancer
- **Social Platforms**: Reddit, Twitter/X, Facebook groups
- **Search Strategy**: Identify high-intent keywords vs noise
- **Sentiment Analysis**: Filter service providers from service seekers

### 2. Workflow Architecture (n8n)
- **Trigger Types**: Schedule-based, webhook-based, manual
- **Data Flow Design**: Multi-source → Filter → Enrich → Score → Deliver
- **Error Handling**: Retry logic, fallback sources, notification systems
- **Rate Limiting**: Respect API limits, implement delays

### 3. Apify Actor Integration
- **Actor Selection Criteria**: Cost, reliability, success rate, output format
- **Configuration**: Input schemas, pagination, filtering parameters
- **Output Parsing**: JSON structure understanding, data extraction
- **Cost Optimization**: Minimize runs, maximize data per run

### 4. Lead Qualification & Scoring
- **Budget Indicators**: Salary ranges, project budgets, company size
- **Urgency Signals**: "ASAP", "urgent", posting date, application deadline
- **Quality Filters**: Remove duplicates, spam, irrelevant posts
- **AI Scoring**: Claude API for 1-10 lead quality rating

### 5. Data Enrichment
- **Contact Finding**: Apollo.io, Hunter.io, Clearbit
- **Company Data**: Employee count, revenue, tech stack, industry
- **Social Profiles**: LinkedIn, Twitter verification
- **Validation**: Email verification, phone validation

### 6. Search Term Strategy
- **High-Intent Terms**: Specific tools (Zapier, Make), specific roles (automation consultant)
- **Pain-Point Terms**: "manual work", "repetitive tasks", "drowning in"
- **Negative Filters**: Exclude service providers, educators, DIY tutorials
- **Context Awareness**: Industry modifiers, location modifiers, budget modifiers

### 7. Filtering & Sentiment Analysis
- **Service Provider Detection**: 
  - Keywords: "I offer", "my services", "hire me", "portfolio"
  - Profile indicators: "freelancer", "consultant", "agency"
  - Post structure: Promotional tone vs help-seeking tone
- **Help-Seeker Detection**:
  - Keywords: "need", "looking for", "help with", "anyone know"
  - Questions vs statements: "How do I..." vs "I can help you..."
  - Budget mentions: Indicates buyer, not seller
- **Claude AI Analysis**: Use for nuanced sentiment detection

### 8. Sector-Specific Intelligence
- **High-Receptivity Sectors**:
  - Real Estate: Manual CRM entry, lead management
  - E-commerce: Order fulfillment, inventory sync
  - Professional Services: Client onboarding, invoicing
  - SaaS: Internal workflows, customer success automation
  - Healthcare: Appointment scheduling, patient intake
  - Legal: Document processing, case management
- **Budget Indicators by Sector**: Understand typical spend ranges
- **Pain Points by Sector**: Industry-specific automation needs

## Technical Implementation

### n8n Workflow Structure
```
[Schedule Trigger]
  ↓
[Multi-Source Scraping] (Parallel)
  ├── [Indeed Scraper]
  ├── [LinkedIn Scraper]
  ├── [Upwork Scraper]
  └── [Reddit Scraper]
  ↓
[Merge & Deduplicate]
  ↓
[Filter Service Providers] (Claude AI)
  ↓
[Enrich with Apollo.io]
  ↓
[Score with Claude AI]
  ↓
[Route by Score]
  ├── [Hot Leads] → Immediate notification
  ├── [Warm Leads] → CRM queue
  └── [Cold Leads] → Nurture sequence
  ↓
[Save to Google Sheets]
  ↓
[Slack Notification]
```

### Claude AI Prompts for Filtering

**Service Provider Detection:**
```
Analyze this post and determine if the author is:
A) Seeking services (potential client)
B) Offering services (service provider)
C) Just discussing/teaching (not a lead)

Post: {text}
Author bio: {bio}
Context: {subreddit/platform}

Return JSON:
{
  "category": "A/B/C",
  "confidence": 0-100,
  "reasoning": "why",
  "is_lead": true/false
}
```

**Lead Quality Scoring:**
```
Score this lead 1-10 based on:
- Budget indicators (+3)
- Urgency signals (+2)
- Specific tool mentioned (+2)
- Company size indicators (+2)
- Clear pain point (+1)

Lead data: {all_data}

Return JSON:
{
  "score": 1-10,
  "budget_indicator": true/false,
  "urgency_level": "low/medium/high",
  "recommended_action": "immediate contact/queue for later/nurture",
  "reasoning": "why this score"
}
```

## Search Term Strategies

### Use Case 1: Automation Services

**High-Intent Job Terms:**
```
"zapier expert" OR "zapier consultant"
"make.com expert" OR "make consultant"
"automation specialist" OR "automation consultant"
"workflow automation" AND "hire"
"n8n developer" OR "n8n consultant"
"airtable automation" AND (contract OR freelance)
"process automation" AND budget
"integration specialist" NOT "we are hiring" (exclude agencies hiring)
```

**Pain Point Terms:**
```
"drowning in manual work"
"manual data entry" AND "too much time"
"repetitive tasks" AND "help"
"spreadsheet hell"
"copy paste all day"
"need to automate"
"wasting time on" AND (admin OR data OR entry)
```

**Reddit-Specific:**
```
subreddit:(smallbusiness OR entrepreneur OR startups OR SaaS)
"manual work" OR "manual processes"
"need automation" OR "automate my business"
NOT ("I offer" OR "my services" OR "check out my")
```

### Use Case 2: Social Media Content Creation

**Job Terms:**
```
"social media manager" OR "content creator"
"instagram content" OR "tiktok content"
"social media coordinator"
"video editor" AND "social media"
"content marketing" AND (contract OR freelance)
"social media strategy" AND hire
```

**Automatable Tasks (They Don't Know Yet):**
```
"scheduling social posts manually"
"posting to multiple platforms"
"repurposing content" AND "time consuming"
"creating captions" AND "takes forever"
"hashtag research" AND "tedious"
"social media reporting" AND "manual"
"content calendar" AND "spreadsheet"
```

## Realistic Expectations

### Contact Information Availability
**Out of 400 leads:**
- **60-80 leads (15-20%)** will have verified email from enrichment
- **120-160 leads (30-40%)** will have company info but no direct contact
- **40-60 leads (10-15%)** will have LinkedIn profiles findable
- **Remainder** will need manual research or outreach via platform

**Best Contact Rates by Source:**
- LinkedIn Jobs: 40-50% (company + hiring manager often visible)
- Upwork: 0% direct email (must contact via platform)
- Indeed: 30-40% (company name → Apollo.io enrichment)
- Reddit: 10-20% (username → profile → maybe contact)

### Lead Quality by Source

**Highest Quality:**
1. **LinkedIn Jobs** - 70% hot leads (hiring = budget + urgency)
2. **Upwork Projects** - 60% hot leads (active projects, budget listed)
3. **Indeed Jobs** - 55% hot leads (varies by job description quality)
4. **Reddit** - 30% hot leads (many tire-kickers, but validated pain)

## Accounts & Costs Required

### Essential (For First Test Run)
1. **Apify**: $5 free credit (enough for 1 test run)
   - Sign up: https://apify.com/sign-up
   
2. **n8n Cloud**: Free trial or $20/month
   - Sign up: https://n8n.io

3. **Anthropic API**: $5 free credit
   - Get key: https://console.anthropic.com

4. **Google Account**: Free (for Sheets)

### Optional (For Enrichment)
5. **Apollo.io**: 50 free credits/month, then $49/month
   - Only needed if you want email/phone enrichment
   - For first test: Skip this, just test data collection

6. **Hunter.io**: 25 free searches/month
   - Email verification
   - For first test: Optional

### Total Cost for ONE Test Run
- Apify: $0 (uses free credit)
- n8n: $0 (14-day trial)
- Claude API: $0.15 (for 50 lead analyses)
- **Total: ~$0.15** 

## Testing Protocol

### Phase 1: Single Source Test (Day 1)
1. Test ONE scraper (Indeed recommended)
2. Search: 1-2 high-intent terms
3. Limit: 20 results
4. Manual review: Are these real leads?
5. Refine search terms based on results

### Phase 2: Multi-Source Test (Day 2-3)
1. Add 2-3 more sources
2. Same search terms across all
3. Limit: 50 results total
4. Compare quality by source
5. Identify best source for your niche

### Phase 3: Filtering Test (Day 4-5)
1. Run without filters: 50 results
2. Manually categorize: Client vs Provider vs Noise
3. Implement Claude filtering
4. Re-run same searches
5. Compare: Did filtering work?

### Phase 4: Scoring Test (Day 6-7)
1. Run on 50 leads
2. Claude scores all leads
3. Manually verify: Do scores match reality?
4. Adjust scoring criteria
5. Re-test

### Phase 5: Full Automation (Day 8+)
1. Schedule daily runs
2. Monitor for 1 week
3. Track: Leads found, quality, false positives
4. Refine weekly

## Common Issues & Solutions

### Issue: Too Many Service Providers in Results
**Solution:**
- Add negative keywords: NOT ("I offer" OR "my services")
- Use Claude sentiment analysis on each result
- Filter by post structure (questions vs statements)

### Issue: Upwork Returns Service Providers Too
**Solution:**
- Filter by "Job" category only (not profiles)
- Search in job postings, not talent search
- Actor configuration: Set `searchType: "jobs"`

### Issue: Reddit Returns Tutorials/Guides
**Solution:**
- Filter by subreddit (avoid r/automation, r/nocode)
- Exclude posts with link sharing
- Use Claude to detect "teaching" tone vs "seeking help" tone

### Issue: Low Email Match Rate
**Solution:**
- Focus on LinkedIn/Indeed (better company data)
- Use LinkedIn profiles to manual research
- Accept platform-based outreach (Upwork, Reddit DM)

### Issue: Too Broad Results (Not Niche Enough)
**Solution:**
- Add industry modifiers: "real estate" AND "automation"
- Add tool specificity: "zapier" instead of "automation"
- Add budget filters: "$500+" OR "contract" OR "full-time"

## Success Metrics

### Week 1 Goals
- 50-100 leads collected
- <20% service provider false positives
- At least 10 leads with contact info
- Identify 1-2 best sources for your niche

### Month 1 Goals
- 400+ leads collected
- 60+ leads with verified contact info
- 5-10 outreach conversations started
- 1-2 discovery calls booked

### Sector Receptivity Ranking

**Most Receptive (High Budget, High Pain):**
1. **SaaS Companies** - Technical, understand automation value
2. **E-commerce** - Clear ROI, repetitive tasks
3. **Real Estate** - Manual CRM work, lead management pain
4. **Professional Services** - Billing, client onboarding automation
5. **Healthcare** - Scheduling, patient intake (compliance-aware)

**Moderate Receptivity:**
6. Legal - Document heavy, but conservative
7. Marketing Agencies - Understand automation, but often DIY
8. Financial Services - Budget available, but slow decision-making

**Lower Receptivity (But Still Viable):**
9. Small Retail - Low budget, may not see value
10. Restaurants - Very low margin, minimal automation understanding

## Best Practices

1. **Always test manually first** before automating
2. **Start with 1 source**, master it, then expand
3. **Focus on quality over quantity** - 20 great leads > 200 mediocre
4. **Respect platforms** - Don't spam, don't scrape too aggressively
5. **Provide value first** - Especially on Reddit/Twitter, don't cold pitch
6. **Track everything** - Source, search term, response rate
7. **Iterate weekly** - Adjust search terms based on what converts
8. **Use negative keywords** liberally to reduce noise
9. **Verify leads** before mass outreach - check if still active
10. **Segment by score** - Different outreach for hot vs warm leads

## Next Steps After This Skill

When user confirms their niche and goals, use this skill to:
1. Create custom search term list for their specific niche
2. Build the complete n8n workflow JSON
3. Configure Claude prompts for their filtering needs
4. Set up testing protocol specific to their timeline
5. Provide realistic conversion expectations for their sector
