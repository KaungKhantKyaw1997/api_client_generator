# API Client Generator

A Dart package to automatically generate an API client based on an OpenAPI YAML schema file. This package is designed to streamline the creation of Dart API clients by parsing an OpenAPI schema and generating Dart code to handle HTTP requests and responses.

## Features

- Automatically generate API client code from an OpenAPI YAML schema.
- Supports `GET`, `POST`, `PUT`, and `DELETE` HTTP methods.
- Handles path parameters, query parameters and request bodies.
- Generates Dart code with `http` package integration.

## Usage

To generate API client code, use the following command in your terminal:

```bash
dart run api_client_generator <schema_path> [output_path]
```

- `<schema_path>`: The path to your OpenAPI YAML schema file.
- `[output_path]` (optional): The directory where the generated Dart code will be saved. Defaults to `lib`.

### Example

Suppose you have an OpenAPI schema file located at `api_schema.yaml`. You can generate the client code by running:

```bash
dart run api_client_generator api_schema.yaml
```

The generated API client will be saved in the `lib` directory by default.

## Example Code

Here's an example of how to use the generated API client:

```dart
import 'package:api_client_generator/api_client.dart';

void main() async {
  final apiClient = ApiClient('https://api.example.com');

  try {
    // GET request
    final response = await apiClient.fetchSomeResources(queryParams: {
      'page': 1,
      'pageSize': 10,
    });
    print('Fetched resources: $response');

    // POST request
    final newResource = await apiClient.createSomeResource({
      'name': 'example',
      'description': 'An example resource',
    });
    print('Created resource: $newResource');

    // PUT request
    final updatedResource = await apiClient.updateSomeResource(
      1,
      {
        'name': 'updated_example',
        'description': 'Updated description',
      },
    );
    print('Updated resource: $updatedResource');

    // DELETE request
    await apiClient.deleteSomeResource(1);
    print('Deleted resource');
  } catch (e) {
    print('Error: $e');
  }
}
```
