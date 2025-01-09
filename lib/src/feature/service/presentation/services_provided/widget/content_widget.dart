import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_provided/widget/widget.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    required this.services,
    super.key,
  });

  final List<ServiceEntity> services;

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
              SliverToBoxAdapter(
                child: Container(
                  color: context.colorPalette.background.primary.color,
                  padding:
                      EdgeInsets.symmetric(vertical: context.space(factor: 5)),
                  child: const IntoWidget(),
                ),
              ),
              SliverList.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return DSTextWidget(
                    services[index].title,
                    color: context.colorPalette.neutral.grey7,
                    style: context.typography.bodyLarge,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
