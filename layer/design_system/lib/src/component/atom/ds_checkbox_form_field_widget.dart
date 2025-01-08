import 'package:design_system/src/component/atom/ds_horizontal_spacer_widget.dart';
import 'package:design_system/src/component/atom/ds_text_widget.dart';
import 'package:design_system/src/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class DSCheckboxFormFieldWidget extends FormField<bool> {
  DSCheckboxFormFieldWidget({
    super.key,
    super.onSaved,
    super.validator,
    bool super.initialValue = false,
    bool isDisabled = false,
    bool isTriStateEnabled = false,
    String? label,
  }) : super(
          builder: (FormFieldState<bool> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DSCheckboxWidget(
                  value: state.value,
                  isDisabled: isDisabled,
                  isTriStateEnabled: isTriStateEnabled,
                  onChanged: (value) {
                    onSaved?.call(value);
                    state.didChange(value);
                    state.validate();
                  },
                  label: label,
                ),
                if (state.hasError)
                  _ErrorTextWidget(error: state.errorText ?? ''),
              ],
            );
          },
        );
}

class DSCheckboxWidget extends StatefulWidget {
  const DSCheckboxWidget({
    required this.value,
    this.isDisabled = false,
    this.isTriStateEnabled = false,
    this.onChanged,
    this.label,
    super.key,
  }) : assert(isTriStateEnabled || value != null);

  final bool? value;
  final bool isDisabled;
  final bool isTriStateEnabled;
  final ValueChanged<bool?>? onChanged;
  final String? label;

  @override
  State<DSCheckboxWidget> createState() => _DSCheckboxWidgetState();
}

class _DSCheckboxWidgetState extends State<DSCheckboxWidget> {
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handlePressed() {
    _focusNode.requestFocus();
    if (!widget.isDisabled) {
      bool? newValue;
      if (widget.isTriStateEnabled) {
        if (widget.value == null) {
          newValue = false;
        } else if (!widget.value!) {
          newValue = true;
        } else if (widget.value!) {
          newValue = null;
        }
      } else {
        if (widget.value == null) {
          throw UnimplementedError();
        }
        newValue = !widget.value!;
      }
      widget.onChanged?.call(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNull = widget.value == null;
    final isTrue = widget.value != null && widget.value! == true;

    final fillColor = widget.isDisabled && (isNull || isTrue)
        ? context.colorPalette.neutral.grey4.color
        : widget.isDisabled
            ? context.colorPalette.neutral.grey2.color
            : isNull || isTrue
                ? context.colorPalette.prominent.primary.color
                : context.colorPalette.background.primary.color;

    final iconColor = widget.isDisabled
        ? context.colorPalette.neutral.grey3.color
        : context.colorPalette.neutral.white.color;

    final borderColor = widget.isDisabled
        ? context.colorPalette.neutral.grey4.color
        : isNull || isTrue
            ? context.colorPalette.brand.secondary.color
            : context.colorPalette.neutral.grey8.color;

    final labelColor = widget.isDisabled
        ? context.colorPalette.neutral.grey10
        : context.colorPalette.neutral.grey9;

    return GestureDetector(
      onTap: widget.isDisabled ? null : _handlePressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: widget.isDisabled ? null : _handlePressed,
            customBorder: const CircleBorder(),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  context.dimen.radiusLevel1.value,
                ),
                border: Border.all(color: borderColor, width: 2),
                color: fillColor,
              ),
              child: SizedBox(
                width: 20,
                height: 20,
                child: Visibility(
                  visible: widget.value == null || (widget.value ?? false),
                  child: FittedBox(
                    child: Icon(
                      widget.value == null ? Icons.remove : Icons.check,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.label != null) ...[
            const DSHorizontalSpacerWidget(1),
            Expanded(
              child: DSTextWidget(
                widget.label!,
                color: labelColor,
                style: context.typography.bodyMedium,
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                ),
              ),
            ),
            const DSHorizontalSpacerWidget(0.5),
          ],
        ],
      ),
    );
  }
}

class _ErrorTextWidget extends StatelessWidget {
  const _ErrorTextWidget({required this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    if (error == null || error?.isEmpty == true) {
      return const SizedBox.shrink();
    }

    return DSTextWidget(
      error!,
      color: context.colorPalette.semantic.error,
      style: context.typography.bodyMedium,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
      ),
    );
  }
}
