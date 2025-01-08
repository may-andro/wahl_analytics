import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/widget/content_widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return appServiceLocator.get<ContactUsBloc>()
          ..add(InitialiseScreenEvent());
      },
      child: Scaffold(
        backgroundColor: context.colorPalette.background.primary.color,
        appBar: DSAppBarWidget(
          height: DSAppBarWidget.getHeight(context),
          onBackClicked: context.pop,
        ),
        body: BlocListener<ContactUsBloc, ContactUsState>(
          listenWhen: (previous, current) {
            return current.isFormSubmittedSuccessfully;
          },
          listener: (context, _) => context.pop(),
          child: const ContentWidget(),
        ),
      ),
    );
  }
}
