# Design Well — Flutter UI Reference Portfolio

A curated collection of Flutter UIs built from reference design images. Each design is decomposed into reusable components, built individually, and composed into a final page.

## Workflow: Adding a New Design

1. **Provide a reference image** — a screenshot or mockup of the target UI
2. **Analyze & decompose** — identify reusable components (cards, headers, lists, etc.)
3. **Create a portfolio folder** — `lib/portfolios/<design_name>/`
4. **Define design tokens** — colors, typography, spacing in `design_tokens.dart`
5. **Build components** — one widget per file in `components/`
6. **Compose the page** — assemble components in `page.dart`
7. **Register in the menu** — add a `PortfolioEntry` in `portfolio_registry.dart`

## Folder Convention

```
lib/
├── main.dart                  # App entry, theme, routing
├── app_shell.dart             # Scaffold wrapper
├── portfolio_menu.dart        # Gallery grid of portfolios
├── portfolio_registry.dart    # Central list of all portfolios
└── portfolios/
    └── <design_name>/         # One folder per design
        ├── page.dart           # Composed full page
        ├── design_tokens.dart  # Colors, text styles, spacing
        ├── components/         # Reusable widgets
        └── README.md           # Notes, reference image link
```

## Running

```bash
cd design_well
flutter run -d chrome
```

## Primary Target

- **Development**: Chrome (web)
- **End goal**: Mobile (Android/iOS) reference designs
