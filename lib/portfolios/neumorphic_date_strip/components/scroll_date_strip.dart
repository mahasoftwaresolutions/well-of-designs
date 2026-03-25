import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'date_pill.dart';
import 'date_strip.dart' show DateItem;

/// A scroll-driven date carousel where swiping selects the centred pill.
///
/// A fixed triangle indicator sits at the viewport centre. Releasing the
/// scroll snaps to the nearest date with a bouncy spring. Tapping a pill
/// scrolls to centre it.
class ScrollDateStrip extends StatefulWidget {
  final List<DateItem> dates;
  final int initialIndex;
  final ValueChanged<int> onSelect;
  final DatePillStyle style;
  final double height;

  const ScrollDateStrip({
    super.key,
    required this.dates,
    this.initialIndex = 6,
    required this.onSelect,
    required this.style,
    this.height = 220,
  });

  @override
  State<ScrollDateStrip> createState() => _ScrollDateStripState();
}

class _ScrollDateStripState extends State<ScrollDateStrip> {
  late final ScrollController _scrollController;
  double _viewportWidth = 0;
  int _centeredIndex = 0;

  double get _itemWidth => widget.style.itemWidth;
  double get _padding => (_viewportWidth - _itemWidth) / 2;

  @override
  void initState() {
    super.initState();
    _centeredIndex = widget.initialIndex;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_viewportWidth == 0) return;
    final newIndex = _indexFromOffset(_scrollController.offset);
    if (newIndex != _centeredIndex) {
      setState(() => _centeredIndex = newIndex);
      widget.onSelect(newIndex);
    } else {
      // Still need to rebuild for smooth progress interpolation
      setState(() {});
    }
  }

  int _indexFromOffset(double offset) {
    return ((offset + _viewportWidth / 2 - _padding) / _itemWidth)
        .floor()
        .clamp(0, widget.dates.length - 1);
  }

  double _snapOffsetForIndex(int index) {
    return index * _itemWidth + _itemWidth / 2 - _viewportWidth / 2 + _padding;
  }

  void _scrollToIndex(int index) {
    final target = _snapOffsetForIndex(index);
    _scrollController.animateTo(
      target.clamp(
        _scrollController.position.minScrollExtent,
        _scrollController.position.maxScrollExtent,
      ),
      duration: widget.style.animDuration,
      curve: Curves.easeOutCubic,
    );
  }

  /// Compute visual progress for [index] based on distance from viewport centre.
  double _progressForIndex(int index, double scrollOffset) {
    final pillCenter = _padding + index * _itemWidth + _itemWidth / 2;
    final viewportCenter = scrollOffset + _viewportWidth / 2;
    final distance = (pillCenter - viewportCenter).abs();
    return (1.0 - distance / _itemWidth).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          _viewportWidth = constraints.maxWidth;
          final edgePadding = _padding;

          // Set initial scroll position on first layout
          if (!_scrollController.hasClients) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController
                    .jumpTo(_snapOffsetForIndex(widget.initialIndex));
              }
            });
          }

          return Stack(
            children: [
              // Scrollable pills
              Positioned.fill(
                top: 28, // Leave room for the fixed triangle
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(overscroll: true),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: _SnapScrollPhysics(
                      itemWidth: _itemWidth,
                      padding: edgePadding,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: edgePadding),
                        ...List.generate(widget.dates.length, (index) {
                          final date = widget.dates[index];
                          final offset = _scrollController.hasClients
                              ? _scrollController.offset
                              : _snapOffsetForIndex(widget.initialIndex);
                          final progress =
                              _progressForIndex(index, offset);

                          return DatePill(
                            dayLetter: date.dayLetter,
                            dayNumber: date.dayNumber,
                            progress: progress,
                            onTap: () => _scrollToIndex(index),
                            style: widget.style,
                            showTriangle: false,
                          );
                        }),
                        SizedBox(width: edgePadding),
                      ],
                    ),
                  ),
                ),
              ),

              // Fixed triangle indicator at centre
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 28,
                child: Center(
                  child: TriangleIndicator(
                    color: widget.style.triangleColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Scroll physics that snaps to item boundaries with an elastic spring.
class _SnapScrollPhysics extends ScrollPhysics {
  final double itemWidth;
  final double padding;

  const _SnapScrollPhysics({
    required this.itemWidth,
    required this.padding,
    super.parent = const BouncingScrollPhysics(),
  });

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _SnapScrollPhysics(
      itemWidth: itemWidth,
      padding: padding,
      parent: buildParent(ancestor),
    );
  }

  double _nearestSnap(ScrollMetrics position) {
    final currentOffset = position.pixels;
    // The snap point for index i is: i * itemWidth
    // (since the edge padding makes index 0 centered at offset 0)
    final index = (currentOffset / itemWidth).round();
    final clamped = index.clamp(
      0,
      ((position.maxScrollExtent) / itemWidth).round(),
    );
    return clamped * itemWidth;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    // If out of bounds, let parent (BouncingScrollPhysics) handle the bounce-back
    if (position.outOfRange) {
      return super.createBallisticSimulation(position, velocity);
    }

    // Find target snap point accounting for velocity (fling distance)
    final target = _nearestSnap(
      FixedScrollMetrics(
        minScrollExtent: position.minScrollExtent,
        maxScrollExtent: position.maxScrollExtent,
        pixels: position.pixels + velocity * 0.15, // fling projection
        viewportDimension: position.viewportDimension,
        axisDirection: position.axisDirection,
        devicePixelRatio: position.devicePixelRatio,
      ),
    );

    // Already at target
    if ((position.pixels - target).abs() < toleranceFor(position).distance) {
      return null;
    }

    // Bouncy spring to snap point
    return SpringSimulation(
      const SpringDescription(mass: 0.8, stiffness: 120, damping: 14),
      position.pixels,
      target,
      velocity,
    );
  }
}
