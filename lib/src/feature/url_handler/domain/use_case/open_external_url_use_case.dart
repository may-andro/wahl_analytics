import 'dart:async';

import 'package:url_launcher/url_launcher.dart';
import 'package:use_case/use_case.dart';

class OpenExternalUrlFailure extends BasicFailure {
  const OpenExternalUrlFailure({super.message, super.cause});
}

class OpenExternalUrlParam {
  const OpenExternalUrlParam(this.uri, this.forceWebView);

  final Uri uri;
  final bool forceWebView;
}

class OpenExternalUrlUseCase
    extends BaseUseCase<bool, OpenExternalUrlParam, OpenExternalUrlFailure> {
  @override
  FutureOr<Either<OpenExternalUrlFailure, bool>> execute(
    OpenExternalUrlParam input,
  ) async {
    final result = await launchUrl(
      input.uri,
      mode: input.forceWebView
          ? LaunchMode.inAppWebView
          : LaunchMode.externalApplication,
    );

    return Right(result);
  }

  @override
  OpenExternalUrlFailure mapErrorToFailure(Object e, StackTrace st) {
    throw OpenExternalUrlFailure(message: e.toString(), cause: st);
  }
}
