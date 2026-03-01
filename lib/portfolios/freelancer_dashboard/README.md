# Freelancer Dashboard — Design Analysis

## Reference Image

Two mobile screens from a freelancer/project management app — a **Dashboard** (left) and **Payments** detail (right).

---

## 🔑 Signature Design Patterns

### 1. Blob Tab Connector (L-Shape Merge)

The most distinctive pattern in this design. When a tab is selected, the tab and its content panel **merge seamlessly** into a single shape resembling an inverted-L or organic blob:

- **Dashboard screen (top)**: The "Projects" tab is selected. Its background extends downward and curves into the content panel below, forming a continuous rounded shape. The unselected "Stats" tab sits as a separate element with its own rounded pill. The junction between selected tab and content uses **concave corner curves** (negative radius) on the adjacent side — creating the "blob" illusion.
- **Payments screen (top)**: Same pattern with "Paid" / "Unpaid" tabs. "Paid" is selected and merges downward into the monthly stats content area.
- **Implementation clue**: This is achieved with `CustomPainter` or a `ClipPath` using a path that curves outward at the junction. Think of it as: the selected tab's bottom-left corner has a **convex curve into the content**, while the content panel's top-right (past the tab) has a **concave notch** that sculpts the blob shape.

### 2. Blob Bottom Navigation Bar

The bottom nav bar uses the **same blob/merge concept** but inverted:

- **Dashboard**: The center "lightning bolt" action button is a **raised yellow circle** that visually connects upward to the content area above through a subtle curve, as if the content is "resting on" the nav bar.
- **Payments**: The "documents" icon (2nd from right) is selected with a **dark circle that merges upward** into the dark content section, creating visual continuity between the nav state and the content color above.
- **Implementation clue**: A `CustomPainter` behind the nav bar that draws the connecting curve between the selected item's circle and the bottom edge of the content scaffold.

### 3. Color-Context Switching

The cards alternate between **light (cream/white)** and **dark (near-black)** backgrounds depending on context:

- Timelines section on the right screen: first card is yellow (active/current), subsequent cards are dark
- Project cards on left screen: first is dark, second is white
- This creates visual rhythm and hierarchy without additional decoration

---

## 📐 Screen-by-Screen Breakdown

### LEFT SCREEN — Dashboard

| Zone | Component | Details |
|------|-----------|---------|
| **Header** | Top bar | Back arrow `<`, centered "DASHBOARD" in caps, circular profile avatar (right) |
| **Tab bar** | Blob tabs | Two tabs: "Stats" + "DECEMBER" pill, "Projects" + count badge `182`. Yellow bg. Selected tab merges with content below. |
| **Tab content** | Countdown timer | "Left Working Time" label. Three circular indicators: `7 DAYS`, `10 HOURS`, `30 MIN` — each is a circular progress ring with the number centered. |
| **Projects section** | Section header | "PROJECTS" in caps + count badge `4` in a rounded pill |
| | Project cards (horizontal scroll) | Card 1 (dark bg): icon, "Travel Planning", pill "MOBILE APP", "7 DAYS LEFT" with yellow linear progress bar. Card 2 (white bg): icon, "Company Landing", pill "WEBSITE", "14 DAYS LEFT" with gray progress bar. |
| **Payments section** | Section header | "PAYMENTS" in caps |
| | Payment list items | Each row: icon (circular), company name (bold) + subtitle (project name), amount right-aligned. Items: Tate Design Studio/$400.00, Framely/$1500.00. |
| | See all link | "SEE ALL" in caps, right-aligned, acts as navigation to Payments screen |
| **Bottom nav** | Blob nav bar | 5 items: home, folder, ⚡ (center, raised yellow circle), chat, profile. Beige/cream background with subtle blob connector. |

### RIGHT SCREEN — Payments

| Zone | Component | Details |
|------|-----------|---------|
| **Header** | Top bar | Back arrow `<`, centered "PAYMENTS" in caps, circular profile avatar |
| **Tab bar** | Blob tabs | "Paid" + count badge `8`, "Unpaid" + count badge `2`. White/light bg. "Paid" selected, merges with content. |
| **Monthly stats** | Stats bar | "Last 3 Months" label. Three month columns: OCT/$2600.00, NOV/$3200.00, DEC/$2100.00 (highlighted). Small chart icon button on right. |
| **Timelines section** | Section header | "TIMELINES" in caps + count badge `3` |
| | Timeline cards (vertical list) | Card 1 (yellow bg): logo icon, "Tate Design Studio", subtitle, "1 WEEK" badge. Card 2 (dark bg): logo, "Framely", subtitle, "4 WEEKS" in bordered circle. Card 3 (dark bg): logo, "Crowd", subtitle, "12 WEEKS" in yellow circle. |
| **Clients section** | Section header | "CLIENTS" in caps + count badge `4` |
| | Client chips (horizontal scroll) | "+" add button, then chips with icon + name: Rubion, Tate, Crowd. Each chip has a subtle border, rounded pill shape. |
| **Bottom nav** | Blob nav bar | Same 5 items. The "folder/document" icon is selected (dark circle), center button is yellow ⚡. Dark blob connects the selected icon upward. |

---

## 🧩 Reusable Components Identified

### Structural (Complex)
1. **BlobTabBar** — The signature L-shape tab-content merge widget
2. **BlobBottomNavBar** — Bottom nav with selected-item merge connector
3. **AppTopBar** — Back arrow + title + avatar

### Cards & Lists
4. **ProjectCard** — Icon, title, type pill, countdown text, progress bar (dark & light variants)
5. **TimelineCard** — Logo, title, subtitle, week badge (yellow, dark, bordered variants)
6. **PaymentListTile** — Icon + name/subtitle + amount
7. **StatCard** — Month label + amount (vertical layout)

### Atoms
8. **CountBadge** — Rounded pill with count number next to section headers
9. **CircularCountdown** — Ring progress with number + label centered
10. **TypePill** — Rounded label like "MOBILE APP", "WEBSITE"
11. **WeekBadge** — Circular/pill badge showing duration (1 WEEK, 4 WEEKS, etc.)
12. **ClientChip** — Icon + name in a bordered horizontal pill
13. **SectionHeader** — "TITLE" in caps + CountBadge
14. **LinearProgressBar** — Thin rounded progress with yellow/gray fill

---

## 🎨 Design Tokens

### Colors
| Token | Hex | Usage |
|-------|-----|-------|
| `golden` | `#F2C94C` | Primary accent — tabs, progress bars, active cards, CTAs |
| `goldenLight` | `#F5DDA0` | Tab backgrounds, header areas |
| `dark` | `#1A1A2E` | Dark cards, selected nav items |
| `darkCard` | `#2D2D3F` | Slightly lighter dark card variant |
| `cream` | `#F5F0E8` | Page background, light areas |
| `white` | `#FFFFFF` | White cards, light content |
| `textPrimary` | `#1A1A1A` | Primary text (dark) |
| `textSecondary` | `#7A7A8A` | Muted text, subtitles |
| `textOnDark` | `#FFFFFF` | Text on dark backgrounds |

### Typography
| Style | Properties |
|-------|------------|
| Page title | 14px, bold, uppercase, tracking wide |
| Tab label | 24-28px, bold |
| Section header | 12px, bold, uppercase, tracking wide |
| Card title | 16px, bold |
| Card subtitle | 12px, regular, muted |
| Amount | 16px, bold |
| Badge | 10-12px, medium |

### Spacing & Radii
| Token | Value |
|-------|-------|
| Card radius | 16-20px |
| Pill/badge radius | 999 (full) |
| Tab blob radius | ~24px with concave curves |
| Card padding | 16-20px |
| Section gap | 24-32px |
| List item gap | 12-16px |

---

## 🏗 Build Order (Recommended)

**Phase 1 — Atoms** (no dependencies)
1. `CountBadge`
2. `TypePill`
3. `WeekBadge`
4. `SectionHeader`
5. `LinearProgressBar`
6. `CircularCountdown`

**Phase 2 — Cards & Lists** (depend on atoms)
7. `ProjectCard`
8. `TimelineCard`
9. `PaymentListTile`
10. `StatCard`
11. `ClientChip`

**Phase 3 — Structural** (depend on CustomPainter)
12. `BlobTabBar` — the signature widget
13. `BlobBottomNavBar`
14. `AppTopBar`

**Phase 4 — Compose screens**
15. Dashboard page (left screen)
16. Payments page (right screen)
