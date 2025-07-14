import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/entity/dummy_entity.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController textFieldControllers;
  late final FocusNode textFieldFocusNodes;

  @override
  void initState() {
    formKey = GlobalKey();
    textFieldControllers = TextEditingController();
    textFieldFocusNodes = FocusNode()..requestFocus();

    super.initState();
  }

  @override
  void dispose() {
    textFieldControllers.dispose();
    textFieldFocusNodes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.space()),
          DSTextFieldWidget(
            key: const Key('name_input_widget'),
            hintText: 'Some text',
            labelText: 'Text',
            controller: textFieldControllers,
            focusNode: textFieldFocusNodes,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (text) {
              textFieldFocusNodes.unfocus();
              FocusScope.of(context).requestFocus(textFieldFocusNodes);
            },
            validator: (input) {
              if (input == null || input.isEmpty) {
                return const TextFieldValidationData.error('Can not be empty');
              }
              return null;
            },
            autoValidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: const [AutofillHints.name],
          ),
          SizedBox(height: context.space(factor: 5)),
          DSButtonWidget(
            key: const Key('add_button_widget'),
            label: 'Add',
            onPressed: () {
              textFieldFocusNodes.unfocus();
              final isFormValidate = formKey.currentState?.validate() ?? false;
              if (isFormValidate) {
                Navigator.pop(
                  context,
                  DummyEntity(name: textFieldControllers.text),
                );
              }
            },
            variant: DSButtonVariant.prominent,
          ),
          SizedBox(height: context.space()),
        ],
      ),
    );
  }
}
