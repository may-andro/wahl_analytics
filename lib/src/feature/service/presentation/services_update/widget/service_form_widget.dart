import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/servcie_update_form_field_type.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ServiceAddEditWidget extends StatelessWidget {
  const ServiceAddEditWidget({required this.service, super.key});

  final ServiceEntity? service;

  static Future<ServiceEntity?> showAsBottomSheet({
    required BuildContext context,
    ServiceEntity? service,
  }) {
    return showModalBottomSheet<ServiceEntity>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.colorPalette.background.primary.color,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).viewInsets.bottom,
          horizontal: context.space(factor: 5),
        ),
        child: ServiceAddEditWidget(service: service),
      ),
    );
  }

  static Future<ServiceEntity?> showAsDialog({
    required BuildContext context,
    ServiceEntity? service,
  }) {
    return showDialog<ServiceEntity>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.colorPalette.background.primary.color,
          content: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).viewInsets.bottom,
              horizontal: context.space(factor: 5),
            ),
            child: ServiceAddEditWidget(service: service),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return appServiceLocator.get<ServiceUpdateBloc>()
          ..add(OnInitServiceUpdateEvent(service));
      },
      child: BlocListener<ServiceUpdateBloc, ServiceUpdateState>(
        listenWhen: (previous, current) {
          return current.isFormSubmittedSuccessfully;
        },
        listener: (context, state) {
          context.pop(state.service);
        },
        child: const SingleChildScrollView(child: _FormWidget()),
      ),
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceUpdateBloc, ServiceUpdateState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: context.space(factor: 5)),
              DSTextWidget(
                context.serviceUpdateState.service == null
                    ? context.localizations.addService
                    : context.localizations.updateService,
                color: context.colorPalette.neutral.grey9,
                style: context.typography.titleLarge,
              ),
              SizedBox(height: context.space(factor: 2)),
              _buildIconSelectorWidget(context),
              SizedBox(height: context.space(factor: 2)),
              _buildTitleTextField(context),
              SizedBox(height: context.space(factor: 2)),
              _buildShortDescriptionTextField(context),
              SizedBox(height: context.space(factor: 2)),
              _buildLongDescriptionTextField(context),
              SizedBox(height: context.space(factor: 2)),
              _buildSubmitButton(context),
              SizedBox(height: context.space(factor: 5)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIconSelectorWidget(BuildContext context) {
    final iconData = context.serviceUpdateState.service?.icon.customIconData;
    return DSDropDownWidget<IconData>(
      key: const Key('icon_drop_down_widget'),
      labelText: context.localizations.iconFormFieldLabel,
      hintText: context.localizations.iconFormFieldHint,
      value: iconData,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      items: DSIcons.all.map((icon) {
        return DropdownMenuItem(
          value: icon,
          child: Row(
            children: [
              Icon(icon, color: context.colorPalette.prominent.primary.color),
              const DSHorizontalSpacerWidget(1),
              DSTextWidget(
                '${icon.codePoint}',
                color: context.colorPalette.neutral.grey9,
                style: context.typography.bodyLarge,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (input) {
        final icon = input == null ? null : '${input.codePoint}';
        context.serviceUpdateBloc.add(SelectServiceIconEvent(icon: icon));
      },
      validator: (value) {
        if (value == null) {
          return DropDownValidationData.error(
            context.localizations.messageFormFieldHint,
          );
        }
        return null;
      },
    );
  }

  Widget _buildTitleTextField(BuildContext context) {
    const formFieldType = ServiceUpdateFormFieldType.title;
    return DSTextFieldWidget(
      key: const Key('title_input_widget'),
      hintText: context.localizations.titleFormFieldLabel,
      labelText: context.localizations.titleFormFieldLabel,
      controller:
          context.serviceUpdateState.textFieldControllers[formFieldType],
      focusNode: context.serviceUpdateState.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) {
        context.serviceUpdateState.textFieldFocusNodes[formFieldType]
            ?.unfocus();
        FocusScope.of(context).requestFocus(
          context
              .serviceUpdateState
              .textFieldFocusNodes[ServiceUpdateFormFieldType.shortDescription],
        );
      },
      onChanged: (input) {
        context.serviceUpdateBloc.add(
          ValidateServiceUpdateTextFieldEvent(
            value: input,
            formFieldType: formFieldType,
          ),
        );
      },
      validator: (input) {
        final message = context
            .serviceUpdateBloc
            .state
            .validationMessages[formFieldType]
            ?.getMessage(context.localizations);
        if (message != null) {
          return TextFieldValidationData.error(message);
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: const [AutofillHints.name],
    );
  }

  Widget _buildShortDescriptionTextField(BuildContext context) {
    const formFieldType = ServiceUpdateFormFieldType.shortDescription;
    return DSTextFieldWidget(
      key: const Key('short_description_input_widget'),
      hintText: context.localizations.shortDescriptionFormFieldLabel,
      labelText: context.localizations.shortDescriptionFormFieldLabel,
      controller:
          context.serviceUpdateState.textFieldControllers[formFieldType],
      focusNode: context.serviceUpdateState.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: 5,
      maxLength: 200,
      textCapitalization: TextCapitalization.sentences,
      onFieldSubmitted: (text) {
        context.serviceUpdateState.textFieldFocusNodes[formFieldType]
            ?.unfocus();
        FocusScope.of(context).requestFocus(
          context
              .serviceUpdateState
              .textFieldFocusNodes[ServiceUpdateFormFieldType.longDescription],
        );
      },
      onChanged: (input) {
        context.serviceUpdateBloc.add(
          ValidateServiceUpdateTextFieldEvent(
            value: input,
            formFieldType: formFieldType,
          ),
        );
      },
      validator: (input) {
        final message =
            context.serviceUpdateState.validationMessages[formFieldType];
        if (message != null) {
          return TextFieldValidationData.error(
            message.getMessage(context.localizations),
          );
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildLongDescriptionTextField(BuildContext context) {
    const formFieldType = ServiceUpdateFormFieldType.longDescription;
    return DSTextFieldWidget(
      key: const Key('long_description_input_widget'),
      hintText: context.localizations.longDescriptionFormFieldLabel,
      labelText: context.localizations.longDescriptionFormFieldLabel,
      controller:
          context.serviceUpdateState.textFieldControllers[formFieldType],
      focusNode: context.serviceUpdateState.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: 10,
      maxLength: 500,
      textCapitalization: TextCapitalization.sentences,
      onFieldSubmitted: (text) {
        context.serviceUpdateState.textFieldFocusNodes[formFieldType]
            ?.unfocus();
      },
      onChanged: (input) {
        context.serviceUpdateBloc.add(
          ValidateServiceUpdateTextFieldEvent(
            value: input,
            formFieldType: formFieldType,
          ),
        );
      },
      validator: (input) {
        final message =
            context.serviceUpdateState.validationMessages[formFieldType];
        if (message != null) {
          return TextFieldValidationData.error(
            message.getMessage(context.localizations),
          );
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return DSButtonWidget(
      key: const Key('submit_button_widget'),
      label: context.localizations.submitButton,
      onPressed: () {
        context.serviceUpdateBloc.add(const SubmitServiceUpdateFormEvent());
      },
      variant: DSButtonVariant.prominent,
    );
  }
}
