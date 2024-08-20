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
