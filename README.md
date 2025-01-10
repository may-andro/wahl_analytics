# wahl_analytics

Dashboard app for Wahl Analytics. Available in `Android`, `IOS` & `Web`

## Table of Contents

- [Getting Started](#getting-started)
- [Run the app](#run-the-app)
- [Architecture](#architecture)
    * [Layer Architecture](#layer-architecture)
    * [Project Architecture](#project-architecture)
    * [State Management](#state-management)
    * [Dependency Injection](#dependency-injection)
    * [Navigation](#navigation)
    * [Design System](#design-system)
    * [Connected Services](#connected-services)
- [CI](#ci)
- [Tools](#tools)

## Getting Started

The project is based on Flutter framework.
[Install](https://flutter.dev/docs/get-started/install) all pre-requisites for Flutter, e.g. Git,
Android Studio, Xcode, emulators and simulators.

### Globally installed packages

#### Melos

[Melos](https://melos.invertase.dev/) is used as a multiple package manager. Please read
more [here](https://melos.invertase.dev/getting-started) to get started and set up.

[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

## Run the app

The project has two versions based on environment:

- `staging`: In this version app runs in staging environment. This is used during development stage.
  Use `melos run_staging` script to run in staging.
- `prod`: In this version app runs in production environment. This is used to release the app in
  different environment and available for user. Use `melos run_prod` script to run in staging.

## Architecture

### Layer Architecture

The project has multiple layers which provides different features needed in the app.

- [Cache](layer/cache/README.md)
- [Core](layer/core/README.md)
- [Dependency Injection](layer/dependency_injection/README.md)
- [Design System](layer/design_system/README.md)
- [Error Reporter](layer/error_reporter/README.md)
- [Feature Flag](layer/feature_flag/README.md)
- [Firebase](layer/firebase/README.md)
- [Log Reporter](layer/log_reporter/README.md)
- [Remote](layer/remote/README.md)
- [UseCase](layer/use_case/README.md)

### Project Architecture

The project follow `SOLID` architecture. The folder are organised in `data`, `domain`,
and `presentation`.

#### Data Layer

This layer consists of `model`, `repository implamentations` and `data source` like `remote`
and `cache`. This layer depends on `domain` layer only. This layer is responsible for fetching data
from various sources.

#### Domain Layer

This layer consists of `entity`, `usecases`. This layer is responsible for business logic.

#### Presentation Layer

This layer consists of `screen`, `widget`, `bloc`, `route` and all view related logic. This layer
depends on `domain` for logic business logic.

#### Feature based folder

Different features are distributed with `SOLID` principles in distinct folder structure. Each folder
exposed only the public functionality and hide internal logics.

### State Management

The project use [Bloc](https://bloclibrary.dev/) package for state management.
Read [here](https://bloclibrary.dev/getting-started/) to get started.

### Dependency Injection

The project use [GetIt](https://pub.dev/packages/get_it) for dependency injection. You can
read [here](layer/dependency_injection/README.md) to get started.

### Navigation

Navigation is the app is handled via [go_router](https://pub.dev/packages/go_router) package.
Refer [here](lib/src/route) for more information.

### Localisation

The project supports `English`, `Spanish` and `Dutch` locale. Refer [here](lib/l10n) for more
information within the project.

### Design System

The project design system is abstracted in [design system](layer/design_system/README.md) package
layer. The design system `foundation` and `components` can be viewed in `Storybook`. Project
is based on `material` design system.

### Connected Services

#### Firebase

The project uses a variety of services Firebase SaaS platform offers. You can
read [here](layer/firebase/README.md) to check all the different services used.

Firebase's `Firestore` acts as source of truth for all the backend data. Mean while `Remote Config`
is used for controlling various features. [Read](layer/feature_flag/README.md) here for more
information regarding the feature
flags.

## CI

TODO

## Tools

The project uses various tools to provide some support work needed in maintenance of project.

### Firestore Content Uploader

This tool is used to upload the json to firestore using command. This is a CLI tools which helps
with maintained of firestore data without editing them manually in web console.

Read [here](tool/firestore_content_uploader/README.md) for more info.

### Storybook

This project showcase the design system used in the main project. It is based on flutter
package [widgetbook](https://pub.dev/packages/widgetbook).

Read [here](tool/storybook/README.md) for more info.

