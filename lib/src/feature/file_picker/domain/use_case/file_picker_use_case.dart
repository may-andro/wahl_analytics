import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:use_case/use_case.dart';
import 'package:wahl_analytics/src/feature/file_picker/domain/entity/entity.dart';

sealed class FilePickerFailure extends BasicFailure {
  const FilePickerFailure({super.message, super.cause});
}

class FileNotFoundFailure extends FilePickerFailure {
  const FileNotFoundFailure();
}

class FileTooBigFailure extends FilePickerFailure {
  const FileTooBigFailure();
}

class UnknownFilePickerFailure extends FilePickerFailure {
  const UnknownFilePickerFailure({super.message, super.cause});
}

class FilePickerUseCase
    extends BaseNoParamUseCase<PickedFile, FilePickerFailure> {
  @protected
  @override
  FutureOr<Either<FilePickerFailure, PickedFile>> execute() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final bytes = result.files.first.bytes;

        if (bytes == null) {
          return const Left(FileNotFoundFailure());
        }

        if (bytes.lengthInBytes / 1024 > 500) {
          return const Left(FileTooBigFailure());
        }

        return Right(
          PickedFile(bytes: bytes, name: result.files.first.name),
        );
      } else {
        return const Left(FileNotFoundFailure());
      }
    } catch (_) {
      return const Left(FileNotFoundFailure());
    }
  }

  @protected
  @override
  FilePickerFailure mapErrorToFailure(Object e, StackTrace st) {
    return UnknownFilePickerFailure(message: e.toString(), cause: e);
  }
}
