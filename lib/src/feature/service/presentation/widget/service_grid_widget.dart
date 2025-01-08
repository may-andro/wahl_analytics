import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/widget/service_card_widget.dart';

class ServiceGridWidget extends StatelessWidget {
  const ServiceGridWidget({
    required this.services,
    super.key,
  });

  final List<ServiceEntity> services;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: context.width / context.space(factor: 60),
      crossAxisSpacing: context.space(),
      mainAxisSpacing: context.space(),
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      children: services
          .sublist(0, 4)
          .map((service) => ServiceCardWidget(service: service))
          .toList(),
    );
  }
}
