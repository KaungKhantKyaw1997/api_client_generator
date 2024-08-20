import 'dart:io';
import 'package:yaml/yaml.dart';

class SchemaParser {
  final String schemaPath;

  SchemaParser(this.schemaPath);

  Future<Map<String, dynamic>> parse() async {
    final file = File(schemaPath);
    final contents = await file.readAsString();
    final yamlMap = loadYaml(contents) as YamlMap;

    return _convertYamlMap(yamlMap);
  }

  Map<String, dynamic> _convertYamlMap(YamlMap yamlMap) {
    final Map<String, dynamic> result = {};
    yamlMap.forEach((key, value) {
      if (value is YamlMap) {
        result[key.toString()] = _convertYamlMap(value);
      } else if (value is YamlList) {
        result[key.toString()] = value.map((e) {
          if (e is YamlMap) {
            return _convertYamlMap(e);
          } else if (e is YamlList) {
            return e.map((item) => _convertYamlMap(item)).toList();
          } else {
            return e;
          }
        }).toList();
      } else {
        result[key.toString()] = value;
      }
    });
    return result;
  }
}
