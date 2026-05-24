import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/mood_entry.dart';
import '../domain/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  final FirebaseFirestore _firestore;

  MoodRepositoryImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _moods => _firestore.collection('moods');

  @override
  Future<void> saveMoodEntry(MoodEntry entry) async {
    await _moods.add(entry.toMap());
  }

  @override
  Future<List<MoodEntry>> getMoodHistory(String userId, {int limit = 30}) async {
    final snapshot = await _moods
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => MoodEntry.fromMap(
              doc.data() as Map<String, dynamic>,
              id: doc.id,
            ))
        .toList();
  }

  @override
  Stream<List<MoodEntry>> watchMoodHistory(String userId, {int limit = 30}) {
    return _moods
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MoodEntry.fromMap(
                  doc.data() as Map<String, dynamic>,
                  id: doc.id,
                ))
            .toList());
  }
}
