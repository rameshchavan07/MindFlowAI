import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/common/glass_card.dart';
import '../../../widgets/common/gradient_button.dart';
import '../domain/mood_entry.dart';
import 'mood_providers.dart';

class MoodScreen extends ConsumerStatefulWidget {
  const MoodScreen({super.key});

  @override
  ConsumerState<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends ConsumerState<MoodScreen> {
  MoodCategory _selectedMood = MoodCategory.calm;
  double _intensity = 5.0;
  final _notesController = TextEditingController();
  bool _showHistory = false;

  final List<MoodCategory> _moodOptions = [
    MoodCategory.sad,
    MoodCategory.stressed,
    MoodCategory.calm,
    MoodCategory.happy,
    MoodCategory.excited,
    MoodCategory.tired,
    MoodCategory.angry,
  ];

  Color _colorForMood(MoodCategory mood) {
    switch (mood) {
      case MoodCategory.happy:
      case MoodCategory.excited:
        return AppColors.lime;
      case MoodCategory.calm:
        return AppColors.cyan;
      case MoodCategory.stressed:
      case MoodCategory.angry:
        return AppColors.error;
      case MoodCategory.sad:
      case MoodCategory.tired:
        return AppColors.purple;
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _onSave() async {
    final success = await ref.read(moodControllerProvider.notifier).saveMood(
          category: _selectedMood,
          intensity: _intensity.toInt(),
          notes: _notesController.text.trim(),
        );

    if (success && mounted) {
      _notesController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mood state recorded successfully!'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final moodState = ref.watch(moodControllerProvider);
    final historyAsync = ref.watch(moodHistoryProvider);
    final isLoading = moodState.isLoading;

    ref.listen<AsyncValue<void>>(moodControllerProvider, (_, next) {
      next.whenOrNull(error: (e, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppColors.error),
        );
      });
    });

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mood Log',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Document your current psychological state.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () => setState(() => _showHistory = !_showHistory),
                  icon: Icon(
                    _showHistory ? Icons.edit_outlined : Icons.history,
                    size: 18,
                    color: AppColors.cyan,
                  ),
                  label: Text(
                    _showHistory ? 'Log Mood' : 'History',
                    style: const TextStyle(color: AppColors.cyan),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            if (!_showHistory) ...[
              // ── Mood Selector ──────────────────────────────
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Current State',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 20.0),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: _moodOptions.map((mood) {
                        final isSelected = _selectedMood == mood;
                        final color = _colorForMood(mood);
                        return GestureDetector(
                          onTap: () => setState(() => _selectedMood = mood),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: isSelected ? color.withValues(alpha: 0.15) : Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: isSelected ? color : AppColors.glassBorder,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  mood.emoji,
                                  style: TextStyle(fontSize: isSelected ? 36 : 28),
                                ).animate(target: isSelected ? 1 : 0).scale(
                                      begin: const Offset(1.0, 1.0),
                                      end: const Offset(1.2, 1.2),
                                      duration: 200.ms,
                                    ),
                                const SizedBox(height: 6.0),
                                Text(
                                  mood.label,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // ── Intensity Slider ──────────────────────────────
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Intensity Level',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: _colorForMood(_selectedMood).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_intensity.toInt()} / 10',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _colorForMood(_selectedMood),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Slider(
                      value: _intensity,
                      min: 1.0,
                      max: 10.0,
                      divisions: 9,
                      activeColor: _colorForMood(_selectedMood),
                      inactiveColor: AppColors.surfaceLight,
                      onChanged: (val) => setState(() => _intensity = val),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Low', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                        Text('High', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),

              // ── Notes ──────────────────────────────
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Additional Context',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      enabled: !isLoading,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        hintText: 'Describe triggers, feelings, or notes...',
                        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),

              isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.lime))
                  : GradientButton(text: 'Save Mood State', onPressed: _onSave),
            ] else ...[
              // ── Mood History ──────────────────────────────
              historyAsync.when(
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.cyan)),
                error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: AppColors.error))),
                data: (entries) {
                  if (entries.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 48.0),
                        child: Column(
                          children: [
                            Text('😐', style: TextStyle(fontSize: 48)),
                            SizedBox(height: 16),
                            Text('No mood entries yet.', style: TextStyle(color: AppColors.textSecondary)),
                            Text('Log your first mood above!', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final color = _colorForMood(entry.category);
                      return GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        borderColor: color.withValues(alpha: 0.3),
                        child: Row(
                          children: [
                            Text(entry.category.emoji, style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        entry.category.label,
                                        style: TextStyle(color: color, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        DateFormat('MMM d, h:mm a').format(entry.timestamp),
                                        style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        'Intensity: ${entry.intensity}/10',
                                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                                      ),
                                      if (entry.notes.isNotEmpty) ...[
                                        const Text(' · ', style: TextStyle(color: AppColors.textMuted)),
                                        Expanded(
                                          child: Text(
                                            entry.notes,
                                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: (index * 60).ms, duration: 400.ms).slideX(begin: 0.1, end: 0);
                    },
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
