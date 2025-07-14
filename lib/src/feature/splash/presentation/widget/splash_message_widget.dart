import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';

class SplashMessageWidget extends StatelessWidget {
  const SplashMessageWidget(
    this.progress, {
    required this.isEnabled,
    super.key,
  });

  final double progress;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.localizations.splashProdMessage,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.15,
            height: 24 / 16,
            color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: progress,
          color: Colors.green,
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
