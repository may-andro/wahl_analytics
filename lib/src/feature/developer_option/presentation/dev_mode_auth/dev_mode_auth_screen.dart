import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/widget/widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class DevModeAuthScreen extends StatelessWidget {
  const DevModeAuthScreen({super.key});

  static Future<bool?> showAsBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const DevModeAuthScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          appServiceLocator.get<DevModeAuthBloc>()..add(const OnInitEvent()),
      child: BlocListener<DevModeAuthBloc, DevModeAuthState>(
        listenWhen: (previous, current) {
          return current.isAuthenticatedSuccessfully;
        },
        listener: (context, state) {
          context.pop(state.isAuthenticatedSuccessfully);
        },
        child: const ContentWidget(),
      ),
    );
  }
}
