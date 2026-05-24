import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/ai/openai_service.dart';

// IMPORTANT: Replace with your actual API key or load from a secure config
const String _kOpenAIApiKey = 'YOUR_OPENAI_API_KEY_HERE';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  ChatState({
    required this.messages,
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final openaiServiceProvider = Provider<OpenAIService>((ref) {
  return OpenAIService(apiKey: _kOpenAIApiKey);
});

class ChatController extends StateNotifier<ChatState> {
  final OpenAIService _aiService;

  ChatController(this._aiService)
      : super(ChatState(messages: [
          ChatMessage(
            text: "Hello! I am your DayScore Wellness Coach. I can help with habits, motivation, stress management or productivity. What is on your mind today?",
            isMe: false,
          ),
        ]));

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(text: text.trim(), isMe: true);
    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      // Convert history to OpenAI format
      final history = state.messages.map((m) => {
        'role': m.isMe ? 'user' : 'assistant',
        'content': m.text,
      }).toList();

      final response = await _aiService.getChatResponse(history);
      
      final aiMessage = ChatMessage(text: response, isMe: false);
      state = state.copyWith(
        messages: [...state.messages, aiMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}

final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  final aiService = ref.watch(openaiServiceProvider);
  return ChatController(aiService);
});
