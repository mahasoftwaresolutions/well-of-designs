import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'portfolio_registry.dart';

class PortfolioMenu extends StatefulWidget {
  const PortfolioMenu({super.key});

  @override
  State<PortfolioMenu> createState() => _PortfolioMenuState();
}

class _PortfolioMenuState extends State<PortfolioMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = PortfolioRegistry.entries;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero header
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Glowing accent dot
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(100),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Design Well',
                      style: GoogleFonts.outfit(
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'A curated collection of Flutter UI references',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withAlpha(120),
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Divider with gradient
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(
                              context,
                            ).colorScheme.primary.withAlpha(120),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Portfolio grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 420,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.35,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final entry = entries[index];
                final delay = index * 0.15;
                return SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: const Offset(0, 0.15),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _controller,
                          curve: Interval(
                            (0.3 + delay).clamp(0.0, 1.0),
                            (0.7 + delay).clamp(0.0, 1.0),
                            curve: Curves.easeOutCubic,
                          ),
                        ),
                      ),
                  child: FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        (0.3 + delay).clamp(0.0, 1.0),
                        (0.7 + delay).clamp(0.0, 1.0),
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: _PortfolioCard(entry: entry),
                  ),
                );
              }, childCount: entries.length),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
        ],
      ),
    );
  }
}

class _PortfolioCard extends StatefulWidget {
  final PortfolioEntry entry;
  const _PortfolioCard({required this.entry});

  @override
  State<_PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<_PortfolioCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, '/portfolio/${widget.entry.slug}');
        },
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: _hovering ? -4.0 : 0.0),
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          builder: (context, yOffset, child) => Transform.translate(
            offset: Offset(0, yOffset),
            transformHitTests: false,
            child: child!,
          ),
          child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF16161F),
            border: Border.all(
              color: _hovering
                  ? widget.entry.accentColor.withAlpha(100)
                  : Colors.white.withAlpha(15),
              width: 1,
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: widget.entry.accentColor.withAlpha(40),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.entry.accentColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: widget.entry.accentColor.withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Icon(
                  widget.entry.icon,
                  color: widget.entry.accentColor,
                  size: 24,
                ),
              ),
              const Spacer(),
              Text(
                widget.entry.title,
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.entry.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withAlpha(100),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              // Arrow indicator
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _hovering ? 32 : 24,
                    height: 2,
                    decoration: BoxDecoration(
                      color: widget.entry.accentColor.withAlpha(
                        _hovering ? 200 : 80,
                      ),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: widget.entry.accentColor.withAlpha(
                      _hovering ? 200 : 80,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}
