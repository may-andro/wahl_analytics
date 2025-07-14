import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_menu_item_widget.dart';
import 'package:wahl_analytics/src/feature/locale/locale.dart';
import 'package:wahl_analytics/src/route/route.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({
    required this.opacity,
    required this.height,
    super.key,
  });

  final double opacity;
  final double height;

  @override
  Widget build(BuildContext context) {
    return DSResponsiveContainerWidget(
      mobileBuilder: (_) => const _MobileHeaderWidget(),
      tabletBuilder: (_) => _TabletHeaderWidget(
        onTrailingButtonClicked: () => _navigateToContactUsScreen(context),
      ),
      desktopBuilder: (_) => _DesktopHeaderWidget(
        opacity: opacity,
        height: height,
        onTrailingButtonClicked: () => _navigateToContactUsScreen(context),
      ),
    );
  }

  void _navigateToContactUsScreen(BuildContext context) {
    context.bloc.add(ContactUsClickEvent());
    context.push(ContactModuleRoute.contactUs.path);
  }
}

class _MobileHeaderWidget extends StatelessWidget {
  const _MobileHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _MenuButtonWidget(),
        Align(child: _LogoWidget(heightFactor: 5)),
        LocaleButtonWidget(),
      ],
    );
  }
}

class _TabletHeaderWidget extends StatelessWidget {
  const _TabletHeaderWidget({
    required this.onTrailingButtonClicked,
  });

  final VoidCallback onTrailingButtonClicked;

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _MenuButtonWidget(),
        _LogoWidget(heightFactor: 5),
        LocaleButtonWidget(),
      ],
    );
  }
}

class _DesktopHeaderWidget extends StatelessWidget {
  const _DesktopHeaderWidget({
    required this.height,
    required this.opacity,
    required this.onTrailingButtonClicked,
  });

  final double height;
  final double opacity;
  final VoidCallback onTrailingButtonClicked;

  @override
  Widget build(BuildContext context) {
    final dividerWidget = _DividerWidget(opacity: opacity, height: height);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.space(factor: 5)),
      child: Row(
        children: [
          const _LogoWidget(heightFactor: 5),
          const DSHorizontalSpacerWidget(2),
          dividerWidget,
          const Spacer(),
          const _TabsWidget(),
          const DSHorizontalSpacerWidget(2),
          dividerWidget,
          const DSHorizontalSpacerWidget(2),
          DSButtonWidget(
            label: context.localizations.contactUs,
            onPressed: onTrailingButtonClicked,
          ),
          const DSHorizontalSpacerWidget(2),
          const LocaleButtonWidget(size: 3, popupMenuYOffset: 4),
        ],
      ),
    );
  }
}

class _TabsWidget extends StatelessWidget {
  const _TabsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return previous.selectedBodySection != current.selectedBodySection;
      },
      builder: (context, state) {
        return Wrap(
          spacing: context.space(factor: 0),
          children: state.homeBodySections?.map((section) {
                return SectionMenuItemWidget(
                  bodySection: section,
                  onTap: () {
                    context.read<HomeBloc>().add(TabSelectionEvent(section));
                  },
                  isSelected: section == state.selectedBodySection,
                  isIndicatorEnabled: true,
                );
              }).toList() ??
              [],
        );
      },
    );
  }
}

class _DividerWidget extends StatelessWidget {
  const _DividerWidget({required this.opacity, required this.height});

  final double opacity;
  final double height;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: 100.ms,
      child: SizedBox(
        height: height,
        child: DSVerticalDividerWidget(
          thickness: 2,
          color: context.colorPalette.brand.primary,
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({required this.heightFactor});

  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeBloc>().add(HeaderLogoClickEvent());
      },
      child: DSSvgImageWidget(
        assetImage: context.isDarkMode
            ? DSSvgAssetImage.logoDark
            : DSSvgAssetImage.logoLight,
        fit: BoxFit.cover,
        height: context.space(factor: heightFactor),
      ),
    );
  }
}

class _MenuButtonWidget extends StatelessWidget {
  const _MenuButtonWidget();

  @override
  Widget build(BuildContext context) {
    return DSIconButtonWidget(
      Icons.menu,
      iconColor: context.colorPalette.background.onPrimary,
      buttonColor: context.colorPalette.neutral.transparent,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
