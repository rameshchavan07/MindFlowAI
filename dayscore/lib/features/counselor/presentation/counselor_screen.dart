import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/common/glass_card.dart';

class CounselorScreen extends StatelessWidget {
  const CounselorScreen({super.key});

  final List<Map<String, dynamic>> _counselors = const [
    {
      'name': 'Dr. Evelyn Carter',
      'specialization': 'Stress & Burnout Management',
      'rating': 4.9,
      'avatar': 'https://api.dicebear.com/7.x/adventurer/png?seed=Evelyn',
      'availability': 'Available Today',
    },
    {
      'name': 'Marcus Vance',
      'specialization': 'Productivity & Focus Coaching',
      'rating': 4.8,
      'avatar': 'https://api.dicebear.com/7.x/adventurer/png?seed=Marcus',
      'availability': 'Available Tomorrow',
    },
    {
      'name': 'Sophia Chen',
      'specialization': 'Cognitive Behavioral Counseling',
      'rating': 4.9,
      'avatar': 'https://api.dicebear.com/7.x/adventurer/png?seed=Sophia',
      'availability': 'Available Thursday',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Book Counselor'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        itemCount: _counselors.length,
        itemBuilder: (context, index) {
          final counselor = _counselors[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: GlassCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.surfaceLight,
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage: NetworkImage(counselor['avatar']),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          counselor['name'],
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          counselor['specialization'],
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(Icons.star, color: AppColors.lime, size: 16),
                            const SizedBox(width: 4.0),
                            Text(
                              counselor['rating'].toString(),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Icon(Icons.calendar_today, color: AppColors.cyan.withValues(alpha: 0.8), size: 14),
                            const SizedBox(width: 4.0),
                            Text(
                              counselor['availability'],
                              style: TextStyle(
                                color: AppColors.cyan.withValues(alpha: 0.8),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: AppColors.textMuted, size: 18),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Starting Jitsi video consultation booking with ${counselor['name']}.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
