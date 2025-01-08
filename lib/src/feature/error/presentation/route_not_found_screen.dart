import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/home/home.dart';
import 'package:wahl_analytics/src/route/route.dart';

class RouteNotFoundScreen extends StatelessWidget {
  const RouteNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorPalette.background.primary.color,
      appBar: DSAppBarWidget(
        height: DSAppBarWidget.getHeight(context),
      ),
      body: DSResponsiveContainerWidget(
        mobileBuilder: (_) {
          return Padding(
            padding: EdgeInsets.all(context.space(factor: 2)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _ContentWidget(imageSize: context.space(factor: 10));
              },
            ),
          );
        },
        tabletBuilder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.1,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _ContentWidget(imageSize: context.space(factor: 8));
              },
            ),
          );
        },
        desktopBuilder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.25,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _ContentWidget(imageSize: context.space(factor: 10));
              },
            ),
          );
        },
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({required this.imageSize});

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          Align(child: Icon(Icons.question_mark, size: imageSize)),
          const DSVerticalSpacerWidget(5),
          DSTextWidget(
            context.localizations.routeNotFoundTitle,
            color: context.colorPalette.neutral.grey9,
            style: context.typography.headlineMedium,
          ),
          const DSVerticalSpacerWidget(2),
          DSTextWidget(
            context.localizations.routeNotFoundMessage,
            color: context.colorPalette.neutral.grey7,
            style: context.typography.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const DSVerticalSpacerWidget(2),
          const Spacer(),
          FittedBox(
            child: DSButtonWidget(
              label: context.localizations.routeNotFoundButton,
              size: DSButtonSize.small,
              variant: DSButtonVariant.secondary,
              onPressed: () => context.popUntil(HomeModuleRoute.home.name),
            ),
          ),
          const DSVerticalSpacerWidget(5),
        ],
      ),
    );
  }
}
