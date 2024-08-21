import 'package:test/test.dart';
import 'package:api_client_generator/api_client_generator.dart';
import 'dart:io';

void main() {
  group('ClientGenerator Tests', () {
    test('should generate API client code successfully', () async {
      final schemaPath = 'test/test_resources/sample_schema.yaml';
      final outputPath = 'test_output';

      final outputDir = Directory(outputPath);
      if (outputDir.existsSync()) {
        outputDir.deleteSync(recursive: true);
      }

      final schemaFile = File(schemaPath);
      schemaFile.writeAsStringSync('''
      paths:
        /users:
          get:
            operationId: getUsers
            responses:
              '200':
                description: successful operation
      ''');

      final generator = ClientGenerator(schemaPath, outputPath);

      await generator.generate();

      final generatedFile = File('$outputPath/api_client.dart');
      expect(generatedFile.existsSync(), isTrue);
      final generatedCode = generatedFile.readAsStringSync();
      expect(generatedCode, contains('class ApiClient'));
      expect(
          generatedCode, contains('Future<Map<String, dynamic>> getUsers()'));

      outputDir.deleteSync(recursive: true);
      schemaFile.deleteSync();
    });

    test('should throw an error if schema file is missing', () async {
      final schemaPath = 'invalid_path/schema.yaml';
      final outputPath = 'test_output';

      final generator = ClientGenerator(schemaPath, outputPath);

      expect(() async => await generator.generate(),
          throwsA(isA<FileSystemException>()));
    });
  });
}
