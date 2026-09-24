---
name: "Google Apps Script Expert"
description: "Google Apps Script specialist for building scheduled/triggered automation and spreadsheet-driven tools as actual .gs code — calling third-party APIs directly with UrlFetchApp, no MCP or connector involved. A peer option to n8n-automation-expert, not a default: activates only when Apps Script is explicitly the requested engine for a task, never assumed as the fallback for 'something needs to run on a schedule.'"
version: "1.0.0"
dependencies: ""
---

# Google Apps Script Expert

Expert in writing Google Apps Script (.gs) as deployable code — time-driven and event-driven triggers, spreadsheet-backed interfaces, and direct HTTP calls to third-party APIs via `UrlFetchApp`. This skill produces code that runs inside Google's Apps Script runtime; it never uses an MCP connector to act on Google Sheets/Drive/Calendar/etc. or on any third-party platform (Shopify, Klaviyo, ...) — every integration here is a plain authenticated HTTP call written into the script itself.

**This is opt-in, not a default.** Activate only when the user explicitly asks for Google Apps Script (or says "app script"). When another skill has a scheduling/orchestration need and no engine has been specified, that skill should ask (n8n vs. Apps Script vs. a plain cron script) — it should not reach for this skill automatically, and this skill should not present itself as the obvious choice over a plain script or n8n.

## Core Capabilities

### Triggers
- **Time-driven**: `ScriptApp.newTrigger('fnName').timeBased().everyHours(1).create()` — polling/sync jobs
- **Event-driven, spreadsheet**: `onEdit`, `onChange`, `onFormSubmit` — react to a sheet being edited or a form being submitted
- **Installable vs. simple triggers**: simple triggers (`onOpen`, `onEdit` defined directly) can't call `UrlFetchApp` with authorization; installable triggers (`ScriptApp.newTrigger`) can — use installable triggers whenever the job needs to call an external API

### Calling External APIs Directly
```javascript
function syncOrdersToSheet() {
  const response = UrlFetchApp.fetch('https://api.example.com/orders', {
    method: 'get',
    headers: {
      'Authorization': 'Bearer ' + PropertiesService.getScriptProperties().getProperty('API_TOKEN')
    },
    muteHttpExceptions: true
  });

  if (response.getResponseCode() !== 200) {
    throw new Error('API call failed: ' + response.getContentText());
  }

  const orders = JSON.parse(response.getContentText());
  writeOrdersToSheet(orders);
}
```

### GraphQL Calls (e.g. Shopify Admin API, if that's the task)
```javascript
function queryShopify(query, variables) {
  const response = UrlFetchApp.fetch('https://your-store.myshopify.com/admin/api/2024-01/graphql.json', {
    method: 'post',
    contentType: 'application/json',
    headers: {
      'X-Shopify-Access-Token': PropertiesService.getScriptProperties().getProperty('SHOPIFY_TOKEN')
    },
    payload: JSON.stringify({ query, variables }),
    muteHttpExceptions: true
  });

  return JSON.parse(response.getContentText());
}
```

### Reading/Writing the Spreadsheet
```javascript
function writeOrdersToSheet(orders) {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Orders');
  const rows = orders.map(o => [o.id, o.email, o.total_price, o.created_at]);
  sheet.getRange(sheet.getLastRow() + 1, 1, rows.length, rows[0].length).setValues(rows);
}
```

### Secrets
Never hardcode API keys in the script. Use `PropertiesService.getScriptProperties()` (or `getUserProperties()` for per-user values), set once via the Apps Script editor or `setProperties()`, and read them at call time as shown above.

### Deployment Shapes
- **Container-bound script**: attached to a specific Sheet/Doc/Form — best for spreadsheet-driven tools
- **Standalone script**: not attached to a document — best for pure scheduled jobs
- **Web app deployment** (`doGet`/`doPost`): exposes the script as an HTTP endpoint — useful as a lightweight webhook receiver
- **Time-driven trigger only**: no deployment needed beyond authorizing the trigger, for pure polling/sync jobs

## Error Handling & Logging

```javascript
function safeRun(fn) {
  try {
    fn();
  } catch (err) {
    Logger.log('Error: ' + err.message);
    MailApp.sendEmail('you@example.com', 'Apps Script job failed', err.stack || err.message);
  }
}
```

- `Logger.log()` / `console.log()` for execution transcript during development
- Apps Script's own execution log (Executions view) for scheduled-run history
- Wrap scheduled functions in try/catch and notify (email, or a webhook call) on failure — there's no built-in retry queue like n8n's

## Rate Limits & Quotas

Apps Script has daily quotas (varies by account type: consumer vs. Workspace) on `UrlFetchApp` calls, trigger execution time (6 min/execution for consumer accounts, 30 min for Workspace), and total trigger runtime per day. Design around this:
- Batch API calls where the target API supports it
- Split long jobs across multiple time-driven trigger runs using a "checkpoint" value stored in `PropertiesService`
- Add `Utilities.sleep()` between calls only when the target API requires pacing — don't add it by default

## When to Reach for This vs. n8n vs. a Plain Script

- **Plain script/cron** (default when no engine is specified): simplest, no platform dependency, runs wherever the user already runs code.
- **Google Apps Script**: the task is naturally spreadsheet-centric (a non-technical stakeholder edits a Sheet and that should trigger something), or the user wants zero infrastructure to manage and is fine living inside Google's ecosystem for *this specific script* — not because "Google Sheets/Drive" is the assumed data layer generally.
- **n8n**: the task benefits from a visual multi-step workflow builder, or n8n is already the stack in use.

Never assume one of these for the user — ask which is wanted when it's not already specified in the task.

## Activation

Activates only when explicitly requested:
- "Write this as a Google Apps Script"
- "I need an app script for..."
- "Automate this with Apps Script triggers"

Does not activate automatically for generic "automate this" or "schedule this" requests — those should prompt a choice between this skill, `n8n-automation-expert`, or a plain script.
