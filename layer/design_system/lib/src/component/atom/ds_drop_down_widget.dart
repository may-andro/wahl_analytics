import 'package:design_system/src/component/atom/ds_horizontal_spacer_widget.dart';
import 'package:design_system/src/component/atom/ds_text_widget.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';

class DSDropDownWidget<T> extends StatefulWidget {
  const DSDropDownWidget({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.labelText,
    this.hintText,
    this.helperText,
    this.onChanged,
    this.onTap,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.validator,
    this.onValidationError,
    this.focusNode,
    this.enabled = false,
  });

  final List<DropdownMenuItem<T>>? items;
  final DropdownButtonBuilder? selectedItemBuilder;
  final T? value;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? onTap;
  final AutovalidateMode autoValidateMode;
  final DropDownValidationData? Function(T?)? validator;
  final ValueChanged<String>? onValidationError;
  final FocusNode? focusNode;
  final bool enabled;

  @override
  State<DSDropDownWidget<T>> createState() => _DSDropDownWidgetState();
}

class _DSDropDownWidgetState<T> extends State<DSDropDownWidget<T>> {
  DropDownValidationData? _dropDownValidationData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ..._buildLabelTextWidget,
        DropdownButtonFormField<T>(
          items: widget.items,
          selectedItemBuilder: widget.selectedItemBuilder,
          initialValue: widget.value,
          decoration: _decorateInputDecoration(hint: widget.hintText),
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          style: context.typography.bodyLarge.textStyle.copyWith(
            color: _getTextFieldState()
                .getInputTextColor(context.colorPalette)
                .color,
          ),
          autovalidateMode: widget.autoValidateMode,
          validator: (value) {
            if (widget.validator == null) return null;
            final data = widget.validator?.call(value);
            _updateTextFieldState(data);
            if (data != null &&
                (data.dropDownValidationType == DropDownValidationType.error)) {
              final onValidationError = widget.onValidationError;
              if (onValidationError != null) {
                onValidationError(data.message);
              }
              return data.message;
            }
            return null;
          },
        ),
        ..._buildTextFieldMessageWidget,
      ],
    );
  }

  InputDecoration _decorateInputDecoration({String? hint}) {
    final borderRadius = BorderRadius.circular(
      context.dimen.radiusLevel1.value,
    );
    return InputDecoration(
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: context.colorPalette.semantic.error.color,
        ),
        borderRadius: borderRadius,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: context.colorPalette.semantic.error.color,
        ),
        borderRadius: borderRadius,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorPalette.neutral.grey4.color),
        borderRadius: borderRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:
              _dropDownValidationData?.dropDownValidationType ==
                  DropDownValidationType.success
              ? context.colorPalette.semantic.success.color
              : context.colorPalette.background.disabled.color,
        ),
        borderRadius: borderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:
              _dropDownValidationData?.dropDownValidationType ==
                  DropDownValidationType.success
              ? context.colorPalette.semantic.success.color
              : context.colorPalette.background.disabled.color,
        ),
        borderRadius: borderRadius,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: context.colorPalette.neutral.grey3.color),
        borderRadius: borderRadius,
      ),
      errorStyle: const TextStyle(height: 0, fontSize: 0.1),
      errorMaxLines: 1,
      counterText: '',
      hintText: hint,
      hintStyle: context.typography.bodyLarge.textStyle.copyWith(
        color: context.colorPalette.neutral.grey5.color,
      ),
    );
  }

  _TextFieldState _getTextFieldState() {
    if (!widget.enabled) return _TextFieldState.disabled;

    if (widget.focusNode?.hasFocus ?? false) return _TextFieldState.active;

    return _TextFieldState.onHold;
  }

  List<Widget> get _buildLabelTextWidget {
    return [
      Padding(
        padding: EdgeInsets.only(left: context.space(factor: 0)),
        child: DSTextWidget(
          widget.labelText ?? '',
          style: context.typography.bodyMedium,
          color: context.colorPalette.neutral.grey9,
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
    ];
  }

  List<Widget> get _buildTextFieldMessageWidget {
    final textFieldHelperData = widget.helperText != null
        ? DropDownValidationData.helper(widget.helperText!)
        : null;
    final validationType = (_dropDownValidationData ?? textFieldHelperData)
        ?.dropDownValidationType;
    final message = (_dropDownValidationData ?? textFieldHelperData)?.message;

    if (validationType == null || message == null) return [];

    return [
      SizedBox(height: context.space(factor: 0.5)),
      Padding(
        padding: EdgeInsets.only(left: context.space(factor: 0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            validationType.getIcon(context),
            const DSHorizontalSpacerWidget(0.5),
            Expanded(
              child: DSTextWidget(
                message,
                style: context.typography.bodyMedium,
                color: validationType.getColor(
                  context.colorPalette,
                  _getTextFieldState(),
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  void _updateTextFieldState(DropDownValidationData? data) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _dropDownValidationData = data;
      });
    });
  }
}

enum _TextFieldState { onHold, disabled, active }

extension _TextFieldStateExtension on _TextFieldState {
  DSColor getInputTextColor(DSColorPalette colorPalette) {
    switch (this) {
      case _TextFieldState.disabled:
        return colorPalette.background.disabled;
      default:
        return colorPalette.neutral.grey9;
    }
  }
}

enum DropDownValidationType { error, success, helper }

extension _TextFieldValidationTypeExtension on DropDownValidationType {
  DSColor getColor(
    DSColorPalette colorPalette,
    _TextFieldState textFieldState,
  ) {
    switch (this) {
      case DropDownValidationType.error:
        return colorPalette.semantic.error;
      case DropDownValidationType.success:
        return colorPalette.semantic.success;
      case DropDownValidationType.helper:
        return colorPalette.neutral.grey7;
    }
  }

  Widget getIcon(BuildContext context) {
    switch (this) {
      case DropDownValidationType.error:
        return Icon(
          Icons.error,
          color: context.colorPalette.semantic.error.color,
          size: context.typography.bodyMedium.fontSize,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class DropDownValidationData {
  const DropDownValidationData.error(this.message)
    : dropDownValidationType = DropDownValidationType.error;

  const DropDownValidationData.success(this.message)
    : dropDownValidationType = DropDownValidationType.success;

  const DropDownValidationData.helper(this.message)
    : dropDownValidationType = DropDownValidationType.helper;

  final String message;
  final DropDownValidationType dropDownValidationType;
}
