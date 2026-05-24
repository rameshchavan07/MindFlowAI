import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/router/route_names.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/common/glass_card.dart';
import '../../auth/presentation/auth_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return AppScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 16.0,
          bottom: AppSizes.bottomNavBarHeight + 24.0,
        ),
        child: userAsync.when(
          loading: () => _buildShimmer(context),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (user) {
            if (user == null) {
              return const Center(child: Text('User profile not found.'));
            }

            return Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
                    onPressed: () => context.pushNamed(RouteNames.settings),
                  ),
                ),
                CircleAvatar(
                  radius: 54,
                  backgroundColor: AppColors.surfaceLight,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://api.dicebear.com/7.x/bottts/png?seed=${user.name}',
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.cyan,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 32.0),
                // Badges & Streaks Grid
                Row(
                  children: [
                    Expanded(
                      child: GlassCard(
                        child: const Column(
                          children: [
                            Icon(Icons.stars, color: AppColors.lime, size: 28),
                            SizedBox(height: 8.0),
                            Text(
                              '0 XP', // Future logic for real XP
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total Points',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: GlassCard(
                        child: const Column(
                          children: [
                            Icon(Icons.local_fire_department, color: AppColors.purple, size: 28),
                            SizedBox(height: 8.0),
                            Text(
                              '0 Days', // Future logic for real streaks
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Active Streak',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                // User Parameters list
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wellness Configuration',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildProfileTile(
                        Icons.flag_outlined,
                        'Goals',
                        user.goals.join(' & '),
                      ),
                      const Divider(color: AppColors.glassBorder),
                      _buildProfileTile(
                        Icons.nights_stay_outlined,
                        'Sleep Target',
                        '${user.sleepTarget} hrs/night',
                      ),
                      const Divider(color: AppColors.glassBorder),
                      _buildProfileTile(
                        Icons.directions_walk,
                        'Fitness Target',
                        '${user.fitnessTarget} steps/day',
                      ),
                      const Divider(color: AppColors.glassBorder),
                      _buildProfileTile(
                        Icons.work_outline,
                        'Activity Level',
                        user.workStudyType,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceLight.withValues(alpha: 0.3),
      highlightColor: AppColors.surfaceLight.withValues(alpha: 0.1),
      child: Column(
        children: [
          const SizedBox(height: 48),
          const CircleAvatar(radius: 54),
          const SizedBox(height: 16),
          Container(height: 32, width: 200, color: Colors.white),
          const SizedBox(height: 8),
          Container(height: 16, width: 150, color: Colors.white),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: Container(height: 100, color: Colors.white)),
              const SizedBox(width: 16),
              Expanded(child: Container(height: 100, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 24),
          Container(height: 200, width: double.infinity, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.cyan, size: 20),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
