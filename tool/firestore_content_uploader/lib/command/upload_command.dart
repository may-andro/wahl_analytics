import 'package:args/command_runner.dart';
import 'package:firestore_content_uploader/di/di.dart';
import 'package:firestore_content_uploader/logger/log.dart';
import 'package:firestore_content_uploader/use_case/use_case.dart';

class UploadCommand extends Command<dynamic> {
  UploadCommand(this._uploadUseCase) {
    argParser.addOption(
      'env',
      abbr: 'e',
      help: 'Name of the env: staging or prod',
    );
    argParser.addOption(
      'document',
      abbr: 'd',
      help: 'Firebase document name to upload',
    );
    argParser.addOption(
      'credentials',
      abbr: 'c',
      help: 'JSON file path for service account credentials',
    );
    argParser.addOption(
      'data',
      abbr: 'p',
      help: 'JSON File path for data to upload',
    );
  }

  final UploadUseCase _uploadUseCase;

  @override
  final name = 'upload';

  @override
  final description = 'Upload the firestore';

  @override
  void run() {
    final env = argResults?['env'] as String?;
    final documentName = argResults?['document'] as String?;
    final credentialsFilePath = argResults?['credentials'] as String?;
    final dataFilePath = argResults?['data'] as String?;

    final log = locator<Log>();

    if (env == null) {
      log.e('Environment not found');
      return;
    }

    if (documentName == null) {
      log.e('Document name not found');
      return;
    }

    if (credentialsFilePath == null) {
      log.e('Credentials file path not found');
      return;
    }

    if (dataFilePath == null) {
      log.e('File path to upload not found');
      return;
    }
    _uploadUseCase.execute(
      env,
      documentName,
      credentialsFilePath,
      dataFilePath,
    );
  }
}
