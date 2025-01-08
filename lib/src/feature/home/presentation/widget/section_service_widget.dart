import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_info_widget.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/route/route.dart';

class SectionServiceWidget extends StatelessWidget {
  const SectionServiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final sections =
            state.homeBodySections?.whereType<ServiceSection>().toList();
        if (sections == null || sections.isEmpty) {
          return const SizedBox.shrink();
        }

        final serviceSection = sections.first;
        return Container(
          key: state.sectionKeyMap?[serviceSection.name],
          color: context.colorPalette.background.primary.color,
          padding: EdgeInsets.symmetric(vertical: context.space(factor: 5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (context.deviceResolution.isMobile)
                ServiceCarousalWidget(
                  services: serviceSection.services,
                ),
              if (context.deviceResolution.isTablet)
                ..._getTabletWidgets(context, serviceSection),
              if (context.deviceResolution.isDesktop)
                ..._getDesktopWidgets(context, serviceSection),
              const DSVerticalSpacerWidget(3),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.space(factor: 5),
                ),
                child: SectionInfoWidget(
                  bodySection: serviceSection,
                  isSecondaryBackground: false,
                  onClicked: state.isServiceDetailEnabled
                      ? () {
                          context.push(
                            ServiceModuleRoute.servicesProvided.path,
                            extra: serviceSection.services,
                          );
                        }
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _getTabletWidgets(
    BuildContext context,
    ServiceSection serviceSection,
  ) {
    return [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.space(factor: 5),
        ),
        child: ServiceGridWidget(services: serviceSection.services),
      ),
    ];
  }

  List<Widget> _getDesktopWidgets(
    BuildContext context,
    ServiceSection serviceSection,
  ) {
    return [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.space(factor: 5),
        ),
        child: ServiceHorizontalListWidget(
          services: serviceSection.services,
        ),
      ),
    ];
  }
}
