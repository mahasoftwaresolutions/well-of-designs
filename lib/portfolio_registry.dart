import 'package:flutter/material.dart';
import 'portfolios/getting_started/page.dart';
import 'portfolios/freelancer_dashboard/page.dart';
import 'portfolios/pill_nav_bar/page.dart';
import 'portfolios/s_curved_tabs/page.dart';
import 'portfolios/neumorphic_date_strip/page.dart';
import 'portfolios/fitness_tracker/page.dart';

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
    PortfolioEntry(
      title: 'S-Curved Tabs',
      description:
          'Organic S-curve tab bar with animated bezier transitions and campaign card.',
      slug: 's-curved-tabs',
      accentColor: const Color(0xFFF40057),
      icon: Icons.waves_rounded,
      pageBuilder: () => const SCurvedTabsPage(),
    ),
    PortfolioEntry(
      title: 'Neumorphic Date Strip',
      description:
          'Horizontal date picker with neumorphic pills, red gradient selection, and spring animation.',
      slug: 'neumorphic-date-strip',
      accentColor: const Color(0xFFE93B3B),
      icon: Icons.calendar_today_rounded,
      pageBuilder: () => const NeumorphicDateStripPage(),
    ),
    PortfolioEntry(
      title: 'Fitness Tracker',
      description:
          'Multi-tab health app with calorie chart, activity heatmap, date strip, and meal tracking.',
      slug: 'fitness-tracker',
      accentColor: const Color(0xFFF58220),
      icon: Icons.fitness_center_rounded,
      pageBuilder: () => const FitnessTrackerPage(),
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
