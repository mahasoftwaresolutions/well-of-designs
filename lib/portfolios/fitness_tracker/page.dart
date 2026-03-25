import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';
import 'components/fitness_header.dart';
import 'components/goal_card.dart';
import 'components/stat_card.dart';
import 'components/activity_heatmap.dart';
import 'components/activity_bar_chart.dart';
import 'components/weight_card.dart';
import 'components/meal_card.dart';
import 'components/plan_card.dart';
import 'components/fitness_nav_bar.dart';
import 'components/add_modal.dart';
import '../neumorphic_date_strip/components/date_pill.dart';
import '../neumorphic_date_strip/components/date_strip.dart';

// ── Fitness-themed DatePillStyle ──────────────────────────

DatePillStyle _fitnessDatePillStyle() => DatePillStyle(
      pillSelectedColor: FTTokens.cardDark,
      pillUnselectedColor: FTTokens.cardWhite,
      pillSelectedShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(77),
          blurRadius: 30,
          offset: const Offset(0, 12),
          spreadRadius: -5,
        ),
      ],
      pillUnselectedShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(13),
          blurRadius: 12,
          offset: const Offset(0, 4),
          spreadRadius: -6,
        ),
      ],
      circleSelectedDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: FTTokens.accent,
        boxShadow: [
          BoxShadow(
            color: FTTokens.accent.withAlpha(102),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      circleUnselectedDecoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: FTTokens.surfaceLight,
      ),
      numberSelectedStyle: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      numberUnselectedStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: FTTokens.textDark,
        letterSpacing: -0.5,
      ),
      dayLetterStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: FTTokens.textLight,
      ),
      triangleColor: FTTokens.textDark,
    );

// ── Page ──────────────────────────────────────────────────

class FitnessTrackerPage extends StatefulWidget {
  const FitnessTrackerPage({super.key});

  @override
  State<FitnessTrackerPage> createState() => _FitnessTrackerPageState();
}

class _FitnessTrackerPageState extends State<FitnessTrackerPage>
    with SingleTickerProviderStateMixin {
  String _activeTab = 'home';
  bool _isAdding = false;
  int _selectedDateIndex = 6;
  int _previousDateIndex = 6;
  late final ScrollController _dateScrollController;
  final _dates = DateItem.generate(weekdayFormat: 'short');
  late final DatePillStyle _dateStyle;
  late final AnimationController _dateAnimController;
  late final CurvedAnimation _dateCurvedAnim;

  @override
  void initState() {
    super.initState();
    _dateScrollController = ScrollController();
    _dateStyle = _fitnessDatePillStyle();
    _dateAnimController = AnimationController(
      vsync: this,
      duration: _dateStyle.animDuration,
      value: 1.0,
    );
    _dateCurvedAnim = CurvedAnimation(
      parent: _dateAnimController,
      curve: _dateStyle.animCurve,
    );
  }

  @override
  void dispose() {
    _dateCurvedAnim.dispose();
    _dateAnimController.dispose();
    _dateScrollController.dispose();
    super.dispose();
  }

  void _onTabChanged(String tab) {
    if (tab == _activeTab) return;
    setState(() => _activeTab = tab);
    if (tab == 'analyze') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DateStrip.centerItem(
          _dateScrollController,
          _selectedDateIndex,
          animate: false,
        );
      });
    }
  }

  void _onDateSelected(int index) {
    if (index == _selectedDateIndex) return;
    setState(() {
      _previousDateIndex = _selectedDateIndex;
      _selectedDateIndex = index;
    });
    _dateAnimController.forward(from: 0.0);
    DateStrip.centerItem(_dateScrollController, index);
  }

  bool get _isMobileDevice =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    final content = _PhoneContent(
      activeTab: _activeTab,
      isAdding: _isAdding,
      dates: _dates,
      selectedDateIndex: _selectedDateIndex,
      previousDateIndex: _previousDateIndex,
      dateAnimation: _dateCurvedAnim,
      dateScrollController: _dateScrollController,
      dateStyle: _dateStyle,
      onTabChanged: _onTabChanged,
      onDateSelected: _onDateSelected,
      onFabTap: () => setState(() => _isAdding = true),
      onModalClose: () => setState(() => _isAdding = false),
      onBack: () => Navigator.maybePop(context),
    );

    if (_isMobileDevice) {
      return Scaffold(body: content);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE8ECeF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8ECEF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Fitness Tracker',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.8,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: _phoneFrame(content),
        ),
      ),
    );
  }

  Widget _phoneFrame(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(FTTokens.phoneRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 48,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(FTTokens.phoneRadius),
        child: child,
      ),
    );
  }
}

// ── Phone content ─────────────────────────────────────────

class _PhoneContent extends StatelessWidget {
  final String activeTab;
  final bool isAdding;
  final List<DateItem> dates;
  final int selectedDateIndex;
  final int previousDateIndex;
  final Animation<double> dateAnimation;
  final ScrollController dateScrollController;
  final DatePillStyle dateStyle;
  final ValueChanged<String> onTabChanged;
  final ValueChanged<int> onDateSelected;
  final VoidCallback onFabTap;
  final VoidCallback onModalClose;
  final VoidCallback onBack;

  const _PhoneContent({
    required this.activeTab,
    required this.isAdding,
    required this.dates,
    required this.selectedDateIndex,
    required this.previousDateIndex,
    required this.dateAnimation,
    required this.dateScrollController,
    required this.dateStyle,
    required this.onTabChanged,
    required this.onDateSelected,
    required this.onFabTap,
    required this.onModalClose,
    required this.onBack,
  });

  String get _headerTitle {
    switch (activeTab) {
      case 'home':
        return 'Welcome Back, Chloe';
      case 'analyze':
        return 'Analyze';
      case 'food':
        return 'Food';
      case 'plans':
        return 'Plans';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FTTokens.background,
      child: Stack(
        children: [
          // Scrollable body
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: FitnessHeader(title: _headerTitle),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 120),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildTab(),
                  ),
                ),
              ),
            ],
          ),

          // Bottom nav
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FitnessNavBar(
              activeTab: activeTab,
              onTabChanged: onTabChanged,
              onFabTap: onFabTap,
            ),
          ),

          // Add modal
          if (isAdding) AddModal(onClose: onModalClose),
        ],
      ),
    );
  }

  Widget _buildTab() {
    switch (activeTab) {
      case 'home':
        return _HomeTab(key: const ValueKey('home'));
      case 'analyze':
        return _AnalyzeTab(
          key: const ValueKey('analyze'),
          dates: dates,
          selectedDateIndex: selectedDateIndex,
          previousDateIndex: previousDateIndex,
          dateAnimation: dateAnimation,
          dateScrollController: dateScrollController,
          dateStyle: dateStyle,
          onDateSelected: onDateSelected,
        );
      case 'food':
        return const _FoodTab(key: ValueKey('food'));
      case 'plans':
        return const _PlansTab(key: ValueKey('plans'));
      default:
        return const SizedBox.shrink();
    }
  }
}

// ── Tab: Home ─────────────────────────────────────────────

class _HomeTab extends StatelessWidget {
  const _HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GoalCard(),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: const [
              StatCard(
                icon: Icons.monitor_heart_outlined,
                label: 'Heart Rate',
                value: '112',
                unit: 'bpm',
              ),
              SizedBox(width: 16),
              StatCard(
                icon: Icons.bar_chart_rounded,
                label: 'Steps',
                value: '8,240',
                isDark: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Tab: Analyze ──────────────────────────────────────────

class _AnalyzeTab extends StatelessWidget {
  final List<DateItem> dates;
  final int selectedDateIndex;
  final int previousDateIndex;
  final Animation<double> dateAnimation;
  final ScrollController dateScrollController;
  final DatePillStyle dateStyle;
  final ValueChanged<int> onDateSelected;

  const _AnalyzeTab({
    super.key,
    required this.dates,
    required this.selectedDateIndex,
    required this.previousDateIndex,
    required this.dateAnimation,
    required this.dateScrollController,
    required this.dateStyle,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Date strip
        DateStrip(
          controller: dateScrollController,
          dates: dates,
          selectedIndex: selectedDateIndex,
          previousIndex: previousDateIndex,
          animation: dateAnimation,
          onSelect: onDateSelected,
          style: dateStyle,
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ActivityHeatmap(),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ActivityBarChart(),
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: WeightCard(),
        ),
      ],
    );
  }
}

// ── Tab: Food ─────────────────────────────────────────────

class _FoodTab extends StatelessWidget {
  const _FoodTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: FTTokens.cardWhite,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: FTTokens.textLight),
                const SizedBox(width: 12),
                Text(
                  'Search food or meals...',
                  style: FTTokens.labelSmall.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text("Today's Meals", style: FTTokens.sectionTitle),
          const SizedBox(height: 16),
          const MealCard(
            name: 'Avocado Toast',
            time: 'Breakfast',
            calories: '320',
            icon: Icons.eco_outlined,
            iconColor: Color(0xFF22C55E),
          ),
          const SizedBox(height: 16),
          const MealCard(
            name: 'Grilled Salmon',
            time: 'Lunch',
            calories: '450',
            icon: Icons.set_meal_outlined,
            iconColor: Color(0xFFF97316),
          ),
          const SizedBox(height: 16),
          const MealCard(
            name: 'Berry Smoothie',
            time: 'Snack',
            calories: '180',
            icon: Icons.local_drink_outlined,
            iconColor: Color(0xFF8B5CF6),
          ),
        ],
      ),
    );
  }
}

// ── Tab: Plans ────────────────────────────────────────────

class _PlansTab extends StatelessWidget {
  const _PlansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Weekly Schedule', style: FTTokens.sectionTitle),
          const SizedBox(height: 16),
          const PlanCard(
            day: 'Today',
            title: 'Full Body HIIT',
            duration: '45 min',
            isHighlighted: true,
          ),
          const SizedBox(height: 16),
          const PlanCard(
            day: 'Tomorrow',
            title: 'Upper Body Strength',
            duration: '60 min',
          ),
          const SizedBox(height: 16),
          const PlanCard(
            day: 'Thursday',
            title: 'Active Recovery',
            duration: '30 min',
          ),
        ],
      ),
    );
  }
}
