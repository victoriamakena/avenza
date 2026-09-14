class ApiService {
  static const String baseUrl =
      'http://127.0.0.1:8000/api';

  String? token;

  Map<String, String> get headers {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}