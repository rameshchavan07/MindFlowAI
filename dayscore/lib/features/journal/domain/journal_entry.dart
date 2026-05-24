import 'package:cloud_firestore/cloud_firestore.dart';

class JournalEntry {
  final String? id;
  final String userId;
  final String content;
  final List<String> tags;
  // Sentiment fields (populated after VADER analysis)
  final double? sentimentCompound; // -1.0 to +1.0
  final double? sentimentPos;
  final double? sentimentNeu;
  final double? sentimentNeg;
  final String? dominantSentiment;
  final DateTime timestamp;

  const JournalEntry({
    this.id,
    required this.userId,
    required this.content,
    required this.tags,
    this.sentimentCompound,
    this.sentimentPos,
    this.sentimentNeu,
    this.sentimentNeg,
    this.dominantSentiment,
    required this.timestamp,
  });

  /// Returns a simple local sentiment label from the compound score
  String get localSentimentLabel {
    if (sentimentCompound == null) return 'Unanalyzed';
    if (sentimentCompound! >= 0.05) return 'Positive';
    if (sentimentCompound! <= -0.05) return 'Negative';
    return 'Neutral';
  }

  int get positivityPercent {
    if (sentimentPos == null) return 0;
    return (sentimentPos! * 100).toInt();
  }

  JournalEntry copyWith({
    double? sentimentCompound,
    double? sentimentPos,
    double? sentimentNeu,
    double? sentimentNeg,
    String? dominantSentiment,
  }) {
    return JournalEntry(
      id: id,
      userId: userId,
      content: content,
      tags: tags,
      sentimentCompound: sentimentCompound ?? this.sentimentCompound,
      sentimentPos: sentimentPos ?? this.sentimentPos,
      sentimentNeu: sentimentNeu ?? this.sentimentNeu,
      sentimentNeg: sentimentNeg ?? this.sentimentNeg,
      dominantSentiment: dominantSentiment ?? this.dominantSentiment,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'tags': tags,
      'sentimentCompound': sentimentCompound,
      'sentimentPos': sentimentPos,
      'sentimentNeu': sentimentNeu,
      'sentimentNeg': sentimentNeg,
      'dominantSentiment': dominantSentiment,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map, {String? id}) {
    return JournalEntry(
      id: id,
      userId: map['userId'] as String? ?? '',
      content: map['content'] as String? ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      sentimentCompound: (map['sentimentCompound'] as num?)?.toDouble(),
      sentimentPos: (map['sentimentPos'] as num?)?.toDouble(),
      sentimentNeu: (map['sentimentNeu'] as num?)?.toDouble(),
      sentimentNeg: (map['sentimentNeg'] as num?)?.toDouble(),
      dominantSentiment: map['dominantSentiment'] as String?,
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
