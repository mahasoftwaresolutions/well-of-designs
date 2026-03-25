import 'package:flutter/material.dart';
import 'date_pill.dart';

/// A date entry for the horizontal date strip.
class DateItem {
  final int id;
  final String dayLetter;
  final int dayNumber;

  const DateItem({
    required this.id,
    required this.dayLetter,
    required this.dayNumber,
  });

  /// Generate dates around today.
  ///
  /// [weekdayFormat] — `'narrow'` for single-letter (T, W), `'short'` for
  /// abbreviated (Tue, Wed).
  static List<DateItem> generate({
    int before = 6,
    int after = 7,
    String weekdayFormat = 'narrow',
  }) {
    final today = DateTime.now();
    const narrow = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    const short = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return List.generate(before + after + 1, (i) {
      final d = today.add(Duration(days: i - before));
      final labels = weekdayFormat == 'short' ? short : narrow;
      return DateItem(
        id: i - before,
        dayLetter: labels[d.weekday % 7],
        dayNumber: d.day,
      );
    });
  }
}

/// A horizontally scrollable date strip built from [DatePill] widgets.
///
/// A single [animation] (owned by the parent page) drives both the
/// selecting and deselecting pill transitions simultaneously.
/// [selectedIndex] is the newly active date; [previousIndex] is the one
/// being deselected.
class DateStrip extends StatelessWidget {
  final ScrollController controller;
  final List<DateItem> dates;
  final int selectedIndex;
  final int previousIndex;
  final Animation<double> animation;
  final ValueChanged<int> onSelect;
  final DatePillStyle style;
  final double height;

  const DateStrip({
    super.key,
    required this.controller,
    required this.dates,
    required this.selectedIndex,
    required this.previousIndex,
    required this.animation,
    required this.onSelect,
    required this.style,
    this.height = 230,
  });

  /// Scroll [controller] so [index] is centred.
  static void centerItem(
    ScrollController controller,
    int index, {
    bool animate = true,
    double itemWidth = 84,
  }) {
    if (!controller.hasClients) return;
    final viewport = controller.position.viewportDimension;
    final target = index * itemWidth - (viewport - itemWidth) / 2;
    final clamped = target.clamp(
      controller.position.minScrollExtent,
      controller.position.maxScrollExtent,
    );
    if (animate) {
      controller.animateTo(
        clamped,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      controller.jumpTo(clamped);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final t = animation.value;
          return SingleChildScrollView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(dates.length, (index) {
                final date = dates[index];

                // Compute progress from the single shared animation value.
                // Selected pill:  0 → 1  (becoming active)
                // Previous pill:  1 → 0  (becoming inactive)
                // All others:     static 0 or 1
                double progress;
                if (index == selectedIndex) {
                  progress = t;
                } else if (index == previousIndex &&
                    previousIndex != selectedIndex) {
                  progress = 1.0 - t;
                } else {
                  progress = 0.0;
                }

                return DatePill(
                  dayLetter: date.dayLetter,
                  dayNumber: date.dayNumber,
                  progress: progress,
                  onTap: () => onSelect(index),
                  style: style,
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
