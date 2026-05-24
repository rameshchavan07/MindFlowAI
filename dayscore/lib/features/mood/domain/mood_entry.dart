import 'package:cloud_firestore/cloud_firestore.dart';

enum MoodCategory {
  happy,
  calm,
  stressed,
  sad,
  angry,
  excited,
  tired,
}

extension MoodCategoryExtension on MoodCategory {
  String get label {
    switch (this) {
      case MoodCategory.happy:
        return 'Happy';
      case MoodCategory.calm:
        return 'Calm';
      case MoodCategory.stressed:
        return 'Stressed';
      case MoodCategory.sad:
        return 'Sad';
      case MoodCategory.angry:
        return 'Angry';
      case MoodCategory.excited:
        return 'Excited';
      case MoodCategory.tired:
        return 'Tired';
    }
  }

  String get emoji {
    switch (this) {
      case MoodCategory.happy:
        return '😊';
      case MoodCategory.calm:
        return '😌';
      case MoodCategory.stressed:
        return '😰';
      case MoodCategory.sad:
        return '😢';
      case MoodCategory.angry:
        return '😡';
      case MoodCategory.excited:
        return '🤩';
      case MoodCategory.tired:
        return '😴';
    }
  }

  static MoodCategory fromString(String value) {
    return MoodCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MoodCategory.calm,
    );
  }
}

class MoodEntry {
  final String? id;
  final String userId;
  final MoodCategory category;
  final int intensity; // 1-10
  final String notes;
  final DateTime timestamp;

  const MoodEntry({
    this.id,
    required this.userId,
    required this.category,
    required this.intensity,
    required this.notes,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'category': category.name,
      'intensity': intensity,
      'notes': notes,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map, {String? id}) {
    return MoodEntry(
      id: id,
      userId: map['userId'] as String? ?? '',
      category: MoodCategoryExtension.fromString(map['category'] as String? ?? 'calm'),
      intensity: map['intensity'] as int? ?? 5,
      notes: map['notes'] as String? ?? '',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
