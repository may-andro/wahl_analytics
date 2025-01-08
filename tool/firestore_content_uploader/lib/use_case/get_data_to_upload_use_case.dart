import 'dart:convert';
import 'dart:io';

class GetDataToUploadUseCase {
  const GetDataToUploadUseCase();

  Future<String> execute(String filePath) async {
    final fileToUpload = await File(filePath).readAsString();
    final jsonToUpload = json.decode(fileToUpload) as Map<String, dynamic>;
    final firestoreJson = _convertToFirestoreFormat(jsonToUpload);
    return json.encode(firestoreJson);
  }

  Map<String, dynamic> _convertToFirestoreFormat(Map<String, dynamic> json) {
    final Map<String, dynamic> firestoreJson = {};

    json.forEach((key, value) {
      firestoreJson[key] = _convertValueToFirestore(value);
    });

    return {'fields': firestoreJson};
  }

// Helper function to convert each value to Firestore format
  dynamic _convertValueToFirestore(dynamic value) {
    if (value is Map<String, dynamic>) {
      // For nested maps, we recursively convert the map into `mapValue` structure
      return {
        'mapValue': {
          'fields': _convertToFirestoreFormat(value)['fields'],
        },
      };
    } else if (value is String) {
      // Convert string values to `stringValue`
      return {
        'stringValue': value,
      };
    } else if (value is int) {
      // Convert integer values to `integerValue`
      return {
        'integerValue': value.toString(),
        // Firestore integer values are stored as strings
      };
    } else if (value is bool) {
      // Convert boolean values to `booleanValue`
      return {
        'booleanValue': value,
      };
    } else if (value is List) {
      // Convert lists to `arrayValue`
      return {
        'arrayValue': {
          'values':
              value.map((item) => _convertValueToFirestore(item)).toList(),
        },
      };
    }

    throw Exception('Unsupported value type: ${value.runtimeType}');
  }
}
