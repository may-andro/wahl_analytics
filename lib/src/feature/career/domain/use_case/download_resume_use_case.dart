import 'dart:async';
import 'dart:io';

import 'package:firebase/firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/career/domain/entity/entity.dart';

class DownloadResumeFailure extends BasicFailure {
  const DownloadResumeFailure({super.message, super.cause});
}

class DownloadResumeUseCase
    extends BaseUseCase<File, CareerEntity, DownloadResumeFailure> {
  DownloadResumeUseCase(
    this._fbStorageController,
  );

  final FbStorageController _fbStorageController;

  @override
  FutureOr<Either<DownloadResumeFailure, File>> execute(
    CareerEntity input,
  ) async {
    assert(!kIsWeb);
    final file = await _fbStorageController.downloadFileDocument(
      fileName: input.resumeName,
      storageFolder: 'career',
    );
    return Right(file);
  }

  @override
  DownloadResumeFailure mapErrorToFailure(Object e, StackTrace st) {
    return DownloadResumeFailure(message: e.toString(), cause: st);
  }
}
