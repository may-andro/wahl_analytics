import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/dto/dto.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/widget/upload_resume_form_field_widget.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CareerApplicationBloc, CareerApplicationState>(
      builder: (context, state) {
        return SafeArea(
          child: Form(
            key: state.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.space(factor: 5)),
                DSTextWidget(
                  context.localizations.careerPageFormTitle,
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.titleLarge,
                ),
                SizedBox(height: context.space(factor: 0.5)),
                DSTextWidget(
                  context.localizations.careerPageFormDescription,
                  color: context.colorPalette.neutral.grey7,
                  style: context.typography.bodyLarge,
                ),
                SizedBox(height: context.space(factor: 3)),
                _buildNameTextField(context),
                SizedBox(height: context.space(factor: 2)),
                _buildEmailTextField(context),
                SizedBox(height: context.space(factor: 2)),
                _buildRoleTextField(context),
                SizedBox(height: context.space(factor: 2)),
                _buildCountryTextField(context),
                SizedBox(height: context.space(factor: 2)),
                _buildMessageTextField(context),
                SizedBox(height: context.space(factor: 2)),
                _buildUploadCVButton(context),
                SizedBox(height: context.space(factor: 2)),
                DSTextWidget(
                  'Consent to the processing of personal data in future recruitment processes',
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
        FocusScope.of(context).requestFocus(
          context.state.textFieldFocusNodes[FormFieldType.email],
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
          context.state.textFieldFocusNodes[FormFieldType.role],
        );
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
      autofillHints: const [AutofillHints.email],
    );
  }

  Widget _buildRoleTextField(BuildContext context) {
    const formFieldType = FormFieldType.role;
    return DSTextFieldWidget(
      key: const Key('role_input_widget'),
      hintText: context.localizations.roleFormFieldHint,
      labelText: context.localizations.roleFormFieldLabel,
      controller: context.state.textFieldControllers[formFieldType],
      focusNode: context.state.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (text) {
        context.state.textFieldFocusNodes[formFieldType]?.unfocus();
        FocusScope.of(context).requestFocus(
          context.state.textFieldFocusNodes[FormFieldType.country],
        );
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
      autofillHints: const [AutofillHints.jobTitle],
    );
  }

  Widget _buildCountryTextField(BuildContext context) {
    const formFieldType = FormFieldType.country;
    return DSTextFieldWidget(
      key: const Key('country_input_widget'),
      hintText: context.localizations.countryFormFieldHint,
      labelText: context.localizations.countryFormFieldLabel,
      controller: context.state.textFieldControllers[formFieldType],
      focusNode: context.state.textFieldFocusNodes[formFieldType],
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
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
        final message = context.state.validationMessages[formFieldType];
        if (message != null) {
          return TextFieldValidationData.error(
            message.getMessage(context.localizations),
          );
        }
        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: const [AutofillHints.countryName],
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

  Widget _buildUploadCVButton(BuildContext context) {
    final resumeFile = context.state.resumeFile;
    return UploadResumeFormFieldWidget(
      resumeFile: resumeFile,
      onClicked: () {
        context.bloc.add(const UploadResumeEvent());
      },
      validator: (_) {
        if (resumeFile == null) {
          final message =
              context.state.validationMessages[FormFieldType.resume];
          return message?.getMessage(context.localizations);
        }
        return null;
      },
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
