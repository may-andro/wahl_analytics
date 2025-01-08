import 'package:cache/cache.dart';
import 'package:core/core.dart';

class DevUserAuthenticatedCache extends MemoryCache<bool> {
  @override
  Duration get timeToLive => 30.minutes;
}
