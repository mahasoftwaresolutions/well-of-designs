import 'package:flutter/material.dart';
import 'portfolios/getting_started/page.dart';
import 'portfolios/freelancer_dashboard/page.dart';
import 'portfolios/pill_nav_bar/page.dart';

class PortfolioEntry {
  final String title;
  final String description;
  final String slug;
  final Color accentColor;
  final IconData icon;
  final Widget Function() pageBuilder;

  const PortfolioEntry({
    required this.title,
    required this.description,
    required this.slug,
    required this.accentColor,
    required this.icon,
    required this.pageBuilder,
  });
}

class PortfolioRegistry {
  static final List<PortfolioEntry> entries = [
    PortfolioEntry(
      title: 'Getting Started',
      description:
          'Design tokens, typography, and sample components — a template for every new portfolio.',
      slug: 'getting-started',
      accentColor: const Color(0xFF6C63FF),
      icon: Icons.auto_awesome_rounded,
      pageBuilder: () => const GettingStartedPage(),
    ),
    PortfolioEntry(
      title: 'Freelancer Dashboard',
      description:
          'Project management app with blob tab connectors, golden theme, and timeline views.',
      slug: 'freelancer-dashboard',
      accentColor: const Color(0xFFF2C94C),
      icon: Icons.bolt_rounded,
      pageBuilder: () => const FreelancerDashboardPage(),
    ),
    PortfolioEntry(
      title: 'Pill Nav Bar',
      description:
          'Sliding pill navigation with expandable hexagon FAB and floating tooltip badge.',
      slug: 'pill-nav-bar',
      accentColor: const Color(0xFF5EC28E),
      icon: Icons.navigation_rounded,
      pageBuilder: () => const PillNavBarPage(),
    ),
  ];

  static PortfolioEntry? findBySlug(String slug) {
    try {
      return entries.firstWhere((e) => e.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
