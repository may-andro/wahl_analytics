import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/careers_request/widget/widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class CareersRequestScreen extends StatelessWidget {
  const CareersRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return appServiceLocator.get<CareersRequestBloc>()
          ..add(GetCareersRequestEvent());
      },
      child: Scaffold(
        backgroundColor: context.colorPalette.background.primary.color,
        appBar: DSAppBarWidget(
          height: DSAppBarWidget.getHeight(context),
          onBackClicked: context.pop,
        ),
        body: BlocBuilder<CareersRequestBloc, CareersRequestState>(
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
                return BlocListener<CareersRequestBloc, CareersRequestState>(
                  listenWhen: (previous, current) {
                    return current.snackBarMessageState != null;
                  },
                  listener: (context, state) {
                    final snackBarMessageState = state.snackBarMessageState;
                    if (snackBarMessageState != null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(snackBarMessageState.getSnackBar(context));
                    }
                  },
                  child: const ContentWidget(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
