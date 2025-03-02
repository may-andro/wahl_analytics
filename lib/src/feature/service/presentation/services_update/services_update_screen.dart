import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/widget/content_widget.dart';

class ServicesUpdateScreen extends StatelessWidget {
  const ServicesUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return appServiceLocator.get<ServicesUpdateBloc>()
          ..add(const GetBusinessServiceEvent());
      },
      child: Scaffold(
        backgroundColor: context.colorPalette.background.primary.color,
        appBar: DSAppBarWidget(
          height: DSAppBarWidget.getHeight(context),
          onBackClicked: context.pop,
        ),
        body: BlocBuilder<ServicesUpdateBloc, ServicesUpdateState>(
          buildWhen: (previous, current) {
            return current.viewState != previous.viewState;
          },
          builder: (context, state) {
            return DSViewStateBuilderWidget(
              state: state.viewState,
              loadingBuilder: (_) {
                return DSLoadingWidget(
                  size: max(
                    context.shortestSide * 0.1,
                    context.space(factor: 2),
                  ),
                );
              },
              errorBuilder: (_) {
                return DSErrorCardWidget(
                  message: context.localizations.errorLoadingFailureMessage,
                );
              },
              builder: (_) {
                final businessService = state.businessService;
                if (businessService == null) {
                  return DSErrorCardWidget(
                    message: context.localizations.errorLoadingFailureMessage,
                  );
                }

                return ContentWidget(businessService: businessService);
              },
            );
          },
        ),
      ),
    );
  }
}
