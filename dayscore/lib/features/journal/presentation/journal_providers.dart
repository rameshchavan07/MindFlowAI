import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/journal_entry.dart';
import '../domain/journal_repository.dart';
import '../data/journal_repository_impl.dart';
import '../../auth/presentation/auth_providers.dart';

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepositoryImpl();
});

// Stream of recent journal entries for the current user
final journalHistoryProvider = StreamProvider<List<JournalEntry>>((ref) {
  final authState = ref.watch(authStateChangesProvider).value;
  if (authState == null) return const Stream.empty();

  final repo = ref.watch(journalRepositoryProvider);
  return repo.watchEntries(authState.uid, limit: 20);
});

// State for the journal save/analyze flow
class JournalState {
  final bool isLoading;
  final JournalEntry? lastSaved;
  final String? error;

  const JournalState({
    this.isLoading = false,
    this.lastSaved,
    this.error,
  });

  JournalState copyWith({bool? isLoading, JournalEntry? lastSaved, String? error}) {
    return JournalState(
      isLoading: isLoading ?? this.isLoading,
      lastSaved: lastSaved ?? this.lastSaved,
      error: error ?? this.error,
    );
  }
}

class JournalController extends StateNotifier<JournalState> {
  final JournalRepository repo;
  final String userId;

  JournalController({required this.repo, required this.userId})
      : super(const JournalState());

  /// Saves the journal entry to Firestore with a mock local sentiment analysis.
  /// The VADER Python API can later update the entry via [updateEntry].
  Future<JournalEntry?> saveAndAnalyze({
    required String content,
    required List<String> tags,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Perform a simple local sentiment estimation while the Python API is pending
      final localSentiment = _localSentimentEstimate(content);

      final entry = JournalEntry(
        userId: userId,
        content: content,
        tags: tags,
        sentimentCompound: localSentiment['compound'],
        sentimentPos: localSentiment['pos'],
        sentimentNeu: localSentiment['neu'],
        sentimentNeg: localSentiment['neg'],
        dominantSentiment: localSentiment['dominant'],
        timestamp: DateTime.now(),
      );

      await repo.saveEntry(entry);
      state = state.copyWith(isLoading: false, lastSaved: entry);
      return entry;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  /// Simple keyword-based sentiment estimate (placeholder until Python VADER API is connected).
  Map<String, dynamic> _localSentimentEstimate(String text) {
    final lower = text.toLowerCase();
    final positiveWords = ['good', 'great', 'happy', 'amazing', 'love', 'wonderful', 'excited', 'grateful', 'joy', 'fantastic', 'excellent', 'productive', 'progress'];
    final negativeWords = ['bad', 'sad', 'awful', 'hate', 'terrible', 'stressed', 'anxious', 'tired', 'exhausted', 'overwhelmed', 'depressed', 'frustrated', 'angry'];

    int posCount = 0, negCount = 0;
    for (final w in positiveWords) {
      if (lower.contains(w)) posCount++;
    }
    for (final w in negativeWords) {
      if (lower.contains(w)) negCount++;
    }

    final total = posCount + negCount;
    if (total == 0) {
      return {'compound': 0.0, 'pos': 0.0, 'neu': 1.0, 'neg': 0.0, 'dominant': 'Neutral'};
    }

    final pos = posCount / total;
    final neg = negCount / total;
    final compound = pos - neg;

    return {
      'compound': double.parse(compound.toStringAsFixed(2)),
      'pos': double.parse(pos.toStringAsFixed(2)),
      'neu': 0.0,
      'neg': double.parse(neg.toStringAsFixed(2)),
      'dominant': compound >= 0.05 ? 'Positive' : (compound <= -0.05 ? 'Negative' : 'Neutral'),
    };
  }
}

final journalControllerProvider =
    StateNotifierProvider<JournalController, JournalState>((ref) {
  final repo = ref.watch(journalRepositoryProvider);
  final authState = ref.watch(authStateChangesProvider).value;
  return JournalController(repo: repo, userId: authState?.uid ?? '');
});
