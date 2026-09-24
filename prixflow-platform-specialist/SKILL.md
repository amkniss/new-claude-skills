---
name: "PrixFlow Platform Specialist"
description: "Expert specialist for the PrixFlow lead generation and client onboarding platform. Deep knowledge of the platform's architecture, onboarding workflows, intelligence analysis system, content generation pipeline, and all integrations. Handles platform-specific debugging, optimization, and feature development."
version: "1.0.0"
dependencies: "supabase-mcp"
---

# PrixFlow Platform Specialist

Expert in the PrixFlow platform architecture, workflows, and all subsystems. Specialized knowledge of client onboarding, intelligence gathering, content generation, and approval workflows.

## Platform Architecture

### Core Systems

#### 1. Client Onboarding System
```typescript
// Workflow States
type WorkflowState =
  | 'registration'
  | 'company_info'
  | 'competitors_industry'
  | 'social_profiles'
  | 'marketing_goals'
  | 'brand_information'
  | 'content_preferences'
  | 'completed'

// Database Schema
interface OnboardingWorkflow {
  workflow_id: string
  client_id: string
  workflow_state: WorkflowState
  current_step: number
  total_steps: number
  percent_progress: number
  step_data: Record<string, any>
  completed_steps: string[]
  started_at: string
  completed_at: string | null
  last_updated_at: string
}

interface OnboardingEvent {
  event_id: string
  workflow_id: string
  client_id: string
  event_type: string
  event_data: Record<string, any>
  created_at: string
}
```

#### 2. Intelligence Analysis System
```typescript
// Intelligence Guard Orchestration
async function intelligenceGuard(client_id: string) {
  const analyses = [
    {
      name: 'comprehensive-intelligence',
      function: 'comprehensive-intelligence',
      priority: 1,
      dependencies: []
    },
    {
      name: 'website-analyzer',
      function: 'website-analyzer',
      priority: 2,
      dependencies: ['comprehensive-intelligence']
    },
    {
      name: 'brand-analyzer',
      function: 'brand-analyzer',
      priority: 3,
      dependencies: ['comprehensive-intelligence']
    }
  ]

  // Execute in sequence with proper error handling
  for (const analysis of analyses) {
    try {
      await invokeEdgeFunction(analysis.function, { client_id })

      // Mark as complete
      await supabase.from('intelligence_analysis').insert({
        client_id,
        analysis_type: analysis.name,
        status: 'completed',
        completed_at: new Date().toISOString()
      })
    } catch (error) {
      await logAnalysisError(client_id, analysis.name, error)
    }
  }
}
```

#### 3. Content Generation Pipeline
```typescript
// Content Request → Generation → Approval Flow
interface ContentRequest {
  request_id: string
  client_id: string
  content_type: 'blog_post' | 'social_media' | 'email'
  topic: string
  keywords: string[]
  target_audience: string
  tone: string
  status: 'pending' | 'generating' | 'awaiting_approval' | 'approved' | 'published'
  created_at: string
}

// Generation Workflow
async function generateContent(request_id: string) {
  // 1. Fetch client intelligence
  const intelligence = await getClientIntelligence(client_id)

  // 2. Generate content using OpenAI
  const content = await generateWithAI({
    intelligence,
    request: contentRequest,
    prompt: buildPrompt(contentRequest, intelligence)
  })

  // 3. Generate image (if needed)
  const image = await generateImage(content.topic)

  // 4. Store for approval
  await supabase.from('generated_content').insert({
    request_id,
    content: content.body,
    image_url: image.url,
    status: 'awaiting_approval'
  })

  // 5. Notify client
  await sendApprovalNotification(client_id, request_id)
}
```

### Database Schema Overview

```sql
-- Core Tables
clients (
  client_id uuid PRIMARY KEY,
  company_name text NOT NULL,
  email text UNIQUE NOT NULL,
  industry text,
  website text,
  business_description text,
  created_at timestamptz DEFAULT now()
)

onboarding_workflows (
  workflow_id uuid PRIMARY KEY,
  client_id uuid REFERENCES clients(client_id),
  workflow_state text NOT NULL,
  current_step integer,
  total_steps integer,
  percent_progress numeric,
  step_data jsonb,
  completed_steps text[],
  started_at timestamptz,
  completed_at timestamptz,
  last_updated_at timestamptz
)

brand_guides (
  guide_id uuid PRIMARY KEY,
  client_id uuid REFERENCES clients(client_id),
  file_url text,
  analysis_results jsonb,
  processed_at timestamptz
)

intelligence_analysis (
  analysis_id uuid PRIMARY KEY,
  client_id uuid REFERENCES clients(client_id),
  analysis_type text,
  data jsonb,
  status text,
  completed_at timestamptz
)

content_requests (
  request_id uuid PRIMARY KEY,
  client_id uuid REFERENCES clients(client_id),
  content_type text,
  topic text,
  status text,
  created_at timestamptz
)

generated_content (
  content_id uuid PRIMARY KEY,
  request_id uuid REFERENCES content_requests(request_id),
  content text,
  image_url text,
  status text,
  approved_at timestamptz
)
```

### Edge Functions Architecture

#### Critical Functions (75+ total)

**Onboarding Functions:**
- `brand-guide-analyzer`: Analyzes uploaded brand guides
- `onboarding-event-handler`: Handles onboarding state changes
- `validate-onboarding-step`: Validates step data before progression

**Intelligence Functions:**
- `intelligence-gaurd`: Orchestrates all intelligence gathering
- `comprehensive-intelligence`: Main intelligence gathering
- `website-analyzer`: Analyzes client website
- `brand-analyzer`: Analyzes brand identity
- `competitor-analyzer`: Competitor research
- `social-media-analyzer`: Social media presence analysis

**Content Functions:**
- `content-generator`: Main content generation
- `image-generator`: AI image generation via Replicate
- `content-optimizer`: SEO optimization
- `content-scheduler`: Publishing schedule management

**Integration Functions:**
- `wix-webhook-handler`: Wix CMS integration
- `resend-email-handler`: Email sending
- `openai-proxy`: OpenAI API wrapper with error handling

### Common Issues & Solutions

#### Issue: Onboarding Workflow Not Progressing
```typescript
// Debug onboarding workflow
async function debugOnboardingWorkflow(client_id: string) {
  // 1. Check workflow exists
  const workflow = await supabase
    .from('onboarding_workflows')
    .select('*')
    .eq('client_id', client_id)
    .single()

  console.log('Workflow state:', workflow.data)

  // 2. Check events
  const events = await supabase
    .from('onboarding_events')
    .select('*')
    .eq('client_id', client_id)
    .order('created_at', { ascending: false })

  console.log('Recent events:', events.data)

  // 3. Verify completed steps match
  const expectedSteps = [
    'company_info',
    'competitors_industry',
    'social_profiles',
    'marketing_goals',
    'brand_information',
    'content_preferences'
  ]

  const completedSteps = workflow.data?.completed_steps || []
  const missingSteps = expectedSteps.filter(
    step => !completedSteps.includes(step)
  )

  console.log('Missing steps:', missingSteps)

  return {
    workflow,
    events: events.data,
    missingSteps
  }
}
```

#### Issue: Intelligence Analysis Not Running
```typescript
// Backfill intelligence analysis
async function backfillIntelligence(client_id: string) {
  console.log('Starting intelligence backfill for:', client_id)

  // Check if already completed
  const existing = await supabase
    .from('intelligence_analysis')
    .select('analysis_type')
    .eq('client_id', client_id)

  const completed = existing.data?.map(a => a.analysis_type) || []

  const required = [
    'comprehensive-intelligence',
    'website-analyzer',
    'brand-analyzer'
  ]

  const missing = required.filter(a => !completed.includes(a))

  if (missing.length === 0) {
    console.log('All intelligence analyses complete')
    return
  }

  console.log('Running missing analyses:', missing)

  // Trigger intelligence guard
  await fetch(
    `${Deno.env.get('SUPABASE_URL')}/functions/v1/intelligence-gaurd`,
    {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ client_id, force: true })
    }
  )

  console.log('Intelligence guard triggered')
}
```

#### Issue: Content Generation Timeout
```typescript
// Queue-based content generation
async function queueContentGeneration(request_id: string) {
  // Insert into queue instead of processing immediately
  await supabase.from('content_generation_queue').insert({
    request_id,
    status: 'queued',
    queued_at: new Date().toISOString()
  })

  // Return immediately with 202 Accepted
  return {
    request_id,
    status: 'queued',
    message: 'Content generation queued. You will be notified when complete.'
  }
}

// Separate worker function processes queue
async function processContentQueue() {
  const { data: jobs } = await supabase
    .from('content_generation_queue')
    .select('*')
    .eq('status', 'queued')
    .limit(5)

  for (const job of jobs || []) {
    try {
      await generateContent(job.request_id)
      await supabase.from('content_generation_queue')
        .update({ status: 'completed' })
        .eq('id', job.id)
    } catch (error) {
      await supabase.from('content_generation_queue')
        .update({
          status: 'failed',
          error: error.message,
          attempts: job.attempts + 1
        })
        .eq('id', job.id)
    }
  }
}
```

## Platform-Specific Workflows

### Complete Onboarding Flow
```typescript
// End-to-end onboarding
async function completeOnboarding() {
  // 1. User registers
  await signUp(email, password)

  // 2. Complete onboarding steps
  await submitStep('company_info', { company_name, industry, website })
  await submitStep('competitors_industry', { competitors, industry_insights })
  await submitStep('social_profiles', { facebook, instagram, linkedin })
  await submitStep('marketing_goals', { goals, target_audience })
  await submitStep('brand_information', { brand_voice, values })
  await submitStep('content_preferences', { content_types, frequency })

  // 3. Upload brand guide (optional)
  await uploadBrandGuide(file)

  // 4. Intelligence guard automatically triggers
  // - comprehensive-intelligence
  // - website-analyzer
  // - brand-analyzer

  // 5. User redirected to dashboard
  // 6. Can now request content
}
```

### Content Creation & Approval Flow
```typescript
// Content workflow
async function contentWorkflow() {
  // 1. Client submits content request
  const request = await createContentRequest({
    content_type: 'blog_post',
    topic: '10 Marketing Tips',
    keywords: ['marketing', 'tips', 'growth']
  })

  // 2. Queue content generation
  await queueContentGeneration(request.request_id)

  // 3. Worker processes queue
  // - Fetches client intelligence
  // - Generates content via OpenAI
  // - Generates featured image via Replicate
  // - Stores for approval

  // 4. Client receives notification
  await sendEmail({
    to: client.email,
    subject: 'Your content is ready for review',
    body: 'Please review and approve your content'
  })

  // 5. Client reviews in dashboard
  // 6. Client approves or requests changes
  await approveContent(content_id)

  // 7. Content published (manual or via n8n)
}
```

## Monitoring & Health Checks

### Platform Health Check
```typescript
async function platformHealthCheck() {
  const checks = []

  // 1. Database connectivity
  try {
    const { error } = await supabase.from('clients').select('count')
    checks.push({ service: 'database', status: error ? 'down' : 'up' })
  } catch (e) {
    checks.push({ service: 'database', status: 'down', error: e.message })
  }

  // 2. Edge functions
  const functions = ['intelligence-gaurd', 'content-generator', 'brand-guide-analyzer']
  for (const func of functions) {
    try {
      const response = await fetch(
        `${Deno.env.get('SUPABASE_URL')}/functions/v1/${func}`,
        {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')}'`,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ health_check: true })
        }
      )
      checks.push({ service: func, status: response.ok ? 'up' : 'down' })
    } catch (e) {
      checks.push({ service: func, status: 'down', error: e.message })
    }
  }

  // 3. External APIs
  checks.push({ service: 'openai', status: await checkOpenAI() })
  checks.push({ service: 'resend', status: await checkResend() })
  checks.push({ service: 'replicate', status: await checkReplicate() })

  return checks
}
```

## Best Practices

- ✅ Always check onboarding_workflows before intelligence guard
- ✅ Use queue pattern for long-running operations
- ✅ Log all edge function executions
- ✅ Implement proper error recovery
- ✅ Monitor edge function health
- ✅ Validate data at each onboarding step
- ✅ Handle file uploads with size limits
- ✅ Use database transactions for related updates
- ✅ Implement retry logic for external APIs
- ✅ Track workflow progress in real-time

## Activation

Activates for:
- PrixFlow platform debugging
- Onboarding workflow issues
- Intelligence analysis problems
- Content generation optimization
- Platform-specific feature development
- Integration troubleshooting
- Performance optimization

Provides deep expertise in PrixFlow platform.
