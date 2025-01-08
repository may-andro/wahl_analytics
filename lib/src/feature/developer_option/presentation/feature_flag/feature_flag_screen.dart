import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/feature_flag/widget/content_widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class FeatureFlagScreen extends StatelessWidget {
  const FeatureFlagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          appServiceLocator.get<FeatureFlagBloc>()..add(OnInitScreenEvent()),
      child: Scaffold(
        backgroundColor: context.colorPalette.background.primary.color,
        appBar: DSAppBarWidget(
          height: DSAppBarWidget.getHeight(context),
          onBackClicked: context.pop,
        ),
        body: const ContentWidget(),
      ),
    );
  }
}
