---
name: "Instant Skill Publisher"
description: "Rapid skill creation and GitHub publishing system. Listens for 'new skill' command, creates fully-formatted skill from context, commits to git, and pushes to GitHub automatically. Makes skill creation instant and frictionless."
version: "1.0.0"
dependencies: "git, github"
---

# Instant Skill Publisher

One-command skill creation and publishing to GitHub.

## Core Purpose

When user says **"new skill"**, instantly:
1. Create skill from conversation context
2. Format with proper YAML frontmatter
3. Add to skills directory
4. Commit to git
5. Push to GitHub
6. Confirm success

## Trigger Phrases

**Primary:**
- "new skill"
- "create this as a skill"
- "make this a skill"

**Context-aware:**
- "save this workflow as a skill"
- "I'll need this again, make it a skill"
- "this should be reusable"

## Workflow

### Step 1: Context Analysis

When triggered, analyze:
```javascript
const context = {
  recent_task: "What were we just working on?",
  conversation_history: "Last 10 messages",
  tools_used: ["Bash", "Edit", "Read", etc.],
  files_touched: ["file paths"],
  commands_run: ["git", "npm", etc.],
  user_intent: "What problem did we solve?"
};
```

### Step 2: Skill Definition

Extract skill components:
```javascript
const skillDraft = {
  name: generateSkillName(context),
  description: summarizePurpose(context),
  version: "1.0.0",
  content: {
    problem: "What pain point does this solve?",
    solution: "How does it solve it?",
    examples: extractExamples(context),
    usage: "When to use this skill",
    code: extractCodeSnippets(context)
  }
};
```

### Step 3: Create Skill File

```javascript
const skillPath = `/Users/amy/.claude/skills/${skillDraft.slug}/SKILL.md`;

const yamlFrontmatter = `---
name: "${skillDraft.name}"
description: "${skillDraft.description}"
version: "${skillDraft.version}"
dependencies: "${skillDraft.dependencies || ''}"
---
`;

const content = `${yamlFrontmatter}

# ${skillDraft.name}

${skillDraft.content.summary}

## Problem Solved

${skillDraft.content.problem}

## How It Works

${skillDraft.content.solution}

## Usage Examples

${skillDraft.content.examples}

## When to Use

${skillDraft.content.usage}

${skillDraft.content.code ? `## Code Examples\n\n${skillDraft.content.code}` : ''}
`;

fs.writeFileSync(skillPath, content);
```

### Step 4: Git Commit & Push

```bash
cd /Users/amy/.claude/skills
git add .
git commit -m "feat: add ${skillDraft.name} skill"
git push origin main
```

### Step 5: Confirmation

```
✅ Skill Created & Published!

📦 **${skillDraft.name}**
📝 ${skillDraft.description}
📂 ${skillPath}
🌐 https://github.com/amkniss/new-claude-skills

The skill is now:
- ✅ Available in Claude Code
- ✅ Committed to git
- ✅ Pushed to GitHub
- ✅ Ready to use

Total skills: ${totalSkillCount}
```

## Skill Name Generation

### Rules
1. **Descriptive** - Clearly states purpose
2. **Hyphenated** - Use dashes, not spaces
3. **Specific** - Not too generic
4. **Memorable** - Easy to reference

### Examples

**From context:** Mapping product CSVs to Shopify
**Generated name:** `product-csv-shopify-mapper`

**From context:** Automating LinkedIn profile scraping
**Generated name:** `linkedin-profile-automation`

**From context:** Debugging n8n webhook errors
**Generated name:** `n8n-webhook-debugger`

### Algorithm
```javascript
function generateSkillName(context) {
  const task = extractPrimaryTask(context);
  const tools = extractTools(context);
  const action = extractAction(context); // scrape, map, debug, etc.

  // Pattern: [action]-[object]-[tool/context]
  const name = `${action}-${task}-${tools[0]}`.toLowerCase();

  // Clean up
  return name
    .replace(/\s+/g, '-')
    .replace(/[^a-z0-9-]/g, '')
    .replace(/-+/g, '-')
    .substring(0, 50);
}

// Example
generateSkillName({
  task: "CSV mapping",
  tools: ["Shopify"],
  action: "automate"
});
// Result: "automate-csv-mapping-shopify"
```

## Content Generation

### Section 1: Problem Statement
```javascript
function extractProblem(context) {
  // Look for user frustration signals
  const frustrationPhrases = [
    "this is tedious",
    "takes too long",
    "always have to",
    "manual",
    "repetitive"
  ];

  // Extract problem from conversation
  const problem = context.messages
    .filter(msg => frustrationPhrases.some(phrase => msg.includes(phrase)))
    .join("\n");

  return problem || "Manual process that can be automated";
}
```

### Section 2: Solution Description
```javascript
function extractSolution(context) {
  const steps = context.actions.map((action, index) => {
    return `${index + 1}. ${action.description}`;
  });

  return `
Automates the following workflow:

${steps.join('\n')}

This eliminates manual work and reduces errors.
  `.trim();
}
```

### Section 3: Examples
```javascript
function extractExamples(context) {
  // Use actual commands/files from conversation
  const examples = context.commands.slice(0, 3).map(cmd => `
\`\`\`bash
${cmd}
\`\`\`
  `);

  return examples.join('\n\n');
}
```

## User Customization

### Quick Mode (Default)
```
User: new skill

Response:
💡 Creating skill from our recent work...

[Creates skill automatically based on context]

✅ Created "${skill_name}" skill
📦 Pushed to GitHub
```

### Detailed Mode
```
User: new skill (detailed)

Response:
I'll create a skill based on our recent work. Here's what I extracted:

**Name:** product-csv-shopify-mapper
**Purpose:** Automate CSV to Shopify product mapping
**Key Features:**
- Auto-detect column formats
- Price cleaning
- Image URL validation

Looks good? I can:
1. Create as-is
2. Adjust name/description
3. Add more examples
4. Cancel

What would you like?
```

### Custom Name
```
User: new skill "My Custom Skill Name"

Response:
✅ Creating skill: "My Custom Skill Name"
[Creates with user-specified name]
```

## Integration with Workflow Analyzer

When **Workflow Analyzer** suggests a skill:
```
Workflow Analyzer:
💡 SKILL SUGGESTION
Create "Bulk Image Optimizer" skill?

User: new skill

Instant Publisher:
✅ Creating suggested skill "Bulk Image Optimizer"...
[Pulls details from Workflow Analyzer suggestion]
[Creates and publishes]
```

## Git Operations

### Pre-flight Checks
```bash
# Check if in git repo
git rev-parse --git-dir 2>/dev/null

# Check if remote configured
git remote -v | grep origin

# Check for uncommitted changes
git status --porcelain

# Check branch
git branch --show-current
```

### Commit Message Format
```
feat: add ${skill_name} skill

${short_description}

- Solves: ${problem}
- Saves: ${time_saved}
- Examples: ${example_count}

Auto-generated by Instant Skill Publisher
```

### Push with Error Handling
```javascript
async function pushToGitHub() {
  try {
    await exec('git push origin main');
    return { success: true };
  } catch (error) {
    if (error.includes('authentication')) {
      return {
        success: false,
        error: 'GitHub authentication failed',
        action: 'Run: gh auth login'
      };
    } else if (error.includes('rejected')) {
      return {
        success: false,
        error: 'Push rejected (remote has changes)',
        action: 'Run: git pull origin main'
      };
    } else {
      return {
        success: false,
        error: error.message,
        action: 'Check git configuration'
      };
    }
  }
}
```

## Skill Registry

Maintain a skills registry:
```json
{
  "skills": [
    {
      "name": "product-csv-shopify-mapper",
      "created": "2024-10-29T12:00:00Z",
      "version": "1.0.0",
      "author": "instant-skill-publisher",
      "path": "/Users/amy/.claude/skills/product-csv-shopify-mapper",
      "github_url": "https://github.com/amkniss/new-claude-skills/tree/main/product-csv-shopify-mapper",
      "usage_count": 0,
      "last_updated": "2024-10-29T12:00:00Z",
      "status": "active"
    }
  ],
  "total_skills": 28,
  "last_sync": "2024-10-29T12:00:00Z"
}
```

### Update Registry
```javascript
function updateRegistry(newSkill) {
  const registryPath = '/Users/amy/.claude/skills/registry.json';
  const registry = JSON.parse(fs.readFileSync(registryPath));

  registry.skills.push({
    name: newSkill.name,
    created: new Date().toISOString(),
    version: newSkill.version,
    author: "instant-skill-publisher",
    path: newSkill.path,
    github_url: `https://github.com/amkniss/new-claude-skills/tree/main/${newSkill.slug}`,
    usage_count: 0,
    last_updated: new Date().toISOString(),
    status: "active"
  });

  registry.total_skills = registry.skills.length;
  registry.last_sync = new Date().toISOString();

  fs.writeFileSync(registryPath, JSON.stringify(registry, null, 2));
}
```

## Quality Checks

Before creating skill:

### Check 1: Sufficient Context
```javascript
function hasSufficientContext(context) {
  return (
    context.messages.length >= 5 &&
    context.actions.length >= 2 &&
    context.user_intent !== null
  );
}

if (!hasSufficientContext(context)) {
  ask("I need more context. What should this skill do?");
}
```

### Check 2: Not Duplicate
```javascript
function isDuplicate(newSkillName) {
  const existing = loadAllSkills();
  const similar = existing.filter(skill =>
    similarity(skill.name, newSkillName) > 0.8
  );

  if (similar.length > 0) {
    ask(`Similar skill exists: "${similar[0].name}". Enhance it instead?`);
    return true;
  }
  return false;
}
```

### Check 3: Reusability
```javascript
function isReusable(context) {
  // One-off task indicators
  const oneOffSignals = [
    "just this once",
    "one time",
    "specific to this project"
  ];

  if (context.messages.some(msg =>
    oneOffSignals.some(signal => msg.includes(signal))
  )) {
    ask("This seems like a one-off task. Still create skill?");
    return false;
  }

  return true;
}
```

## Usage Tracking

### Log Skill Creation
```javascript
const skillCreationLog = {
  timestamp: new Date().toISOString(),
  skill_name: "product-csv-shopify-mapper",
  context_messages: 12,
  context_actions: 5,
  time_to_create: "3 seconds",
  auto_approved: true,
  github_pushed: true,
  user: "amy"
};

appendLog('/Users/amy/.claude/skills/creation-log.jsonl', skillCreationLog);
```

### Analytics
```javascript
// Total skills created by this system
const totalCreated = registry.skills.filter(s =>
  s.author === "instant-skill-publisher"
).length;

// Average creation time
const avgTime = skillCreationLogs.reduce((sum, log) =>
  sum + log.time_to_create, 0
) / skillCreationLogs.length;

// Most productive days
const byDay = groupBy(skillCreationLogs, log =>
  new Date(log.timestamp).toDateString()
);
```

## Advanced Features

### Template Selection
```javascript
const templates = {
  automation: "Automation skill template",
  integration: "API integration template",
  debugger: "Debugging assistant template",
  data_mapper: "Data transformation template",
  scraper: "Web scraping template"
};

function selectTemplate(context) {
  if (context.tools.includes("Playwright")) return templates.scraper;
  if (context.apis.length > 1) return templates.integration;
  if (context.errors.length > 0) return templates.debugger;
  // ... etc
}
```

### Multi-file Skills
```javascript
// For complex skills
const skillFiles = {
  main: `${skillPath}/SKILL.md`,
  examples: `${skillPath}/EXAMPLES.md`,
  config: `${skillPath}/config.json`,
  scripts: `${skillPath}/scripts/`
};
```

### Skill Dependencies
```yaml
---
name: "Advanced Shopify Mapper"
dependencies: "shopify-data-mapper, data-mapper, web-scraping-specialist"
---
```

## Example Scenarios

### Scenario 1: After Repetitive Task
```
[User maps 3 CSVs to Shopify]

User: new skill