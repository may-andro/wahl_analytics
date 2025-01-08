import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/widget/contact_detail_widget.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/widget/content_card_widget.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/widget/form_widget.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/widget/intro_widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              context.colorPalette.background.primary.color
                  .withValues(alpha: 0.5),
              BlendMode.darken,
            ),
            child: const DSAssetImageWidget(
              DSAssetImage.contactUs,
              width: double.maxFinite,
              height: double.maxFinite,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: 0,
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
    const contactDetailsWidget = ContactDetailWidget();
    switch (context.deviceWidth) {
      case DSDeviceWidthResolution.xs:
        return const _XSContentWidget(formWidget, contactDetailsWidget);
      case DSDeviceWidthResolution.s:
        return const _SContentWidget(formWidget, contactDetailsWidget);
      case DSDeviceWidthResolution.m:
        return const _MContentWidget(formWidget, contactDetailsWidget);
      case DSDeviceWidthResolution.l:
      case DSDeviceWidthResolution.xl:
        return const _LContentWidget(formWidget, contactDetailsWidget);
    }
  }
}

class _XSContentWidget extends StatelessWidget {
  const _XSContentWidget(
    this.formWidget,
    this.contactDetailsWidget,
  );

  final Widget formWidget;
  final Widget contactDetailsWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.colorPalette.background.primary.color,
          padding: EdgeInsets.symmetric(vertical: context.space(factor: 5)),
          child: const IntoWidget(),
        ),
        Container(
          color: context.colorPalette.background.primary.color,
          padding: EdgeInsets.symmetric(horizontal: context.space(factor: 5)),
          child: formWidget,
        ),
        ColoredBox(
          color: context.colorPalette.backgroundSecondary.primary.color
              .withValues(alpha: 0.5),
          child: contactDetailsWidget,
        ),
      ],
    );
  }
}

class _SContentWidget extends StatelessWidget {
  const _SContentWidget(
    this.formWidget,
    this.contactDetailsWidget,
  );

  final Widget formWidget;
  final Widget contactDetailsWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.colorPalette.background.primary.color,
          padding: EdgeInsets.symmetric(vertical: context.space(factor: 5)),
          child: const IntoWidget(),
        ),
        ContentCardWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
            child: formWidget,
          ),
        ),
        ColoredBox(
          color: context.colorPalette.backgroundSecondary.primary.color
              .withValues(alpha: 0.9),
          child: contactDetailsWidget,
        ),
      ],
    );
  }
}

class _MContentWidget extends StatelessWidget {
  const _MContentWidget(
    this.formWidget,
    this.contactDetailsWidget,
  );

  final Widget formWidget;
  final Widget contactDetailsWidget;

  @override
  Widget build(BuildContext context) {
    return ContentCardWidget(
      child: Column(
        children: [
          Container(
            color: context.colorPalette.background.primary.color,
            padding: EdgeInsets.symmetric(vertical: context.space(factor: 5)),
            child: const IntoWidget(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.2),
            child: formWidget,
          ),
          ColoredBox(
            color: context.colorPalette.backgroundSecondary.primary.color
                .withValues(alpha: 0.9),
            child: contactDetailsWidget,
          ),
        ],
      ),
    );
  }
}

class _LContentWidget extends StatelessWidget {
  const _LContentWidget(
    this.formWidget,
    this.contactDetailsWidget,
  );

  final Widget formWidget;
  final Widget contactDetailsWidget;

  @override
  Widget build(BuildContext context) {
    return ContentCardWidget(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DSVerticalSpacerWidget(5),
                  const IntoWidget(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.space(factor: 5),
                    ),
                    child: formWidget,
                  ),
                ],
              ),
            ),
            DSVerticalDividerWidget(
              thickness: 5,
              color: context.colorPalette.backgroundSecondary.primary,
            ),
            Expanded(
              child: Container(
                color: context.colorPalette.backgroundSecondary.primary.color
                    .withValues(alpha: 0.9),
                padding: EdgeInsets.all(context.space(factor: 5)),
                child: contactDetailsWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
