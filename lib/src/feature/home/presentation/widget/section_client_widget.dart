import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/client/client.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_info_widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class SectionClientWidget extends StatelessWidget {
  const SectionClientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final sections = state.sections;
        if (sections == null || sections.isEmpty) {
          return const SizedBox.shrink();
        }

        final clientSections = sections.whereType<ClientSection>().toList();
        if (clientSections.isEmpty) return const SizedBox.shrink();

        final clientSection = clientSections.first;
        return Container(
          key: state.sectionKeyMap?[clientSection.name],
          color: context.colorPalette.backgroundSecondary.primary.color,
          padding: EdgeInsets.symmetric(
            horizontal: context.space(factor: 5),
            vertical: context.space(factor: 5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClientGridWidget(
                clients: clientSection.clients,
              ),
              const DSVerticalSpacerWidget(3),
              SectionInfoWidget(
                bodySection: clientSection,
                isSecondaryBackground: true,
                onClicked: () =>
                    context.push(ContactModuleRoute.contactUs.path),
              ),
            ],
          ),
        );
      },
    );
  }
}
