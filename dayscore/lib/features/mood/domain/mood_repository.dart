import '../domain/mood_entry.dart';

abstract class MoodRepository {
  /// Save a new mood entry to Firestore
  Future<void> saveMoodEntry(MoodEntry entry);

  /// Fetch mood history for a user (last [limit] entries)
  Future<List<MoodEntry>> getMoodHistory(String userId, {int limit = 30});

  /// Stream of latest mood entries (real-time updates)
  Stream<List<MoodEntry>> watchMoodHistory(String userId, {int limit = 30});
}
