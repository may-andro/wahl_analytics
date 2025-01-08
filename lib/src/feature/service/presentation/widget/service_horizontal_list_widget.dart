import 'dart:math';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/widget/service_card_widget.dart';

class ServiceHorizontalListWidget extends StatefulWidget {
  const ServiceHorizontalListWidget({
    required this.services,
    super.key,
  });

  final List<ServiceEntity> services;

  @override
  State<ServiceHorizontalListWidget> createState() =>
      _ServiceHorizontalListWidgetState();
}

class _ServiceHorizontalListWidgetState
    extends State<ServiceHorizontalListWidget> {
  @override
  Widget build(BuildContext context) {
    final serviceCount = widget.services.length;
    return LayoutBuilder(
      builder: (context, constraint) {
        final width = constraint.maxWidth;
        int maxServiceCount = min(3, serviceCount);
        switch (width) {
          case > 1100 && < 1400:
            maxServiceCount = min(4, serviceCount);
          case >= 1400 && < 1900:
            maxServiceCount = min(5, serviceCount);
          case >= 1900 && < 2200:
            maxServiceCount = min(6, serviceCount);
          case >= 2200:
            maxServiceCount = serviceCount;
          default:
            maxServiceCount = min(3, serviceCount);
        }

        return Wrap(
          runSpacing: context.space(),
          spacing: context.space(),
          children: widget.services.sublist(0, maxServiceCount).map(
            (service) {
              return SizedBox(
                width: min(
                  width / maxServiceCount - context.space(),
                  context.space(factor: 20),
                ),
                height: context.space(factor: 22.5),
                child: ServiceCardWidget(service: service),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
