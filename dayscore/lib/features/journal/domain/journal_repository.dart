import '../domain/journal_entry.dart';

abstract class JournalRepository {
  /// Save a new journal entry to Firestore
  Future<String> saveEntry(JournalEntry entry);

  /// Fetch past journal entries for a user
  Future<List<JournalEntry>> getEntries(String userId, {int limit = 20});

  /// Stream of real-time journal entries
  Stream<List<JournalEntry>> watchEntries(String userId, {int limit = 20});

  /// Update an existing entry (e.g. after VADER analysis completes)
  Future<void> updateEntry(String entryId, Map<String, dynamic> updates);
}
