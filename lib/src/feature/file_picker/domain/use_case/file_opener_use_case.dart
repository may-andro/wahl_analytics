import 'dart:async';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:use_case/use_case.dart';

const _supportedTypes = {'.pdf': 'application/pdf'};

sealed class FileOpenerFailure extends BasicFailure {
  const FileOpenerFailure({super.message, super.cause});
}

final class NoAppFoundToOpenFailure extends FileOpenerFailure {
  const NoAppFoundToOpenFailure({super.message, super.cause});
}

final class NonExistingFileFailure extends FileOpenerFailure {
  const NonExistingFileFailure({super.message, super.cause});
}

final class PermissionDeniedFailure extends FileOpenerFailure {
  const PermissionDeniedFailure({super.message, super.cause});
}

final class FileOpenErrorFailure extends FileOpenerFailure {
  const FileOpenErrorFailure({super.message, super.cause});
}

final class FileOpenUnknownFailure extends FileOpenerFailure {
  const FileOpenUnknownFailure({super.message, super.cause});
}

class FileOpenerUseCase extends BaseUseCase<void, File, FileOpenerFailure> {
  @override
  FutureOr<Either<FileOpenerFailure, void>> execute(File input) async {
    final extension = _getFileExtension(input.path);
    final result = await OpenFile.open(
      input.path,
      type: _supportedTypes[extension],
    );

    final failure = _getFailure(result.type);
    if (failure == null) {
      return const Right(null);
    }

    return Left(failure);
  }

  @override
  FileOpenerFailure mapErrorToFailure(Object e, StackTrace st) {
    return FileOpenUnknownFailure(message: e.toString(), cause: e);
  }

  String _getFileExtension(String fileName) {
    try {
      return ".${fileName.split('.').last}";
    } catch (e) {
      return '';
    }
  }

  FileOpenerFailure? _getFailure(ResultType resultType) {
    switch (resultType) {
      case ResultType.noAppToOpen:
        return const NoAppFoundToOpenFailure();
      case ResultType.fileNotFound:
        return const NonExistingFileFailure();
      case ResultType.permissionDenied:
        return const PermissionDeniedFailure();
      case ResultType.error:
        return const FileOpenErrorFailure();
      case ResultType.done:
        return null;
    }
  }
}
