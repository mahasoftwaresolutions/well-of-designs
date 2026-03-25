# CLAUDE.md — Well of Designs

## Mission

When given a **React/JSX code snippet**, convert it into a Flutter portfolio page following this project's architecture. Every conversion must produce a fully functional, well-decomposed Flutter implementation.

## React → Flutter Conversion Workflow

1. **Analyze the React code** — identify JSX structure, props, state (`useState`, `useEffect`), event handlers, and styling (CSS/Tailwind/styled-components)
2. **Map to Flutter equivalents:**
   - JSX elements → Widget tree
   - `useState` / `useReducer` → `StatefulWidget` + `setState()`
   - `useEffect` → `initState()` / `didChangeDependencies()` / `didUpdateWidget()`
   - `useRef` → `GlobalKey` or controller fields
   - CSS flexbox → `Row`, `Column`, `Flex`, `Expanded`, `Flexible`
   - CSS grid → `GridView`, `Wrap`
   - CSS position absolute → `Stack` + `Positioned`
   - `className` / Tailwind → Flutter inline styling (`TextStyle`, `BoxDecoration`, `EdgeInsets`)
   - `onClick` → `GestureDetector`, `InkWell`, `onTap`
   - `map()` rendering → `ListView.builder`, `Column(children: items.map(...).toList())`
   - CSS transitions → `AnimatedContainer`, `TweenAnimationBuilder`, `AnimationController`
   - `border-radius` → `BorderRadius.circular()`
   - `box-shadow` → `BoxShadow` in `BoxDecoration`
   - SVG icons → `Icons.*` or `CustomPaint`
   - `framer-motion` / CSS keyframes → `AnimationController` + `CurvedAnimation`
3. **Extract design tokens** — pull all colors, font sizes, font weights, spacing values, and radii into `design_tokens.dart`
4. **Decompose into components** — one widget per file under `components/`, each with a single responsibility
5. **Compose the page** — assemble in `page.dart` with responsive layout
6. **Register** — add a `PortfolioEntry` to `portfolio_registry.dart`

## Project Conventions

See `AGENTS.md` for folder structure and file naming conventions.

Key rules:
- **State management:** Pure `StatefulWidget` + `setState()` only — no Provider, Riverpod, BLoC, or GetX
- **Dependencies:** Only `google_fonts` — avoid adding new packages unless absolutely necessary
- **Constructors:** Use `const` constructors wherever possible
- **Disposal:** Always `dispose()` AnimationControllers, ScrollControllers, etc.
- **File naming:** `snake_case.dart` for files, `PascalCase` for classes
- **One widget per file** in `components/`
- **Design tokens:** Static class with `static const` fields — never hardcode colors/sizes in widgets

## Responsive Layout Pattern

Every `page.dart` should support:
- **Native mobile** (when running on device): full-screen, no wrapper
- **Desktop/web**: centered phone-frame container with max-width ~420px

Use `MediaQuery` to detect platform width — see existing portfolios for the pattern.

## Flutter Best Practices

- Prefer composition over inheritance
- Use `CustomPaint` for complex organic shapes, `ClipPath` for clipping
- Use `AnimatedContainer` / `TweenAnimationBuilder` for simple animations
- Use `AnimationController` for complex or staggered animations
- Curves: prefer `Curves.easeOutCubic` (primary) and `Curves.easeInOutCubic` (secondary)
- Keep widgets small and focused — if a build method exceeds ~80 lines, extract a sub-widget

## Registration Template

```dart
PortfolioEntry(
  title: 'Design Name',
  description: 'One-line description of the UX pattern.',
  slug: 'design-name',
  accentColor: const Color(0xFF______),
  icon: Icons.some_icon,
  pageBuilder: () => const DesignNamePage(),
),
```
