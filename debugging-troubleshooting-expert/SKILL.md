---
name: "Debugging & Troubleshooting Expert"
description: "Master debugger and troubleshooting specialist. Systematically diagnoses issues across frontend, backend, database, API integrations, and deployment. Expert in root cause analysis, live debugging, log analysis, and rapid issue resolution with comprehensive documentation."
version: "1.0.0"
dependencies: "supabase-mcp"
---

# Debugging & Troubleshooting Expert

Elite debugging specialist with systematic approach to identifying, diagnosing, and resolving complex issues across full-stack applications.

## Debugging Methodology

### Systematic Debugging Process

1. **Reproduce the Issue**
   - Get exact steps to reproduce
   - Document expected vs actual behavior
   - Identify if it's consistent or intermittent

2. **Gather Information**
   - Check logs (browser console, server logs, database logs)
   - Review recent changes (git diff)
   - Check related systems (database, APIs, third-party services)

3. **Form Hypothesis**
   - Identify likely causes based on symptoms
   - Prioritize by probability and impact

4. **Test Hypothesis**
   - Add targeted logging
   - Use debugger breakpoints
   - Isolate variables

5. **Fix and Verify**
   - Implement fix
   - Test the fix thoroughly
   - Verify no regressions

6. **Document**
   - Record root cause
   - Document the fix
   - Add tests to prevent regression

## Debugging Tools & Techniques

### Frontend Debugging

#### Browser DevTools
```javascript
// Strategic console logging
console.group('User Authentication Flow')
console.log('1. User data:', userData)
console.log('2. Token:', token ? 'Present' : 'Missing')
console.log('3. Session:', session)
console.groupEnd()

// Performance debugging
console.time('API Call')
await fetch('/api/data')
console.timeEnd('API Call')

// Conditional breakpoints
if (userId === 'problematic-user-id') {
  debugger
}

// Error context
try {
  await riskyOperation()
} catch (error) {
  console.error('Operation failed:', {
    error: error.message,
    stack: error.stack,
    context: { userId, attemptCount }
  })
}
```

#### React DevTools
```tsx
// Debug renders
useEffect(() => {
  console.log('Component rendered with props:', props)
}, [props])

// Track why component re-renders
function useWhyDidYouUpdate(name: string, props: any) {
  const previousProps = useRef<any>()

  useEffect(() => {
    if (previousProps.current) {
      const allKeys = Object.keys({ ...previousProps.current, ...props })
      const changedProps: any = {}

      allKeys.forEach((key) => {
        if (previousProps.current[key] !== props[key]) {
          changedProps[key] = {
            from: previousProps.current[key],
            to: props[key],
          }
        }
      })

      if (Object.keys(changedProps).length > 0) {
        console.log('[why-did-you-update]', name, changedProps)
      }
    }

    previousProps.current = props
  })
}
```

### Backend Debugging

#### Supabase Function Debugging
```typescript
// Comprehensive logging wrapper
function debugLog(context: string, data: any) {
  const timestamp = new Date().toISOString()
  console.log(JSON.stringify({
    timestamp,
    context,
    data,
    requestId: crypto.randomUUID()
  }))
}

serve(async (req) => {
  const requestId = crypto.randomUUID()
  debugLog('function_start', { requestId })

  try {
    const body = await req.json()
    debugLog('request_body', { requestId, body })

    const result = await processRequest(body)
    debugLog('processing_complete', { requestId, result })

    return new Response(JSON.stringify({ success: true, data: result }), {
      headers: corsHeaders,
      status: 200
    })
  } catch (error) {
    debugLog('error_occurred', {
      requestId,
      error: error.message,
      stack: error.stack,
      cause: error.cause
    })

    return new Response(JSON.stringify({
      error: error.message,
      requestId
    }), {
      headers: corsHeaders,
      status: 500
    })
  }
})
```

#### Database Query Debugging
```sql
-- Enable query logging
SHOW log_statement;
SET log_statement = 'all';

-- Analyze slow queries
EXPLAIN ANALYZE
SELECT * FROM clients
WHERE industry = 'technology'
AND created_at > NOW() - INTERVAL '30 days';

-- Check locks
SELECT
  pid,
  usename,
  pg_blocking_pids(pid) as blocked_by,
  query as blocked_query
FROM pg_stat_activity
WHERE cardinality(pg_blocking_pids(pid)) > 0;

-- Monitor active queries
SELECT
  pid,
  now() - pg_stat_activity.query_start AS duration,
  query,
  state
FROM pg_stat_activity
WHERE state != 'idle'
ORDER BY duration DESC;
```

### Network Debugging

#### API Request Debugging
```typescript
// Request/Response interceptor
async function debugFetch(url: string, options?: RequestInit) {
  const requestId = crypto.randomUUID()

  console.log(`[${requestId}] Request:`, {
    url,
    method: options?.method || 'GET',
    headers: options?.headers,
    body: options?.body
  })

  const startTime = Date.now()

  try {
    const response = await fetch(url, options)
    const duration = Date.now() - startTime

    const responseData = await response.text()

    console.log(`[${requestId}] Response:`, {
      status: response.status,
      statusText: response.statusText,
      headers: Object.fromEntries(response.headers.entries()),
      body: responseData,
      duration: `${duration}ms`
    })

    return new Response(responseData, {
      status: response.status,
      statusText: response.statusText,
      headers: response.headers
    })
  } catch (error) {
    const duration = Date.now() - startTime

    console.error(`[${requestId}] Error:`, {
      error: error.message,
      duration: `${duration}ms`
    })

    throw error
  }
}
```

### Workflow Debugging (n8n — reference only, use when n8n is actually in the stack)

#### n8n Workflow Debugging
```javascript
// Debug node in workflow
{
  "name": "Debug Logger",
  "type": "n8n-nodes-base.code",
  "parameters": {
    "jsCode": `
      // Log all incoming data
      console.log('=== Debug Point ===');
      console.log('Input data:', JSON.stringify($input.all(), null, 2));
      console.log('Environment:', {
        nodeCount: $input.all().length,
        firstItem: $input.first(),
        lastItem: $input.last()
      });

      // Check for issues
      const issues = [];
      for (const item of $input.all()) {
        if (!item.json.email) {
          issues.push({ index: item.pairedItem, issue: 'Missing email' });
        }
      }

      if (issues.length > 0) {
        console.warn('Issues found:', issues);
      }

      // Pass through unchanged
      return $input.all();
    `
  }
}
```

## Common Issue Patterns

### Authentication Issues

```typescript
// Debug authentication flow
async function debugAuth() {
  console.log('1. Check session')
  const session = await getSession()
  console.log('Session:', session)

  if (!session) {
    console.log('2. No session - check cookies')
    console.log('Cookies:', document.cookie)
    console.log('LocalStorage:', localStorage.getItem('session'))
  }

  console.log('3. Verify token')
  if (session?.access_token) {
    try {
      const decoded = JSON.parse(atob(session.access_token.split('.')[1]))
      console.log('Token payload:', decoded)
      console.log('Token expires:', new Date(decoded.exp * 1000))
      console.log('Is expired:', Date.now() > decoded.exp * 1000)
    } catch (e) {
      console.error('Token decode error:', e)
    }
  }

  console.log('4. Check API accessibility')
  try {
    const response = await fetch('/api/auth/session')
    console.log('Auth endpoint status:', response.status)
  } catch (e) {
    console.error('Auth endpoint error:', e)
  }
}
```

### Database Connection Issues

```bash
#!/bin/bash
# debug-db-connection.sh

echo "=== Database Connection Debug ==="

# 1. Check environment variables
echo "1. Environment Variables:"
echo "   DATABASE_URL set: ${DATABASE_URL:+YES}"
echo "   SUPABASE_URL: ${SUPABASE_URL}"

# 2. Test DNS resolution
echo "2. DNS Resolution:"
host vajqezvhllefdgdwytgm.supabase.co

# 3. Test connectivity
echo "3. Network Connectivity:"
nc -zv vajqezvhllefdgdwytgm.supabase.co 443

# 4. Test API endpoint
echo "4. API Health:"
curl -v https://vajqezvhllefdgdwytgm.supabase.co/rest/v1/

# 5. Test with credentials
echo "5. Authenticated Request:"
curl -H "apikey: $SUPABASE_ANON_KEY" \
     -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
     https://vajqezvhllefdgdwytgm.supabase.co/rest/v1/clients?select=count

echo "=== Debug Complete ==="
```

### Race Condition Debugging

```typescript
// Detect race conditions
let operationInProgress = false
let operationQueue: Array<() => Promise<void>> = []

async function safeOperation(operation: () => Promise<void>) {
  if (operationInProgress) {
    console.warn('Race condition detected! Queueing operation...')
    operationQueue.push(operation)
    return
  }

  operationInProgress = true
  try {
    await operation()

    // Process queue
    while (operationQueue.length > 0) {
      const nextOp = operationQueue.shift()
      if (nextOp) await nextOp()
    }
  } finally {
    operationInProgress = false
  }
}
```

### Memory Leak Detection

```typescript
// Monitor memory usage
function trackMemory(label: string) {
  if ('memory' in performance) {
    const memory = (performance as any).memory
    console.log(`[${label}] Memory:`, {
      usedJSHeapSize: `${(memory.usedJSHeapSize / 1048576).toFixed(2)} MB`,
      totalJSHeapSize: `${(memory.totalJSHeapSize / 1048576).toFixed(2)} MB`,
      limit: `${(memory.jsHeapSizeLimit / 1048576).toFixed(2)} MB`
    })
  }
}

// Usage
trackMemory('before')
await heavyOperation()
trackMemory('after')

// Detect leaks in React
useEffect(() => {
  const interval = setInterval(() => {
    trackMemory('component-mounted')
  }, 5000)

  return () => {
    clearInterval(interval)
    trackMemory('component-unmounted')
  }
}, [])
```

## Live Debugging Scripts

### Supabase Live Monitor
```bash
#!/bin/bash
# monitor-supabase.sh

SUPABASE_URL="https://vajqezvhllefdgdwytgm.supabase.co"
SERVICE_KEY="your-service-key"

while true; do
  clear
  echo "=== Supabase Live Monitor ==="
  echo "Time: $(date)"
  echo ""

  # Check onboarding workflows
  echo "Recent Onboarding Workflows:"
  curl -s -H "apikey: $SERVICE_KEY" \
       -H "Authorization: Bearer $SERVICE_KEY" \
       "$SUPABASE_URL/rest/v1/onboarding_workflows?select=*&order=created_at.desc&limit=5" \
       | jq '.[] | {id, workflow_state, current_step, percent_progress, created_at}'

  echo ""

  # Check recent errors
  echo "Recent Errors:"
  curl -s -H "apikey: $SERVICE_KEY" \
       -H "Authorization: Bearer $SERVICE_KEY" \
       "$SUPABASE_URL/rest/v1/error_logs?select=*&order=created_at.desc&limit=5" \
       | jq '.[] | {function_name, error_message, created_at}'

  sleep 5
done
```

### Edge Function Health Check
```typescript
// health-check-agent.ts
async function checkEdgeFunctions() {
  const functions = [
    'intelligence-gaurd',
    'comprehensive-intelligence',
    'website-analyzer',
    'brand-analyzer',
    'brand-guide-analyzer'
  ]

  const results = []

  for (const func of functions) {
    const startTime = Date.now()

    try {
      const response = await fetch(
        `${Deno.env.get('SUPABASE_URL')}/functions/v1/${func}`,
        {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ health_check: true })
        }
      )

      const duration = Date.now() - startTime

      results.push({
        function: func,
        status: response.status,
        duration: `${duration}ms`,
        healthy: response.ok
      })
    } catch (error) {
      results.push({
        function: func,
        status: 'error',
        error: error.message,
        healthy: false
      })
    }
  }

  return results
}
```

## Error Pattern Recognition

### Common Error Signatures

**Timeout Errors:**
```
- "Function execution timed out"
- "Request timeout"
- "Gateway timeout (504)"
→ Solution: Implement queue pattern, optimize queries
```

**Authentication Errors:**
```
- "Invalid JWT token"
- "User not authenticated"
- "Unauthorized (401)"
→ Solution: Check token expiry, refresh flow, session handling
```

**Database Errors:**
```
- "PGRST301: JWT expired"
- "relation does not exist"
- "violates foreign key constraint"
→ Solution: Check RLS policies, verify schema, check data integrity
```

**CORS Errors:**
```
- "CORS policy: No 'Access-Control-Allow-Origin'"
- "Preflight request failed"
→ Solution: Add CORS headers, handle OPTIONS requests
```

## Troubleshooting Checklist

### Frontend Issues
- [ ] Check browser console for errors
- [ ] Verify network requests in DevTools
- [ ] Check React component state
- [ ] Verify environment variables
- [ ] Test in incognito mode (cache issues)
- [ ] Check responsive design in different viewports

### Backend Issues
- [ ] Check function logs
- [ ] Verify database connectivity
- [ ] Check API rate limits
- [ ] Verify environment secrets
- [ ] Test queries in Supabase dashboard
- [ ] Check for database locks

### Integration Issues
- [ ] Verify API keys are valid
- [ ] Check webhook endpoints are accessible
- [ ] Test third-party API responses
- [ ] Verify payload formats
- [ ] Check for rate limiting
- [ ] Monitor queue status

### Performance Issues
- [ ] Check database query performance (EXPLAIN ANALYZE)
- [ ] Monitor API response times
- [ ] Check for N+1 queries
- [ ] Verify indexes exist
- [ ] Check bundle size
- [ ] Monitor memory usage

## Best Practices

- ✅ Reproduce issues before debugging
- ✅ Use systematic approach
- ✅ Add comprehensive logging
- ✅ Document root causes
- ✅ Create regression tests
- ✅ Monitor in production
- ✅ Use proper error boundaries
- ✅ Implement health checks
- ✅ Track error patterns
- ✅ Set up alerts for critical issues

## Activation

Activates for:
- Application errors and bugs
- Performance issues
- Integration failures
- Database problems
- Deployment issues
- Mysterious behavior
- Live debugging sessions

Provides systematic, thorough debugging with resolution.
