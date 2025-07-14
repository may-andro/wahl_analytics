import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/tracking_log/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/tracking_log/widget/widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class TrackingLogScreen extends StatelessWidget {
  const TrackingLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return appServiceLocator.get<TrackingLogBloc>()..add(OnInitEvent());
      },
      child: BlocBuilder<TrackingLogBloc, TrackingLogState>(
        builder: (context, state) {
          return RouteObserverWidget(
            onResume: () => context.bloc.add(ScreenVisibleEvent()),
            child: Scaffold(
              backgroundColor: context.colorPalette.background.primary.color,
              body: const ContentWidget(),
              appBar: AppBar(
                backgroundColor: context.colorPalette.background.primary.color,
                surfaceTintColor:
                    context.colorPalette.neutral.transparent.color,
                shadowColor: context.colorPalette.background.onPrimary.color,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: DSTextWidget(
                  'Event History',
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.titleMedium,
                ),
                titleSpacing: 0,
                leading: context.isDesktop
                    ? null
                    : Padding(
                        padding: EdgeInsets.only(
                          left: context.space(factor: 3),
                        ),
                        child: DSIconButtonWidget(
                          Icons.close,
                          iconColor: context.colorPalette.background.onPrimary,
                          buttonColor: context.colorPalette.background.primary,
                          onPressed: context.pop,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
