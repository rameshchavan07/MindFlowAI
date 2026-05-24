import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/mood_entry.dart';
import '../domain/mood_repository.dart';
import '../data/mood_repository_impl.dart';
import '../../auth/presentation/auth_providers.dart';

final moodRepositoryProvider = Provider<MoodRepository>((ref) {
  return MoodRepositoryImpl();
});

// Stream of recent mood history for the current user
final moodHistoryProvider = StreamProvider<List<MoodEntry>>((ref) {
  final authState = ref.watch(authStateChangesProvider).value;
  if (authState == null) return const Stream.empty();

  final repo = ref.watch(moodRepositoryProvider);
  return repo.watchMoodHistory(authState.uid, limit: 30);
});

// Controller state for saving mood entries
class MoodController extends StateNotifier<AsyncValue<void>> {
  final MoodRepository repo;
  final String userId;

  MoodController({required this.repo, required this.userId})
      : super(const AsyncValue.data(null));

  Future<bool> saveMood({
    required MoodCategory category,
    required int intensity,
    required String notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final entry = MoodEntry(
        userId: userId,
        category: category,
        intensity: intensity,
        notes: notes,
        timestamp: DateTime.now(),
      );
      await repo.saveMoodEntry(entry);
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final moodControllerProvider =
    StateNotifierProvider<MoodController, AsyncValue<void>>((ref) {
  final repo = ref.watch(moodRepositoryProvider);
  final authState = ref.watch(authStateChangesProvider).value;
  return MoodController(repo: repo, userId: authState?.uid ?? '');
});
