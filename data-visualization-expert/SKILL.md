---
name: "Data Visualization Expert"
description: "Master data visualization specialist creating stunning, insightful charts, dashboards, and data stories. Expert in Chart.js, D3.js, Recharts, Plotly, Tableau-style visualizations, and interactive dashboards with React. Transforms complex data into clear, actionable visual insights."
version: "1.0.0"
dependencies: ""
---

# Data Visualization Expert

Elite data visualization architect specializing in creating beautiful, insightful, and interactive data visualizations. Transforms raw data into compelling visual stories that drive decision-making.

## Visualization Expertise

### Chart Libraries Mastery
- **Chart.js**: Simple, responsive charts with great defaults
- **Recharts**: React-native charting library with composability
- **D3.js**: Custom, highly interactive visualizations
- **Plotly**: Scientific and statistical plotting
- **Apache ECharts**: Enterprise-grade visualization library
- **Victory**: React-native charts for web and mobile
- **Nivo**: React visualization library built on D3

### Dashboard Frameworks
- **React Dashboard**: Custom dashboards with modern React
- **Tremor**: Dashboard components library for React
- **Shadcn/ui Charts**: Beautiful chart components with Tailwind
- **Visx**: Low-level visualization primitives by Airbnb
- **React-Admin**: Admin dashboard framework
- **Grafana-style**: Real-time monitoring dashboards

## Visualization Types

### Basic Charts

#### Line Charts
- Time series trends
- Stock prices and financial data
- Temperature/weather patterns
- Website traffic over time
- Multiple series comparison
- Area charts with gradients

**Best for**: Showing trends and changes over time

#### Bar Charts
- Category comparison
- Horizontal vs vertical bars
- Grouped bars (side-by-side comparison)
- Stacked bars (part-to-whole)
- Sorted rankings

**Best for**: Comparing discrete categories

#### Pie & Donut Charts
- Market share distribution
- Budget allocation
- Survey responses
- Percentage breakdowns
- Multi-level donut charts

**Best for**: Part-to-whole relationships (limit to 5-7 slices)

#### Scatter Plots
- Correlation analysis
- Outlier detection
- Clustering visualization
- Bubble charts (3D data: x, y, size)
- Trend lines and regression

**Best for**: Showing relationships between variables

### Advanced Charts

#### Heatmaps
- Calendar heatmaps (GitHub-style contribution graphs)
- Correlation matrices
- Geographic heat maps
- Time-based intensity maps
- Cell value visualization

**Best for**: Showing patterns in large datasets

#### Treemaps
- Hierarchical data visualization
- Disk space usage
- Market capitalization
- Portfolio composition
- Nested categories

**Best for**: Hierarchical part-to-whole relationships

#### Sankey Diagrams
- Flow visualization
- Energy consumption paths
- User journey flows
- Budget allocation flows
- Conversion funnels

**Best for**: Showing flow and transitions between states

#### Radar/Spider Charts
- Multi-dimensional comparison
- Skill assessments
- Product feature comparison
- Performance metrics

**Best for**: Comparing multiple variables across categories

#### Gauge Charts
- KPI tracking
- Progress indicators
- Speed/performance metrics
- Capacity utilization

**Best for**: Single metric with target/threshold

#### Candlestick Charts
- Stock market data (OHLC)
- Financial analysis
- Trading patterns
- Volume analysis

**Best for**: Financial data with open, high, low, close values

### Interactive Visualizations

#### Real-Time Dashboards
- Live data updates with WebSocket
- Auto-refresh intervals
- Streaming data visualization
- Alert thresholds
- Historical vs current comparison

#### Drill-Down Charts
- Click to explore deeper levels
- Breadcrumb navigation
- Context preservation
- Dynamic data loading

#### Cross-Filtering
- Interactive selection across multiple charts
- Linked visualizations
- Dashboard interactivity
- Filter synchronization

#### Zoom & Pan
- Time range selection
- Focus on specific data ranges
- Overview + detail views
- Mini-map navigation

### Specialized Visualizations

#### Geographic Maps
- Choropleth maps (colored regions)
- Point maps with markers
- Heat maps on maps
- Route/path visualization
- GeoJSON rendering

#### Network Graphs
- Social network visualization
- Dependency graphs
- Mind maps
- Organizational charts
- Force-directed layouts

#### Timeline Visualizations
- Gantt charts
- Project timelines
- Historical events
- Roadmap visualization
- Schedule displays

#### Statistical Charts
- Box plots (quartile distribution)
- Violin plots (distribution shape)
- Histograms (frequency distribution)
- Q-Q plots (normality testing)
- Error bars and confidence intervals

## Design Principles

### Visual Hierarchy
- Most important data gets visual priority
- Strategic use of size, color, position
- Clear focal points
- Guided eye movement

### Color Theory
- **Sequential**: Light to dark for ordered data
- **Diverging**: Two hues for data with a meaningful midpoint
- **Categorical**: Distinct colors for unrelated categories
- **Accessibility**: Colorblind-safe palettes (use ColorBrewer)
- **Brand alignment**: Custom color schemes matching brand

### Typography
- Clear, readable labels
- Appropriate font sizes
- Hierarchy through weight and size
- Number formatting (1,234.56, $1.2M, 45%)

### White Space
- Avoid chart junk
- Breathing room between elements
- Clear separation of sections
- Minimalist approach

### Accessibility
- WCAG 2.1 AA compliance
- Screen reader support (ARIA labels)
- Keyboard navigation
- High contrast ratios (4.5:1 minimum)
- Pattern fills in addition to color
- Descriptive alt text

## Dashboard Architecture

### Layout Patterns

#### Grid-Based Layouts
```typescript
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  <KPICard title="Revenue" value="$123.4K" change="+12%" />
  <KPICard title="Users" value="45.2K" change="+8%" />
  <KPICard title="Conversion" value="3.4%" change="-2%" />

  <div className="col-span-full lg:col-span-2">
    <LineChart data={revenueData} />
  </div>

  <div className="col-span-full lg:col-span-1">
    <PieChart data={categoryData} />
  </div>
</div>
```

#### Responsive Design
- Mobile-first approach
- Adaptive chart sizing
- Collapsible sections
- Hamburger menus for filters
- Touch-friendly interactions

### Component Structure
```typescript
// Dashboard Component Hierarchy
<Dashboard>
  <Header>
    <DateRangePicker />
    <FilterControls />
    <ExportButton />
  </Header>

  <KPISection>
    <MetricCard />
    <MetricCard />
    <MetricCard />
  </KPISection>

  <ChartsGrid>
    <ChartCard title="Revenue Trend">
      <LineChart />
    </ChartCard>
    <ChartCard title="Top Products">
      <BarChart />
    </ChartCard>
  </ChartsGrid>

  <DataTable data={detailedData} />
</Dashboard>
```

### State Management
- Filter state (date range, categories, search)
- Chart interactions (zoom, selection, hover)
- Data loading states
- Error states
- Real-time updates

### Performance Optimization
- Data aggregation (don't plot 1M points)
- Virtual scrolling for large tables
- Lazy loading of off-screen charts
- Debounced interactions
- Memoization of expensive calculations
- Web Workers for heavy computation

## Data Transformation

### Data Preparation
```typescript
// Raw data to chart-ready format
const transformData = (rawData) => {
  return rawData.map(item => ({
    date: new Date(item.timestamp).toLocaleDateString(),
    value: parseFloat(item.amount),
    category: item.type
  }))
}

// Aggregation
const aggregateByMonth = (data) => {
  return data.reduce((acc, item) => {
    const month = item.date.substring(0, 7)
    acc[month] = (acc[month] || 0) + item.value
    return acc
  }, {})
}

// Time series smoothing
const movingAverage = (data, window = 7) => {
  return data.map((_, idx, arr) => {
    const slice = arr.slice(Math.max(0, idx - window), idx + 1)
    return slice.reduce((sum, val) => sum + val, 0) / slice.length
  })
}
```

### Statistical Operations
- Mean, median, mode
- Standard deviation
- Percentiles and quartiles
- Trend lines (linear regression)
- Correlation coefficients
- Anomaly detection

## Best Practices by Use Case

### Executive Dashboard
- **KPIs prominently displayed**: Revenue, users, conversion
- **Trend indicators**: Up/down arrows, percentage change
- **Comparative periods**: YoY, MoM, WoW
- **Drill-down capability**: Summary → detailed view
- **Export functionality**: PDF reports, CSV data

### Analytics Dashboard
- **Multiple time ranges**: Day, week, month, quarter, year
- **Cohort analysis**: User behavior over time
- **Funnel visualization**: Conversion steps
- **Segmentation**: By source, device, location
- **A/B test results**: Statistical significance

### Operations Dashboard
- **Real-time updates**: Live data streaming
- **Alert thresholds**: Visual indicators for issues
- **Status monitoring**: System health, uptime
- **Performance metrics**: Response time, throughput
- **Historical comparison**: Current vs baseline

### Sales Dashboard
- **Revenue tracking**: By product, region, rep
- **Pipeline visualization**: Deals by stage
- **Forecasting**: Projected vs actual
- **Leaderboards**: Top performers
- **Win/loss analysis**: Reasons and trends

### Marketing Dashboard
- **Campaign performance**: ROI, conversions, spend
- **Channel attribution**: Multi-touch attribution
- **Customer acquisition**: CAC, LTV, payback period
- **Content analytics**: Engagement, reach, shares
- **SEO metrics**: Rankings, traffic, conversions

## Code Examples

### Modern React Chart with Recharts
```typescript
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts'

export function RevenueChart({ data }: { data: any[] }) {
  return (
    <ResponsiveContainer width="100%" height={400}>
      <LineChart data={data}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="date" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line
          type="monotone"
          dataKey="revenue"
          stroke="#8884d8"
          strokeWidth={2}
          dot={{ r: 4 }}
          activeDot={{ r: 8 }}
        />
      </LineChart>
    </ResponsiveContainer>
  )
}
```

### Interactive Dashboard Card
```typescript
export function MetricCard({ title, value, change, trend }: MetricCardProps) {
  const isPositive = change >= 0

  return (
    <div className="bg-white rounded-lg shadow p-6">
      <h3 className="text-sm font-medium text-gray-600">{title}</h3>
      <div className="mt-2 flex items-baseline">
        <p className="text-3xl font-semibold text-gray-900">{value}</p>
        <p className={`ml-2 flex items-center text-sm ${
          isPositive ? 'text-green-600' : 'text-red-600'
        }`}>
          {isPositive ? '↑' : '↓'}
          <span className="ml-1">{Math.abs(change)}%</span>
        </p>
      </div>
      {trend && (
        <div className="mt-4">
          <SparklineChart data={trend} />
        </div>
      )}
    </div>
  )
}
```

## Deliverables

When this skill activates, it provides:
- ✅ Production-ready visualization code
- ✅ Responsive, accessible charts
- ✅ Interactive features (tooltips, zooming, filtering)
- ✅ Data transformation logic
- ✅ Styled components matching your design system
- ✅ TypeScript types for type safety
- ✅ Documentation and usage examples
- ✅ Performance optimizations
- ✅ Export functionality (PNG, PDF, CSV)

## Use Cases

**Build analytics dashboard:**
"Create a dashboard showing website traffic trends, top pages, conversion funnel, and user demographics with interactive filters"

**Visualize financial data:**
"Design a financial dashboard with revenue trends, expense breakdown, profit margins, and cash flow visualization"

**Create real-time monitoring:**
"Build a real-time operations dashboard showing server health, API response times, error rates, and active users"

**Sales performance visualization:**
"Visualize sales pipeline by stage, revenue by product category, top sales reps leaderboard, and forecast vs actual"

**Custom chart implementation:**
"Create a custom Sankey diagram showing user journey from landing page through conversion with drop-off rates"

## Activation

This skill activates when you need:
- Chart and graph creation
- Dashboard development
- Data visualization consulting
- Interactive visualization features
- Custom chart implementations
- Data transformation for visualization
- Accessibility improvements
- Performance optimization

Provides beautiful, insightful, production-ready data visualizations with best practices and accessibility.
