import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  ApiService._internal();
  static final ApiService instance = ApiService._internal();

  static const String baseUrl = 'http://127.0.0.1:8000/api';

  String? token;

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('avenza_token');
  }

  Future<void> saveToken(String newToken) async {
    token = newToken;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avenza_token', newToken);
  }

  Future<void> clearToken() async {
    token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('avenza_token');
  }

  Map<String, String> get headers {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String path) async {
    final response = await http.get(Uri.parse('$baseUrl$path'), headers: headers);
    return _handle(response);
  }

  Future<dynamic> post(String path, [Map<String, dynamic>? body]) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handle(response);
  }

  Future<dynamic> put(String path, [Map<String, dynamic>? body]) async {
    final response = await http.put(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: body != null ? jsonEncode(body) : null,
    );
    return _handle(response);
  }

  dynamic _handle(http.Response response) {
    final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : {};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    final message = decoded is Map ? decoded['message'] : null;
    throw Exception(message ?? 'Something went wrong.');
  }
}