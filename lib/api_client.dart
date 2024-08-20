import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  ApiClient(this.baseUrl);

  Future<Map<String, dynamic>> fetchSomeResources(
      {Map<String, dynamic>? queryParams}) async {
    final uri =
        Uri.parse('${baseUrl}/resources').replace(queryParameters: queryParams);
    final response = await http.get(uri, headers: _headers());
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> createSomeResource(
      Map<String, dynamic> body) async {
    final response = await http.post(Uri.parse('${baseUrl}/resources'),
        body: jsonEncode(body), headers: _headers());
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> updateSomeResource(
      int resourceId, Map<String, dynamic> body) async {
    final response = await http.put(
        Uri.parse('${baseUrl}/resources/${resourceId}'),
        body: jsonEncode(body),
        headers: _headers());
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> deleteSomeResource(int resourceId) async {
    final response = await http.delete(
        Uri.parse('${baseUrl}/resources/${resourceId}'),
        headers: _headers());
    return _handleResponse(response);
  }

  Map<String, String> _headers() {
    return {'Content-Type': 'application/json'};
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        // Handle successful response
        return jsonDecode(response.body) as Map<String, dynamic>;
      case 204:
        // No content to return
        return {};
      case 400:
        throw Exception('Bad Request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Not Found: ${response.body}');
      case 500:
        throw Exception('Server Error: ${response.body}');
      default:
        throw Exception('Unexpected error occurred: ${response.statusCode}');
    }
  }
}
