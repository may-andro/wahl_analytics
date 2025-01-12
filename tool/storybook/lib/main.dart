import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:storybook/assets/assets.gen.dart';
import 'package:storybook/main.directories.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StorybookApp());
}

@widgetbook.App()
class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      appBuilder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              Chip(
                label: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Text('Version: ${snapshot.data!.version}');
                    }
                    return SizedBox.shrink();
                  },
                ),
                labelStyle: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  height: 1.33,
                  letterSpacing: 0.4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              SizedBox(width: 16),
            ],
            title: SvgPicture.asset(
              (context.isDarkMode
                      ? Assets.image.logoDark
                      : Assets.image.logoLight)
                  .path,
              width: 40,
              height: 40,
            ),
          ),
          body: child,
        );
      },
      addons: [
        DeviceFrameAddon(
          devices: [
            ...Devices.ios.all,
            ...Devices.android.all,
          ],
        ),
        TextScaleAddon(
          initialScale: 1,
        ),
        ThemeAddon<_CustomTheme>(
          themes: [
            WidgetbookTheme(
              name: 'Light Theme ',
              data: _CustomTheme(Brightness.light, DesignSystem.primary),
            ),
            WidgetbookTheme(
              name: 'Dark Theme',
              data: _CustomTheme(Brightness.dark, DesignSystem.primary),
            ),
          ],
          themeBuilder: (context, theme, child) {
            return DSThemeBuilderWidget(
              designSystem: theme.designSystem,
              brightness: theme.brightness,
              child: child,
            );
          },
        ),
      ],
    );
  }
}

class _CustomTheme {
  _CustomTheme(this.brightness, this.designSystem);

  final Brightness brightness;
  final DesignSystem designSystem;
}
