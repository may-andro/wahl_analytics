import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:tracking/tracking.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/tracking_log/bloc/bloc.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingLogBloc, TrackingLogState>(
      builder: (context, state) {
        final trackingLogs = state.trackingLogs;
        if (trackingLogs == null || trackingLogs.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(context.space()),
              child: DSTextWidget(
                'No event found!',
                color: context.colorPalette.neutral.grey7,
                style: context.typography.bodyLarge,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: trackingLogs.length,
          itemBuilder: (context, index) {
            final tracking = trackingLogs.values.toList()[index];
            return ListTile(
              style: ListTileStyle.drawer,
              title: DSTextWidget(
                trackingLogs.keys.toList()[index].toFormattedDateTime,
                color: context.colorPalette.neutral.grey9,
                style: context.typography.bodySmall,
              ),
              subtitle: DSTextWidget(
                tracking.parameters.toString(),
                color: context.colorPalette.neutral.grey7,
                style: context.typography.bodyLarge,
              ),
              trailing: Icon(tracking.icon, color: tracking.color),
            );
          },
        );
      },
    );
  }
}

extension on Tracking {
  IconData get icon {
    switch (this) {
      case ViewTracking():
        return Icons.view_column;
      case ScreenViewTracking():
        return Icons.view_comfortable_rounded;
      case ClickTracking():
        return Icons.ads_click_rounded;
      case AppStartTracking():
        return Icons.start;
      case AppInitializationFinishedTracking():
        return Icons.done_all;
      default:
        return Icons.event;
    }
  }

  Color get color {
    switch (this) {
      case ViewTracking():
        return Colors.blueGrey;
      case ScreenViewTracking():
        return Colors.blue;
      case ClickTracking():
        return Colors.red;
      case AppStartTracking():
        return Colors.green;
      case AppInitializationFinishedTracking():
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }
}
