import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook/main.directories.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() {
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
        return Scaffold(body: child);
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
