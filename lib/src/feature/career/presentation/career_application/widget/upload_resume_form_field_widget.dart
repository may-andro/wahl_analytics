import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/file_picker/file_picker.dart';

class UploadResumeFormFieldWidget extends FormField<PickedFile> {
  UploadResumeFormFieldWidget({
    super.key,
    required VoidCallback onClicked,
    super.validator,
    bool isLoading = false,
    PickedFile? resumeFile,
  }) : super(
         builder: (FormFieldState<PickedFile> state) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const _LabelTextWidget(),
               _ButtonWidget(onPressed: onClicked, isLoading: isLoading),
               if (resumeFile != null) ...[
                 const DSVerticalSpacerWidget(0.5),
                 _SuccessTextWidget(fileName: resumeFile.name),
               ],
               if (state.hasError && resumeFile == null) ...[
                 const DSVerticalSpacerWidget(0.5),
                 _ErrorTextWidget(error: state.errorText),
               ],
             ],
           );
         },
       );
}

class _LabelTextWidget extends StatelessWidget {
  const _LabelTextWidget();

  @override
  Widget build(BuildContext context) {
    return DSTextWidget(
      'Resume',
      color: context.colorPalette.neutral.grey9,
      style: context.typography.bodyMedium,
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({required this.onPressed, this.isLoading = false});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DSButtonWidget(
      key: const Key('resume_button_widget'),
      label: 'Add Resume'.toUpperCase(),
      onPressed: onPressed,
      isLoading: isLoading,
      variant: DSButtonVariant.secondary,
      icon: Icons.add,
    );
  }
}

class _SuccessTextWidget extends StatelessWidget {
  const _SuccessTextWidget({required this.fileName});

  final String? fileName;

  @override
  Widget build(BuildContext context) {
    if (fileName == null || fileName?.isEmpty == true) {
      return const SizedBox.shrink();
    }

    return DSTextWidget(
      'Document uploaded: ${fileName!}',
      color: context.colorPalette.semantic.success,
      style: context.typography.bodyMedium,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
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
