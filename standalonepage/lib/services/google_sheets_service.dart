import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleSheetsService {
  static const String _scriptUrl = 
    'https://script.google.com/macros/s/AKfycbw2vHAgO3m3BO62CCbenGndaV8ldjkS6nxxXw6N8gMjuJJX-wm0HWD_I7Wmsk4KKMjE/exec';

  static Future<void> submitForm(String name, String email, String message) async {
    try {
      final response = await http.post(
        Uri.parse(_scriptUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          // Add CORS headers
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type',
        },
        body: json.encode({
          'action': 'submit',  // Add action identifier
          'data': {
            'name': name,
            'email': email,
            'message': message,
            'timestamp': DateTime.now().toIso8601String(),
          }
        }),
      );

      if (response.statusCode == 302 || response.statusCode == 200) {
        // Success
        return;
      }

      throw Exception('Failed to submit form: ${response.statusCode}');
    } catch (e) {
      print('Error submitting to Google Sheets: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getSubmissions() async {
    try {
      final response = await http.get(
        Uri.parse('$_scriptUrl?action=get'),  // Add action parameter
        headers: {
          'Accept': 'application/json',
          // Add CORS headers
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'POST, GET, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List) {
          return List<Map<String, dynamic>>.from(responseData);
        }
        return [];
      }

      throw Exception('Failed to fetch submissions: ${response.statusCode}');
    } catch (e) {
      print('Error fetching from Google Sheets: $e');
      // Return empty list instead of throwing
      return [];
    }
  }
} 