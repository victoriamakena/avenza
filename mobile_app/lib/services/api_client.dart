import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  // Android emulator reaches your machine's localhost at 10.0.2.2.
  // Use your machine's real LAN IP instead if testing on a physical phone.
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<String?> _token() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('avenza_token');
  }

  static Future<Map<String, String>> _headers() async {
    final token = await _token();

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<dynamic> get(String path) async {
    final response = await http.get(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
    );

    return _handle(response);
  }

  static Future<dynamic> post(String path, [Map<String, dynamic>? body]) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handle(response);
  }

  static Future<dynamic> put(String path, [Map<String, dynamic>? body]) async {
    final response = await http.put(
      Uri.parse('$baseUrl$path'),
      headers: await _headers(),
      body: body != null ? jsonEncode(body) : null,
    );

    return _handle(response);
  }

  static dynamic _handle(http.Response response) {
    final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : {};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    final message = decoded is Map ? decoded['message'] : null;
    throw ApiException(message ?? 'Something went wrong.', response.statusCode);
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => message;
}