import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/widget/widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ServicesProvidedScreen extends StatelessWidget {
  const ServicesProvidedScreen({
    required this.services,
    super.key,
  });

  final List<ServiceEntity> services;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return appServiceLocator.get<ServicesProvidedBloc>()
          ..add(SetBusinessServiceEntityEvent(services));
      },
      child: Scaffold(
        backgroundColor: context.colorPalette.background.primary.color,
        appBar: DSAppBarWidget(
          height: DSAppBarWidget.getHeight(context),
          onBackClicked: context.pop,
        ),
        body: BlocBuilder<ServicesProvidedBloc, ServicesProvidedState>(
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
                return const DSErrorCardWidget(
                  message: 'Error',
                );
              },
              builder: (_) {
                return ContentWidget(services: services);
              },
            );
          },
        ),
      ),
    );
  }
}
