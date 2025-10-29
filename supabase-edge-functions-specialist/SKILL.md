---
name: "Supabase Edge Functions Specialist"
description: "Expert in Supabase Edge Functions deployment, debugging, and optimization. Handles function versioning, deployment via CLI and MCP, timeout prevention, error handling, and ensures reliable execution. Specialized in PrixFlow platform's 75+ edge functions architecture."
version: "1.0.0"
dependencies: "supabase-mcp"
---

# Supabase Edge Functions Specialist

Elite Supabase Edge Functions engineer specializing in deployment, debugging, performance optimization, and managing large-scale function architectures.

## Core Expertise

### Edge Functions Architecture

#### Standard Function Structure
```typescript
// supabase/functions/function-name/index.ts
import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )

    const { data, error } = await req.json()

    // Function logic here
    const result = await processData(data)

    return new Response(
      JSON.stringify({ success: true, data: result }),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 200,
      }
    )
  } catch (error) {
    console.error('Function error:', error)
    return new Response(
      JSON.stringify({ error: error.message }),
      {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 500,
      }
    )
  }
})
```

### Deployment Methods

#### CLI Deployment
```bash
# Deploy single function
supabase functions deploy function-name

# Deploy all functions
supabase functions deploy

# Deploy with custom environment
supabase functions deploy function-name --project-ref YOUR_PROJECT_REF

# Set secrets
supabase secrets set OPENAI_API_KEY=sk-...
supabase secrets set RESEND_API_KEY=re_...
```

#### MCP Deployment
```typescript
// Using Supabase MCP for deployment
import { mcp__supabase__deploy_edge_function } from '@/mcp/supabase'

await mcp__supabase__deploy_edge_function({
  name: 'intelligence-gaurd',
  files: [
    {
      name: 'index.ts',
      content: functionCode
    }
  ],
  entrypoint_path: 'index.ts'
})
```

### Timeout Prevention

#### Long-Running Function Pattern
```typescript
// For operations that may exceed timeout
serve(async (req) => {
  try {
    const { client_id } = await req.json()

    // Start async processing
    const processingPromise = longRunningTask(client_id)

    // Immediately return with task ID
    const taskId = crypto.randomUUID()

    // Continue processing in background
    processingPromise.then(async (result) => {
      await supabase.from('task_results').insert({
        task_id: taskId,
        result,
        completed_at: new Date().toISOString()
      })
    }).catch(async (error) => {
      await supabase.from('task_errors').insert({
        task_id: taskId,
        error: error.message,
        failed_at: new Date().toISOString()
      })
    })

    return new Response(
      JSON.stringify({ task_id: taskId, status: 'processing' }),
      { headers: corsHeaders, status: 202 }
    )
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: corsHeaders,
      status: 500
    })
  }
})
```

#### Chain Functions with Queue Pattern
```typescript
// Function 1: Start processing
async function initiateWorkflow(client_id: string) {
  // Insert job into queue
  await supabase.from('job_queue').insert({
    client_id,
    job_type: 'intelligence_analysis',
    status: 'pending',
    created_at: new Date().toISOString()
  })

  return { queued: true }
}

// Function 2: Worker that processes queue
async function processQueue() {
  const { data: jobs } = await supabase
    .from('job_queue')
    .select('*')
    .eq('status', 'pending')
    .limit(5)

  for (const job of jobs || []) {
    // Mark as processing
    await supabase.from('job_queue')
      .update({ status: 'processing' })
      .eq('id', job.id)

    try {
      // Do work
      await performAnalysis(job.client_id)

      // Mark complete
      await supabase.from('job_queue')
        .update({ status: 'completed' })
        .eq('id', job.id)
    } catch (error) {
      await supabase.from('job_queue')
        .update({
          status: 'failed',
          error: error.message
        })
        .eq('id', job.id)
    }
  }
}

// Cron trigger (setup in Supabase)
// SELECT cron.schedule('process-queue', '* * * * *', $$
//   SELECT net.http_post(
//     url:='https://PROJECT_REF.supabase.co/functions/v1/queue-processor',
//     headers:='{"Authorization": "Bearer SERVICE_KEY"}'::jsonb
//   );
// $$);
```

### Error Handling & Retry Logic

```typescript
async function retryWithExponentialBackoff<T>(
  fn: () => Promise<T>,
  maxRetries = 3,
  baseDelay = 1000
): Promise<T> {
  for (let attempt = 0; attempt <= maxRetries; attempt++) {
    try {
      return await fn()
    } catch (error) {
      if (attempt === maxRetries) throw error

      const delay = baseDelay * Math.pow(2, attempt)
      console.log(`Retry attempt ${attempt + 1} after ${delay}ms`)
      await new Promise(resolve => setTimeout(resolve, delay))
    }
  }
  throw new Error('Max retries exceeded')
}

// Usage
const result = await retryWithExponentialBackoff(
  () => fetch('https://api.openai.com/v1/chat/completions', {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${apiKey}` },
    body: JSON.stringify(payload)
  })
)
```

### Function Versioning

```typescript
// Version tracking in database
const FUNCTION_VERSION = '2.1.0'

serve(async (req) => {
  // Log function execution
  await supabase.from('function_executions').insert({
    function_name: 'intelligence-gaurd',
    version: FUNCTION_VERSION,
    executed_at: new Date().toISOString(),
    request_id: req.headers.get('x-request-id')
  })

  // Function logic...
})
```

### Debugging Edge Functions

#### Local Testing
```bash
# Start local Supabase
supabase start

# Serve function locally
supabase functions serve intelligence-gaurd

# Test with curl
curl -i --location --request POST 'http://localhost:54321/functions/v1/intelligence-gaurd' \
  --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...' \
  --header 'Content-Type: application/json' \
  --data '{"client_id":"123"}'
```

#### Remote Debugging
```typescript
// Comprehensive logging
console.log({
  timestamp: new Date().toISOString(),
  event: 'function_start',
  data: { client_id }
})

try {
  const result = await processData(client_id)
  console.log({ event: 'processing_complete', result })
} catch (error) {
  console.error({
    event: 'error',
    error: error.message,
    stack: error.stack,
    context: { client_id }
  })
  throw error
}
```

#### Check Logs
```bash
# View function logs
supabase functions logs intelligence-gaurd --tail

# Filter logs
supabase functions logs intelligence-gaurd --filter "error"
```

### Performance Optimization

#### Batch Processing
```typescript
// Process multiple items in parallel
async function batchProcess(items: string[]) {
  const BATCH_SIZE = 10

  for (let i = 0; i < items.length; i += BATCH_SIZE) {
    const batch = items.slice(i, i + BATCH_SIZE)

    await Promise.all(
      batch.map(item => processItem(item))
    )

    // Brief pause between batches
    if (i + BATCH_SIZE < items.length) {
      await new Promise(resolve => setTimeout(resolve, 100))
    }
  }
}
```

#### Caching Strategy
```typescript
// Cache expensive operations
const cache = new Map<string, { data: any; timestamp: number }>()
const CACHE_TTL = 5 * 60 * 1000 // 5 minutes

async function getCachedData(key: string, fetchFn: () => Promise<any>) {
  const cached = cache.get(key)

  if (cached && Date.now() - cached.timestamp < CACHE_TTL) {
    console.log('Cache hit:', key)
    return cached.data
  }

  console.log('Cache miss:', key)
  const data = await fetchFn()

  cache.set(key, { data, timestamp: Date.now() })
  return data
}
```

### Common Patterns for PrixFlow

#### Intelligence Guard Pattern
```typescript
// Orchestrates multiple analysis functions
serve(async (req) => {
  const { client_id } = await req.json()

  // Trigger analyses in sequence with proper error handling
  const analyses = [
    { name: 'comprehensive-intelligence', priority: 1 },
    { name: 'website-analyzer', priority: 2 },
    { name: 'brand-analyzer', priority: 3 }
  ]

  const results = []

  for (const analysis of analyses) {
    try {
      const response = await fetch(
        `${Deno.env.get('SUPABASE_URL')}/functions/v1/${analysis.name}`,
        {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ client_id })
        }
      )

      const data = await response.json()
      results.push({ analysis: analysis.name, success: true, data })
    } catch (error) {
      console.error(`${analysis.name} failed:`, error)
      results.push({ analysis: analysis.name, success: false, error: error.message })
    }
  }

  return new Response(JSON.stringify({ results }), {
    headers: corsHeaders,
    status: 200
  })
})
```

## Troubleshooting Guide

### Common Issues

**Issue: Function truncated in dashboard**
- **Cause**: Dashboard shows transpiled/minified version
- **Solution**: Use CLI deployment or verify via `supabase functions download`

**Issue: Function timeout**
- **Cause**: Execution exceeds 150s limit
- **Solution**: Implement queue pattern, return 202 Accepted immediately

**Issue: Cross-database reference error**
- **Cause**: Using `extensions.net.http_post` incorrectly
- **Solution**: Use `supabase.functions.invoke()` or direct fetch

**Issue: Environment variables not available**
- **Cause**: Secrets not set in Supabase
- **Solution**: `supabase secrets set KEY=value`

## Best Practices

- ✅ Always handle CORS properly
- ✅ Use exponential backoff for retries
- ✅ Log comprehensively for debugging
- ✅ Implement timeout prevention strategies
- ✅ Version your functions
- ✅ Test locally before deploying
- ✅ Use TypeScript for type safety
- ✅ Handle errors gracefully
- ✅ Monitor function execution
- ✅ Optimize for cold starts

## Activation

Activates for:
- Edge function deployment
- Function debugging
- Timeout issues
- Performance optimization
- Error handling
- Version management
- MCP integration

Provides reliable Supabase Edge Functions management.
