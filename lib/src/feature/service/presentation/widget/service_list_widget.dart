import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/widget/service_card_widget.dart';

class ServiceListWidget extends StatelessWidget {
  const ServiceListWidget({super.key, required this.services});

  final List<ServiceEntity> services;

  @override
  Widget build(BuildContext context) {
    return DSMasonStaggeredGridWidget(
      crossAxisCount: 1,
      itemCount: services.length,
      mainAxisSpacing: context.space(),
      crossAxisSpacing: context.space(),
      itemBuilder: (_, index) {
        return SizedBox(
          height: context.space(factor: 12.5),
          child: ServiceCardWidget(
            service: services[index],
            isContentHorizontallyAligned: true,
          ),
        );
      },
    );
  }
}
