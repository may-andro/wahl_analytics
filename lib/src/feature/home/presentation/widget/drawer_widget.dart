import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_menu_item_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return previous.selectedBodySection != current.selectedBodySection;
      },
      builder: (context, state) {
        return Drawer(
          backgroundColor: context.colorPalette.background.primary.color,
          width: max(context.space(factor: 30), context.width * 0.4),
          elevation: context.dimen.elevationLevel3.value,
          child: Padding(
            padding: EdgeInsets.all(context.space(factor: 2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: DSIconButtonWidget(
                    Icons.close,
                    onPressed: () => Navigator.pop(context),
                    iconColor: context.colorPalette.background.onPrimary,
                    buttonColor: context.colorPalette.background.primary,
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: min(
                            context.space(factor: 20),
                            context.height * 0.2,
                          ),
                          child: DSSvgImageWidget(
                            assetImage: context.isDarkMode
                                ? DSSvgAssetImage.logoDark
                                : DSSvgAssetImage.logoLight,
                            //height: context.space(factor: 15),
                          ),
                        ),
                      ),
                      ..._getMenuItemWidgets(
                        context,
                        state.homeBodySections,
                        state.selectedBodySection,
                      ),
                    ],
                  ),
                ),
                Align(
                  child: SelectableText.rich(
                    TextSpan(
                      text: context.localizations.copyright(
                        '${DateTime.now().year}',
                      ),
                      style: context.typography.labelSmall.textStyle,
                      children: [
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: context.localizations.companyName,
                          style: context.typography.bodySmall.textStyle,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<SliverToBoxAdapter> _getMenuItemWidgets(
    BuildContext context,
    List<BodySection>? sections,
    BodySection? selectedSection,
  ) {
    if (sections == null) return [];

    return sections.map((section) {
      return SliverToBoxAdapter(
        child: SectionMenuItemWidget(
          bodySection: section,
          onTap: () {
            context.read<HomeBloc>().add(TabSelectionEvent(section));
            Navigator.pop(context);
          },
          isSelected: section == selectedSection,
        ),
      );
    }).toList();
  }
}
