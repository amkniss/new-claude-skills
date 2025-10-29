---
name: "QA Engineer Team"
description: "Comprehensive quality assurance team skill covering all testing types and languages. Provides unit testing, integration testing, E2E testing, performance testing, security testing, and accessibility testing with framework-specific expertise for JavaScript/TypeScript, Python, Go, Rust, Java, C#, and more."
version: "1.0.0"
dependencies: ""
---

# QA Engineer Team

An elite quality assurance team with deep expertise across all programming languages, testing frameworks, and testing methodologies. Ensures comprehensive test coverage, catches bugs early, and maintains code quality standards.

## Testing Specializations

### Unit Testing
**JavaScript/TypeScript:**
- Jest with React Testing Library
- Vitest for Vite projects
- Mocha + Chai + Sinon
- Component testing (shallow vs. mount)
- Mock implementations and spies
- Snapshot testing

**Python:**
- pytest with fixtures and parametrization
- unittest (built-in)
- Mock and patch strategies
- Property-based testing with Hypothesis
- Coverage reporting with pytest-cov

**Go:**
- Built-in testing package
- Table-driven tests
- Subtests and test helpers
- Testify for assertions
- Mock generation with gomock

**Rust:**
- Built-in #[test] attribute
- assert! macros and custom assertions
- proptest for property-based testing
- Mock traits with mockall

**Java/Kotlin:**
- JUnit 5 with assertions
- Mockito for mocking
- MockK for Kotlin
- Kotest framework

**C#/.NET:**
- xUnit, NUnit, MSTest
- Moq for mocking
- FluentAssertions
- AutoFixture for test data

### Integration Testing
- API endpoint testing (Supertest, httptest, requests)
- Database integration (test databases, transactions, rollback)
- External service mocking (WireMock, nock, responses)
- Message queue testing (RabbitMQ, Kafka)
- File system operations
- Email delivery verification

### End-to-End (E2E) Testing
**Playwright (Recommended):**
- Multi-browser testing (Chrome, Firefox, Safari, Edge)
- Auto-wait and retry mechanisms
- Network interception and mocking
- Screenshot and video recording
- Parallel execution
- Component testing mode

**Cypress:**
- Time-travel debugging
- Automatic waiting
- Network stubbing
- Visual regression testing
- Custom commands

**Selenium:**
- Cross-browser compatibility
- Grid setup for parallel execution
- Page Object Model pattern
- Explicit and implicit waits

### Performance Testing
- Load testing (Artillery, k6, Locust, JMeter)
- Stress testing and spike testing
- Benchmark testing (Benchmark.js, pytest-benchmark, Go benchmarks)
- Memory profiling and leak detection
- Response time monitoring
- Throughput and concurrency testing
- Database query performance

### Security Testing
- Input validation and sanitization tests
- SQL injection prevention verification
- XSS and CSRF protection testing
- Authentication and authorization tests
- Secrets and credential scanning
- Dependency vulnerability checks (npm audit, Snyk, OWASP)
- Penetration testing basics
- API security testing (OWASP API Security Top 10)

### Accessibility Testing
- WCAG 2.1 AA/AAA compliance
- Screen reader compatibility (NVDA, JAWS, VoiceOver)
- Keyboard navigation testing
- Color contrast verification
- ARIA attributes validation
- axe-core integration (jest-axe, Playwright accessibility testing)
- Semantic HTML validation

### Visual Regression Testing
- Percy for visual diffs
- Chromatic for Storybook
- BackstopJS for screenshot comparison
- Playwright visual comparisons

### API Testing
- REST API validation (status codes, headers, body)
- GraphQL query and mutation testing
- Schema validation (JSON Schema, GraphQL schema)
- Contract testing (Pact)
- API documentation testing (Swagger/OpenAPI validation)
- Rate limiting verification
- Authentication flow testing

### Test Data Management
- Factory patterns (Factory Boy, Faker, chance.js)
- Test fixtures and seeders
- Database snapshots and restoration
- Synthetic data generation
- PII data anonymization for testing

## Testing Best Practices

### Test Structure
- **AAA Pattern**: Arrange, Act, Assert
- **Given-When-Then**: BDD style
- Descriptive test names (`it('should return 404 when user not found')`)
- One assertion per test (when logical)
- Setup and teardown (beforeEach, afterEach, fixtures)

### Code Coverage
- Target: 80%+ line coverage, 90%+ for critical paths
- Branch coverage analysis
- Mutation testing (Stryker)
- Coverage reports (Istanbul, Coverage.py)
- Exclude non-critical code (types, configs) from coverage

### Test Organization
```
tests/
├── unit/           # Fast, isolated unit tests
├── integration/    # Service integration tests
├── e2e/            # End-to-end user flow tests
├── performance/    # Load and stress tests
├── fixtures/       # Test data and mocks
└── utils/          # Test helpers and utilities
```

### Mocking Strategies
- **Don't mock what you don't own** (test real integrations when possible)
- Mock external APIs and third-party services
- Use in-memory databases for faster tests
- Stub time-dependent functions (Date.now(), setTimeout)
- Mock file system operations

### Continuous Testing
- Run unit tests on every commit (pre-commit hooks)
- Integration tests in CI pipeline
- E2E tests on staging environment
- Performance regression testing
- Automated security scans

## Framework-Specific Expertise

### React Testing
```typescript
// Component testing with React Testing Library
import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { UserProfile } from './UserProfile'

test('displays user information after loading', async () => {
  render(<UserProfile userId="123" />)

  expect(screen.getByText(/loading/i)).toBeInTheDocument()

  await waitFor(() => {
    expect(screen.getByText('John Doe')).toBeInTheDocument()
  })
})
```

### Next.js Testing
- Server Component testing
- API route testing with NextRequest/NextResponse
- Server Action testing
- Middleware testing
- Dynamic route testing

### Python FastAPI Testing
```python
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_create_user():
    response = client.post("/users", json={
        "email": "test@example.com",
        "password": "secure123"
    })
    assert response.status_code == 201
    assert response.json()["email"] == "test@example.com"
```

### Go Testing
```go
func TestUserRepository_FindByID(t *testing.T) {
    tests := []struct {
        name    string
        userID  string
        want    *User
        wantErr bool
    }{
        {
            name:    "existing user",
            userID:  "123",
            want:    &User{ID: "123", Name: "John"},
            wantErr: false,
        },
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            // Test implementation
        })
    }
}
```

## Test Quality Metrics

### Coverage Targets by Code Type
- **Business Logic**: 95%+
- **API Endpoints**: 90%+
- **UI Components**: 80%+
- **Utility Functions**: 100%
- **Configuration**: 50% (if testable)

### Test Pyramid
- 70% Unit tests (fast, isolated)
- 20% Integration tests (moderate speed, some dependencies)
- 10% E2E tests (slow, full system)

### Performance Benchmarks
- Unit tests: < 5 minutes for entire suite
- Integration tests: < 15 minutes
- E2E tests: < 30 minutes
- Individual test: < 1 second (unit), < 10 seconds (integration)

## Advanced Testing Techniques

### Test-Driven Development (TDD)
1. Write failing test (Red)
2. Write minimal code to pass (Green)
3. Refactor while keeping tests green (Refactor)

### Behavior-Driven Development (BDD)
- Cucumber/Gherkin syntax
- Spec-style testing (Jasmine, Mocha)
- User story → acceptance criteria → tests

### Property-Based Testing
- Tests invariants rather than examples
- Generates random inputs to find edge cases
- QuickCheck (Haskell), Hypothesis (Python), fast-check (JS)

### Mutation Testing
- Introduces bugs to verify tests catch them
- Measures test effectiveness, not just coverage
- Stryker (JS), mutmut (Python), go-mutesting (Go)

### Chaos Engineering
- Randomly inject failures to test resilience
- Network latency simulation
- Service failure scenarios
- Database connection drops

## Common Test Scenarios

### Authentication Testing
- Login with valid credentials
- Login with invalid credentials
- Token expiration and refresh
- Password reset flow
- Multi-factor authentication
- Session management
- CSRF protection

### Authorization Testing
- Role-based access control (RBAC)
- Resource ownership verification
- Permission escalation prevention
- Attribute-based access control (ABAC)

### Edge Cases & Error Handling
- Null/undefined/None inputs
- Empty strings and arrays
- Very large inputs (overflow testing)
- Special characters and unicode
- Network timeouts and retries
- Database connection failures
- Race conditions and concurrency issues

### Database Testing
- CRUD operations
- Transaction rollback
- Constraint violations
- Concurrent updates (optimistic locking)
- Soft deletes
- Cascade deletions
- Index usage verification

## Deliverables

When this skill activates, it provides:
- ✅ Comprehensive test suites with high coverage
- ✅ Test documentation and examples
- ✅ CI/CD integration configs
- ✅ Mock data and fixtures
- ✅ Test utilities and helpers
- ✅ Performance benchmarks
- ✅ Security test cases
- ✅ Accessibility audit results
- ✅ Bug reports with reproduction steps
- ✅ Test maintenance recommendations

## Use Cases

**Test a new feature:**
"Write comprehensive tests for the shopping cart module including unit tests for cart logic, integration tests for database operations, and E2E tests for checkout flow"

**Improve test coverage:**
"Analyze current test coverage and add missing tests for the authentication service, focusing on edge cases and error scenarios"

**E2E testing:**
"Create Playwright E2E tests for the user registration and onboarding flow with visual regression testing"

**Performance testing:**
"Set up load testing for the API with k6, targeting 1000 requests/second with < 200ms p95 latency"

**Security testing:**
"Audit the payment processing module for security vulnerabilities and create tests to prevent SQL injection, XSS, and unauthorized access"

## Activation

This skill activates when you need:
- Test creation for new or existing code
- Test coverage improvement
- Bug reproduction and verification
- Performance or security testing
- Accessibility compliance testing
- Test refactoring or optimization
- CI/CD test integration
- Test framework setup

Provides language and framework-specific tests following best practices with excellent coverage and maintainability.
