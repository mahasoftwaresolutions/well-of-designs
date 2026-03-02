import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Fluid bottom nav bar matching the React FluidNavBar reference.
/// The active icon lifts into a golden circle, and a coloured blob "drop"
/// slides horizontally to sit behind it — coloured to match the active
/// screen's bottom background, creating a seamless visual connection.
class BlobBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  /// Colour of the sliding blob drop — pass the bottom background colour of
  /// the currently visible screen so the drop blends seamlessly.
  final Color blobColor;

  const BlobBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.blobColor = Colors.white,
  });

  static const List<IconData> icons = [
    Icons.home_rounded,
    Icons.folder_rounded,
    Icons.bolt_rounded,
    Icons.account_balance_wallet_outlined,
    Icons.person_outline_rounded,
  ];

  @override
  State<BlobBottomNavBar> createState() => _BlobBottomNavBarState();
}

class _BlobBottomNavBarState extends State<BlobBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pos; // animated slot index (0.0 – 4.0)

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    final start = widget.selectedIndex.toDouble();
    _pos = Tween<double>(begin: start, end: start)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic));
  }

  @override
  void didUpdateWidget(BlobBottomNavBar old) {
    super.didUpdateWidget(old);
    if (old.selectedIndex != widget.selectedIndex) {
      _pos = Tween<double>(
        begin: _pos.value,
        end: widget.selectedIndex.toDouble(),
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic));
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: LayoutBuilder(builder: (context, constraints) {
        final slotW = constraints.maxWidth / 5;
        return AnimatedBuilder(
          animation: _pos,
          builder: (_, _) => Stack(
            clipBehavior: Clip.none,
            children: [
              // Navbar background + sliding blob shape
              CustomPaint(
                size: Size(constraints.maxWidth, 80),
                painter: _BlobPainter(
                  blobPos: _pos.value,
                  slotWidth: slotW,
                  blobColor: widget.blobColor,
                  bgColor: FDTokens.creamLight,
                ),
              ),

              // Icons row
              Row(
                children: List.generate(5, (i) {
                  final isActive = i == widget.selectedIndex;
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => widget.onTap(i),
                    child: SizedBox(
                      width: slotW,
                      height: 80,
                      child: Center(
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: isActive ? 1.0 : 0.0),
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                          builder: (_, t, _) => Transform.translate(
                            offset: Offset(0, -25 * t),
                            transformHitTests: false,
                            child: Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Color.lerp(
                                    Colors.transparent, FDTokens.golden, t),
                                shape: BoxShape.circle,
                                boxShadow: t > 0.05
                                    ? [
                                        BoxShadow(
                                          color: FDTokens.golden
                                              .withAlpha((60 * t).round()),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Icon(
                                BlobBottomNavBar.icons[i],
                                size: 22,
                                color: Color.lerp(
                                    FDTokens.textSecondary, FDTokens.dark, t),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _BlobPainter extends CustomPainter {
  final double blobPos; // 0.0 – 4.0 (animated)
  final double slotWidth;
  final Color blobColor;
  final Color bgColor;

  _BlobPainter({
    required this.blobPos,
    required this.slotWidth,
    required this.blobColor,
    required this.bgColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Fill navbar background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = bgColor,
    );

    // Blob "U-drop" shape centred on the active slot
    final cx = (blobPos + 0.5) * slotWidth;
    const hw = 36.0; // half-width of the drop body
    const dh = 54.0; // total drop height
    const br = 36.0; // bottom radius (= hw → full half-circle base)
    const cr = 18.0; // concave corner radius at top edges

    final path = Path()
      ..moveTo(cx - hw - cr, 0)
      ..quadraticBezierTo(cx - hw, 0, cx - hw, cr) // left concave corner
      ..lineTo(cx - hw, dh - br)
      ..arcToPoint(Offset(cx + hw, dh - br),
          radius: const Radius.circular(br), clockwise: false) // rounded base
      ..lineTo(cx + hw, cr)
      ..quadraticBezierTo(cx + hw, 0, cx + hw + cr, 0) // right concave corner
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..color = blobColor
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(_BlobPainter old) =>
      old.blobPos != blobPos || old.blobColor != blobColor;
}
