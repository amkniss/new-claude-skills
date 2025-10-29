---
name: "Dashboard Builder"
description: "Specialized dashboard and admin panel creator. Builds beautiful, data-rich, interactive dashboards with real-time updates, advanced filtering, charts, tables, and analytics. Expert in React Admin, Tremor, Recharts, and custom dashboard frameworks."
version: "1.0.0"
dependencies: ""
---

# Dashboard Builder

Expert dashboard architect creating production-ready admin panels, analytics dashboards, and data visualization interfaces.

## Dashboard Expertise

### Dashboard Types

#### Analytics Dashboard
- KPI cards with trend indicators
- Time-series charts (revenue, users, conversions)
- Comparative metrics (YoY, MoM, WoW)
- Funnel visualizations
- Cohort analysis
- Geographic data visualization

#### Admin Panel
- CRUD operations for all entities
- Advanced data tables with sorting, filtering, pagination
- Bulk actions
- Role-based access control
- Audit logs
- User management
- Settings and configuration

#### Monitoring Dashboard
- Real-time system metrics
- Alert thresholds and notifications
- Historical trend analysis
- Service health status
- Error rate tracking
- Performance metrics

#### Business Intelligence Dashboard
- Executive summary with key metrics
- Interactive reports
- Drill-down capabilities
- Custom date range filters
- Export functionality (PDF, CSV)
- Scheduled reports

### Tech Stack

```tsx
// Modern Dashboard Stack
import { Card, Title, Text, Metric } from '@tremor/react'
import { AreaChart, BarChart } from '@tremor/react'
import { DataTable } from '@/components/ui/data-table'
import { DateRangePicker } from '@/components/ui/date-range-picker'
```

### Dashboard Components

#### KPI Cards
```tsx
function KPICard({ title, value, change, trend }: KPICardProps) {
  return (
    <Card>
      <Text>{title}</Text>
      <Metric>{value}</Metric>
      <div className="flex items-center gap-2 mt-2">
        <span className={cn(
          "text-sm",
          change >= 0 ? "text-green-600" : "text-red-600"
        )}>
          {change >= 0 ? '↑' : '↓'} {Math.abs(change)}%
        </span>
        <Sparkline data={trend} />
      </div>
    </Card>
  )
}
```

#### Advanced Data Table
```tsx
import {
  ColumnDef,
  flexRender,
  getCoreRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  useReactTable,
} from '@tanstack/react-table'

function DataTable<TData, TValue>({
  columns,
  data,
}: DataTableProps<TData, TValue>) {
  const table = useReactTable({
    data,
    columns,
    getCoreRowModel: getCoreRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
  })

  return (
    <div>
      <Input
        placeholder="Filter..."
        onChange={(e) => table.setGlobalFilter(e.target.value)}
      />
      <Table>
        <TableHeader>
          {table.getHeaderGroups().map((headerGroup) => (
            <TableRow key={headerGroup.id}>
              {headerGroup.headers.map((header) => (
                <TableHead key={header.id}>
                  {flexRender(
                    header.column.columnDef.header,
                    header.getContext()
                  )}
                </TableHead>
              ))}
            </TableRow>
          ))}
        </TableHeader>
        <TableBody>
          {/* Render rows */}
        </TableBody>
      </Table>
      <Pagination table={table} />
    </div>
  )
}
```

#### Chart Dashboard Section
```tsx
import { Card, Title, AreaChart } from '@tremor/react'

export function RevenueDashboard({ data }: { data: ChartData[] }) {
  return (
    <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <Card>
        <Title>Revenue Trend</Title>
        <AreaChart
          data={data}
          index="date"
          categories={["revenue", "profit"]}
          colors={["blue", "green"]}
          valueFormatter={(value) => `$${value.toLocaleString()}`}
        />
      </Card>

      <Card>
        <Title>Top Products</Title>
        <BarChart
          data={productData}
          index="name"
          categories={["sales"]}
          colors={["purple"]}
        />
      </Card>
    </div>
  )
}
```

### Dashboard Features

#### Real-Time Updates
```tsx
'use client'

import { useEffect, useState } from 'react'

export function RealtimeDashboard() {
  const [metrics, setMetrics] = useState<Metrics>()

  useEffect(() => {
    const ws = new WebSocket('wss://api.example.com/metrics')

    ws.onmessage = (event) => {
      const data = JSON.parse(event.data)
      setMetrics(data)
    }

    return () => ws.close()
  }, [])

  return <MetricsDisplay data={metrics} />
}
```

#### Advanced Filtering
```tsx
export function FilteredDashboard() {
  const [filters, setFilters] = useState({
    dateRange: { from: new Date(), to: new Date() },
    status: [],
    category: [],
  })

  return (
    <>
      <FilterBar filters={filters} onChange={setFilters} />
      <Dashboard filters={filters} />
    </>
  )
}
```

#### Export Functionality
```tsx
async function exportToPDF() {
  const doc = new jsPDF()
  const chartElement = document.getElementById('revenue-chart')
  const chartImage = await htmlToImage.toPng(chartElement)

  doc.addImage(chartImage, 'PNG', 10, 10, 190, 100)
  doc.save('dashboard-report.pdf')
}

async function exportToCSV(data: any[]) {
  const csv = convertToCSV(data)
  const blob = new Blob([csv], { type: 'text/csv' })
  saveAs(blob, 'data-export.csv')
}
```

### Layout Patterns

#### Grid-Based Dashboard
```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
  <KPICard className="lg:col-span-1" />
  <KPICard className="lg:col-span-1" />
  <KPICard className="lg:col-span-1" />
  <KPICard className="lg:col-span-1" />

  <Card className="lg:col-span-3">
    <RevenueChart />
  </Card>

  <Card className="lg:col-span-1">
    <TopProducts />
  </Card>

  <Card className="lg:col-span-4">
    <DataTable />
  </Card>
</div>
```

#### Sidebar + Main Content
```tsx
<div className="flex h-screen">
  <Sidebar className="w-64 fixed h-full" />
  <main className="flex-1 ml-64 overflow-auto p-6">
    <DashboardContent />
  </main>
</div>
```

### Performance Optimization

- Virtualized lists for large datasets
- Debounced search and filters
- Memoized chart data transformations
- Lazy loading for off-screen charts
- Server-side pagination
- Data aggregation on backend
- Caching with React Query

## Complete Dashboard Example

```tsx
export default function DashboardPage() {
  const { data: metrics, isLoading } = useQuery({
    queryKey: ['metrics'],
    queryFn: fetchMetrics,
    refetchInterval: 30000, // Refresh every 30s
  })

  if (isLoading) return <DashboardSkeleton />

  return (
    <div className="p-6 space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Dashboard</h1>
        <div className="flex gap-4">
          <DateRangePicker />
          <Button onClick={exportReport}>Export</Button>
        </div>
      </div>

      {/* KPIs */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <KPICard
          title="Total Revenue"
          value="$123.4K"
          change={12}
          trend={metrics.revenueTrend}
        />
        <KPICard
          title="Active Users"
          value="45.2K"
          change={8}
          trend={metrics.usersTrend}
        />
        <KPICard
          title="Conversion Rate"
          value="3.4%"
          change={-2}
          trend={metrics.conversionTrend}
        />
        <KPICard
          title="Avg Order Value"
          value="$89"
          change={5}
          trend={metrics.aovTrend}
        />
      </div>

      {/* Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <Title>Revenue Over Time</Title>
          <AreaChart data={metrics.revenueData} />
        </Card>
        <Card>
          <Title>Sales by Category</Title>
          <DonutChart data={metrics.categoryData} />
        </Card>
      </div>

      {/* Data Table */}
      <Card>
        <Title>Recent Orders</Title>
        <DataTable
          columns={orderColumns}
          data={metrics.recentOrders}
        />
      </Card>
    </div>
  )
}
```

## Best Practices

- ✅ Mobile-responsive design
- ✅ Loading states for all async data
- ✅ Error handling with retry
- ✅ Real-time updates when appropriate
- ✅ Efficient data fetching and caching
- ✅ Accessible charts and tables
- ✅ Export capabilities
- ✅ Customizable date ranges
- ✅ Role-based access control
- ✅ Performance optimization

## Activation

Activates for:
- Analytics dashboard creation
- Admin panel development
- Data table implementation
- Chart and visualization integration
- Real-time monitoring dashboards
- Export functionality
- Filter and search systems

Delivers production-ready dashboards with rich features.
