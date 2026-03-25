import 'package:flutter/material.dart';
import '../design_tokens.dart';

/// Bottom-sheet modal triggered by the FAB with Meal / Workout options.
class AddModal extends StatelessWidget {
  final VoidCallback onClose;

  const AddModal({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Backdrop
        GestureDetector(
          onTap: onClose,
          child: Container(color: Colors.black.withAlpha(102)),
        ),

        // Sheet
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                // Handle
                Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Add New', style: FTTokens.modalTitle),
                ),
                const SizedBox(height: 24),

                // Option buttons
                Row(
                  children: [
                    _optionButton(
                      icon: Icons.lunch_dining_rounded,
                      label: 'Meal',
                    ),
                    const SizedBox(width: 16),
                    _optionButton(
                      icon: Icons.fitness_center_rounded,
                      label: 'Workout',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _optionButton({required IconData icon, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: FTTokens.surfaceLight,
          borderRadius: BorderRadius.circular(FTTokens.cardRadiusMd),
        ),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(icon, size: 24, color: FTTokens.accent),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: FTTokens.mealName.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
