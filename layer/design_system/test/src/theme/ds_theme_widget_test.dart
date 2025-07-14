import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../util/test_wrapper_widget.dart';

class _TestWidget extends StatelessWidget {
  const _TestWidget();

  @override
  Widget build(BuildContext context) {
    final color = context.theme.colorPalette.brand.primary.color;
    return Text('Find me', style: TextStyle(color: color));
  }
}

void main() {
  group(DSThemeBuilderWidget, () {
    testWidgets('should able to access $DSTheme via $DSThemeBuilderWidget', (
      WidgetTester tester,
    ) async {
      const testWidget = TestWidgetWrapper(
        brightness: Brightness.light,
        designSystem: DesignSystem.primary,
        child: _TestWidget(),
      );

      await tester.pumpWidget(testWidget);
      await tester.pump();

      final finder = find.textContaining('Find me');
      final Text widget = tester.widget(finder);
      expect(widget.style?.color, isNotNull);
      expect(widget.style?.color, const DSColor(0xFF990B2C).color);
    });
  });
}
