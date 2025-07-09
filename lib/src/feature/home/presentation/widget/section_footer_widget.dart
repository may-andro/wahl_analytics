import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/home/domain/domain.dart';
import 'package:wahl_analytics/src/feature/home/presentation/bloc/bloc.dart';

class SectionFooterWidget extends StatelessWidget {
  const SectionFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final footerSections = state.sections?.whereType<FooterSection>();
        if (footerSections == null || footerSections.isEmpty) {
          return const SizedBox.shrink();
        }

        final footerSection = footerSections.first;

        return SafeArea(
          child: Container(
            color: context.colorPalette.backgroundSecondary.primary.color,
            padding: EdgeInsets.symmetric(
              horizontal: context.space(factor: 5),
              vertical: context.space(factor: 5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (context.deviceResolution == DSDeviceResolution.mobile)
                  ..._getMobileWidgets(
                    context,
                    footerSection,
                    state.isMobileDetailVisible,
                    state.isEmailDetailVisible,
                  ),
                if (context.deviceResolution == DSDeviceResolution.tablet)
                  ..._getTabletWidgets(
                    context,
                    footerSection,
                    state.isMobileDetailVisible,
                    state.isEmailDetailVisible,
                  ),
                if (context.deviceResolution == DSDeviceResolution.desktop)
                  ..._getDesktopWidgets(
                    context,
                    footerSection,
                    state.isMobileDetailVisible,
                    state.isEmailDetailVisible,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _getMobileWidgets(
    BuildContext context,
    FooterSection footerSection,
    bool isMobileVisible,
    bool isEmailVisible,
  ) {
    return [
      const _LogoWidget(heightFactor: 10),
      const DSVerticalSpacerWidget(3),
      _ContactWidget(
        footerSection: footerSection,
        isMobileVisible: isMobileVisible,
        isEmailVisible: isEmailVisible,
      ),
      const DSVerticalSpacerWidget(3),
      _AddressWidget(footerSection: footerSection),
      const DSVerticalSpacerWidget(3),
      const _CopyrightTextWidget(),
    ];
  }

  List<Widget> _getTabletWidgets(
    BuildContext context,
    FooterSection footerSection,
    bool isMobileVisible,
    bool isEmailVisible,
  ) {
    return [
      const _LogoWidget(heightFactor: 5),
      const DSVerticalSpacerWidget(3),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobileVisible && isEmailVisible) ...[
            _ContactWidget(
              footerSection: footerSection,
              isMobileVisible: isMobileVisible,
              isEmailVisible: isEmailVisible,
            ),
            const Spacer(),
          ],
          _AddressWidget(footerSection: footerSection),
          const Spacer(flex: 4),
        ],
      ),
      const DSVerticalSpacerWidget(3),
      const _CopyrightTextWidget(),
    ];
  }

  List<Widget> _getDesktopWidgets(
    BuildContext context,
    FooterSection footerSection,
    bool isMobileVisible,
    bool isEmailVisible,
  ) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _LogoWidget(heightFactor: 5),
          const Spacer(),
          if (isMobileVisible && isEmailVisible) ...[
            _ContactWidget(
              footerSection: footerSection,
              isMobileVisible: isMobileVisible,
              isEmailVisible: isEmailVisible,
            ),
            const Spacer(),
          ],
          _AddressWidget(footerSection: footerSection),
          const Spacer(flex: 3),
        ],
      ),
      const Align(
        alignment: Alignment.bottomRight,
        child: _CopyrightTextWidget(),
      ),
    ];
  }
}

class _CopyrightTextWidget extends StatelessWidget {
  const _CopyrightTextWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DSTextWidget(
          '©${DateTime.now().year} ${context.localizations.companyName}',
          color: context.colorPalette.neutral.grey3,
          style: context.typography.labelSmall,
        ),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (_, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Padding(
                padding: EdgeInsets.only(left: context.space(factor: 0.25)),
                child: DSTextWidget(
                  '[v${snapshot.data!.version}]',
                  color: context.colorPalette.neutral.grey3,
                  style: context.typography.labelSmall,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _ContactWidget extends StatelessWidget {
  const _ContactWidget({
    required this.footerSection,
    required this.isEmailVisible,
    required this.isMobileVisible,
  });

  final FooterSection footerSection;
  final bool isEmailVisible;
  final bool isMobileVisible;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isEmailVisible) ...[
          DSIconTitleTileWidget(
            text: footerSection.email,
            icon: Icons.email,
          ),
          const DSVerticalSpacerWidget(2),
        ],
        if (isMobileVisible) ...[
          DSIconTitleTileWidget(
            text: footerSection.mobileNumber,
            icon: Icons.phone,
          ),
          const DSVerticalSpacerWidget(2),
        ],
      ],
    );
  }
}

class _AddressWidget extends StatelessWidget {
  const _AddressWidget({
    required this.footerSection,
  });

  final FooterSection footerSection;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: context.space(factor: 0.5),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DSTextWidget(
          context.localizations.footerLocationLabel.toUpperCase(),
          color: context.colorPalette.neutral.grey1,
          style: context.typography.bodyLarge,
          textOverflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        ...footerSection.address.map((address) {
          return DSTextWidget(
            address,
            color: context.colorPalette.neutral.grey2,
            style: context.typography.bodyMedium,
          );
        }),
      ],
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({required this.heightFactor});

  final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return DSSvgImageWidget(
      assetImage: context.isDarkMode
          ? DSSvgAssetImage.logoLight
          : DSSvgAssetImage.logoDark,
      fit: BoxFit.cover,
      height: context.space(factor: heightFactor),
    );
  }
}
