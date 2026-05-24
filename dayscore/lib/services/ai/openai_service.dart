import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class OpenAIService {
  final String apiKey;
  final String baseUrl = 'https://api.openai.com/v1/chat/completions';
  final String model = 'gpt-4o-mini';
  final http.Client _client;

  OpenAIService({required this.apiKey, http.Client? client}) 
      : _client = client ?? http.Client();

  Future<String> getChatResponse(List<Map<String, String>> messages) async {
    try {
      final response = await _client.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content': 'You are the DayScore Wellness Coach, an intelligent assistant focused on productivity, habit building, stress management, and mental wellness. You provide helpful, motivational, and actionable advice. Disclaimer: You do not provide clinical diagnoses or medical prescriptions.'
            },
            ...messages,
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        final error = jsonDecode(response.body);
        throw Exception('OpenAI Error: ${error['error']['message'] ?? 'Unknown error'}');
      }
    } catch (e) {
      debugPrint('Error calling OpenAI: $e');
      rethrow;
    }
  }
}
