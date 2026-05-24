import 'package:flutter_test/flutter_test.dart';
import 'package:dayscore/services/ai/openai_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dart:convert';

import 'openai_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late OpenAIService openAIService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    openAIService = OpenAIService(apiKey: 'test_key', client: mockClient);
  });

  test('OpenAIService returns response on success', () async {
    final responseBody = {
      'choices': [
        {
          'message': {'content': 'Hello from AI'}
        }
      ]
    };

    when(mockClient.post(
      any,
      headers: anyNamed('headers'),
      body: anyNamed('body'),
    )).thenAnswer((_) async => http.Response(jsonEncode(responseBody), 200));

    final result = await openAIService.getChatResponse([
      {'role': 'user', 'content': 'Hi'}
    ]);

    expect(result, 'Hello from AI');
    verify(mockClient.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: captureAnyNamed('headers'),
      body: captureAnyNamed('body'),
    )).called(1);
  });
}
