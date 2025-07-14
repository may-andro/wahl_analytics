import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/service/domain/domain.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/widget/service_delete_widget.dart';
import 'package:wahl_analytics/src/feature/service/presentation/services_update/widget/service_form_widget.dart';

class ServiceListWidget extends StatelessWidget {
  const ServiceListWidget({required this.services, super.key});

  final List<ServiceEntity> services;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: services.length,
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        context.bloc.add(ReorderServicePositionEvent(oldIndex, newIndex));
      },
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        return _ServiceWidget(
          index: index,
          service: services[index],
          key: Key(services[index].title),
        );
      },
    );
  }
}

class _ServiceWidget extends StatelessWidget {
  const _ServiceWidget({required this.service, required this.index, super.key});

  final ServiceEntity service;
  final int index;

  @override
  Widget build(BuildContext context) {
    return DsCardWidget(
      backgroundColor: context.colorPalette.backgroundSecondary.primary,
      surfaceTintColor: context.colorPalette.neutral.transparent,
      elevation: context.dimen.elevationLevel1,
      radius: context.dimen.radiusLevel2,
      margin: EdgeInsets.only(bottom: context.space(factor: 2)),
      child: Padding(
        padding: EdgeInsets.all(context.space(factor: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              service.icon.customIconData,
              color: context.colorPalette.prominent.primary.color,
              size: context.space(
                factor: context.isMobile
                    ? 4
                    : context.isTablet
                    ? 3
                    : 2,
              ),
            ),
            const DSHorizontalSpacerWidget(3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DSTextWidget(
                    service.title.toUpperCase(),
                    color: context.colorPalette.neutral.grey3,
                    style: context.typography.titleMedium,
                    softWrap: true,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  const DSVerticalSpacerWidget(0.5),
                  DSTextWidget(
                    service.shortDescription,
                    color: context.colorPalette.neutral.grey1,
                    style: context.typography.labelMedium,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _EditButtonWidget(service),
                _DeleteButtonWidget(service),
              ],
            ),
            ReorderableDragStartListener(
              index: index,
              child: Icon(
                Icons.drag_handle,
                color: context.colorPalette.backgroundSecondary.onPrimary.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteButtonWidget extends StatelessWidget {
  const _DeleteButtonWidget(this.service);

  final ServiceEntity service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.delete,
          color: context.colorPalette.backgroundSecondary.onPrimary.color,
        ),
      ),
      onTap: () async {
        final isDeleted = await ServiceDeleteWidget.showAsBottomSheet(
          context: context,
          service: service,
        );
        if (isDeleted == true && context.mounted) {
          context.bloc.add(DeleteServiceFormEvent(service));
        }
      },
    );
  }
}

class _EditButtonWidget extends StatelessWidget {
  const _EditButtonWidget(this.service);

  final ServiceEntity service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.edit,
          color: context.colorPalette.backgroundSecondary.onPrimary.color,
        ),
      ),
      onTap: () async {
        final index = context.bloc.state.businessService?.services.indexOf(
          service,
        );

        if (index == null) return;

        final updatedService = await (context.isDesktop
            ? ServiceAddEditWidget.showAsDialog(
                context: context,
                service: service,
              )
            : ServiceAddEditWidget.showAsBottomSheet(
                context: context,
                service: service,
              ));

        if (updatedService != null && context.mounted) {
          context.bloc.add(UpdateServiceFormEvent(updatedService, index));
        }
      },
    );
  }
}
