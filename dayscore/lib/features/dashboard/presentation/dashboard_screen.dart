import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/route_names.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/common/glass_card.dart';
import '../../../widgets/animations/wellness_ring.dart';
import '../../auth/presentation/auth_providers.dart';
import '../../../services/health/health_providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Future<void> _onRefresh() async {
    await ref.read(healthMetricsProvider.notifier).syncData();
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(currentUserProvider).value;
    final metrics = ref.watch(healthMetricsProvider);
    final score = ref.watch(wellnessScoreProvider);

    final displayName = userProfile?.name ?? 'Pathfinder';
    final stepTarget = userProfile?.fitnessTarget ?? 8000;
    final sleepTargetHours = userProfile?.sleepTarget ?? 8.0;

    // Convert sleep minutes to formatted hours & minutes
    final sleepHrs = metrics.sleepMinutes ~/ 60;
    final sleepMins = metrics.sleepMinutes % 60;

    return AppScaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.lime,
        backgroundColor: AppColors.surfaceDark,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 16.0,
            bottom: AppSizes.bottomNavBarHeight + 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $displayName',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Text(
                        'Your wellness is optimizing.',
                        style: TextStyle(
                          color: AppColors.cyan,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          metrics.isLoading ? Icons.sync : Icons.refresh,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: metrics.isLoading ? null : _onRefresh,
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Center(
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  hasGlow: true,
                  glowColor: score > 70 ? AppColors.lime : AppColors.cyan,
                  child: Column(
                    children: [
                      WellnessRing(score: score),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Wellness Condition',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        score > 75 
                            ? 'Your daily metrics are in excellent alignment.' 
                            : 'Keep up the healthy habits to optimize your score.',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Live Matrix',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12.0),
              // Grid of 4 Health Metrics
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.15,
                children: [
                  // Steps Card
                  GlassCard(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Steps',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                            ),
                            Icon(Icons.directions_walk, color: AppColors.lime, size: 20),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${metrics.steps}',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Goal: $stepTarget',
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Sleep Card
                  GlassCard(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sleep',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                            ),
                            Icon(Icons.nights_stay_outlined, color: AppColors.purple, size: 20),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${sleepHrs}h ${sleepMins}m',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              'Goal: ${sleepTargetHours}h',
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Heart Rate Card
                  GlassCard(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Heart Rate',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                            ),
                            Icon(Icons.favorite_border, color: AppColors.error, size: 20),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${metrics.heartRate} bpm',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Avg (today)',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Calories Card
                  GlassCard(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Calories',
                              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                            ),
                            Icon(Icons.local_fire_department_outlined, color: AppColors.cyan, size: 20),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${metrics.calories.toInt()} kcal',
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            const Text(
                              'Active burn',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              // Navigation shortcuts
              GlassCard(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0x208B5CF6),
                    child: Icon(Icons.edit_note, color: AppColors.purple),
                  ),
                  title: const Text(
                    'Daily Journal Analysis',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Sentiment and mood tracking updates.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                  onTap: () => context.pushNamed(RouteNames.journal),
                ),
              ),
              const SizedBox(height: 12.0),
              GlassCard(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0x2022D3EE),
                    child: Icon(Icons.support_agent, color: AppColors.cyan),
                  ),
                  title: const Text(
                    'Schedule Consultation',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'Book with professional wellness counselors.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                  onTap: () => context.pushNamed(RouteNames.counselor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
