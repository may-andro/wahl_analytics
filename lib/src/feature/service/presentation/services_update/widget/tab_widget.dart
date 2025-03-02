import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ChipWidget(
          label: 'EN',
          selected: context.bloc.state.locale == 'en',
          onSelected: (selected) {
            if (selected) {
              context.bloc.add(const SelectLocaleEvent('en'));
            }
          },
        ),
        const DSHorizontalSpacerWidget(2),
        _ChipWidget(
          label: 'ES',
          selected: context.bloc.state.locale == 'es',
          onSelected: (selected) {
            if (selected) {
              context.bloc.add(const SelectLocaleEvent('es'));
            }
          },
        ),
        const DSHorizontalSpacerWidget(2),
        _ChipWidget(
          label: 'NL',
          selected: context.bloc.state.locale == 'nl',
          onSelected: (selected) {
            if (selected) {
              context.bloc.add(const SelectLocaleEvent('nl'));
            }
          },
        ),
        const DSHorizontalSpacerWidget(2),
      ],
    );
  }
}

class _ChipWidget extends StatelessWidget {
  const _ChipWidget({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: DSTextWidget(
        label,
        color: selected
            ? context.colorPalette.background.primary
            : context.colorPalette.background.onPrimary,
        style: context.typography.bodyLarge,
      ),
      iconTheme: IconThemeData(
        color: context.colorPalette.background.primary.color,
      ),
      selected: selected,
      selectedColor: context.colorPalette.background.onPrimary.color,
      onSelected: onSelected,
    );
  }
}
