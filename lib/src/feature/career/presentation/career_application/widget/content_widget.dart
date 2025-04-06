import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/widget/content_card_widget.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/widget/form_widget.dart';
import 'package:wahl_analytics/src/feature/career/presentation/career_application/widget/intro_widget.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              context.colorPalette.background.primary.color.withValues(
                alpha: 0.5,
              ),
              BlendMode.darken,
            ),
            child: const DSAssetImageWidget(
              DSAssetImage.career,
              width: double.maxFinite,
              height: double.maxFinite,
            ),
          ),
        ),
        Positioned.fill(
          child: CustomScrollView(
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(child: _getContent(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getContent(BuildContext context) {
    const formWidget = FormWidget(key: Key('career_form_widget'));
    switch (context.deviceWidth) {
      case DSDeviceWidthResolution.xs:
        return const _XSContentWidget(formWidget);
      case DSDeviceWidthResolution.s:
        return const _SContentWidget(formWidget);
      case DSDeviceWidthResolution.m:
        return const _MContentWidget(formWidget);
      case DSDeviceWidthResolution.l:
      case DSDeviceWidthResolution.xl:
        return const _LContentWidget(formWidget);
    }
  }
}

class _XSContentWidget extends StatelessWidget {
  const _XSContentWidget(this.formWidget);

  final Widget formWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.colorPalette.backgroundSecondary.primary.color,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: context.space(factor: 5)),
          child: Icon(
            Icons.workspace_premium_rounded,
            color: context.colorPalette.prominent.primary.color,
            size: context.space(factor: 15),
          ),
        ),
        ColoredBox(
          color: context.colorPalette.backgroundSecondary.primary.color,
          child: const IntoWidget(),
        ),
        Container(
          color: context.colorPalette.background.primary.color,
          padding: EdgeInsets.all(context.space(factor: 2)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space(factor: 2)),
            child: formWidget,
          ),
        ),
      ],
    );
  }
}

class _SContentWidget extends StatelessWidget {
  const _SContentWidget(this.formWidget);

  final Widget formWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColoredBox(
          color: context.colorPalette.backgroundSecondary.primary.color
              .withValues(alpha: 0.9),
          child: const IntoWidget(),
        ),
        ContentCardWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
            child: formWidget,
          ),
        ),
      ],
    );
  }
}

class _MContentWidget extends StatelessWidget {
  const _MContentWidget(this.formWidget);

  final Widget formWidget;

  @override
  Widget build(BuildContext context) {
    return ContentCardWidget(
      child: Column(
        children: [
          ColoredBox(
            color: context.colorPalette.backgroundSecondary.primary.color
                .withValues(alpha: 0.9),
            child: const IntoWidget(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.2),
            child: formWidget,
          ),
        ],
      ),
    );
  }
}

class _LContentWidget extends StatelessWidget {
  const _LContentWidget(this.formWidget);

  final Widget formWidget;

  @override
  Widget build(BuildContext context) {
    return ContentCardWidget(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: context.colorPalette.backgroundSecondary.primary.color
                    .withValues(alpha: 0.9),
                padding: EdgeInsets.all(context.space(factor: 5)),
                child: Column(
                  children: [
                    const Spacer(),
                    Icon(
                      Icons.workspace_premium_rounded,
                      color: context.colorPalette.prominent.primary.color,
                      size: context.space(factor: 15),
                    ),
                    const DSVerticalSpacerWidget(2),
                    const IntoWidget(),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
            DSVerticalDividerWidget(
              thickness: 5,
              color: context.colorPalette.backgroundSecondary.primary,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.space(factor: 5),
                ),
                child: formWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
