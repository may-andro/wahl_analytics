## Table of Contents

- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Adding Components](#adding-components)
- [Hosting](#hosting)

## Getting Started

Storybook is a web app which is used to showcase the different components defined in the design
system.

This project has following purpose:

1. Catalog the foundations of the design system.
2. Catalog all the components of the design system.
3. Show case different behaviours and configuration of a components.

The project is based on the flutter package [widgetbook](https://pub.dev/packages/widgetbook).
The `widgetbook_generator` mode is used for the development which uses `build_runner` package to
generate the necessary code.
For further information please refer to the [doc](https://docs.widgetbook.io/getting-started/setup).

## Project Structure

```
lib/
├ main.dart
├ src
    ├ component
        ├ atom
        ├ molecule
        ├ organism
    ├ foundation
    ├ model
    ├ widget
```

## Adding Components

1. Add the new component in the corresponding `atoms`, `molecules` and `compounds` folder.
2. Add the `@widgetbook.UseCase` to add the entry in the storybook. For more info
   refer [here](https://docs.widgetbook.io/getting-started/components).
   Here is an example:
   ```dart
    @widgetbook.UseCase(name: 'Your Widget', type: YourWidget) {
        YourWidget yourWidget(BuildContext context) {
            return const YourWidget();
        }
   
        class YourWidget extends StatelessWidget {
            @override
            Widget build(BuildContext context) {
                // Your widget under test
            }
        }
    }  
   ```
3. Once done, use the `melos` command `gen` to generate the code.
4. Run the `storybook` in chrome using `flutter run`.

## Hosting

The `Storybook` is hosted using `Firebase`. It is available at [Storybook](https://storybook.wahlanalytics.es/).

The new version can be manually hosted using the `melos` command: `host_storybook`. It is not recommended as version is maintained in CI pipeline.

### CI Hosting

The `storybook_release.yaml` workflow is used to generate production builds of the application and deploy them to Firebase for hosting.

The `storybook_release_preview.yaml` workflow triggers a preview deployment when changes are made to the Storybook or design system layers. 
The preview website is available for a limited time, typically a few hours, and is intended for testing purposes only.

### Release Workflow
Release workflows are responsible for building, creating, and deploying artifacts to their respective destinations.

Follow these steps to create a release:

1. Navigate to the Releases section on GitHub and click `Draft a new release`.
2. Choose the appropriate build number and update the version code.
3. To create a production build for release, append the `-storybook-prod` keyword at the end of the version tag. For example: `1.1.0+2025xx-storybook-prod`.