import 'package:dependency_injection/dependency_injection.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';

class SplashInfoWidget extends StatelessWidget {
  const SplashInfoWidget(
    this.receivedEvents, {
    required this.isEnabled,
    super.key,
  });

  final List<DISetUpStatus> receivedEvents;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) return const SizedBox.shrink();

    return ListView(
      shrinkWrap: true,
      children: [
        _ItemWidget(receivedEvents, setUpStatus: DISetUpStatus.warmup),
        const Divider(color: Colors.grey),
        _ItemWidget(receivedEvents, setUpStatus: DISetUpStatus.fetch),
        const Divider(color: Colors.grey),
        _ItemWidget(receivedEvents, setUpStatus: DISetUpStatus.register),
        const Divider(color: Colors.grey),
        _ItemWidget(receivedEvents, setUpStatus: DISetUpStatus.done),
      ],
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(this.receivedStatusList, {required this.setUpStatus});

  final List<DISetUpStatus> receivedStatusList;
  final DISetUpStatus setUpStatus;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: receivedStatusList.contains(setUpStatus)
          ? Icon(
              setUpStatus.icon,
              color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
              size: 24,
            )
          : SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
              ),
            ),
      title: Text(
        setUpStatus.getLabel(context),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.15,
          height: 24 / 16,
          color: Color(context.isDarkMode ? 0xFFFFFFFF : 0xFF121212),
        ),
      ),
    );
  }
}

extension _SetUpStatusMapper on DISetUpStatus {
  IconData get icon {
    switch (this) {
      case DISetUpStatus.warmup:
        return Icons.start_rounded;
      case DISetUpStatus.fetch:
        return Icons.download_rounded;
      case DISetUpStatus.register:
        return Icons.save_alt_rounded;
      case DISetUpStatus.done:
        return Icons.download_done_rounded;
    }
  }

  String getLabel(BuildContext context) {
    switch (this) {
      case DISetUpStatus.warmup:
        return context.localizations.splashStagingWarmupMessage;
      case DISetUpStatus.fetch:
        return context.localizations.splashStagingFetchMessage;
      case DISetUpStatus.register:
        return context.localizations.splashStagingRegisterMessage;
      case DISetUpStatus.done:
        return context.localizations.splashStagingDoneMessage;
    }
  }
}
