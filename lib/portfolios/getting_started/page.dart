import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GettingStartedTokens.surfaceDark,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            pinned: true,
            backgroundColor: GettingStartedTokens.surfaceDark.withAlpha(230),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Getting Started',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Intro ───────────────────────────────────
                  Text(
                    'Design System',
                    style: GettingStartedTokens.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This is the starter template. Every portfolio includes design tokens, font samples, and reusable components.',
                    style: GettingStartedTokens.bodyLarge,
                  ),
                  const SizedBox(height: 40),

                  // ── Color Palette ───────────────────────────
                  _SectionHeader(title: 'Color Palette'),
                  const SizedBox(height: 16),
                  _ColorPaletteGrid(),
                  const SizedBox(height: 40),

                  // ── Typography ──────────────────────────────
                  _SectionHeader(title: 'Typography'),
                  const SizedBox(height: 16),
                  _TypographyShowcase(),
                  const SizedBox(height: 40),

                  // ── Spacing & Radii ─────────────────────────
                  _SectionHeader(title: 'Spacing & Radii'),
                  const SizedBox(height: 16),
                  _SpacingShowcase(),
                  const SizedBox(height: 40),

                  // ── Components ──────────────────────────────
                  _SectionHeader(title: 'Sample Components'),
                  const SizedBox(height: 16),
                  _ButtonShowcase(),
                  const SizedBox(height: 24),
                  _CardShowcase(),
                  const SizedBox(height: 24),
                  _ChipShowcase(),
                  const SizedBox(height: 24),
                  _InputShowcase(),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// Section Header
// ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: GettingStartedTokens.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(title, style: GettingStartedTokens.headlineLarge),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────
// Color Palette
// ────────────────────────────────────────────────────────────
class _ColorPaletteGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(
        GettingStartedTokens.palette.length,
        (i) => _ColorSwatch(
          color: GettingStartedTokens.palette[i],
          name: GettingStartedTokens.paletteNames[i],
          hex:
              '#${GettingStartedTokens.palette[i].toARGB32().toRadixString(16).substring(2).toUpperCase()}',
        ),
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final Color color;
  final String name;
  final String hex;
  const _ColorSwatch({
    required this.color,
    required this.name,
    required this.hex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceCard,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusMd),
        border: Border.all(color: GettingStartedTokens.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 72,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(
                GettingStartedTokens.radiusSm,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GettingStartedTokens.labelLarge),
                const SizedBox(height: 2),
                Text(hex, style: GettingStartedTokens.mono),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// Typography
// ────────────────────────────────────────────────────────────
class _TypographyShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      ('Display Large', GettingStartedTokens.displayLarge, 'Outfit 48/800'),
      ('Display Medium', GettingStartedTokens.displayMedium, 'Outfit 34/700'),
      ('Headline Large', GettingStartedTokens.headlineLarge, 'Outfit 24/700'),
      ('Headline Medium', GettingStartedTokens.headlineMedium, 'Outfit 20/600'),
      ('Body Large', GettingStartedTokens.bodyLarge, 'Inter 16/400'),
      ('Body Medium', GettingStartedTokens.bodyMedium, 'Inter 14/400'),
      ('Body Small', GettingStartedTokens.bodySmall, 'Inter 12/400'),
      ('Label Large', GettingStartedTokens.labelLarge, 'Inter 14/600'),
      ('Monospace', GettingStartedTokens.mono, 'JetBrains Mono 13/400'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceCard,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusLg),
        border: Border.all(color: GettingStartedTokens.borderSubtle),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final (label, style, meta) = entry.value;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              border: i < items.length - 1
                  ? const Border(
                      bottom: BorderSide(
                        color: GettingStartedTokens.borderSubtle,
                      ),
                    )
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 3, child: Text(label, style: style)),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Text(
                    meta,
                    style: GettingStartedTokens.mono.copyWith(
                      fontSize: 11,
                      color: GettingStartedTokens.textMuted,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// Spacing & Radii
// ────────────────────────────────────────────────────────────
class _SpacingShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacings = [
      ('XS', GettingStartedTokens.spacingXs),
      ('SM', GettingStartedTokens.spacingSm),
      ('MD', GettingStartedTokens.spacingMd),
      ('LG', GettingStartedTokens.spacingLg),
      ('XL', GettingStartedTokens.spacingXl),
      ('2XL', GettingStartedTokens.spacing2Xl),
    ];

    final radii = [
      ('SM', GettingStartedTokens.radiusSm),
      ('MD', GettingStartedTokens.radiusMd),
      ('LG', GettingStartedTokens.radiusLg),
      ('XL', GettingStartedTokens.radiusXl),
      ('Full', GettingStartedTokens.radiusFull),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceCard,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusLg),
        border: Border.all(color: GettingStartedTokens.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Spacing Scale', style: GettingStartedTokens.headlineMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: spacings.map((s) {
              return Column(
                children: [
                  Container(
                    width: s.$2,
                    height: s.$2,
                    decoration: BoxDecoration(
                      color: GettingStartedTokens.primary.withAlpha(60),
                      border: Border.all(
                        color: GettingStartedTokens.primary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${s.$1}\n${s.$2.toInt()}',
                    textAlign: TextAlign.center,
                    style: GettingStartedTokens.bodySmall,
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          Text('Border Radii', style: GettingStartedTokens.headlineMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: radii.map((r) {
              return Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: GettingStartedTokens.secondary.withAlpha(40),
                      border: Border.all(
                        color: GettingStartedTokens.secondary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(r.$2.clamp(0, 26)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${r.$1}\n${r.$2 == 999 ? '∞' : r.$2.toInt().toString()}',
                    textAlign: TextAlign.center,
                    style: GettingStartedTokens.bodySmall,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// Buttons
// ────────────────────────────────────────────────────────────
class _ButtonShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceCard,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusLg),
        border: Border.all(color: GettingStartedTokens.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Buttons', style: GettingStartedTokens.headlineMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              // Filled
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: GettingStartedTokens.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      GettingStartedTokens.radiusMd,
                    ),
                  ),
                  elevation: 0,
                ),
                child: const Text('Primary'),
              ),
              // Secondary
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: GettingStartedTokens.secondary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      GettingStartedTokens.radiusMd,
                    ),
                  ),
                  elevation: 0,
                ),
                child: const Text('Secondary'),
              ),
              // Outlined
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: GettingStartedTokens.primary,
                  side: const BorderSide(
                    color: GettingStartedTokens.primary,
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      GettingStartedTokens.radiusMd,
                    ),
                  ),
                ),
                child: const Text('Outlined'),
              ),
              // Ghost
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: GettingStartedTokens.textSecondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      GettingStartedTokens.radiusMd,
                    ),
                  ),
                ),
                child: const Text('Ghost'),
              ),
              // Icon button
              Container(
                decoration: BoxDecoration(
                  color: GettingStartedTokens.accent.withAlpha(30),
                  borderRadius: BorderRadius.circular(
                    GettingStartedTokens.radiusMd,
                  ),
                  border: Border.all(
                    color: GettingStartedTokens.accent.withAlpha(80),
                  ),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: GettingStartedTokens.accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// Cards
// ────────────────────────────────────────────────────────────
class _CardShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceCard,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusLg),
        border: Border.all(color: GettingStartedTokens.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cards', style: GettingStartedTokens.headlineMedium),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStatCard(
                  'Active Users',
                  '2,847',
                  '+12.5%',
                  Icons.people_alt_rounded,
                  GettingStartedTokens.primary,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Revenue',
                  '\$48.2K',
                  '+8.1%',
                  Icons.trending_up_rounded,
                  GettingStartedTokens.secondary,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Conversion',
                  '3.24%',
                  '-0.4%',
                  Icons.auto_graph_rounded,
                  GettingStartedTokens.accent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String change,
    IconData icon,
    Color color,
  ) {
    final isPositive = change.startsWith('+');
    return Container(
      width: 180,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceElevated,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusLg),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const Spacer(),
          Text(value, style: GettingStartedTokens.headlineLarge),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(title, style: GettingStartedTokens.bodySmall),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color:
                      (isPositive
                              ? GettingStartedTokens.secondary
                              : GettingStartedTokens.accent)
                          .withAlpha(25),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  change,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isPositive
                        ? GettingStartedTokens.secondary
                        : GettingStartedTokens.accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// Chips
// ────────────────────────────────────────────────────────────
class _ChipShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chips = [
      ('Flutter', GettingStartedTokens.primary),
      ('Design', GettingStartedTokens.secondary),
      ('Mobile', GettingStartedTokens.accent),
      ('UI/UX', GettingStartedTokens.warning),
      ('Dart', GettingStartedTokens.info),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceCard,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusLg),
        border: Border.all(color: GettingStartedTokens.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chips & Tags', style: GettingStartedTokens.headlineMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: chips.map((c) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: c.$2.withAlpha(20),
                  borderRadius: BorderRadius.circular(
                    GettingStartedTokens.radiusFull,
                  ),
                  border: Border.all(color: c.$2.withAlpha(60)),
                ),
                child: Text(
                  c.$1,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: c.$2,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────
// Inputs
// ────────────────────────────────────────────────────────────
class _InputShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: GettingStartedTokens.surfaceCard,
        borderRadius: BorderRadius.circular(GettingStartedTokens.radiusLg),
        border: Border.all(color: GettingStartedTokens.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inputs', style: GettingStartedTokens.headlineMedium),
          const SizedBox(height: 16),
          // Text field
          TextField(
            style: GettingStartedTokens.bodyLarge.copyWith(
              color: GettingStartedTokens.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Search components...',
              hintStyle: GettingStartedTokens.bodyLarge.copyWith(
                color: GettingStartedTokens.textMuted,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: GettingStartedTokens.textMuted,
              ),
              filled: true,
              fillColor: GettingStartedTokens.surfaceElevated,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  GettingStartedTokens.radiusMd,
                ),
                borderSide: BorderSide(
                  color: GettingStartedTokens.borderSubtle,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  GettingStartedTokens.radiusMd,
                ),
                borderSide: BorderSide(
                  color: GettingStartedTokens.borderSubtle,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  GettingStartedTokens.radiusMd,
                ),
                borderSide: BorderSide(
                  color: GettingStartedTokens.primary,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Toggle row
          Row(
            children: [
              Text('Dark Mode', style: GettingStartedTokens.labelLarge),
              const Spacer(),
              Switch(
                value: true,
                onChanged: (_) {},
                activeThumbColor: GettingStartedTokens.primary,
                activeTrackColor: GettingStartedTokens.primary.withAlpha(80),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
