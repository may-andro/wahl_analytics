import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/dev_mode_auth/bloc/bloc.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevModeAuthBloc, DevModeAuthState>(
      builder: (context, state) {
        return Form(
          key: state.formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space(factor: 5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DSVerticalSpacerWidget(5),
                DSTextWidget(
                  context.localizations.devModeTitle,
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.titleLarge,
                ),
                const DSVerticalSpacerWidget(0.5),
                DSTextWidget(
                  context.localizations.devModeSubtitle,
                  color: context.colorPalette.neutral.grey7,
                  style: context.typography.bodyLarge,
                ),
                const DSVerticalSpacerWidget(1.5),
                DSTextWidget(
                  context.localizations.devModeDescription,
                  color: context.colorPalette.neutral.grey7,
                  style: context.typography.bodySmall,
                ),
                const DSVerticalSpacerWidget(0.5),
                _buildVerificationCodeTextField(context),
                const DSVerticalSpacerWidget(2),
                _buildSubmitButton(context),
                const DSVerticalSpacerWidget(5),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVerificationCodeTextField(BuildContext context) {
    return DSTextFieldWidget(
      key: const Key('verification_code_input_widget'),
      labelText: context.localizations.verificationCodeFormFieldLabel,
      controller: context.state.textFieldController,
      focusNode: context.state.focusNode,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => context.state.focusNode.unfocus(),
      onChanged: (input) {
        context.bloc.add(ValidateTextFieldEvent(text: input));
      },
      validator: (input) {
        final message = context.bloc.state.validationMessage.getMessage(
          context.localizations,
        );

        if (message != null) {
          return TextFieldValidationData.error(message);
        }

        return null;
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: const [AutofillHints.password],
      textFieldType: TextFieldType.password,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return DSButtonWidget(
      key: const Key('submit_button_widget'),
      label: context.localizations.submitButton,
      onPressed: () {
        context.bloc.add(
          SubmitFormEvent(
            docId: context.state.verificationDocId!,
            code: context.state.textFieldController.text.trim(),
          ),
        );
      },
      isDisabled:
          context.state.verificationDocId == null ||
          context.state.validationMessage.getMessage(context.localizations) !=
              null,
      isLoading: context.state.viewState.isLoading,
      variant: DSButtonVariant.prominent,
    );
  }
}
