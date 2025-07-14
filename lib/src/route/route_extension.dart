import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension RouteExtension on BuildContext {
  void popUntil(String routeName) {
    while ((canPop()) && (ModalRoute.of(this)!.settings.name != routeName)) {
      pop();
    }
  }
}

extension GoRouterStateExtension on GoRouterState {
  CustomTransitionPage<dynamic> getCustomTransitionPage(Widget child) {
    return CustomTransitionPage(
      key: pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final opacity = CurveTween(
          curve: Curves.easeInOutCirc,
        ).animate(animation);
        return FadeTransition(opacity: opacity, child: child);
      },
    );
  }
}
