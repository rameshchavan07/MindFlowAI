import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/journal_entry.dart';
import '../domain/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final FirebaseFirestore _firestore;

  JournalRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _journals => _firestore.collection('journals');

  @override
  Future<String> saveEntry(JournalEntry entry) async {
    final doc = await _journals.add(entry.toMap());
    return doc.id;
  }

  @override
  Future<List<JournalEntry>> getEntries(String userId, {int limit = 20}) async {
    final snapshot = await _journals
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => JournalEntry.fromMap(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ))
        .toList();
  }

  @override
  Stream<List<JournalEntry>> watchEntries(String userId, {int limit = 20}) {
    return _journals
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => JournalEntry.fromMap(
                  doc.data() as Map<String, dynamic>,
                  id: doc.id,
                ))
            .toList());
  }

  @override
  Future<void> updateEntry(String entryId, Map<String, dynamic> updates) async {
    await _journals.doc(entryId).update(updates);
  }
}
