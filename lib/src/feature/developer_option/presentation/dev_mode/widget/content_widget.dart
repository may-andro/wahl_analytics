import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/route/route.dart';
import 'package:wahl_analytics/src/feature/service/service.dart';
import 'package:wahl_analytics/src/route/route.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollBehavior: ScrollConfiguration.of(context).copyWith(
        scrollbars: false,
      ),
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: ListTile(
            title: DSTextWidget(
              'Open widget book',
              color: context.colorPalette.neutral.grey9,
              style: context.typography.titleSmall,
            ),
            subtitle: DSTextWidget(
              'https://storybook.wahlanalytics.es/',
              color: context.colorPalette.neutral.grey7,
              style: context.typography.bodySmall,
            ),
          ),
        ),
        if (!kIsWeb) ...[
          SliverToBoxAdapter(
            child: _buildItemWidget(
              context: context,
              title: 'Open Feature Flag',
              subtitle:
                  'You can play around with FF to verify various features in the app',
              onTap: () {
                context.push(DeveloperOptionModuleRoute.featureFlag.path);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: _buildItemWidget(
              context: context,
              title: 'Cache playground',
              subtitle:
                  'Playground to verify the the functionality for cache in the system',
              onTap: () {
                context.push(DeveloperOptionModuleRoute.cachePlayground.path);
              },
            ),
          ),
        ],
        SliverToBoxAdapter(
          child: _buildItemWidget(
            title: 'Update Services',
            subtitle:
                'Update the data visible in the service section of the app',
            onTap: () {
              context.push(ServiceModuleRoute.servicesUpdate.path);
            },
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _buildItemWidget({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return ListTile(
      title: DSTextWidget(
        title,
        color: context.colorPalette.neutral.grey9,
        style: context.typography.titleSmall,
      ),
      subtitle: DSTextWidget(
        subtitle,
        color: context.colorPalette.neutral.grey7,
        style: context.typography.bodySmall,
      ),
      onTap: onTap,
    );
  }
}
