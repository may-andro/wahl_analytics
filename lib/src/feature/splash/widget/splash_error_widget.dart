import 'package:design_system/design_system.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';

class SplashErrorWidget extends StatelessWidget {
  const SplashErrorWidget(this._cause, {super.key});

  final Object? _cause;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.localizations.splashErrorTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.15,
            height: 24 / 16,
            color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 16),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
              ),
              color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212)
                  .withValues(alpha: 0.5),
            ),
            child: Text(
              _cause.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.15,
                height: 24 / 16,
                color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            text: context.localizations.splashErrorMessage,
            style: TextStyle(
              color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
              fontSize: 14,
              letterSpacing: 0.15,
              height: 20 / 14,
            ),
            children: <TextSpan>[
              const TextSpan(text: ' '),
              TextSpan(
                text: context.localizations.splashContactSupport,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.15,
                  height: 20 / 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'This feature is not yer developed',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.15,
                            height: 20 / 14,
                            color: Color(
                              context.isDarkMode ? 0xFFFFFFFF : 0xFF121212,
                            ),
                          ),
                        ),
                        duration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
