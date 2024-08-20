import 'package:api_client_generator/api_client_generator.dart';

void main(List<String> arguments) async {
  if (arguments.isEmpty || arguments.length > 2) {
    print('Usage: dart run api_client_generator <schema_path> [output_path]');
    return;
  }

  final schemaPath = arguments[0];
  final outputPath = arguments.length == 2 ? arguments[1] : 'lib';

  final generator = ClientGenerator(schemaPath, outputPath);

  try {
    await generator.generate();
    print('API client code generated successfully.');
  } catch (e) {
    print('Error: $e');
  }
}
