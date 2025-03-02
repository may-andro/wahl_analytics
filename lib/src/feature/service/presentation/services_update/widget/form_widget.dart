import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/dto/dto.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/widget/service_form_widget.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/widget/service_list_widget.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/widget/tab_widget.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesUpdateBloc, ServicesUpdateState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.space(factor: 5)),
              TabWidget(key: UniqueKey()),
              SizedBox(height: context.space(factor: 2)),
              _buildTitleTextField(context),
              SizedBox(height: context.space(factor: 2)),
              _buildDescriptionTextField(context),
              SizedBox(height: context.space(factor: 2)),
              if (state.businessService?.services != null) ...[
                ServiceListWidget(services: state.businessService!.services),
                SizedBox(height: context.space(factor: 2)),
              ],
              _buildAddServiceButton(context),
              SizedBox(height: context.space(factor: 2)),
              _buildSubmitButton(context, state.isFormSubmitted),
              SizedBox(height: context.space(factor: 5)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleTextField(BuildContext context) {
    const formFieldType = ServicesUpdateFormFieldType.title;
    return DSTextFieldWidget(
      key: const Key('title_input_widget'),
      hintText: context.localizations.titleFormFieldLabel,
      labelText: context.localizations.titleFormFieldLabel,
      controller: context.state.textFieldControllers[formFieldType],
      focusNode: context.state.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) {
        context.state.textFieldFocusNodes[formFieldType]?.unfocus();
        FocusScope.of(context).requestFocus(
          context.state
              .textFieldFocusNodes[ServicesUpdateFormFieldType.description],
        );
      },
      onChanged: (input) {
        context.bloc.add(
          ValidateTextFieldEvent(value: input, formFieldType: formFieldType),
        );
      },
      validator: (input) {
        final message = context.bloc.state.validationMessages[formFieldType];
        if (message != null) {
          return TextFieldValidationData.error(
            message.getMessage(context.localizations),
          );
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: const [AutofillHints.name],
    );
  }

  Widget _buildDescriptionTextField(BuildContext context) {
    const formFieldType = ServicesUpdateFormFieldType.description;
    return DSTextFieldWidget(
      key: const Key('description_input_widget'),
      hintText: context.localizations.descriptionFormFieldLabel,
      labelText: context.localizations.descriptionFormFieldLabel,
      controller: context.state.textFieldControllers[formFieldType],
      focusNode: context.state.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: 10,
      textCapitalization: TextCapitalization.sentences,
      onFieldSubmitted: (text) {
        context.state.textFieldFocusNodes[formFieldType]?.unfocus();
      },
      onChanged: (input) {
        context.bloc.add(
          ValidateTextFieldEvent(value: input, formFieldType: formFieldType),
        );
      },
      validator: (input) {
        final message = context.state.validationMessages[formFieldType];
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

  Widget _buildSubmitButton(BuildContext context, bool isLoading) {
    return DSButtonWidget(
      key: const Key('submit_button_widget'),
      label: context.localizations.submitButton,
      onPressed: () {
        context.bloc.add(const SubmitFormEvent());
      },
      isLoading: isLoading,
      variant: DSButtonVariant.prominent,
    );
  }

  Widget _buildAddServiceButton(BuildContext context) {
    return DSButtonWidget(
      key: const Key('add_service_button_widget'),
      label: context.localizations.addService,
      onPressed: () async {
        final service = await ServiceAddEditWidget.showAsBottomSheet(
          context: context,
        );
        if (service != null && context.mounted) {
          context.bloc.add(AddServiceFormEvent(service));
        }
      },
      variant: DSButtonVariant.secondary,
    );
  }
}
