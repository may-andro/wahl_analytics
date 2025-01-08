import 'package:firestore_content_uploader/command/upload_command.dart';
import 'package:firestore_content_uploader/logger/log.dart';
import 'package:firestore_content_uploader/use_case/use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

GetIt locator = GetIt.instance;

void setUpDI() {
  _addHttpClientToDI();
  _addLoggerToDI();
  _addUseCasesToDI();
  _addCommandsToDI();
}

void _addHttpClientToDI() {
  locator.registerFactory<http.Client>(
    () => http.Client(),
  );
}

void _addLoggerToDI() {
  locator.registerFactory<Logger>(
    () => Logger(),
  );

  locator.registerFactory<Log>(
    () => LogImpl(
      locator<Logger>(),
    ),
  );
}

void _addUseCasesToDI() {
  locator.registerFactory<GetBaseUrlUseCase>(
    () => const GetBaseUrlUseCase(),
  );

  locator.registerFactory<GetDataToUploadUseCase>(
    () => const GetDataToUploadUseCase(),
  );

  locator.registerFactory<GetClientCredentialsUseCase>(
    () => const GetClientCredentialsUseCase(),
  );

  locator.registerFactory<GetAuthTokenUseCase>(
    () => GetAuthTokenUseCase(
      locator<http.Client>(),
      locator<GetClientCredentialsUseCase>(),
    ),
  );

  locator.registerFactory<GetApiHeaderUseCase>(
    () => GetApiHeaderUseCase(
      locator<GetAuthTokenUseCase>(),
    ),
  );

  locator.registerFactory<UploadUseCase>(
    () => UploadUseCase(
      locator<GetBaseUrlUseCase>(),
      locator<GetApiHeaderUseCase>(),
      locator<GetDataToUploadUseCase>(),
      locator<http.Client>(),
      locator<Log>(),
    ),
  );
}

void _addCommandsToDI() {
  locator.registerFactory<UploadCommand>(
    () => UploadCommand(
      locator<UploadUseCase>(),
    ),
  );
}
