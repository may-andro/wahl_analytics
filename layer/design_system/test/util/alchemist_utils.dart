import 'package:alchemist/alchemist.dart';
import 'package:design_system/src/design_system/design_system.dart';
import 'package:design_system/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recase/recase.dart';

/// A [TestCase] holds the description of the test, and the widget to be
/// rendered.
class TestCase {
  const TestCase(this.description, this.widget);

  final String description;
  final Widget widget;
}

/// This testing utility function renders a list of [testCases] in a golden file
///
/// The [widgetUnderTest] is used for generating the correct file names and
/// test descriptions for all brightness levels.
///
/// The [label] is an optional text that, if provided, will be rendered onto the
/// golden images (below the title) and will be part of the golden files' name.
void groupGoldenForBrightnessAndDS(
  String widgetUnderTest,
  List<TestCase> Function(DSTheme theme) testCasesCallback, {
  String? label,
}) {
  for (final brightness in Brightness.values) {
    for (final designSystem in DesignSystem.values) {
      final dsTheme = DSTheme(
        brightness: brightness,
        designSystem: designSystem,
      );
      final testCases = testCasesCallback(dsTheme);
      groupGolden(
        widgetUnderTest,
        brightness,
        designSystem,
        testCases,
        label: label,
      );
    }
  }
}

/// This testing utility function renders a list of [testCases] in a golden file
///
/// The [widgetUnderTest] is used for generating the correct file names and
/// test descriptions.
///
/// The [label] is an optional text that, if provided, will be rendered onto the
/// golden images (below the title) and will be part of the golden files' name.
void groupGolden(
  String widgetUnderTest,
  Brightness brightness,
  DesignSystem designSystem,
  List<TestCase> testCases, {
  String? label,
}) {
  group(widgetUnderTest, () {
    goldenTest(
      'on $brightness with $designSystem',
      fileName:
          '${widgetUnderTest.snakeCase}_'
          '${label == null ? '' : '${label.snakeCase.replaceAll(' ', '')}_'}'
          '${brightness.title.toLowerCase().snakeCase..replaceAll(' ', '')}',
      pumpBeforeTest: precacheImages,
      builder: () => GoldenTestGroup(
        scenarioConstraints: const BoxConstraints(maxWidth: 600),
        children: testCases.map((testCase) {
          return _TestCaseWidget(
            testCase,
            designSystem: designSystem,
            brightness: brightness,
          );
        }).toList(),
      ),
    );
  });
}

/// The test case widget that renders the test description and the
/// widget under test.
class _TestCaseWidget extends StatelessWidget {
  const _TestCaseWidget(
    this.testCase, {
    required this.brightness,
    required this.designSystem,
  });

  final TestCase testCase;
  final Brightness brightness;
  final DesignSystem designSystem;

  @override
  Widget build(BuildContext context) {
    return GoldenTestScenario(
      name: testCase.description,
      child: DSThemeBuilderWidget(
        brightness: brightness,
        designSystem: designSystem,
        child: testCase.widget,
      ),
    );
  }
}

extension on Brightness {
  String get title {
    switch (this) {
      case Brightness.dark:
        return 'Dark Mode';
      case Brightness.light:
        return 'Light Mode';
    }
  }
}
