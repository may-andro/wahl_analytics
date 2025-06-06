import 'package:core/core.dart';
import 'package:dependency_injection/dependency_injection.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wahl_analytics/src/dependency_injection/app_module_configurator.dart';
import 'package:wahl_analytics/src/feature/locale/locale.dart';
import 'package:wahl_analytics/src/feature/splash/bloc/bloc.dart';
import 'package:wahl_analytics/src/feature/splash/widget/widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    required this.buildConfig,
    required this.moduleConfigurators,
    required this.onInitializationSuccessful,
    super.key,
  });

  final BuildConfig buildConfig;
  final List<ModuleConfigurator> moduleConfigurators;
  final void Function(DesignSystem, AppLocale) onInitializationSuccessful;

  @override
  Widget build(BuildContext context) {
    final isDescriptive = buildConfig.buildEnvironment.isSplashDescriptive;
    return BlocProvider(
      create: (_) => SplashBloc(
        DIController(),
        moduleConfigurators,
      )..add(StartSetUp()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              switch (state) {
                case SetUpCompeted():
                  {
                    onSetComplete(state.designSystem);
                    return const SizedBox.shrink();
                  }
                case SetUpError():
                  {
                    return Stack(
                      children: [
                        const Center(child: SplashIconWidget()),
                        Positioned(
                          bottom: 24,
                          left: 0,
                          right: 0,
                          child: SplashErrorWidget(state.cause),
                        ),
                      ],
                    );
                  }
                case SetUpProgress():
                  {
                    return Stack(
                      children: [
                        const Center(child: SplashIconWidget()),
                        Positioned(
                          bottom: 24,
                          left: 0,
                          right: 0,
                          child: SplashInfoWidget(
                            state.setUpStatus,
                            isEnabled: isDescriptive,
                          ),
                        ),
                        Positioned(
                          bottom: 24,
                          left: 0,
                          right: 0,
                          child: SplashMessageWidget(
                            state.progress,
                            isEnabled: !isDescriptive,
                          ),
                        ),
                      ],
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> onSetComplete(DesignSystem designSystem) async {
    AppLocale appLocale = appServiceLocator.get<AppLocale>();
    final cachedAppLocaleEither =
        await appServiceLocator.get<GetCachedAppLocaleUseCase>().call();
    if (cachedAppLocaleEither.isRight) {
      appLocale = cachedAppLocaleEither.right;
    }

    await appServiceLocator.unregister<AppLocale>();
    appServiceLocator.registerSingleton<AppLocale>(() => appLocale);

    onInitializationSuccessful(designSystem, appLocale);
  }
}
