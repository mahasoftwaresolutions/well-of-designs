import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// "Select a report" pill button with document icon and chevron.
class ReportButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ReportButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 6, 20, 6),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(FlexCardTokens.reportButtonRadius),
          border: Border.all(
            color: FlexCardTokens.reportBorderColor,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: FlexCardTokens.reportIconSize,
              height: FlexCardTokens.reportIconSize,
              decoration: const BoxDecoration(
                color: FlexCardTokens.actionButtonBg,
                shape: BoxShape.circle,
                boxShadow: [FlexCardTokens.buttonShadow],
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 18,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 12),
            Text('Select a report', style: FlexCardTokens.reportLabel),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Color(0xFF222222),
            ),
          ],
        ),
      ),
    );
  }
}
