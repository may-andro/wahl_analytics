import 'package:design_system/src/component/atom/ds_horizontal_spacer_widget.dart';
import 'package:design_system/src/component/atom/ds_text_widget.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:design_system/src/foundation/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DSTextFieldWidget extends StatefulWidget {
  const DSTextFieldWidget({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.helperText,
    this.autofillHints,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.onFieldSubmitted,
    this.onValidationError,
    this.validator,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.suffixIcon,
    this.textInputAction,
    this.textFieldType = TextFieldType.normal,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final List<String>? autofillHints;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final void Function(String)? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onValidationError;
  final TextFieldValidationData? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode autoValidateMode;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final IconData? suffixIcon;
  final TextInputAction? textInputAction;
  final TextFieldType textFieldType;

  @override
  State<DSTextFieldWidget> createState() => _DSTextFieldWidgetState();
}

class _DSTextFieldWidgetState extends State<DSTextFieldWidget> {
  bool _obscureText = false;

  bool _hasContent = false;

  TextFieldValidationData? _textFieldValidationData;

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.textFieldType == TextFieldType.password;
    if (widget.controller != null) {
      if (widget.controller!.text.isNotEmpty) {
        setState(() {
          _hasContent = true;
        });
      }
      widget.controller!.addListener(() {
        setState(() {
          _hasContent = widget.controller!.text.isNotEmpty;
        });
      });
    } else {
      _controller = TextEditingController()
        ..addListener(() {
          setState(() {
            _hasContent = _controller!.text.isNotEmpty;
          });
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ..._buildLabelTextWidget,
        TextFormField(
          cursorColor: context.colorPalette.neutral.grey9.color,
          cursorWidth: 1,
          textAlignVertical: TextAlignVertical.center,
          autocorrect: false,
          autofillHints: widget.enabled ? widget.autofillHints : null,
          autofocus: widget.autofocus,
          autovalidateMode: widget.autoValidateMode,
          controller: widget.controller ?? _controller,
          decoration: decorateInputDecoration(
            hint: widget.hintText,
            suffixIcon: _buildSuffixIcon,
          ),
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          maxLines: widget.maxLines,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onFieldSubmitted,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          style: context.typography.bodyLarge.textStyle.copyWith(
            color: _getTextFieldState()
                .getInputTextColor(context.colorPalette)
                .color,
          ),
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          validator: (value) {
            if (widget.validator == null) return null;
            final data = widget.validator?.call(value);
            _updateTextFieldState(data);
            if (data != null &&
                (data.textFieldValidationType ==
                    TextFieldValidationType.error)) {
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

  InputDecoration decorateInputDecoration({String? hint, Widget? suffixIcon}) {
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
              _textFieldValidationData?.textFieldValidationType ==
                  TextFieldValidationType.success
              ? context.colorPalette.semantic.success.color
              : context.colorPalette.background.disabled.color,
        ),
        borderRadius: borderRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color:
              _textFieldValidationData?.textFieldValidationType ==
                  TextFieldValidationType.success
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
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIcon != null
          ? BoxConstraints(
              minHeight: context.space(factor: 4),
              minWidth: context.space(factor: 4),
            )
          : null,
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

    if (_hasContent) return _TextFieldState.filled;

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

  Widget? get _buildSuffixIcon {
    return widget.textFieldType == TextFieldType.normal
        ? _buildNormalSuffixIcon
        : _buildPasswordSuffixIconButton;
  }

  Widget? get _buildNormalSuffixIcon {
    final icon = widget.suffixIcon;
    if (icon == null) return null;

    return ExcludeSemantics(
      child: Icon(
        icon,
        color: widget.enabled
            ? context.colorPalette.neutral.grey9.color
            : context.colorPalette.background.disabled.color,
      ),
    );
  }

  Widget get _buildPasswordSuffixIconButton {
    return ExcludeSemantics(
      child: Padding(
        padding: EdgeInsets.only(right: context.space(factor: 0.5)),
        child: InkWell(
          onTap: () => setState(() => _obscureText = !_obscureText),
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: widget.enabled
                ? context.colorPalette.neutral.grey9.color
                : context.colorPalette.background.disabled.color,
          ),
        ),
      ),
    );
  }

  List<Widget> get _buildTextFieldMessageWidget {
    final textFieldHelperData = widget.helperText != null
        ? TextFieldValidationData.helper(widget.helperText!)
        : null;
    final validationType = (_textFieldValidationData ?? textFieldHelperData)
        ?.textFieldValidationType;
    final message = (_textFieldValidationData ?? textFieldHelperData)?.message;

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

  void _updateTextFieldState(TextFieldValidationData? data) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _textFieldValidationData = data;
      });
    });
  }
}

enum _TextFieldState { onHold, disabled, filled, active }

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

enum TextFieldType { normal, password }

enum TextFieldValidationType { error, success, helper }

extension _TextFieldValidationTypeExtension on TextFieldValidationType {
  DSColor getColor(
    DSColorPalette colorPalette,
    _TextFieldState textFieldState,
  ) {
    switch (this) {
      case TextFieldValidationType.error:
        return colorPalette.semantic.error;
      case TextFieldValidationType.success:
        return colorPalette.semantic.success;
      case TextFieldValidationType.helper:
        return colorPalette.neutral.grey7;
    }
  }

  Widget getIcon(BuildContext context) {
    switch (this) {
      case TextFieldValidationType.error:
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

class TextFieldValidationData {
  const TextFieldValidationData.error(this.message)
    : textFieldValidationType = TextFieldValidationType.error;

  const TextFieldValidationData.success(this.message)
    : textFieldValidationType = TextFieldValidationType.success;

  const TextFieldValidationData.helper(this.message)
    : textFieldValidationType = TextFieldValidationType.helper;

  final String message;
  final TextFieldValidationType textFieldValidationType;
}
