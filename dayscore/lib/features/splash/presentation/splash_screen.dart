import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/router/route_names.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/animations/wellness_ring.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 2800));
    if (mounted) {
      context.goNamed(RouteNames.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Glowing neon logo placeholder
            const WellnessRing(
              score: 85.0,
              size: 150.0,
              strokeWidth: 8.0,
            )
                .animate()
                .scale(
                  duration: 1000.ms,
                  curve: Curves.elasticOut,
                )
                .then()
                .shimmer(
                  duration: 1500.ms,
                  color: AppColors.lime.withValues(alpha: 0.3),
                ),
            const SizedBox(height: 32.0),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w800,
                  ),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 800.ms)
                .slideY(begin: 0.2, end: 0.0),
            const SizedBox(height: 8.0),
            Text(
              AppStrings.appSlogan,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.cyan,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  ),
            )
                .animate()
                .fadeIn(delay: 600.ms, duration: 800.ms)
                .slideY(begin: 0.2, end: 0.0),
          ],
        ),
      ),
    );
  }
}
