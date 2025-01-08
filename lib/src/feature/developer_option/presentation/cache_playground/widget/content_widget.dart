import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/bloc/bloc.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CachePlaygroundBloc, CachePlaygroundState>(
      builder: (context, state) {
        final dummyLists = state.dummyLists;
        if (dummyLists == null || dummyLists.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(context.space()),
              child: DSTextWidget(
                'No cache found, you can add using the button',
                color: context.colorPalette.neutral.grey7,
                style: context.typography.bodyLarge,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: dummyLists.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: DSTextWidget(
                dummyLists[index].name,
                color: context.colorPalette.neutral.grey9,
                style: context.typography.bodyLarge,
              ),
              subtitle: DSTextWidget(
                'This cache has max life time of 1 min',
                color: context.colorPalette.neutral.grey7,
                style: context.typography.bodySmall,
              ),
              trailing: const Icon(Icons.delete),
              onTap: () {
                context.bloc.add(
                  DeleteCacheDataEvent(dummyEntity: dummyLists[index]),
                );
              },
            );
          },
        );
      },
    );
  }
}
