import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../widgets/common/app_scaffold.dart';
import '../../../widgets/common/glass_card.dart';
import '../../../widgets/common/gradient_button.dart';
import 'journal_providers.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final _journalController = TextEditingController();
  final _tagsController = TextEditingController();
  bool _showHistory = false;

  @override
  void dispose() {
    _journalController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _onSaveAndAnalyze() async {
    if (_journalController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something before saving.'), backgroundColor: AppColors.error),
      );
      return;
    }

    final tags = _tagsController.text
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final entry = await ref.read(journalControllerProvider.notifier).saveAndAnalyze(
          content: _journalController.text.trim(),
          tags: tags,
        );

    if (entry != null && mounted) {
      _journalController.clear();
      _tagsController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Journal entry saved & analyzed!'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final journalState = ref.watch(journalControllerProvider);
    final historyAsync = ref.watch(journalHistoryProvider);
    final lastSaved = journalState.lastSaved;

    ref.listen<JournalState>(journalControllerProvider, (_, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: AppColors.error),
        );
      }
    });

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Reflective Journal'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => _showHistory = !_showHistory),
            icon: Icon(
              _showHistory ? Icons.edit_outlined : Icons.history,
              size: 18,
              color: AppColors.cyan,
            ),
            label: Text(
              _showHistory ? 'Write' : 'History',
              style: const TextStyle(color: AppColors.cyan),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_showHistory) ...[
              // ── Write Entry ──────────────────────────────
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Record Your Thoughts',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic_none, color: AppColors.cyan),
                          onPressed: () {}, // Speech-to-text hook (Phase 5)
                          tooltip: 'Voice Input (coming soon)',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _journalController,
                      maxLines: 10,
                      enabled: !journalState.isLoading,
                      style: const TextStyle(color: AppColors.textPrimary, height: 1.5),
                      decoration: const InputDecoration(
                        hintText: 'Start writing... How was your day? What is on your mind?',
                        hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // ── Emotion Tags ──────────────────────────────
              GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: TextField(
                  controller: _tagsController,
                  enabled: !journalState.isLoading,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                  decoration: const InputDecoration(
                    labelText: 'Emotion Tags',
                    labelStyle: TextStyle(color: AppColors.textSecondary),
                    hintText: 'e.g. work, anxiety, gratitude (comma separated)',
                    hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 12),
                    prefixIcon: Icon(Icons.label_outline, color: AppColors.purple, size: 20),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // ── Sentiment Result ──────────────────────────────
              if (lastSaved != null)
                GlassCard(
                  hasGlow: true,
                  glowColor: _sentimentColor(lastSaved.sentimentCompound ?? 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.psychology_outlined,
                            color: _sentimentColor(lastSaved.sentimentCompound ?? 0.0),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'NLP Sentiment Insights',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _sentimentRow('Dominant Emotion', lastSaved.dominantSentiment ?? 'Neutral',
                          _sentimentColor(lastSaved.sentimentCompound ?? 0.0)),
                      const SizedBox(height: 8),
                      _sentimentRow('Positivity', '${lastSaved.positivityPercent}%', AppColors.lime),
                      const SizedBox(height: 8),
                      _sentimentRow('Compound Score', lastSaved.sentimentCompound?.toStringAsFixed(2) ?? '0.00', AppColors.cyan),
                      const SizedBox(height: 12),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: ((lastSaved.sentimentCompound ?? 0) + 1) / 2,
                          minHeight: 6,
                          color: _sentimentColor(lastSaved.sentimentCompound ?? 0.0),
                          backgroundColor: AppColors.surfaceLight,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Very Negative', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                          Text('Very Positive', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 24.0),
              journalState.isLoading
                  ? const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(color: AppColors.cyan),
                          SizedBox(height: 12),
                          Text('Analyzing sentiment...', style: TextStyle(color: AppColors.cyan, fontSize: 12)),
                        ],
                      ),
                    )
                  : GradientButton(text: 'Save and Analyze Entry', onPressed: _onSaveAndAnalyze),
            ] else ...[
              // ── Journal History ──────────────────────────────
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
                            Text('📓', style: TextStyle(fontSize: 48)),
                            SizedBox(height: 16),
                            Text('No journal entries yet.', style: TextStyle(color: AppColors.textSecondary)),
                            Text('Write your first entry!', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final compound = entry.sentimentCompound ?? 0.0;
                      final sentColor = _sentimentColor(compound);

                      return GlassCard(
                        padding: const EdgeInsets.all(16.0),
                        borderColor: sentColor.withValues(alpha: 0.25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: sentColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    entry.localSentimentLabel,
                                    style: TextStyle(color: sentColor, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  DateFormat('MMM d, h:mm a').format(entry.timestamp),
                                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              entry.content,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (entry.tags.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 6.0,
                                children: entry.tags.map((tag) => Chip(
                                  label: Text(tag, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                                  backgroundColor: AppColors.surface,
                                  side: const BorderSide(color: AppColors.glassBorder),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                )).toList(),
                              ),
                            ],
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

  Widget _sentimentRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        Text(value, style: TextStyle(color: valueColor, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  Color _sentimentColor(double compound) {
    if (compound >= 0.05) return AppColors.lime;
    if (compound <= -0.05) return AppColors.error;
    return AppColors.cyan;
  }
}
