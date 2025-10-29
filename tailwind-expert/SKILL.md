---
name: "Tailwind CSS Expert"
description: "Master Tailwind CSS specialist creating beautiful, responsive, accessible UI components and layouts. Expert in utility-first design, custom configurations, design systems, animations, and modern CSS patterns with Tailwind v3+."
version: "1.0.0"
dependencies: ""
---

# Tailwind CSS Expert

Elite Tailwind CSS specialist with comprehensive knowledge of utility-first CSS, responsive design, component architecture, and modern UI/UX patterns.

## Core Expertise

### Tailwind Fundamentals
- Utility-first CSS philosophy
- Responsive design (sm, md, lg, xl, 2xl breakpoints)
- Mobile-first approach
- Dark mode implementation
- Custom configurations (tailwind.config.js)
- JIT (Just-In-Time) compiler optimization
- PurgeCSS/content configuration for optimal bundle size

### Layout Mastery

#### Flexbox Layouts
```tsx
<div className="flex flex-col md:flex-row items-center justify-between gap-4">
  <div className="flex-1">Content</div>
  <div className="flex-shrink-0">Sidebar</div>
</div>
```

#### Grid Layouts
```tsx
<div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  {items.map(item => <Card key={item.id} {...item} />)}
</div>
```

#### Container & Spacing
- Container queries with @tailwindcss/container-queries
- Consistent spacing scale (space-y, gap, p-, m-)
- Aspect ratio utilities
- Max-width constraints

### Component Patterns

#### Button Variants
```tsx
// Primary Button
className="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed"

// Ghost Button
className="px-4 py-2 text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"

// Icon Button
className="p-2 rounded-full hover:bg-gray-100 transition-colors"
```

#### Card Components
```tsx
<div className="bg-white dark:bg-gray-800 rounded-xl shadow-lg p-6 hover:shadow-xl transition-shadow">
  <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
    Card Title
  </h3>
  <p className="text-gray-600 dark:text-gray-300">
    Card description
  </p>
</div>
```

#### Form Elements
```tsx
<input
  type="text"
  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-colors"
  placeholder="Enter text..."
/>

<select className="w-full px-4 py-2 pr-8 border border-gray-300 rounded-lg appearance-none bg-white focus:ring-2 focus:ring-blue-500">
  <option>Option 1</option>
</select>
```

### Advanced Techniques

#### Custom Design System
```js
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        brand: {
          50: '#f0f9ff',
          100: '#e0f2fe',
          500: '#0ea5e9',
          900: '#0c4a6e',
        }
      },
      fontFamily: {
        sans: ['Inter var', 'sans-serif'],
        display: ['Lexend', 'sans-serif'],
      },
      spacing: {
        '18': '4.5rem',
        '88': '22rem',
      },
      borderRadius: {
        '4xl': '2rem',
      }
    }
  }
}
```

#### Animations & Transitions
```tsx
// Fade in
className="animate-fadeIn opacity-0"

// Slide up
className="animate-slideUp translate-y-4"

// Custom animations in config
animation: {
  'fadeIn': 'fadeIn 0.5s ease-in-out',
  'slideUp': 'slideUp 0.3s ease-out',
  'spin-slow': 'spin 3s linear infinite',
}

keyframes: {
  fadeIn: {
    '0%': { opacity: '0' },
    '100%': { opacity: '1' },
  },
  slideUp: {
    '0%': { transform: 'translateY(1rem)', opacity: '0' },
    '100%': { transform: 'translateY(0)', opacity: '1' },
  }
}
```

#### Dark Mode
```tsx
<div className="bg-white dark:bg-gray-900 text-gray-900 dark:text-white">
  <h1 className="text-2xl font-bold">
    Supports dark mode
  </h1>
</div>

// In tailwind.config.js
module.exports = {
  darkMode: 'class', // or 'media'
}
```

### Responsive Design Patterns

#### Mobile Navigation
```tsx
<nav className="flex items-center justify-between p-4">
  <div className="text-xl font-bold">Logo</div>

  {/* Mobile menu button */}
  <button className="md:hidden">
    <MenuIcon />
  </button>

  {/* Desktop nav */}
  <ul className="hidden md:flex gap-6">
    <li><a href="/">Home</a></li>
    <li><a href="/about">About</a></li>
  </ul>
</nav>
```

#### Responsive Typography
```tsx
<h1 className="text-2xl md:text-4xl lg:text-5xl font-bold leading-tight">
  Responsive Heading
</h1>

<p className="text-sm md:text-base lg:text-lg text-gray-600">
  Responsive paragraph
</p>
```

#### Responsive Grid
```tsx
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4">
  {/* Auto-responsive grid */}
</div>
```

### Advanced UI Patterns

#### Glassmorphism
```tsx
className="bg-white/10 backdrop-blur-lg border border-white/20 shadow-xl"
```

#### Neumorphism
```tsx
className="bg-gray-100 shadow-[8px_8px_16px_#d1d1d1,-8px_-8px_16px_#ffffff]"
```

#### Gradient Backgrounds
```tsx
className="bg-gradient-to-r from-purple-500 via-pink-500 to-red-500"
className="bg-gradient-to-br from-blue-400 to-purple-600"
```

#### Complex Hover States
```tsx
className="group relative overflow-hidden"

// Child elements respond to parent hover
className="group-hover:scale-110 transition-transform"
className="group-hover:opacity-100 opacity-0 transition-opacity"
```

### Accessibility with Tailwind

#### Focus States
```tsx
className="focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none"
```

#### Screen Reader Only
```tsx
<span className="sr-only">Descriptive text for screen readers</span>
```

#### ARIA Support
```tsx
<button
  className="..."
  aria-label="Close menu"
  aria-expanded={isOpen}
>
```

### Performance Optimization

#### Content Configuration
```js
// tailwind.config.js
content: [
  './src/**/*.{js,ts,jsx,tsx}',
  './pages/**/*.{js,ts,jsx,tsx}',
  './components/**/*.{js,ts,jsx,tsx}',
],
```

#### Safelist for Dynamic Classes
```js
safelist: [
  'bg-red-500',
  'bg-green-500',
  {
    pattern: /bg-(red|green|blue)-(100|500|900)/,
  }
]
```

### Integration with Component Libraries

#### Shadcn/ui + Tailwind
```tsx
import { cn } from "@/lib/utils"

<div className={cn(
  "base-classes",
  variant === "primary" && "primary-classes",
  className
)}>
```

#### Headless UI + Tailwind
```tsx
import { Dialog } from '@headlessui/react'

<Dialog className="fixed inset-0 z-50 flex items-center justify-center">
  <Dialog.Overlay className="fixed inset-0 bg-black/30" />
  <Dialog.Panel className="bg-white rounded-lg p-6 max-w-md">
    Content
  </Dialog.Panel>
</Dialog>
```

### Common Patterns

#### Loading States
```tsx
<div className="animate-pulse">
  <div className="h-4 bg-gray-300 rounded w-3/4 mb-2"></div>
  <div className="h-4 bg-gray-300 rounded w-1/2"></div>
</div>
```

#### Badges & Pills
```tsx
<span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
  New
</span>
```

#### Tooltips (with CSS only)
```tsx
<div className="group relative inline-block">
  <button>Hover me</button>
  <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-1 bg-gray-900 text-white text-sm rounded opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none">
    Tooltip text
  </div>
</div>
```

#### Modal Overlay
```tsx
<div className="fixed inset-0 z-50 flex items-center justify-center">
  <div className="fixed inset-0 bg-black/50" onClick={onClose} />
  <div className="relative bg-white rounded-lg max-w-lg w-full mx-4">
    Modal content
  </div>
</div>
```

## Best Practices

### Class Organization
```tsx
// Recommended order: layout → spacing → typography → colors → effects
className="flex items-center gap-4 p-4 text-lg font-semibold text-gray-900 bg-white rounded-lg shadow-md hover:shadow-lg transition-shadow"
```

### Extract Components
```tsx
// Instead of repeating classes
const buttonClasses = "px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"

// Or use @apply in CSS (sparingly)
.btn-primary {
  @apply px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors;
}
```

### Avoid Arbitrary Values (when possible)
```tsx
// Prefer configured values
className="w-64" // Better

// Over arbitrary values
className="w-[256px]" // Use only when necessary
```

## Deliverables

Provides:
- ✅ Responsive, mobile-first layouts
- ✅ Accessible components (WCAG 2.1 AA)
- ✅ Dark mode support
- ✅ Custom design system configuration
- ✅ Optimized for production (minimal CSS)
- ✅ Consistent spacing and typography
- ✅ Beautiful animations and transitions
- ✅ Cross-browser compatible

## Activation

This skill activates for:
- UI component styling
- Layout creation
- Design system setup
- Responsive design
- Dark mode implementation
- Animation and transitions
- Accessibility improvements
- Tailwind configuration

Provides production-ready Tailwind CSS with best practices and accessibility.
