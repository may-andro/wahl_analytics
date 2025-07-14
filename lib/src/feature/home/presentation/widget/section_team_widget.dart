import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/career/career.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_info_widget.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/feature/team/team.dart';

class SectionTeamWidget extends StatelessWidget {
  const SectionTeamWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final sections = state.homeBodySections
            ?.whereType<TeamSection>()
            .toList();
        if (sections == null || sections.isEmpty) {
          return const SizedBox.shrink();
        }

        final teamSection = sections.first;
        final teamMembers = teamSection.members;
        if (teamMembers.isEmpty) return const SizedBox.shrink();

        final teamMember = teamMembers[0];
        return TrackingImpressionDetectorWidget(
          impressionId: 'home_section_team',
          onImpression: () => context.bloc.add(HomeTeamSectionViewEvent()),
          child: Container(
            key: state.sectionKeyMap?[teamSection.name],
            color: context.colorPalette.background.primary.color,
            padding: EdgeInsets.symmetric(vertical: context.space(factor: 5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DSResponsiveContainerWidget(
                  mobileBuilder: (_) =>
                      _MobileContentWidget(teamMember: teamMember),
                  tabletBuilder: (_) =>
                      _TabletContentWidget(teamMember: teamMember),
                  desktopBuilder: (_) =>
                      _DesktopContentWidget(teamMember: teamMember),
                ),
                const DSVerticalSpacerWidget(3),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.space(factor: 5),
                  ),
                  child: SectionInfoWidget(
                    bodySection: teamSection,
                    isSecondaryBackground: false,
                    onClicked: () {
                      context.bloc.add(ContactUsClickEvent());
                      context.push(CareerModuleRoute.careerApplication.path);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MobileContentWidget extends StatelessWidget {
  const _MobileContentWidget({required this.teamMember});

  final TeamMemberEntity teamMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: context.space(factor: 60),
          child: TeamMemberWidget(teamMember: teamMember),
        ),
        const DSVerticalSpacerWidget(2),
        ServiceCarousalWidget(services: teamMember.services),
      ],
    );
  }
}

class _TabletContentWidget extends StatelessWidget {
  const _TabletContentWidget({required this.teamMember});

  final TeamMemberEntity teamMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: context.space(factor: 30),
          child: TeamMemberWidget(teamMember: teamMember),
        ),
        const DSVerticalSpacerWidget(2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.space(factor: 5)),
          child: ServiceListWidget(services: teamMember.services),
        ),
      ],
    );
  }
}

class _DesktopContentWidget extends StatelessWidget {
  const _DesktopContentWidget({required this.teamMember});

  final TeamMemberEntity teamMember;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: context.space(factor: 20),
          child: TeamMemberWidget(
            teamMember: teamMember,
            arrangeHorizontally: true,
          ),
        ),
        const DSVerticalSpacerWidget(2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.space(factor: 5)),
          child: ServiceHorizontalListWidget(services: teamMember.services),
        ),
      ],
    );
  }
}
