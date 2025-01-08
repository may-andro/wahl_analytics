import 'package:firestore_content_uploader/command/upload_command.dart';
import 'package:firestore_content_uploader/di/di.dart';

void init() => setUpDI();

UploadCommand get uploadCommand => locator<UploadCommand>();
