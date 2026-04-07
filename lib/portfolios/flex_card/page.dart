import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';
import 'components/flex_card_shape.dart';
import 'components/avatar_header.dart';
import 'components/progress_bar.dart';
import 'components/report_button.dart';
import 'components/circle_action_button.dart';

class FlexCardPage extends StatelessWidget {
  const FlexCardPage({super.key});

  bool get _isMobileDevice =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    final content = _FlexCardContent();

    if (_isMobileDevice) {
      return Scaffold(
        backgroundColor: FlexCardTokens.pageBg,
        body: content,
      );
    }

    return Scaffold(
      backgroundColor: FlexCardTokens.pageBg,
      appBar: AppBar(
        backgroundColor: FlexCardTokens.pageBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1A1A2E)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Flex Card',
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
        borderRadius: BorderRadius.circular(FlexCardTokens.phoneRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(FlexCardTokens.phoneRadius),
        child: Container(
          decoration: BoxDecoration(
            color: FlexCardTokens.pageBg,
            border: Border.all(
              color: const Color(0xFF2A2A2C),
              width: FlexCardTokens.phoneBorderWidth,
            ),
            borderRadius: BorderRadius.circular(FlexCardTokens.phoneRadius),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              FlexCardTokens.phoneRadius - FlexCardTokens.phoneBorderWidth,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// The inner content displaying the FlexCard centered on the page.
class _FlexCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: FlexCardTokens.pageBg,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: FlexCardTokens.cardWidth,
            height: FlexCardTokens.cardHeight,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Background shape with cutout
                const FlexCardShape(),

                // Top-right action buttons (in the cutout area)
                Positioned(
                  top: 16,
                  right: 8,
                  child: Row(
                    children: const [
                      CircleActionButton(icon: Icons.notifications_outlined),
                      SizedBox(width: 14),
                      CircleActionButton(icon: Icons.info_outline_rounded),
                    ],
                  ),
                ),

                // Main content
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with avatar
                        const AvatarHeader(
                          name: 'Alesha Hyocinth',
                          role: 'Project Manager',
                          avatarIcon: Icons.person_rounded,
                        ),

                        const SizedBox(height: 40),

                        // Project title
                        Text(
                          'OxeliaMetrix',
                          style: FlexCardTokens.projectTitle,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text('Industry: ',
                                style: FlexCardTokens.industryLabel),
                            Text('SaaS',
                                style: FlexCardTokens.industryValue),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // Progress bar
                        const ProgressBar(progress: 0.34),

                        const Spacer(),

                        // Bottom actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const ReportButton(),
                            Container(
                              width: FlexCardTokens.sendButtonSize,
                              height: FlexCardTokens.sendButtonSize,
                              decoration: const BoxDecoration(
                                color: FlexCardTokens.sendButtonBg,
                                shape: BoxShape.circle,
                                boxShadow: [FlexCardTokens.sendShadow],
                              ),
                              child: const Icon(
                                Icons.send_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
