## Table of Contents

- [Getting Started](#getting-started)
- [Structure](#structure)
- [State Management](#state-management)
- [Foundations](#foundations)
- [Components](#components)
- [Golden Test](#golden-test)
- [Storybook](#storybook)

## Getting Started

This module exposes the design system which defines the style foundations and components.

Here are some general guidelines for the module.

- [x] All concepts must be abstract. This means, no product related details should be present in the
  component, styles.
- [x] All components and styles must be close for modification.
- [x] All components and styles must start with `DS` prefix.
- [x] All components and styles must have valid tests.

### Add the dependency in `pubspec.yaml`

```yaml
design_system:
  path: layer/design_system
```


## Structure

```
src/
├ components
├ design_systems
├ foundations
    ├ colors
    ├ dimens
    ├ typographies
├ theme
├ extensions
```

## State Management

The module uses flutter's inbuilt InheritedWidget. This ensures that the module is independent of
any third party library.

`DSTheme` is exposed in the widget tree via `DSThemeWidget`.

Here is an example of it's usage:

```dart

final theme = DSTheme(
  brightness: context.platformBrightness,
  designSystem: designSystem,
  textScaleFactor: context.textScaleFactor,
);

final app = MaterialApp(
  title: "WahlAnalytics",
  builder: (context, child) {
    return DSThemeWidget(
      dsTheme: theme,
      child: child ?? const SizedBox.shrink(),
    );
  },
  home: const SizeBox(),
);
```

#### Usage

The `DSTheme` can be accessed via `BuildContext`:

```dart

final DSTheme theme = DSThemeWidget.of(context);
```

or use the extension provided by the library

```dart

final DSTheme theme = context.theme;
```

## Foundations

The design system has defined three foundation styles.

- [Colors](#colors)
- [Typographies](#typographies)
- [Dimens](#dimens)

### Colors

The design system defines color scheme in light and dark modes. Below the main key classes of the
color styles defined in the module.

- [x] `DSColorPalette`: Define the color scheme abstraction for the design system.
- [x] `DSColor`: This object is exposed out of the module and used to protect the color definition
  of the module.
- [x] `BackgroundColorScheme`: This object defines all the `background` colors.
- [x] `BrandColorScheme`: This object defines all the `brand` colors.
- [x] `NeutralColorScheme`: This object defines all the `neutral` colors.
- [x] `SemanticColorScheme`: This object defines all the `semantic` colors.

#### Usage

The colors can be obtained via context.

```dart

final DSColorPalette colorPalette = context.dsTheme.colorPalette;
final DSColor neutral0 = colorPallete.neutral.grey4;
final color = neutral0.color;
```

### Typographies

The module defines text styles which is used across the app. Below the main key classes of the text
styles defined in the module.

- [x] `DSTypography`: Define the text styles abstraction for the design system.
- [x] `DSTextStyle`: This object is exposed out of the module and used to protect the module from
  unknown text styles.

#### Usage

The text styles can be obtained via context.

```dart

final typography = context.typography;
final titleMedium = typography.titleMedium;
final textStyle = titleMedium.textStyle;
```

The text styles defined in the module are decoupled from the color definition.

### Dimens

The module defines some base dimensions which can be used in the app.

#### Usage

The space can be obtained via context.

```dart

final DSDimens dimens = context.dimens;
final DSRadius radius = dimens.radiusLevel1;
final DSElevation elevation = dimens.elevationNone;
final space = context.space(factor: 1.2);
```

## Components

All the components defined in the design system must be present in the module so that we can reuse
them easily.

Here are some guidelines for creating a new component:

- [x] All components must be abstract. This means, no product related details should be present in
  the component.
- [x] All components must be close for modification. A component must not accept entities which are
  foreign to the design system.
- [x] All components must start with `DS` prefix.
- [x] All components must have `Widget` suffix.
- [x] All components must have [Golden Test](#golden-test) to verify it's behaviour.
- [x] All components must be exposed out of the module in `components.dart`.

## Golden Test

`Golden Test` are screen shot tests in flutter. The [alchemist](https://pub.dev/packages/alchemist)
package is used for the purpose.

```
groupGoldenForBrightnessAndDS(
    'Some Name',
    Brightness.light,
    [
      TestCase(
        'Title',
        DSTestWidget(),
      ),
    ],
    label: 'some label',
  );
```

The `groupGoldenForBrightnessAndDS` helper methods to generate the golden test for both brightness
levels and `DesignSystems`. Use `TestCase` to define your test cases for a particular widget.

The file `dart_test.yaml` defines the `golden` tag for the tests. `flutter_test_config.dart` is a
setup file which runs before every golden test.

### To update the screenshots

```
cd layer/design_system && fvm flutter test --tags golden
```

or use the `melos` command

```
melos update_golden_test
```

### To run the test

```
cd layer/design_system && fvm flutter test --tags golden --update-goldens
```

or use the `melos` command

```
melos run_golden_test
```

## Storybook

The components are demonstrated in the `Storybook` project. Visit the storybook from [here](https://storybook.wahlanalytics.es/).