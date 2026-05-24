import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../common/glass_card.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavBarItem(Icons.grid_view_rounded, 'Home'),
      _NavBarItem(Icons.mood_rounded, 'Mood'),
      _NavBarItem(Icons.support_agent_rounded, 'Coach'),
      _NavBarItem(Icons.analytics_outlined, 'Trends'),
      _NavBarItem(Icons.person_outline_rounded, 'Profile'),
    ];

    return Positioned(
      bottom: 24.0,
      left: 16.0,
      right: 16.0,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        borderRadius: AppSizes.radiusXl,
        borderColor: AppColors.glassBorder,
        color: AppColors.surfaceDark.withValues(alpha: 0.65),
        hasGlow: true,
        glowColor: AppColors.cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isActive = currentIndex == index;

            return GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.cyan.withValues(alpha: 0.12) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: isActive ? AppColors.cyan.withValues(alpha: 0.3) : Colors.transparent,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: isActive ? AppColors.cyan : AppColors.textSecondary,
                      size: AppSizes.iconMd,
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 8.0),
                      Text(
                        item.label,
                        style: const TextStyle(
                          color: AppColors.cyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavBarItem {
  final IconData icon;
  final String label;

  _NavBarItem(this.icon, this.label);
}
