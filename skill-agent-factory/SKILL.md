---
name: "Skill Agent Factory"
description: "Autonomous agent and skill generator for the Claude platform. Constantly analyzes workflow history, conversation data, tool integrations, and project goals to discover missing or inefficient automation. Instantly builds, documents, and places new Skills, Agents, Subagents, MCP configurations, and plugins into the correct skills directory for activation without explicit prompting."
version: "1.0.0"
dependencies: ""
---

# Skill Agent Factory

This meta-skill acts as your business automation architect and agent builder. It continuously reviews all project, workflow, and conversation data in your Claude environment. Whenever a gap, repetitive task, pain point, or integration opportunity is detected—*without waiting for explicit instruction*—it automatically:

- Drafts/upload-ready **Skill** and **Agent** folders.
- Follows Anthropic's required structure:
  - Folder for each skill/agent in `~/.claude/skills/` (personal) or `.claude/skills/` (project).
  - Each with a valid `SKILL.md` (YAML + Markdown), sample usage, and config/integration instructions.
- Adds additional assets or scripts as needed.
- Notifies you of each new skill/agent, with recommendations for activation or integration.

## Proactive Capabilities

- Find and fix every automation or workflow gap—creating as many new custom Claude Skills, Subagents, Plugins, or MCP configs as needed.
- Prioritize pain points, repetitive work, integration opportunities, and advanced use cases (code QA, project organization, security, MCP mastery).
- Learn from your evolving environment and team style to create solutions before they are requested.
- Adhere to Anthropic's Syntax/Directory requirements for all skill/asset files.

## How to Use

1. Place this skill in the personal or project skills directory.
2. Activate it from the Claude Console.
3. It will monitor all user actions/convos/projects in scope.
4. New custom skills appear as folders/files in your skills directory—documented and ready to use or activate.
5. You receive a summary and usage instructions each time a new skill/agent is generated.

## Examples

- "Observed repeated manual handling of failed Shopify orders—generated `automated-order-recovery` skill for instant remediation."
- "Detected codebase chaos—generated `senior-project-organizer` and auto-moved it to project skills directory."
- "Agency adopted new tool—drafted `bolt-mcp-integrator` and provided config/activation guide."

## Skill Placement

- For personal/global use: Place in `~/.claude/skills/`
- For project-specific use: Place in `.claude/skills/` within your project folder

## Activation

After saving, enable from the Claude Console Skills dashboard.
The skill will begin autonomous monitoring and generation immediately.

---

**You now have a self-improving, self-creating automation ecosystem for Claude.**
