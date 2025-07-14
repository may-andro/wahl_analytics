import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode/widget/content_widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class DevModeScreen extends StatelessWidget {
  const DevModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => appServiceLocator.get<DevModeBloc>(),
      child: BlocBuilder<DevModeBloc, DevModeState>(
        builder: (context, state) {
          return RouteObserverWidget(
            onResume: () => context.bloc.add(ScreenVisibleEvent()),
            child: Scaffold(
              backgroundColor: context.colorPalette.background.primary.color,
              appBar: DSAppBarWidget(
                height: DSAppBarWidget.getHeight(context),
                onBackClicked: context.pop,
              ),
              body: const ContentWidget(),
            ),
          );
        },
      ),
    );
  }
}
