import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/common/glass_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 16.0,
          bottom: AppSizes.bottomNavBarHeight + 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Insights & Trends',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              'Daily performance and mental wellness analytics.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 32.0),
            // ML Energy Prediction Module
            GlassCard(
              hasGlow: true,
              glowColor: AppColors.purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Energy Forecast (Next-day)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Chip(
                        label: Text('ML Model Active', style: TextStyle(fontSize: 10, color: AppColors.surfaceDark)),
                        backgroundColor: AppColors.purple,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        '84%',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: AppColors.purple,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(width: 16.0),
                      const Expanded(
                        child: Text(
                          'Your predicted wellness score is high. Sleep levels and mood entries are positively correlated.',
                          style: TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            // Custom Mock Chart Container
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wellness Trend (7 days)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Mock graphical trend bars
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildChartBar(height: 60, label: 'Mon'),
                        _buildChartBar(height: 80, label: 'Tue'),
                        _buildChartBar(height: 50, label: 'Wed'),
                        _buildChartBar(height: 90, label: 'Thu'),
                        _buildChartBar(height: 75, label: 'Fri'),
                        _buildChartBar(height: 85, label: 'Sat'),
                        _buildChartBar(height: 95, label: 'Sun', isActive: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Avg Sleep', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        SizedBox(height: 8),
                        Text('7.4 hrs', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: GlassCard(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mood Average', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                        SizedBox(height: 8),
                        Text('Good', style: TextStyle(color: AppColors.lime, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartBar({required double height, required String label, bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
                    colors: [AppColors.lime, AppColors.cyan],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : LinearGradient(
                    colors: [AppColors.surfaceLight, AppColors.surfaceLight.withValues(alpha: 0.5)],
                  ),
            borderRadius: BorderRadius.circular(6),
            border: isActive ? Border.all(color: AppColors.cyan.withValues(alpha: 0.5)) : null,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? AppColors.cyan : AppColors.textMuted,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
