import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/developer_option/developer_option.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/dev_mode_auth.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          appServiceLocator.get<HomeBloc>()..add(OnInitScreenEvent()),
      child: Scaffold(
        backgroundColor: context.colorPalette.background.primary.color,
        drawer: context.isDesktop ? null : const DrawerWidget(),
        drawerEnableOpenDragGesture: false,
        floatingActionButton: !context.isDesktop
            ? BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (!state.isContactUsFabVisible) {
                    return const SizedBox.shrink();
                  }
                  return FloatingActionButton(
                    onPressed: () {
                      context.push(ContactModuleRoute.contactUs.path);
                    },
                    shape: const CircleBorder(),
                    child: const Icon(Icons.email),
                  );
                },
              )
            : null,
        body: BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            return previous.devMenuTriggerCount !=
                    current.devMenuTriggerCount &&
                current.devMenuTriggerCount > 0;
          },
          listener: (context, state) {
            if (state.isDevMenuEnabled && context.mounted) {
              context.push(DeveloperOptionModuleRoute.devMode.path);
              return;
            }

            DevModeAuthScreen.showAsBottomSheet(context).then(
              (isAuthenticated) {
                if (context.mounted && (isAuthenticated ?? false)) {
                  context.push(DeveloperOptionModuleRoute.devMode.path);
                }
              },
            );
          },
          child: const ContentWidget(),
        ),
      ),
    );
  }
}
