import 'package:flutter_test/flutter_test.dart';

import 'package:storybook/main.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  testWidgets('should render Widgetbook', (WidgetTester tester) async {
    await tester.pumpWidget(const StorybookApp());

    expect(find.byType(Widgetbook), findsOneWidget);
  });
}
