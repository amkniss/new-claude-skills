---
name: "Supabase Database Expert"
description: "Comprehensive Supabase specialist covering PostgreSQL database design, Row Level Security (RLS), real-time subscriptions, Edge Functions, Auth, Storage, and complete Supabase application development. Expert in migrations, performance optimization, and MCP integration."
version: "1.0.0"
dependencies: "supabase-mcp"
---

# Supabase Database Expert

Elite Supabase engineer with deep expertise in PostgreSQL, Row Level Security, real-time features, authentication, and full-stack Supabase application development.

## Supabase Expertise

### Database Design & Schema

#### Table Creation with RLS
```sql
-- Users table with RLS
create table public.users (
  id uuid primary key default uuid_generate_v4(),
  email text unique not null,
  full_name text,
  avatar_url text,
  created_at timestamptz default now()
);

-- Enable RLS
alter table public.users enable row level security;

-- Policies
create policy "Users can view own profile"
  on public.users for select
  using (auth.uid() = id);

create policy "Users can update own profile"
  on public.users for update
  using (auth.uid() = id);
```

#### Foreign Keys & Relationships
```sql
create table public.posts (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid references public.users(id) on delete cascade,
  title text not null,
  content text,
  published boolean default false,
  created_at timestamptz default now()
);

-- Indexes for performance
create index posts_user_id_idx on public.posts(user_id);
create index posts_created_at_idx on public.posts(created_at desc);
```

### Row Level Security (RLS) Patterns

#### User-Specific Data
```sql
create policy "Users see only their data"
  on public.posts for select
  using (auth.uid() = user_id);
```

#### Organization/Tenant Isolation
```sql
create policy "Organization members can view posts"
  on public.posts for select
  using (
    exists (
      select 1 from public.organization_members
      where organization_members.user_id = auth.uid()
      and organization_members.organization_id = posts.organization_id
    )
  );
```

#### Role-Based Access
```sql
create policy "Admins can update all posts"
  on public.posts for update
  using (
    exists (
      select 1 from public.user_roles
      where user_roles.user_id = auth.uid()
      and user_roles.role = 'admin'
    )
  );
```

### Database Functions

#### Custom Functions
```sql
create or replace function public.search_posts(search_query text)
returns setof public.posts
language sql
stable
as $$
  select *
  from public.posts
  where
    to_tsvector('english', title || ' ' || content)
    @@ plainto_tsquery('english', search_query)
  order by created_at desc;
$$;
```

#### Triggers
```sql
create or replace function public.handle_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger set_updated_at
  before update on public.posts
  for each row
  execute function public.handle_updated_at();
```

### Real-Time Subscriptions

#### TypeScript Client
```tsx
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
)

// Subscribe to changes
const channel = supabase
  .channel('posts-changes')
  .on(
    'postgres_changes',
    {
      event: '*',
      schema: 'public',
      table: 'posts'
    },
    (payload) => {
      console.log('Change received!', payload)
      // Update UI
    }
  )
  .subscribe()

// Cleanup
return () => {
  supabase.removeChannel(channel)
}
```

### Authentication Integration

#### Email/Password Auth
```tsx
// Sign up
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'secure-password',
  options: {
    data: {
      full_name: 'John Doe'
    }
  }
})

// Sign in
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'secure-password'
})

// Get current session
const { data: { session } } = await supabase.auth.getSession()
```

#### OAuth Providers
```tsx
const { data, error } = await supabase.auth.signInWithOAuth({
  provider: 'google',
  options: {
    redirectTo: `${window.location.origin}/auth/callback`
  }
})
```

### CRUD Operations

#### Insert
```tsx
const { data, error } = await supabase
  .from('posts')
  .insert({
    title: 'New Post',
    content: 'Post content',
    user_id: session.user.id
  })
  .select()
  .single()
```

#### Query with Filters
```tsx
const { data, error } = await supabase
  .from('posts')
  .select('*, users(full_name, avatar_url)')
  .eq('published', true)
  .order('created_at', { ascending: false })
  .range(0, 9) // Pagination
```

#### Update
```tsx
const { error } = await supabase
  .from('posts')
  .update({ published: true })
  .eq('id', postId)
```

#### Delete
```tsx
const { error } = await supabase
  .from('posts')
  .delete()
  .eq('id', postId)
```

### Storage

#### Upload File
```tsx
const { data, error } = await supabase.storage
  .from('avatars')
  .upload(`${userId}/avatar.png`, file, {
    upsert: true
  })

// Get public URL
const { data: { publicUrl } } = supabase.storage
  .from('avatars')
  .getPublicUrl(`${userId}/avatar.png`)
```

#### Storage Policies
```sql
create policy "Users can upload own avatar"
  on storage.objects for insert
  with check (
    bucket_id = 'avatars' and
    auth.uid()::text = (storage.foldername(name))[1]
  );
```

### Edge Functions

```typescript
// supabase/functions/send-email/index.ts
import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  const { to, subject, body } = await req.json()

  // Send email via Resend/SendGrid
  const response = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${Deno.env.get('RESEND_API_KEY')}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ to, subject, html: body })
  })

  return new Response(JSON.stringify({ success: true }), {
    headers: { 'Content-Type': 'application/json' }
  })
})
```

### Migrations with MCP

```tsx
// Using Supabase MCP
await mcp__supabase__apply_migration({
  name: 'add_posts_table',
  query: `
    create table public.posts (
      id uuid primary key default uuid_generate_v4(),
      title text not null,
      content text,
      created_at timestamptz default now()
    );

    alter table public.posts enable row level security;
  `
})

// List migrations
const migrations = await mcp__supabase__list_migrations()
```

### Performance Optimization

#### Indexes
```sql
-- B-tree index for exact matches
create index users_email_idx on public.users(email);

-- Partial index
create index active_posts_idx on public.posts(created_at)
  where published = true;

-- Full-text search index
create index posts_search_idx on public.posts
  using gin(to_tsvector('english', title || ' ' || content));
```

#### Query Optimization
```tsx
// Use select() to fetch only needed columns
const { data } = await supabase
  .from('posts')
  .select('id, title, created_at')
  .eq('published', true)

// Use count for pagination metadata
const { count } = await supabase
  .from('posts')
  .select('*', { count: 'exact', head: true })
```

### TypeScript Types

```tsx
// Generate types from database
import { Database } from '@/types/supabase'

const supabase = createClient<Database>(url, key)

// Type-safe queries
const { data } = await supabase
  .from('posts')
  .select('*')
  .returns<Database['public']['Tables']['posts']['Row'][]>()
```

## Best Practices

- ✅ Enable RLS on all tables
- ✅ Create appropriate indexes for queries
- ✅ Use foreign keys with CASCADE
- ✅ Implement soft deletes when needed
- ✅ Use database functions for complex logic
- ✅ Validate data with check constraints
- ✅ Use transactions for related operations
- ✅ Monitor query performance
- ✅ Regular database backups
- ✅ Use TypeScript types from database

## Common Patterns

### Multi-Tenant SaaS
```sql
create table public.organizations (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  created_at timestamptz default now()
);

create table public.organization_members (
  organization_id uuid references public.organizations(id),
  user_id uuid references public.users(id),
  role text not null check (role in ('owner', 'admin', 'member')),
  primary key (organization_id, user_id)
);

-- RLS for tenant isolation
create policy "Members can view organization data"
  on public.posts for select
  using (
    exists (
      select 1 from public.organization_members
      where organization_members.user_id = auth.uid()
      and organization_members.organization_id = posts.organization_id
    )
  );
```

## Activation

Activates for:
- Database schema design
- RLS policy creation
- Migration writing
- Query optimization
- Real-time subscription setup
- Authentication integration
- Edge Function development
- Storage configuration

Provides production-ready Supabase implementations with best practices.
