import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_client_widget.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_footer_widget.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_header_widget.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_intro_widget.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_service_widget.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_team_widget.dart';

const _minHeaderHeightFactor = 7.0;
const _maxHeaderHeightFactor = 8.0;

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current.viewState != previous.viewState,
      builder: (context, state) {
        return DSViewStateBuilderWidget(
          state: state.viewState,
          loadingBuilder: (_) {
            return DSLoadingWidget(
              size: max(context.shortestSide * 0.1, context.space(factor: 2)),
            );
          },
          errorBuilder: (_) {
            return DSErrorCardWidget(
              message: state.errorStateCause,
            );
          },
          builder: (_) {
            return const _SuccessContentWidget();
          },
        );
      },
    );
  }
}

class _SuccessContentWidget extends StatefulWidget {
  const _SuccessContentWidget();

  @override
  State<_SuccessContentWidget> createState() => _SuccessContentWidgetState();
}

class _SuccessContentWidgetState extends State<_SuccessContentWidget>
    with TickerProviderStateMixin {
  late ScrollController _listScrollController;

  late AnimationController _animationController;
  late Animation<double> _toolBarHeightFactorTweenAnimation;
  double _listScrollPercent = 0;

  @override
  void initState() {
    super.initState();
    _listScrollController = ScrollController()
      ..addListener(_listScrollListener);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );

    _toolBarHeightFactorTweenAnimation = Tween<double>(
      begin: _maxHeaderHeightFactor,
      end: _minHeaderHeightFactor,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.scrollContentToSection) {
          _scrollToSection(
            state.sectionKeyMap?[state.selectedBodySection?.name],
          );
        }
      },
      child: CustomScrollView(
        controller: _listScrollController,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
        ),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final animationValue = _toolBarHeightFactorTweenAnimation.value;
              final scrollPercentage =
                  (animationValue - _minHeaderHeightFactor) /
                      (_maxHeaderHeightFactor - _minHeaderHeightFactor);
              final height = context.space(factor: animationValue);
              final colorPalette = context.colorPalette;
              return SliverAppBar(
                pinned: true,
                backgroundColor: colorPalette.background.primary.color,
                surfaceTintColor: colorPalette.neutral.transparent.color,
                shadowColor: colorPalette.background.onPrimary.color,
                toolbarHeight: height,
                automaticallyImplyLeading: false,
                title: SectionHeaderWidget(
                  opacity: 1 - scrollPercentage,
                  height: height,
                ),
                titleSpacing: 0,
                leadingWidth: context.space(factor: 13),
                leading: context.isDesktop
                    ? null
                    : DSIconButtonWidget(
                        Icons.menu,
                        iconColor: colorPalette.background.onPrimary,
                        buttonColor: colorPalette.background.primary,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SectionIntroWidget(),
          ),
          const SliverToBoxAdapter(
            child: SectionServiceWidget(),
          ),
          const SliverToBoxAdapter(
            child: SectionClientWidget(),
          ),
          const SliverToBoxAdapter(
            child: SectionTeamWidget(),
          ),
          const SliverToBoxAdapter(
            child: SectionFooterWidget(),
          ),
        ],
      ),
    );
  }

  void _scrollToSection(GlobalKey? globalKey) {
    final currentContext = globalKey?.currentContext;
    if (currentContext != null) {
      Scrollable.ensureVisible(currentContext, duration: 300.ms);
    }
  }

  void _listScrollListener() {
    final maxScroll = _listScrollController.position.maxScrollExtent;
    final currentScroll = _listScrollController.offset;
    _listScrollPercent = (currentScroll / maxScroll).clamp(0, 1);
    if (_listScrollPercent > 0.2) {
      _animationController.value = 1;
    } else {
      _animationController.value = _listScrollPercent / 0.2;
    }

    final state = context.read<HomeBloc>().state;
    final sections = state.homeBodySections;
    if (sections == null) return;
    for (var i = 0; i < sections.length; i++) {
      final keyContext = state.sectionKeyMap?[sections[i].name]?.currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero).dy;
          if (position <= context.height / 2 &&
              position >= -box.size.height / 2) {
            context.read<HomeBloc>().add(ContentScrollEvent(sections[i]));
          }
        }
      }
    }
  }
}
