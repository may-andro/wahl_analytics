import 'package:meta/meta.dart';

@internal
abstract class Cache {
  int get lastCachedTimestamp;

  Duration get timeToLive => Duration.zero;

  @visibleForTesting
  @protected
  bool get isExpired {
    final allowedTime = timeToLive.inMilliseconds;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    return allowedTime != 0 && lastCachedTimestamp + allowedTime < currentTime;
  }
}
