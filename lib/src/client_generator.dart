import 'dart:io';

import 'schema_parser.dart';
import 'code_generator.dart';

class ClientGenerator {
  final String schemaPath;
  final String outputPath;

  ClientGenerator(this.schemaPath, [this.outputPath = 'lib']);

  Future<void> generate() async {
    final parser = SchemaParser(schemaPath);
    final schema = await parser.parse();
    final generator = CodeGenerator(schema);
    final code = generator.generateClientCode();

    final outputDir = Directory(outputPath);
    if (!outputDir.existsSync()) {
      outputDir.createSync(recursive: true);
    }

    final outputFile = File('$outputPath/api_client.dart');
    await outputFile.writeAsString(code);
  }
}
