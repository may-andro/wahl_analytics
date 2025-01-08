## Table of Contents

- [Getting Started](#getting-started)
- [Usage](#usage)

## Getting Started

This modules defines all the feature flags used in the app. Here are the list of feature flags:
- `contactUsHomeFab`: Used to control FAB button visibility on the home screen for contact us feature.
- `languageSwitcher`: Used to control the language switching capability in the app.
- `mobileDetailVisibility`: Used to control the mobile details visibility in the app.
- `emailDetailVisibility`: Used to control the email details visibility in the app.
- `serviceDetail`: Used to control service details feature.

Behaviour in different environment:
- `staging`: A local DB is used to cache the values which allows to modify the FF in different session of app. This feature is available only on Mobile for now.
- `prod`: The value is cached in a session cache. 

## Usage

The module exposes various use cases for controlling the storage behaviour of the feature flags:
- `GetFeatureFlagsUseCase`
- `InitFeatureFlagsUseCase`
- `IsFeatureEnabledUseCase`
- `ResetFeatureFlagsUseCase`
- `UpdateFeatureFlagUseCase`

```yaml
use_case:
  path: layers/feature_flag
```