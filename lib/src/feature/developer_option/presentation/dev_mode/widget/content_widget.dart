import 'package:design_system/design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/route/route.dart';
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
            child: ListTile(
              title: DSTextWidget(
                'Open Feature Flag',
                color: context.colorPalette.neutral.grey9,
                style: context.typography.titleSmall,
              ),
              subtitle: DSTextWidget(
                'You can play around with FF to verify various features in the app',
                color: context.colorPalette.neutral.grey7,
                style: context.typography.bodySmall,
              ),
              onTap: () {
                context.push(DeveloperOptionModuleRoute.featureFlag.path);
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              title: DSTextWidget(
                'Cache playground',
                color: context.colorPalette.neutral.grey7,
                style: context.typography.titleSmall,
              ),
              subtitle: DSTextWidget(
                'Playground to verify the the functionality for cache in the system',
                color: context.colorPalette.neutral.grey7,
                style: context.typography.bodySmall,
              ),
              onTap: () {
                context.push(DeveloperOptionModuleRoute.cachePlayground.path);
              },
            ),
          ),
        ],
        SliverToBoxAdapter(
          child: ListTile(
            title: DSTextWidget(
              'Update Clients',
              color: context.colorPalette.neutral.grey7,
              style: context.typography.titleSmall,
            ),
            subtitle: DSTextWidget(
              'Update the data visible in the client section of the app',
              color: context.colorPalette.neutral.grey7,
              style: context.typography.bodySmall,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListTile(
            title: DSTextWidget(
              'Update Services',
              color: context.colorPalette.neutral.grey7,
              style: context.typography.titleSmall,
            ),
            subtitle: DSTextWidget(
              'Update the data visible in the service section of the app',
              color: context.colorPalette.neutral.grey7,
              style: context.typography.bodySmall,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ListTile(
            title: DSTextWidget(
              'Update Teams',
              color: context.colorPalette.neutral.grey7,
              style: context.typography.titleSmall,
            ),
            subtitle: DSTextWidget(
              'Update the data visible in the team section of the app',
              color: context.colorPalette.neutral.grey7,
              style: context.typography.bodySmall,
            ),
          ),
        ),
      ],
    );
  }
}
