import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/googleapis_auth.dart';

class GetClientCredentialsUseCase {
  const GetClientCredentialsUseCase();

  Future<ServiceAccountCredentials> execute(String filePath) async {
    final credentialsFile = await File(filePath).readAsString();
    final credentialsJson = json.decode(credentialsFile);
    return ServiceAccountCredentials.fromJson(credentialsJson);
  }
}
