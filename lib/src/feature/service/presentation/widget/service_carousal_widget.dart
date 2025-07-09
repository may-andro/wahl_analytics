import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/widget/service_card_widget.dart';

class ServiceCarousalWidget extends StatelessWidget {
  ServiceCarousalWidget({
    required this.services,
    super.key,
  });

  final List<ServiceEntity> services;
  final ValueNotifier<int> _snappedItemIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return DSFadeSlideVisibilityContainerWidget(
      uniqueId: 'service_carousal_${services.length}',
      child: Column(
        children: [
          DSCarousalWidget(
            height: context.space(factor: 44),
            autoPlay: true,
            enableInfiniteScroll: true,
            onPageChanged: (index, _) {
              _snappedItemIndex.value = index;
            },
            children: services.map(
              (service) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.space(factor: 3),
                    horizontal: context.space(factor: 5),
                  ),
                  child: ServiceCardWidget(service: service),
                );
              },
            ).toList(),
          ),
          DSPositionIndicatorWidget(
            itemCount: services.length,
            indexListener: _snappedItemIndex,
          ),
        ],
      ),
    );
  }
}
