import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/client/domain/domain.dart';

class ClientGridWidget extends StatelessWidget {
  const ClientGridWidget({super.key, required this.clients});

  final List<ClientEntity> clients;

  @override
  Widget build(BuildContext context) {
    return DSFadeSlideVisibilityContainerWidget(
      uniqueId: 'clients_grid_${clients.length}',
      child: DSMasonStaggeredGridWidget(
        crossAxisCount: context.crossAxisCount,
        itemCount: clients.length,
        crossAxisSpacing: context.space(),
        mainAxisSpacing: context.space(),
        itemBuilder: (_, index) {
          return _ClientCardWidget(client: clients[index]);
        },
      ),
    );
  }
}

class _ClientCardWidget extends StatelessWidget {
  const _ClientCardWidget({required this.client});

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    return DSAnimatedHoverIndicator(
      onHoverChange: (bool isHovering) {},
      builder: (BuildContext context, bool isHovering) {
        return DsCardWidget(
          backgroundColor: context.colorPalette.neutral.white,
          shadowColor: context.colorPalette.neutral.black,
          elevation: isHovering
              ? context.dimen.elevationLevel3
              : context.dimen.elevationLevel1,
          radius: context.dimen.radiusLevel1,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: EdgeInsets.all(context.space()),
            child: DSNetworkImageWidget(
              url: client.url,
              autoSizeImage: true,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}

extension _BuildContextExtension on BuildContext {
  int get crossAxisCount {
    switch (deviceWidth) {
      case DSDeviceWidthResolution.xs:
        return 4;
      case DSDeviceWidthResolution.s:
        return 5;
      case DSDeviceWidthResolution.m:
        return 6;
      case DSDeviceWidthResolution.l:
        return 7;
      case DSDeviceWidthResolution.xl:
        return 8;
    }
  }
}
