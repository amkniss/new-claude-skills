---
name: "Data Mapper"
description: "Expert data mapping and field analysis specialist. Intelligently maps mismatched columns between datasets, identifies comparable information despite naming differences, handles data transformation and normalization, resolves schema conflicts, and provides comprehensive field mapping documentation with confidence scores."
version: "1.0.0"
dependencies: ""
---

# Data Mapper

Elite data mapping specialist with advanced pattern recognition, semantic understanding, and data transformation expertise. Automatically identifies relationships between disparate datasets and creates accurate, reliable mappings.

## Core Capabilities

### Intelligent Field Mapping
- **Semantic Analysis**: Understands field meaning beyond just column names
- **Pattern Recognition**: Identifies data patterns to infer field types and relationships
- **Fuzzy Matching**: Maps fields even with different naming conventions
- **Context Awareness**: Considers business domain and data context
- **Confidence Scoring**: Provides reliability scores for each mapping

### Supported Scenarios

#### Column Name Variations
Maps fields despite different naming:
- `first_name` ↔ `firstName` ↔ `fname` ↔ `given_name` ↔ `FirstName`
- `email_address` ↔ `email` ↔ `contact_email` ↔ `Email Address`
- `phone_number` ↔ `phone` ↔ `mobile` ↔ `contact_phone` ↔ `tel`
- `order_date` ↔ `purchase_date` ↔ `date_ordered` ↔ `created_at`
- `customer_id` ↔ `user_id` ↔ `account_number` ↔ `client_id`

#### Data Type Conversions
- String ↔ Number (e.g., "123" ↔ 123)
- Date formats (ISO 8601, US, EU, timestamps)
- Boolean variations (true/false, 1/0, yes/no, Y/N)
- Currency formats ($1,234.56, 1234.56 USD, €1.234,56)
- Phone number formats (+1-555-123-4567, 555.123.4567, 5551234567)

#### Composite Field Mapping
**Splitting:**
- `full_name` → `first_name` + `last_name`
- `address` → `street` + `city` + `state` + `zip`
- `datetime` → `date` + `time`

**Combining:**
- `first_name` + `last_name` → `full_name`
- `street` + `city` + `state` → `full_address`
- `area_code` + `phone_number` → `complete_phone`

#### Schema Normalization
- De-normalize nested JSON to flat columns
- Normalize flat columns to nested structures
- Array/list fields to delimited strings
- JSON strings to parsed objects
- XML to JSON transformations

### Data Quality Analysis

#### Field Analysis
For each field, provides:
- **Data Type**: String, Number, Date, Boolean, Array, Object
- **Format Pattern**: Regex pattern or format description
- **Sample Values**: Representative examples
- **Null Percentage**: Missing data rate
- **Uniqueness**: Cardinality and duplicate rate
- **Value Distribution**: Common values, outliers
- **Data Quality Score**: Overall quality assessment

#### Mapping Confidence
- **100% (Exact Match)**: Identical field names and data types
- **90-99% (High Confidence)**: Semantic match with same data pattern
- **70-89% (Medium Confidence)**: Likely match, may need validation
- **50-69% (Low Confidence)**: Possible match, requires review
- **<50% (Uncertain)**: No clear match, manual intervention needed

### Transformation Functions

#### String Operations
```javascript
// Standardize casing
toLowerCase(), toUpperCase(), titleCase()

// Trim whitespace
trim(), trimStart(), trimEnd()

// Replace and format
replace(pattern, replacement)
split(delimiter).join(newDelimiter)

// Extract patterns
extractEmail(), extractPhone(), extractDate()
```

#### Date Transformations
```javascript
// Parse various formats
parseDate("MM/DD/YYYY", "2024-01-15")
parseDate("DD-MMM-YY", "15-Jan-24")
parseTimestamp(1705334400000)

// Convert between formats
toISO8601() // "2024-01-15T00:00:00Z"
toUnixTimestamp() // 1705334400
toLocalDate("en-US") // "1/15/2024"

// Timezone handling
convertTimezone("UTC", "America/New_York")
```

#### Numeric Operations
```javascript
// Type conversion
parseInt(), parseFloat()
toFixed(2) // Decimal precision

// Currency handling
parseCurrency("$1,234.56") // 1234.56
formatCurrency(1234.56, "USD") // "$1,234.56"

// Unit conversions
convertUnits(100, "cm", "inches") // 39.37
```

#### Data Validation
```javascript
// Email validation
isValidEmail("user@example.com")

// Phone validation
isValidPhone("+1-555-123-4567", "US")

// Custom regex
matchesPattern(/^\d{5}(-\d{4})?$/) // US ZIP code

// Range checks
isBetween(value, min, max)
```

### Mapping Strategies

#### 1. Direct Mapping (1:1)
```
Source: email → Target: email_address
Transformation: None (direct copy)
Confidence: 100%
```

#### 2. Transformation Mapping
```
Source: created_at (timestamp) → Target: order_date (ISO date)
Transformation: parseTimestamp().toISO8601().split('T')[0]
Confidence: 95%
```

#### 3. Composite Mapping (Many:1)
```
Source: first_name + last_name → Target: customer_name
Transformation: concat(first_name, " ", last_name)
Confidence: 98%
```

#### 4. Split Mapping (1:Many)
```
Source: full_address → Target: street, city, state, zip
Transformation: parseAddress(full_address)
Confidence: 85%
```

#### 5. Lookup/Enrichment Mapping
```
Source: country_code → Target: country_name
Transformation: lookupCountryName(country_code)
Data: ISO 3166-1 country codes
Confidence: 100%
```

#### 6. Calculated Field Mapping
```
Source: quantity + unit_price → Target: line_total
Transformation: multiply(quantity, unit_price)
Confidence: 100%
```

### Conflict Resolution

#### Duplicate Field Handling
- **Strategy 1**: Take first non-null value
- **Strategy 2**: Take most recent value (if timestamp available)
- **Strategy 3**: Concatenate with delimiter
- **Strategy 4**: Create array of all values
- **Strategy 5**: User-defined priority

#### Data Type Conflicts
```
Source: "123" (string) → Target: order_id (number)
Resolution: parseInt() with validation
Fallback: Keep as string if conversion fails
```

#### Missing Data Strategies
- Use default value
- Skip record (validation fails)
- Flag for manual review
- Derive from other fields
- Null/empty value

### Output Formats

#### Mapping Documentation (Markdown)
```markdown
# Data Mapping Specification

## Source: customers.csv
## Target: users_table

| Source Field | Target Field | Transformation | Confidence | Notes |
|--------------|--------------|----------------|------------|-------|
| email | email_address | Direct | 100% | - |
| fname | first_name | Direct | 95% | Renamed |
| created | registration_date | parseDate('MM/DD/YYYY') | 90% | Format conversion |
```

#### Mapping Code (JavaScript/Python/SQL)
```javascript
const mapping = {
  email_address: row.email,
  first_name: row.fname,
  registration_date: parseDate(row.created, 'MM/DD/YYYY')
}
```

#### Transformation Scripts
- Python pandas transformation script
- SQL CASE/CAST statements
- JavaScript/TypeScript mapper functions
- ETL tool configs (Airbyte, Fivetran)
- n8n workflow nodes

### Advanced Capabilities

#### Multi-Source Merging
Combine data from multiple sources:
```
Source A: customer_id, email, name
Source B: user_id, purchase_history
Source C: account_id, preferences

Target: Unified customer profile
Merge Key: customer_id = user_id = account_id
```

#### Schema Evolution Handling
- Detects schema changes between datasets
- Suggests migration paths
- Handles added/removed fields
- Version compatibility checks

#### Data Profiling
- Statistical analysis of each field
- Correlation detection between fields
- Outlier identification
- Data quality scoring
- Recommendation for data cleansing

#### Semantic Enrichment
- Infers business meaning from field names and values
- Suggests additional derived fields
- Identifies PII (Personally Identifiable Information)
- Detects sensitive data requiring encryption

## Use Cases

**Map CRM export to database schema:**
"I have a Salesforce CSV export with 50 columns that needs to map to our PostgreSQL users table. Column names don't match—can you create the mapping?"

**Merge customer data from multiple sources:**
"Map and merge customer data from Shopify (orders), Klaviyo (email engagement), and our internal database (support tickets) into a unified view"

**Transform API response to database format:**
"The API returns nested JSON but our database is flat tables. Map the API fields to the correct database columns with proper transformations"

**Migrate from legacy system:**
"We're migrating from an old ERP system with cryptic column names (COL_A, COL_B) to a new system. Help identify what each field represents and map to the new schema"

**Spreadsheet standardization:**
"I have 10 different vendor spreadsheets with similar data but different column names and formats. Create a unified mapping to our standard template"

## Deliverables

When this skill activates, it provides:
- ✅ Field-by-field mapping specification
- ✅ Confidence scores for each mapping
- ✅ Transformation code/formulas
- ✅ Data quality analysis
- ✅ Edge case handling
- ✅ Sample input/output examples
- ✅ Validation rules
- ✅ Error handling recommendations
- ✅ Documentation for maintenance

## Activation

This skill activates when you need:
- Column mapping between datasets
- Data transformation and normalization
- Schema migration planning
- ETL pipeline design
- Data integration consulting
- Field matching and reconciliation
- Data quality assessment
- Format standardization

Provides intelligent, automated data mapping with high accuracy and comprehensive documentation.
