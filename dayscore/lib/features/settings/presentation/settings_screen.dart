import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/router/route_names.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/common/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _healthSync = true;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Text(
              'Integrations & Preferences',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            GlassCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Google Fit / HealthKit Sync'),
                    subtitle: const Text('Automatically sync activity data in background', style: TextStyle(fontSize: 11)),
                    value: _healthSync,
                    activeThumbColor: AppColors.lime,
                    inactiveThumbColor: AppColors.textSecondary,
                    onChanged: (val) {
                      setState(() {
                        _healthSync = val;
                      });
                    },
                  ),
                  const Divider(color: AppColors.glassBorder),
                  SwitchListTile(
                    title: const Text('Push Notifications'),
                    subtitle: const Text('Receive wellness suggestions & session updates', style: TextStyle(fontSize: 11)),
                    value: _notifications,
                    activeThumbColor: AppColors.lime,
                    inactiveThumbColor: AppColors.textSecondary,
                    onChanged: (val) {
                      setState(() {
                        _notifications = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Text(
              'Privacy & Compliance',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            GlassCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.shield_outlined, color: AppColors.cyan),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () {
                      _showPolicyDialog(context, 'Privacy Policy', 'Your fitness and mood data is fully encrypted at-rest and in-transit. In accordance with GDPR guidelines, you maintain absolute ownership over your logs.');
                    },
                  ),
                  const Divider(color: AppColors.glassBorder),
                  ListTile(
                    leading: const Icon(Icons.gavel_outlined, color: AppColors.cyan),
                    title: const Text('Terms of Service'),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () {
                      _showPolicyDialog(context, 'Terms of Service', 'By using DayScore, you agree to local data storage and periodic synchronization with Google Fit services.');
                    },
                  ),
                  const Divider(color: AppColors.glassBorder),
                  ListTile(
                    leading: const Icon(Icons.delete_outline, color: AppColors.error),
                    title: const Text('Delete My Data & Account', style: TextStyle(color: AppColors.error)),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.error),
                    onTap: () {
                      _showDeleteConfirmation(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48.0),
            Center(
              child: TextButton(
                onPressed: () {
                  context.goNamed(RouteNames.login);
                },
                child: const Text('Sign Out', style: TextStyle(color: AppColors.textMuted, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPolicyDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
        content: Text(content, style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close', style: TextStyle(color: AppColors.lime)),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Delete Account?', style: TextStyle(color: AppColors.error)),
        content: const Text('This action will permanently delete your DayScore account, Firestore collections, and sync configurations. This is irreversible under GDPR Right to Erasure.', style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account erasure queued.'), backgroundColor: AppColors.error),
              );
              context.goNamed(RouteNames.login);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
