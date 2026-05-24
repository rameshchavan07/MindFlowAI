import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dayscore/features/chatbot/presentation/chatbot_providers.dart';

void main() {
  test('Initial state has welcome message', () {
    final container = ProviderContainer();
    final state = container.read(chatControllerProvider);

    expect(state.messages.length, 1);
    expect(state.messages.first.isMe, false);
    expect(state.messages.first.text, contains('Hello! I am your DayScore Wellness Coach'));
  });
}
