class CodeGenerator {
  final Map<String, dynamic> schema;

  CodeGenerator(this.schema);

  String generateClientCode() {
    final endpoints = schema['paths'] as Map<String, dynamic>;
    final buffer = StringBuffer();
    buffer.writeln('import \'dart:convert\';');
    buffer.writeln('import \'package:http/http.dart\' as http;');
    buffer.writeln('');

    buffer.writeln('class ApiClient {');
    buffer.writeln('  final String baseUrl;');
    buffer.writeln('  ApiClient(this.baseUrl);');
    buffer.writeln('');

    // Generate API methods
    endpoints.forEach((path, methods) {
      methods.forEach((method, details) {
        final operationId =
            details['operationId'] ?? _generateUniqueMethodName(path, method);
        final methodName = _sanitizeMethodName(operationId);
        final pathParameters = _extractPathParameters(path, details);
        final queryParameters = _extractQueryParameters(details);

        switch (method) {
          case 'get':
          case 'head':
            if (pathParameters.isNotEmpty) {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}, {Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.get(uri, headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}) async {');
                buffer.writeln(
                    '    final response = await http.get(Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\'), headers: _headers());');
              }
            } else {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName({Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}$path\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.get(uri, headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName() async {');
                buffer.writeln(
                    '    final response = await http.get(Uri.parse(\'\${baseUrl}$path\'), headers: _headers());');
              }
            }
            buffer.writeln('    return _handleResponse(response);');
            buffer.writeln('  }');
            buffer.writeln('');
            break;
          case 'post':
            if (pathParameters.isNotEmpty) {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}, Map<String, dynamic> body, {Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.post(uri, body: jsonEncode(body), headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}, Map<String, dynamic> body) async {');
                buffer.writeln(
                    '    final response = await http.post(Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\'), body: jsonEncode(body), headers: _headers());');
              }
            } else {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(Map<String, dynamic> body, {Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}$path\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.post(uri, body: jsonEncode(body), headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(Map<String, dynamic> body) async {');
                buffer.writeln(
                    '    final response = await http.post(Uri.parse(\'\${baseUrl}$path\'), body: jsonEncode(body), headers: _headers());');
              }
            }
            buffer.writeln('    return _handleResponse(response);');
            buffer.writeln('  }');
            buffer.writeln('');
            break;
          case 'put':
          case 'patch':
            if (pathParameters.isNotEmpty) {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}, Map<String, dynamic> body, {Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.${method}(uri, body: jsonEncode(body), headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}, Map<String, dynamic> body) async {');
                buffer.writeln(
                    '    final response = await http.${method}(Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\'), body: jsonEncode(body), headers: _headers());');
              }
            } else {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(Map<String, dynamic> body, {Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}$path\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.${method}(uri, body: jsonEncode(body), headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(Map<String, dynamic> body) async {');
                buffer.writeln(
                    '    final response = await http.${method}(Uri.parse(\'\${baseUrl}$path\'), body: jsonEncode(body), headers: _headers());');
              }
            }
            buffer.writeln('    return _handleResponse(response);');
            buffer.writeln('  }');
            buffer.writeln('');
            break;
          case 'delete':
            if (pathParameters.isNotEmpty) {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}, {Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.delete(uri, headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName(${_generateParameters(pathParameters)}) async {');
                buffer.writeln(
                    '    final response = await http.delete(Uri.parse(\'\${baseUrl}${_replacePathParameters(path, pathParameters)}\'), headers: _headers());');
              }
            } else {
              if (queryParameters.isNotEmpty) {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName({Map<String, dynamic>? queryParams}) async {');
                buffer.writeln(
                    '    final uri = Uri.parse(\'\${baseUrl}$path\').replace(queryParameters: queryParams);');
                buffer.writeln(
                    '    final response = await http.delete(uri, headers: _headers());');
              } else {
                buffer.writeln(
                    '  Future<Map<String, dynamic>> $methodName() async {');
                buffer.writeln(
                    '    final response = await http.delete(Uri.parse(\'\${baseUrl}$path\'), headers: _headers());');
              }
            }
            buffer.writeln('    return _handleResponse(response);');
            buffer.writeln('  }');
            buffer.writeln('');
            break;
          default:
            throw Exception('Unsupported HTTP method: $method');
        }
      });
    });

    // Generate header method
    buffer.writeln('  Map<String, String> _headers() {');
    buffer.writeln('    return {\'Content-Type\': \'application/json\'};');
    buffer.writeln('  }');
    buffer.writeln('');

    // Handle response
    buffer.writeln(
        '  Map<String, dynamic> _handleResponse(http.Response response) {');
    buffer.writeln('    switch (response.statusCode) {');
    buffer.writeln('      case 200:');
    buffer.writeln('      case 201:');
    buffer.writeln('        // Handle successful response');
    buffer.writeln(
        '        return jsonDecode(response.body) as Map<String, dynamic>;');
    buffer.writeln('      case 204:');
    buffer.writeln('        // No content to return');
    buffer.writeln('        return {};');
    buffer.writeln('      case 400:');
    buffer.writeln(
        '        throw Exception(\'Bad Request: \${response.body}\');');
    buffer.writeln('      case 401:');
    buffer.writeln(
        '        throw Exception(\'Unauthorized: \${response.body}\');');
    buffer.writeln('      case 403:');
    buffer
        .writeln('        throw Exception(\'Forbidden: \${response.body}\');');
    buffer.writeln('      case 404:');
    buffer
        .writeln('        throw Exception(\'Not Found: \${response.body}\');');
    buffer.writeln('      case 500:');
    buffer.writeln(
        '        throw Exception(\'Server Error: \${response.body}\');');
    buffer.writeln('      default:');
    buffer.writeln(
        '        throw Exception(\'Unexpected error occurred: \${response.statusCode}\');');
    buffer.writeln('    }');
    buffer.writeln('  }');
    buffer.writeln('}');

    return buffer.toString();
  }

  List<Map<String, dynamic>> _extractPathParameters(
      String path, Map<String, dynamic> details) {
    final params = <Map<String, dynamic>>[];
    final regex = RegExp(r'\{(\w+)\}');

    // Extract parameter names from the path
    for (var match in regex.allMatches(path)) {
      final paramName = match.group(1)!;

      // Ensure parameters exist and handle null safely
      final paramSchema = details['parameters']?.firstWhere(
        (param) => param['name'] == paramName,
        orElse: () => {},
      );

      if (paramSchema != null && paramSchema['schema'] != null) {
        params.add({
          'name': paramName,
          'type': _getDartType(paramSchema['schema']['type']),
        });
      }
    }
    return params;
  }

  List<Map<String, dynamic>> _extractQueryParameters(
      Map<String, dynamic> details) {
    final params = <Map<String, dynamic>>[];
    final parameters = details['parameters'] as List<dynamic>?;

    if (parameters != null) {
      for (var param in parameters) {
        if (param['in'] == 'query') {
          params.add({
            'name': param['name'],
            'type': _getDartType(param['schema']['type']),
          });
        }
      }
    }
    return params;
  }

  String _generateParameters(List<Map<String, dynamic>> params) {
    return params
        .map((param) => '${param['type']} ${param['name']}')
        .join(', ');
  }

  String _replacePathParameters(
      String path, List<Map<String, dynamic>> params) {
    var updatedPath = path;
    for (var param in params) {
      updatedPath = updatedPath.replaceFirst(
          '{${param['name']}}', '\${${param['name']}}');
    }
    return updatedPath;
  }

  String _getDartType(String? schemaType) {
    switch (schemaType) {
      case 'integer':
        return 'int';
      case 'string':
        return 'String';
      case 'boolean':
        return 'bool';
      case 'number':
        return 'double';
      case 'array':
        return 'List<dynamic>'; // Modify if you have specific array types
      default:
        return 'dynamic'; // Default type
    }
  }

  String _generateUniqueMethodName(String path, String method) {
    // Convert HTTP method to descriptive action
    final action = _httpMethodToAction(method);
    return 'api_${action}_${path.replaceAll(RegExp(r'[^\w\d]'), '_')}';
  }

  String _httpMethodToAction(String method) {
    switch (method) {
      case 'get':
        return 'fetch';
      case 'post':
        return 'create';
      case 'put':
        return 'update';
      case 'delete':
        return 'delete';
      default:
        return 'unknown';
    }
  }

  String _sanitizeMethodName(String name) {
    // Dart method names must start with a letter and cannot contain spaces or special characters
    return name
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_')
        .replaceAll(RegExp(r'^[^a-zA-Z]'), '_');
  }
}
