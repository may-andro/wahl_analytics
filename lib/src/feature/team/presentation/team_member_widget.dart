import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/team/domain/domain.dart';
import 'package:wahl_analytics/src/feature/team/presentation/dto/dto.dart';
import 'package:wahl_analytics/src/feature/team/presentation/widget/widget.dart';

class TeamMemberWidget extends StatefulWidget {
  const TeamMemberWidget({
    required this.teamMember,
    this.arrangeHorizontally = false,
    super.key,
  });

  final TeamMemberEntity teamMember;
  final bool arrangeHorizontally;

  @override
  State<TeamMemberWidget> createState() => _TeamMemberWidgetState();
}

class _TeamMemberWidgetState extends State<TeamMemberWidget>
    with TickerProviderStateMixin {
  late final AnimationManager _animationManager;

  @override
  void initState() {
    super.initState();

    _animationManager = AnimationManager(
      vsync: this,
      duration: 700.milliseconds,
    );

    // Adding animations
    _animationManager.addScaleAnimation(key: 'image', start: 0.0, end: 0.3);
    _animationManager.addScaleAnimation(key: 'name', start: 0.3, end: 0.5);
    _animationManager.addScaleAnimation(key: 'role', start: 0.5, end: 0.7);
    _animationManager.addFadeAnimation(
      key: 'description',
      start: 0.7,
      end: 1.0,
    );
  }

  @override
  void dispose() {
    _animationManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DSVisibilityDetectorWidget(
      key: Key(widget.teamMember.name),
      onVisibilityChanged: (visiblePercentage) {
        if (visiblePercentage > 25) {
          _animationManager.controller.forward();
        }
      },
      child: widget.arrangeHorizontally
          ? _HorizontalContentWidget(
              teamMember: widget.teamMember,
              animationManager: _animationManager,
            )
          : _VerticalContentWidget(
              teamMember: widget.teamMember,
              animationManager: _animationManager,
            ),
    );
  }
}

class _HorizontalContentWidget extends StatelessWidget {
  const _HorizontalContentWidget({
    required this.teamMember,
    required this.animationManager,
  });

  final TeamMemberEntity teamMember;
  final AnimationManager animationManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: _MemberImageWidget(
                teamMember: teamMember,
                animationManager: animationManager,
              ),
            ),
            const DSVerticalSpacerWidget(1),
            _NameTextWidget(
              teamMember: teamMember,
              animationManager: animationManager,
            ),
            _RoleTextWidget(
              teamMember: teamMember,
              animationManager: animationManager,
            ),
          ],
        ),
        const DSHorizontalSpacerWidget(5),
        Expanded(
          flex: 5,
          child: _DescriptionImageWidget(
            teamMember: teamMember,
            animationManager: animationManager,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _VerticalContentWidget extends StatelessWidget {
  const _VerticalContentWidget({
    required this.teamMember,
    required this.animationManager,
  });

  final TeamMemberEntity teamMember;
  final AnimationManager animationManager;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DSVerticalSpacerWidget(2),
        Flexible(
          child: _MemberImageWidget(
            teamMember: teamMember,
            animationManager: animationManager,
          ),
        ),
        const DSVerticalSpacerWidget(2),
        _NameTextWidget(
          teamMember: teamMember,
          animationManager: animationManager,
        ),
        const DSVerticalSpacerWidget(1),
        _RoleTextWidget(
          teamMember: teamMember,
          animationManager: animationManager,
        ),
        const DSVerticalSpacerWidget(1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.space(factor: 5)),
          child: _DescriptionImageWidget(
            teamMember: teamMember,
            animationManager: animationManager,
          ),
        ),
      ],
    );
  }
}

class _MemberImageWidget extends StatelessWidget {
  const _MemberImageWidget({
    required this.teamMember,
    required this.animationManager,
  });

  final TeamMemberEntity teamMember;
  final AnimationManager animationManager;

  @override
  Widget build(BuildContext context) {
    return AnimationWrapperWidget(
      animation: animationManager.getAnimation('image')!,
      child: DSNetworkImageWidget(
        url: teamMember.url,
        fit: BoxFit.cover,
        shape: BoxShape.circle,
        height: context.space(factor: 15),
      ),
    );
  }
}

class _NameTextWidget extends StatelessWidget {
  const _NameTextWidget({
    required this.teamMember,
    required this.animationManager,
  });

  final TeamMemberEntity teamMember;
  final AnimationManager animationManager;

  @override
  Widget build(BuildContext context) {
    return AnimationWrapperWidget(
      animation: animationManager.getAnimation('name')!,
      child: DSTextWidget(
        teamMember.name,
        color: context.colorPalette.neutral.grey9,
        style: context.typography.titleLarge,
      ),
    );
  }
}

class _RoleTextWidget extends StatelessWidget {
  const _RoleTextWidget({
    required this.teamMember,
    required this.animationManager,
  });

  final TeamMemberEntity teamMember;
  final AnimationManager animationManager;

  @override
  Widget build(BuildContext context) {
    return AnimationWrapperWidget(
      animation: animationManager.getAnimation('role')!,
      child: DSTextWidget(
        teamMember.role,
        color: context.colorPalette.neutral.grey8,
        style: context.typography.bodyLarge,
      ),
    );
  }
}

class _DescriptionImageWidget extends StatelessWidget {
  const _DescriptionImageWidget({
    required this.teamMember,
    required this.animationManager,
  });

  final TeamMemberEntity teamMember;
  final AnimationManager animationManager;

  @override
  Widget build(BuildContext context) {
    return AnimationWrapperWidget(
      animation: animationManager.getAnimation('description')!,
      animationType: AnimationType.fade,
      child: _QuotedTextWidget(text: teamMember.shortDescription),
    );
  }
}

class _QuotedTextWidget extends StatelessWidget {
  const _QuotedTextWidget({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: DSTextWidget(
              '\u275D',
              style: context.typography.titleLarge,
              color: context.colorPalette.neutral.grey6,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(context.space()),
              child: DSTextWidget(
                text,
                textAlign: TextAlign.center,
                style: context.typography.titleMedium,
                color: context.colorPalette.neutral.grey7,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: DSTextWidget(
              '\u275E',
              style: context.typography.titleLarge,
              color: context.colorPalette.neutral.grey6,
            ),
          ),
        ],
      ),
    );
  }
}
