import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/widget/form_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevModeAuthBloc, DevModeAuthState>(
      buildWhen: (previous, current) => current.viewState != previous.viewState,
      builder: (context, state) {
        return DSViewStateBuilderWidget(
          state: state.viewState,
          loadingBuilder: (_) {
            return DSLoadingWidget(
              size: max(context.shortestSide * 0.1, context.space(factor: 2)),
            );
          },
          errorBuilder: (_) {
            return DSErrorCardWidget(
              message: context.localizations.splashErrorMessage,
            );
          },
          builder: (_) {
            return const FormWidget();
          },
        );
      },
    );
  }
}
