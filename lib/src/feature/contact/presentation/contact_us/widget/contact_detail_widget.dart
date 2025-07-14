import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/l10n/l10n.dart';
import 'package:wahl_analytics/src/feature/contact/presentation/contact_us/bloc/bloc.dart';

class ContactDetailWidget extends StatelessWidget {
  const ContactDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsBloc, ContactUsState>(
      builder: (context, state) {
        final businessContact = state.businessContact;
        if (businessContact == null) return const SizedBox.shrink();

        return SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.space(factor: 5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DSVerticalSpacerWidget(5),
                  DSTextWidget(
                    context.localizations.contactUs.toUpperCase(),
                    color: context.colorPalette.neutral.grey3,
                    style: context.typography.headlineMedium,
                  ),
                  const DSVerticalSpacerWidget(3),
                  FutureBuilder(
                    future: context.read<ContactUsBloc>().isMobileDetailVisible,
                    builder: (_, snapshot) {
                      if (snapshot.hasData && snapshot.data == true) {
                        return Column(
                          children: [
                            _ContactIconTextWidget(
                              icon: Icons.phone,
                              text: context.localizations.callUs,
                            ),
                            const DSVerticalSpacerWidget(0.5),
                            DSTextWidget(
                              businessContact.mobileNumber,
                              color: context.colorPalette.neutral.grey3,
                              style: context.typography.labelLarge,
                            ),
                            const DSVerticalSpacerWidget(3),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  _ContactIconTextWidget(
                    icon: Icons.location_pin,
                    text: context.localizations.location,
                  ),
                  const DSVerticalSpacerWidget(0.5),
                  ...businessContact.address.map(
                    (address) => DSTextWidget(
                      address,
                      color: context.colorPalette.neutral.grey3,
                      style: context.typography.labelLarge,
                    ),
                  ),
                  const DSVerticalSpacerWidget(3),
                  _ContactIconTextWidget(
                    icon: Icons.access_time_filled_rounded,
                    text: context.localizations.businessHoursLabel,
                  ),
                  const DSVerticalSpacerWidget(0.5),
                  DSTextWidget(
                    context.localizations.businessHours,
                    color: context.colorPalette.neutral.grey3,
                    style: context.typography.labelLarge,
                  ),
                  const DSVerticalSpacerWidget(5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ContactIconTextWidget extends StatelessWidget {
  const _ContactIconTextWidget({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DSIconTitleTileWidget(
      icon: icon,
      text: text,
      textColor: context.colorPalette.neutral.grey1,
      style: context.typography.titleMedium,
      iconSize: context.space(factor: 3),
    );
  }
}
