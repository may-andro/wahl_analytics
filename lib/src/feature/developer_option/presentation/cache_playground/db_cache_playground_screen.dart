import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/developer_option/domain/domain.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/developer_option/presentation/cache_playground/widget/widget.dart';
import 'package:wahl_analytics/src/route/route.dart';

class DbCachePlaygroundScreen extends StatelessWidget {
  const DbCachePlaygroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return appServiceLocator.get<CachePlaygroundBloc>()..add(OnInitEvent());
      },
      child: BlocBuilder<CachePlaygroundBloc, CachePlaygroundState>(
        builder: (context, state) {
          return RouteObserverWidget(
            onResume: () => context.bloc.add(ScreenVisibleEvent()),
            child: Scaffold(
              backgroundColor: context.colorPalette.background.primary.color,
              body: const ContentWidget(),
              appBar: AppBar(
                backgroundColor: context.colorPalette.background.primary.color,
                surfaceTintColor:
                    context.colorPalette.neutral.transparent.color,
                shadowColor: context.colorPalette.background.onPrimary.color,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: DSTextWidget(
                  'Cache Playground',
                  color: context.colorPalette.neutral.grey9,
                  style: context.typography.titleMedium,
                ),
                titleSpacing: 0,
                leading: context.isDesktop
                    ? null
                    : Padding(
                        padding: EdgeInsets.only(
                          left: context.space(factor: 3),
                        ),
                        child: DSIconButtonWidget(
                          Icons.close,
                          iconColor: context.colorPalette.background.onPrimary,
                          buttonColor: context.colorPalette.background.primary,
                          onPressed: context.pop,
                        ),
                      ),
              ),
              floatingActionButton:
                  BlocBuilder<CachePlaygroundBloc, CachePlaygroundState>(
                    builder: (context, state) {
                      return FloatingActionButton(
                        onPressed: () {
                          showDialog<DummyEntity>(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: DSTextWidget(
                                  'Add entry to data base',
                                  color: context.colorPalette.neutral.grey7,
                                  style: context.typography.titleMedium,
                                ),
                                content: const FormWidget(),
                              );
                            },
                          ).then((dummyEntity) {
                            if (dummyEntity != null && context.mounted) {
                              context.bloc.add(
                                AddCacheDataEvent(dummyEntity: dummyEntity),
                              );
                            }
                          });
                        },
                        child: const Icon(Icons.add),
                      );
                    },
                  ),
            ),
          );
        },
      ),
    );
  }
}
