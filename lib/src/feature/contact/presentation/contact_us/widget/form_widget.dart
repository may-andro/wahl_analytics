import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/extension/l10n_extension.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/dto/dto.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsBloc, ContactUsState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.space(factor: 5)),
              _buildNameTextField(context),
              SizedBox(height: context.space(factor: 2)),
              _buildEmailTextField(context),
              SizedBox(height: context.space(factor: 2)),
              _buildMessageTextField(context),
              SizedBox(height: context.space(factor: 2)),
              DSTextWidget(
                context.localizations.userDataConsentTitle,
                color: context.colorPalette.neutral.grey9,
                style: context.typography.bodyLarge,
              ),
              SizedBox(height: context.space(factor: 0.5)),
              _buildConsentCheckBox(context),
              SizedBox(height: context.space(factor: 2)),
              _buildSubmitButton(context),
              SizedBox(height: context.space(factor: 5)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNameTextField(BuildContext context) {
    const formFieldType = FormFieldType.name;
    return DSTextFieldWidget(
      key: const Key('name_input_widget'),
      hintText: context.localizations.nameFormFieldHint,
      labelText: context.localizations.nameFormFieldLabel,
      controller: context.state.textFieldControllers[formFieldType],
      focusNode: context.state.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) {
        context.state.textFieldFocusNodes[formFieldType]?.unfocus();
        FocusScope.of(
          context,
        ).requestFocus(context.state.textFieldFocusNodes[FormFieldType.email]);
      },
      onChanged: (input) {
        context.bloc.add(
          ValidateTextFieldEvent(value: input, formFieldType: formFieldType),
        );
      },
      validator: (input) {
        final message = context.bloc.state.validationMessages[formFieldType]
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

  Widget _buildEmailTextField(BuildContext context) {
    const formFieldType = FormFieldType.email;
    return DSTextFieldWidget(
      key: const Key('email_input_widget'),
      hintText: context.localizations.emailFormFieldHint,
      labelText: context.localizations.emailFormFieldLabel,
      controller: context.state.textFieldControllers[formFieldType],
      focusNode: context.state.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) {
        context.state.textFieldFocusNodes[formFieldType]?.unfocus();
        FocusScope.of(context).requestFocus(
          context.state.textFieldFocusNodes[FormFieldType.message],
        );
      },
      onChanged: (input) {
        context.bloc.add(
          ValidateTextFieldEvent(value: input, formFieldType: formFieldType),
        );
      },
      validator: (input) {
        final message = context.state.validationMessages[formFieldType]
            ?.getMessage(context.localizations);
        if (message != null) {
          return TextFieldValidationData.error(message);
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: const [AutofillHints.email],
    );
  }

  Widget _buildMessageTextField(BuildContext context) {
    const formFieldType = FormFieldType.message;
    return DSTextFieldWidget(
      key: const Key('message_input_widget'),
      hintText: context.localizations.messageFormFieldHint,
      labelText: context.localizations.messageFormFieldLabel,
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
        final message = context.state.validationMessages[formFieldType]
            ?.getMessage(context.localizations);
        if (message != null) {
          return TextFieldValidationData.error(message);
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildConsentCheckBox(BuildContext context) {
    return DSCheckboxFormFieldWidget(
      label: context.localizations.userDataConsentCheckboxLabel,
      onSaved: (value) {
        context.bloc.add(
          OnConsentSelectedEvent(isConsentGiven: value ?? false),
        );
      },
      validator: (value) {
        if (value == null || value == false) {
          final message =
              context.state.validationMessages[FormFieldType.consent];
          return message?.getMessage(context.localizations);
        }
        return null;
      },
      initialValue: context.state.isConsentGiven,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return DSButtonWidget(
      key: const Key('submit_button_widget'),
      label: context.localizations.submitButton,
      onPressed: () {
        context.bloc.add(const SubmitFormEvent());
      },
      isLoading: context.state.viewState.isLoading,
      variant: DSButtonVariant.prominent,
    );
  }
}
