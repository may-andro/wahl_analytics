import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update//widget/form_widget.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/widget/update_message_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    required this.businessService,
    super.key,
  });

  final BusinessServiceEntity businessService;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServicesUpdateBloc, ServicesUpdateState>(
      listenWhen: (previous, current) {
        return current.isFormSubmittedSuccessfully &&
            previous.isFormSubmittedSuccessfully !=
                current.isFormSubmittedSuccessfully;
      },
      listener: (context, state) {
        context.isDesktop
            ? UpdateMessageWidget.showAsDialog(
          context: context,
          isUpdatedSuccessfully: state.isFormSubmittedSuccessfully,
          locale: state.locale,
        )
            : UpdateMessageWidget.showAsBottomSheet(
          context: context,
          isUpdatedSuccessfully: state.isFormSubmittedSuccessfully,
          locale: state.locale,
        );
      },
      child: SingleChildScrollView(
        child: Container(
          color: context.colorPalette.background.primary.color,
          padding: EdgeInsets.symmetric(horizontal: getPadding(context)),
          child: const FormWidget(),
        ),
      ),
    );
  }

  double getPadding(BuildContext context) {
    switch (context.deviceWidth) {
      case DSDeviceWidthResolution.xs:
      case DSDeviceWidthResolution.s:
        return context.space(factor: 5);
      case DSDeviceWidthResolution.m:
        return context.width * 0.15;
      case DSDeviceWidthResolution.l:
        return context.width * 0.2;
      case DSDeviceWidthResolution.xl:
        return context.width * 0.25;
    }
  }
}
