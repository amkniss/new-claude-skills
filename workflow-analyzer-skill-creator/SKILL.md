---
name: "Workflow Analyzer & Skill Creator"
description: "Proactive issue detection and skill generation system. Continuously monitors work sessions for inefficiencies, gaps, and repeated patterns, then automatically creates new skills to resolve them. Self-improving assistant that learns from every interaction."
version: "1.0.0"
dependencies: ""
---

# Workflow Analyzer & Skill Creator

Autonomous meta-skill that identifies workflow inefficiencies and creates specialized skills to solve them.

## Core Purpose

Monitor every work session and:
1. **Detect patterns** - Repeated tasks, manual workarounds, friction points
2. **Diagnose root causes** - Why is this inefficient?
3. **Generate skills** - Create reusable solutions
4. **Validate effectiveness** - Did it improve workflow?

## When This Skill Activates

**Automatic triggers:**
- User performs same task 3+ times in a session
- Error occurs repeatedly
- User expresses frustration ("this is tedious", "wish this was automated")
- Manual workaround detected
- Context switching overhead identified
- Tool/API integration needed repeatedly

**Manual triggers:**
- User says "this should be a skill"
- User asks "can we automate this?"
- End of long work session (reflection mode)

## Detection Patterns

### Pattern 1: Repeated Task
**Example conversation:**
```
User: Map this CSV to Shopify format
Assistant: [maps data]
User: Now map this other CSV
Assistant: [maps data again]
User: And another one...
```

**Detection:** Same task type performed 3+ times

**Skill creation trigger:** Yes

**Generated skill:** CSV-to-Shopify mapper with templates

### Pattern 2: Manual Workaround
**Example:**
```
User: I need to manually check each lead on LinkedIn
Assistant: [helps with one]
User: Now the next one
User: This is taking forever...
```

**Detection:** Manual repetition + frustration signal

**Generated skill:** LinkedIn profile automation scraper

### Pattern 3: Missing Integration
**Example:**
```
User: How do I get data from Apollo into Supabase?
Assistant: [provides manual steps]
User: I have to do this every day
```

**Detection:** Repeated data transfer between systems

**Generated skill:** Apollo-to-Supabase sync automation

### Pattern 4: Error Loop
**Example:**
```
User: This keeps failing
Assistant: [tries solution]
User: Still failing
Assistant: [tries another]
User: Why does this always break?
```

**Detection:** Same error 2+ times with different attempts

**Generated skill:** Error-specific debugger with checklist

## Skill Generation Process

### Step 1: Evidence Collection
```javascript
const evidence = {
  trigger: "repeated_task",
  occurrences: 3,
  task_description: "Mapping CSV columns to Shopify format",
  pain_points: [
    "Manual column mapping",
    "Price formatting inconsistencies",
    "Image URL validation"
  ],
  time_cost: "~15 minutes per CSV",
  frequency: "Daily",
  user_frustration_level: "medium"
};
```

### Step 2: Root Cause Analysis
```javascript
const analysis = {
  core_problem: "No reusable mapping template",
  why_manual: "Column names vary between sources",
  existing_solutions: [
    "shopify-data-mapper (covers basics)",
    "data-mapper (generic)"
  ],
  gap: "No source-specific templates with auto-detection",
  solution_type: "enhancement" // or "new_skill"
};
```

### Step 3: Skill Definition
```javascript
const newSkill = {
  name: "CSV-to-Shopify Auto-Mapper",
  type: "enhancement", // enhance existing shopify-data-mapper
  purpose: "Automatically detect CSV format and apply correct mapping template",

  features: [
    "Auto-detect source format (Supplier A, Scraper B, etc.)",
    "Pre-built mapping templates",
    "Validation before upload",
    "Error highlighting"
  ],

  implementation: {
    location: "shopify-data-mapper/SKILL.md",
    section_to_add: "Auto-Detection Patterns",
    code_examples: true,
    testing_required: true
  },

  success_criteria: {
    time_saved: "> 10 minutes per CSV",
    error_reduction: "> 80%",
    user_satisfaction: "eliminates frustration"
  }
};
```

### Step 4: Validation Questions
Before creating the skill, ask:
1. Is this truly reusable (not one-off)?
2. Will this solve the root cause?
3. Does an existing skill cover this (maybe needs enhancement)?
4. Is the ROI worth it (time saved vs. complexity)?

### Step 5: Implementation
```
IF new_skill:
  - Create skill file with YAML frontmatter
  - Include comprehensive examples
  - Add to skills directory
  - Notify user

IF enhancement:
  - Add section to existing skill
  - Update version number
  - Test integration
  - Notify user

IF defer:
  - Log for future consideration
  - Explain why (e.g., too niche, one-off use case)
```

## Skill Templates

### Template 1: Automation Skill
```yaml
---
name: "[Task] Automation Assistant"
description: "Automates [specific task] to save [X] minutes per execution"
version: "1.0.0"
dependencies: ""
---

# [Task] Automation Assistant

Automates [task description] with [specific tools/methods].

## Problem Solved
[Original pain point with evidence]

## How It Works
[Step-by-step automation process]

## Usage Examples
[3-5 concrete examples]

## Success Metrics
- Time saved: [X minutes/hours]
- Error reduction: [X%]
- Frequency: [daily/weekly/monthly]
```

### Template 2: Integration Skill
```yaml
---
name: "[Service A] to [Service B] Sync"
description: "Seamless data sync between [A] and [B] with transformation"
version: "1.0.0"
dependencies: ""
---

# [Service A] to [Service B] Sync

Automated data synchronization with mapping and validation.

## Data Flow
[A] → Transform → Validate → [B]

## Mapping Rules
[Source field → Target field]

## Error Handling
[What happens when sync fails]

## Usage
[How to trigger and monitor]
```

### Template 3: Debugger Skill
```yaml
---
name: "[Error Type] Debugger"
description: "Systematic debugging for [specific error] with checklist"
version: "1.0.0"
dependencies: ""
---

# [Error Type] Debugger

Root cause analysis and resolution for [error].

## Common Causes
1. [Cause 1] - Check [X]
2. [Cause 2] - Check [Y]

## Debug Checklist
- [ ] [Step 1]
- [ ] [Step 2]

## Known Solutions
[Proven fixes with success rate]
```

## Proactive Suggestions

### During Work Session

**When I detect a pattern:**
```
💡 SKILL SUGGESTION

I've noticed you're [task description] for the 3rd time.

Would you like me to create a "[Skill Name]" skill to automate this?

Benefits:
- Save ~[X] minutes per occurrence
- Reduce errors by [Y%]
- Reusable for future [tasks]

Say "yes" to create, "not now" to skip, or "show me" for details.
```

### End of Session

**Reflection mode:**
```
📊 SESSION ANALYSIS

Today we:
- Mapped 5 CSVs to Shopify (75 minutes)
- Debugged n8n webhook errors (3 occurrences)
- Searched for LinkedIn profiles (10 manual lookups)

SKILL OPPORTUNITIES:
1. CSV-to-Shopify Quick Mapper (save 60 min/day)
2. N8N Webhook Debugger (prevent 80% of errors)
3. LinkedIn Profile Scraper (save 30 min/day)

Create these skills? [Yes / Pick specific ones / Not now]
```

## Skill Evolution Tracking

### Performance Metrics
```javascript
const skillMetrics = {
  skill_name: "csv-to-shopify-auto-mapper",
  created_date: "2024-10-29",
  usage_count: 15,
  time_saved_per_use: 12, // minutes
  total_time_saved: 180, // minutes
  error_prevention_rate: 0.87,
  user_satisfaction: "high",
  last_used: "2024-10-29",
  status: "active" // active, needs_update, deprecated
};
```

### Enhancement Triggers
```javascript
if (skill.usage_count > 10 && skill.error_rate > 0.2) {
  suggest_enhancement({
    reason: "High usage but error-prone",
    proposal: "Add validation step and better error messages"
  });
}

if (skill.last_used > 30_days_ago) {
  suggest_deprecation({
    reason: "Not used in 30 days",
    replacement: "Possibly obsolete or replaced by newer skill"
  });
}
```

## Integration with Existing Skills

### Check for Overlap
```javascript
function checkOverlap(newSkill) {
  const existingSkills = loadSkills();

  const overlaps = existingSkills.filter(existing => {
    return (
      similar(existing.purpose, newSkill.purpose) > 0.7 ||
      existing.keywords.some(k => newSkill.keywords.includes(k))
    );
  });

  if (overlaps.length > 0) {
    return {
      action: "enhance",
      target: overlaps[0].name,
      reason: `Similar to existing skill: ${overlaps[0].name}`
    };
  }

  return { action: "create_new" };
}
```

### Skill Dependencies
```javascript
const skillDependencies = {
  "csv-to-shopify-auto-mapper": [
    "shopify-data-mapper", // base skill
    "data-mapper" // generic mapping
  ],
  "linkedin-profile-scraper": [
    "web-scraping-specialist", // scraping methods
    "api-integration-specialist" // LinkedIn API if available
  ]
};
```

## User Control & Preferences

### Settings
```javascript
const userPreferences = {
  auto_create_skills: false, // Ask before creating
  suggestion_frequency: "high", // high, medium, low
  skill_complexity: "practical", // comprehensive, practical, minimal
  notification_style: "proactive", // proactive, on-request, silent

  auto_approve_types: [
    "automation", // Auto-approve automation skills
    // "integration" // Require approval for integrations
  ],

  never_suggest: [
    "one-off-tasks", // Don't create skills for one-time tasks
    "experimental-features" // Wait until proven
  ]
};
```

### Opt-in/Opt-out
```
User: "Stop suggesting skills"
Response: ✅ Skill suggestions disabled. Say "enable skill suggestions" to re-enable.

User: "Only suggest high-impact skills"
Response: ✅ Will only suggest skills saving >30 min/week or >10% error reduction.
```

## Implementation Checklist

When creating a new skill:

- [ ] Verify pattern occurs 3+ times
- [ ] Check for existing skills that could be enhanced
- [ ] Estimate time saved and error reduction
- [ ] Draft skill with YAML frontmatter
- [ ] Include 3-5 concrete examples
- [ ] Add validation/testing section
- [ ] Create skill file in proper directory
- [ ] Update skills count (now 28, 29, etc.)
- [ ] Notify user with summary
- [ ] Track first usage for metrics

## Example: Real-Time Skill Creation

**Conversation:**
```
User: Can you map this CSV to Shopify?
Assistant: [maps CSV]

User: Now this one too
Assistant: [maps second CSV]

User: I have 10 more of these to do...

💡 I notice you're mapping multiple CSVs to Shopify.

Would you like me to create a "Bulk CSV-to-Shopify Mapper" skill?

It would:
- Batch process multiple CSVs
- Auto-detect format
- Validate before upload
- Save ~40 minutes for 10 files

Create this skill? [Yes]

User: Yes