import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/contact/contact.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/home/presentation/widget/section_menu_item_widget.dart';
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
    context.push(ContactModuleRoute.contactUs.path);
  }
}

class _MobileHeaderWidget extends StatelessWidget {
  const _MobileHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-30, 0),
      child: const Row(
        children: [
          Spacer(),
          _LogoWidget(heightFactor: 5),
          Spacer(),
          DSHorizontalSpacerWidget(5.5),
        ],
      ),
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
    return Transform.translate(
      offset: const Offset(-15.5, 0),
      child: Row(
        children: [
          const Spacer(),
          const _LogoWidget(heightFactor: 5),
          const Spacer(),
          DSButtonWidget(
            label: 'Contact Us',
            size: DSButtonSize.small,
            onPressed: onTrailingButtonClicked,
          ),
        ],
      ),
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
            label: 'Contact Us',
            size: DSButtonSize.medium,
            onPressed: onTrailingButtonClicked,
          ),
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
