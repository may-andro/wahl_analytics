import 'package:flutter/widgets.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class RouteObserverWidget extends StatefulWidget {
  const RouteObserverWidget({
    super.key,
    required this.child,
    this.onResume,
    this.onPause,
    this.onStop,
  });

  final VoidCallback? onResume;
  final VoidCallback? onPause;
  final VoidCallback? onStop;
  final Widget child;

  @override
  State<RouteObserverWidget> createState() => _RouteObserverWidgetState();
}

class _RouteObserverWidgetState extends State<RouteObserverWidget>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Called when the route is initially pushed onto the navigator stack.
    super.didPush();
    widget.onResume?.call();
  }

  @override
  void didPushNext() {
    // Called when another route is pushed on top, this one is now obscured.
    super.didPushNext();
    widget.onPause?.call();
  }

  @override
  void didPopNext() {
    // Called when a route above is popped, and this one becomes visible again.
    super.didPopNext();
    widget.onResume?.call();
  }

  @override
  void didPop() {
    // Called when the route is popped off and destroyed.
    super.didPop();
    widget.onStop?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
