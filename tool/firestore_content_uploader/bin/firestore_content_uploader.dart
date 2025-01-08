import 'package:args/command_runner.dart';
import 'package:firestore_content_uploader/firestore_content_uploader.dart'
    as firestore_content_uploader;
import 'package:logger/logger.dart';

Future<void> main(List<String> args) async {
  firestore_content_uploader.init();
  final runner = CommandRunner<void>(
    'firestore_content_uploader',
    'A tool for uploading json content to FireStore',
  );
  runner.addCommand(firestore_content_uploader.uploadCommand);
  await runner.run(args).catchError((dynamic error) => Logger().e(error));
}
