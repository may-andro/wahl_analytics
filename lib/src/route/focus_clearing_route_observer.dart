import 'package:flutter/widgets.dart';

/// This route observer will clear focus on push and replace.
/// This will close the soft keyboard when opening the new route.
class FocusClearingRouteObserver extends NavigatorObserver {
  FocusClearingRouteObserver(this._focusManager);

  final FocusManager _focusManager;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _focusManager.primaryFocus?.unfocus();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _focusManager.primaryFocus?.unfocus();
  }
}
