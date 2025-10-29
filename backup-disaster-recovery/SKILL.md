---
name: "Backup & Disaster Recovery"
description: "Backup and disaster recovery specialist. Implements automated backup strategies, version control for databases and configurations, recovery procedures, and ensures business continuity. Expert in database snapshots, incremental backups, and rapid restoration."
version: "1.0.0"
dependencies: "supabase-mcp"
---

# Backup & Disaster Recovery

Expert in backup strategies, disaster recovery planning, and ensuring data integrity and business continuity across all systems.

## Backup Strategies

### Database Backups (Supabase/PostgreSQL)

#### Automated Daily Backups
```bash
#!/bin/bash
# scripts/backup-database.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/backups/database"
PROJECT_REF="vajqezvhllefdgdwytgm"
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

mkdir -p "$BACKUP_DIR"

echo "Starting database backup at $TIMESTAMP"

# Backup using Supabase CLI
supabase db dump --db-url "$DATABASE_URL" > "$BACKUP_FILE"

# Compress
gzip "$BACKUP_FILE"

# Upload to cloud storage
aws s3 cp "$BACKUP_FILE.gz" "s3://your-backup-bucket/database/$TIMESTAMP.sql.gz"

# Keep only last 30 days locally
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +30 -delete

echo "Backup complete: $BACKUP_FILE.gz"
```

#### Point-in-Time Recovery Setup
```sql
-- Enable Point-in-Time Recovery in Supabase
-- This is automatic for paid plans

-- Create backup schema
CREATE SCHEMA IF NOT EXISTS backups;

-- Function to create table snapshots
CREATE OR REPLACE FUNCTION backups.create_snapshot(
  source_table text,
  snapshot_name text DEFAULT NULL
)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  snapshot_table text;
BEGIN
  snapshot_table := COALESCE(
    snapshot_name,
    source_table || '_snapshot_' || to_char(now(), 'YYYYMMDD_HH24MISS')
  );

  EXECUTE format(
    'CREATE TABLE backups.%I AS SELECT * FROM %I',
    snapshot_table,
    source_table
  );

  RAISE NOTICE 'Snapshot created: backups.%', snapshot_table;
END;
$$;

-- Usage
SELECT backups.create_snapshot('clients');
SELECT backups.create_snapshot('onboarding_workflows');
```

### Application Code Backups

#### Git-Based Version Control
```bash
#!/bin/bash
# scripts/backup-codebase.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/backups/code"
PROJECT_NAME="prixflow-onboard"

mkdir -p "$BACKUP_DIR"

# Create git bundle (portable backup)
git bundle create "$BACKUP_DIR/${PROJECT_NAME}_${TIMESTAMP}.bundle" --all

# Create tarball with .git directory
tar -czf "$BACKUP_DIR/${PROJECT_NAME}_${TIMESTAMP}.tar.gz" \
  --exclude='node_modules' \
  --exclude='.next' \
  --exclude='dist' \
  --exclude='build' \
  .

# Upload to cloud
aws s3 cp "$BACKUP_DIR/${PROJECT_NAME}_${TIMESTAMP}.bundle" \
  "s3://your-backup-bucket/code/"

echo "Code backup complete"
```

### Configuration Backups

#### Environment & Secrets Backup
```bash
#!/bin/bash
# scripts/backup-configs.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/backups/configs"

mkdir -p "$BACKUP_DIR"

# Backup environment files (encrypted)
tar -czf - .env.local .env.production supabase/.env | \
  openssl enc -aes-256-cbc -salt -pbkdf2 \
  -out "$BACKUP_DIR/env_${TIMESTAMP}.tar.gz.enc"

# Backup Supabase config
supabase db dump --db-url "$DATABASE_URL" --schema pg_catalog > \
  "$BACKUP_DIR/supabase_schema_${TIMESTAMP}.sql"

# Backup n8n workflows
docker exec n8n n8n export:workflow --all --output=/backup/workflows.json
docker cp n8n:/backup/workflows.json "$BACKUP_DIR/n8n_workflows_${TIMESTAMP}.json"

echo "Config backup complete"
```

### Supabase Edge Functions Backup

```bash
#!/bin/bash
# scripts/backup-edge-functions.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/backups/edge-functions"
FUNCTIONS_DIR="supabase/functions"

mkdir -p "$BACKUP_DIR"

# Create timestamped backup
cp -r "$FUNCTIONS_DIR" "$BACKUP_DIR/functions_${TIMESTAMP}"

# Create git tag for this version
git tag -a "functions-backup-${TIMESTAMP}" -m "Edge functions backup ${TIMESTAMP}"

# List all deployed functions with versions
supabase functions list > "$BACKUP_DIR/deployed_functions_${TIMESTAMP}.txt"

echo "Edge functions backup complete"
```

## Disaster Recovery Procedures

### Complete System Recovery

#### Recovery Runbook
```markdown
# Disaster Recovery Runbook

## Prerequisites
- [ ] AWS CLI configured
- [ ] Supabase CLI installed
- [ ] Node.js 20+ installed
- [ ] Git configured
- [ ] Backup credentials available

## Step 1: Restore Database (15-30 minutes)

1. Create new Supabase project or reset existing
2. Restore latest backup:
   ```bash
   # Download latest backup
   aws s3 cp s3://your-backup-bucket/database/latest.sql.gz ./restore.sql.gz
   gunzip restore.sql.gz

   # Restore to Supabase
   psql "$DATABASE_URL" < restore.sql
   ```

3. Verify data:
   ```sql
   SELECT COUNT(*) FROM clients;
   SELECT COUNT(*) FROM onboarding_workflows;
   ```

## Step 2: Restore Codebase (5-10 minutes)

1. Clone from GitHub:
   ```bash
   git clone https://github.com/your-org/prixflow-onboard.git
   cd prixflow-onboard
   ```

2. Or restore from bundle backup:
   ```bash
   aws s3 cp s3://your-backup-bucket/code/latest.bundle ./
   git clone latest.bundle prixflow-onboard
   ```

3. Install dependencies:
   ```bash
   npm ci
   ```

## Step 3: Restore Configuration (5 minutes)

1. Restore environment files:
   ```bash
   aws s3 cp s3://your-backup-bucket/configs/latest.tar.gz.enc ./
   openssl enc -aes-256-cbc -d -pbkdf2 -in latest.tar.gz.enc | tar -xz
   ```

2. Update with new Supabase credentials:
   ```bash
   # Update .env.local
   NEXT_PUBLIC_SUPABASE_URL=<new-url>
   NEXT_PUBLIC_SUPABASE_ANON_KEY=<new-key>
   SUPABASE_SERVICE_ROLE_KEY=<new-service-key>
   ```

## Step 4: Deploy Edge Functions (10-15 minutes)

1. Deploy all functions:
   ```bash
   supabase functions deploy
   ```

2. Set secrets:
   ```bash
   supabase secrets set OPENAI_API_KEY=$OPENAI_API_KEY
   supabase secrets set RESEND_API_KEY=$RESEND_API_KEY
   ```

3. Verify deployment:
   ```bash
   supabase functions list
   ```

## Step 5: Deploy Application (10 minutes)

1. Deploy to Vercel:
   ```bash
   vercel deploy --prod
   ```

2. Verify deployment:
   ```bash
   curl https://your-app.vercel.app/api/health
   ```

## Step 6: Restore n8n Workflows (5 minutes)

1. Import workflows:
   ```bash
   aws s3 cp s3://your-backup-bucket/configs/n8n_workflows_latest.json ./
   docker cp ./n8n_workflows_latest.json n8n:/import/
   docker exec n8n n8n import:workflow --input=/import/workflows.json
   ```

## Step 7: Verification (10-15 minutes)

- [ ] Frontend loads correctly
- [ ] User can sign in
- [ ] Database queries work
- [ ] Edge functions execute
- [ ] n8n workflows trigger
- [ ] Email sending works
- [ ] API integrations functional

## Estimated Total Recovery Time: 60-90 minutes
```

### Incremental Backup Strategy

```bash
#!/bin/bash
# scripts/incremental-backup.sh

BACKUP_BASE="$HOME/backups"
LAST_BACKUP="$BACKUP_BASE/.last_backup"

# Full backup on Sundays, incremental otherwise
if [ "$(date +%u)" -eq 7 ]; then
  BACKUP_TYPE="full"
else
  BACKUP_TYPE="incremental"
fi

echo "Running $BACKUP_TYPE backup..."

if [ "$BACKUP_TYPE" == "full" ]; then
  # Full backup
  pg_dump "$DATABASE_URL" | gzip > "$BACKUP_BASE/full_$(date +%Y%m%d).sql.gz"
  echo "$(date +%s)" > "$LAST_BACKUP"
else
  # Incremental: only changed data since last backup
  LAST_TIME=$(cat "$LAST_BACKUP" 2>/dev/null || echo "0")

  psql "$DATABASE_URL" <<EOF > "$BACKUP_BASE/incremental_$(date +%Y%m%d_%H%M).sql"
    -- Export changed records
    COPY (SELECT * FROM clients WHERE updated_at > to_timestamp($LAST_TIME)) TO STDOUT;
    COPY (SELECT * FROM content_requests WHERE updated_at > to_timestamp($LAST_TIME)) TO STDOUT;
EOF

  echo "$(date +%s)" > "$LAST_BACKUP"
fi

echo "Backup complete"
```

### Automated Backup Monitoring

```typescript
// scripts/backup-monitor.ts
import { createClient } from '@supabase/supabase-js'

async function monitorBackups() {
  const supabase = createClient(
    process.env.SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
  )

  // Check last backup time
  const lastBackup = await getLastBackupTime()
  const hoursSinceBackup = (Date.now() - lastBackup) / (1000 * 60 * 60)

  if (hoursSinceBackup > 24) {
    await sendAlert({
      severity: 'high',
      message: `No backup in ${hoursSinceBackup.toFixed(1)} hours!`,
      action: 'Run manual backup immediately'
    })
  }

  // Verify backup integrity
  const latestBackup = await getLatestBackup()
  const isValid = await verifyBackupIntegrity(latestBackup)

  if (!isValid) {
    await sendAlert({
      severity: 'critical',
      message: 'Latest backup file is corrupted!',
      action: 'Investigate backup process'
    })
  }

  // Check backup storage space
  const storageUsed = await getBackupStorageUsage()
  const storageLimit = 100 * 1024 * 1024 * 1024 // 100GB

  if (storageUsed > storageLimit * 0.9) {
    await sendAlert({
      severity: 'medium',
      message: 'Backup storage 90% full',
      action: 'Clean up old backups or increase storage'
    })
  }
}

// Run daily
setInterval(monitorBackups, 24 * 60 * 60 * 1000)
```

## Data Recovery Scenarios

### Accidental Data Deletion
```sql
-- Restore from snapshot
INSERT INTO clients
SELECT * FROM backups.clients_snapshot_20240121
WHERE client_id = 'deleted-client-id';

-- Or restore entire table
BEGIN;
DELETE FROM clients; -- Clear current
INSERT INTO clients SELECT * FROM backups.clients_snapshot_20240121;
COMMIT;
```

### Corrupted Records
```sql
-- Identify corrupted records
SELECT * FROM clients
WHERE business_description IS NULL
  OR company_name IS NULL
  OR email !~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$';

-- Restore specific records
UPDATE clients c
SET
  business_description = b.business_description,
  company_name = b.company_name,
  email = b.email
FROM backups.clients_snapshot_latest b
WHERE c.client_id = b.client_id
  AND c.client_id IN (SELECT client_id FROM corrupted_records);
```

### Edge Function Rollback
```bash
# Rollback to previous version
cd supabase/functions
git log --oneline intelligence-gaurd/

# Checkout previous version
git checkout abc123 -- intelligence-gaurd/

# Redeploy
supabase functions deploy intelligence-gaurd
```

## Backup Automation (Cron)

```bash
# crontab -e

# Daily database backup at 2 AM
0 2 * * * /home/user/scripts/backup-database.sh >> /var/log/backup-db.log 2>&1

# Hourly incremental backup
0 * * * * /home/user/scripts/incremental-backup.sh >> /var/log/backup-incremental.log 2>&1

# Weekly full code backup on Sundays at 3 AM
0 3 * * 0 /home/user/scripts/backup-codebase.sh >> /var/log/backup-code.log 2>&1

# Daily config backup at 1 AM
0 1 * * * /home/user/scripts/backup-configs.sh >> /var/log/backup-configs.log 2>&1

# Backup verification at 4 AM
0 4 * * * /home/user/scripts/verify-backups.sh >> /var/log/backup-verify.log 2>&1
```

## Best Practices

- ✅ Automate all backups
- ✅ Test recovery procedures regularly (quarterly)
- ✅ Store backups in multiple locations (local + cloud)
- ✅ Encrypt sensitive backups
- ✅ Verify backup integrity
- ✅ Document recovery procedures
- ✅ Monitor backup status
- ✅ Set up alerts for backup failures
- ✅ Keep backups for appropriate retention period
- ✅ Test restoration process

## Backup Retention Policy

- **Daily backups**: Keep 7 days
- **Weekly backups**: Keep 4 weeks
- **Monthly backups**: Keep 12 months
- **Yearly backups**: Keep 3 years

## Activation

Activates for:
- Backup setup and automation
- Disaster recovery planning
- Data restoration
- Backup monitoring
- Recovery testing
- Backup verification

Ensures business continuity with reliable backup and recovery.
