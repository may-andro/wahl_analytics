# Tracking

A structured and extensible event reporting system for app. This package helps manage analytics events consistently with built-in support for Firebase Analytics, local logging, and composable reporters.

## Table of Contents

- [Getting Started](#getting-started)
- [Usage](#usage)

## Getting Started

1. `Tracking`: Represents a single analytics event. There are some predefined events like `ViewTracking`, `ScreenViewTracking`, `ClickTracking`, `AppStartTracking`, and `AppInitializationFinishedTracking`. Custom events can be created by extending the `Event` class.
2. `TrackingAction`: Encapsulates action metadata for events. There are some predefined actions like `ClickAction`. `ViewAction`, `SetupAction`. Custom EventAction can be created by extending the `EventAction` class.
    ```dart
    @JsonSerializable()
    class PurchaseAction extends TrackingAction {
      const PurchaseAction(this.itemId) : super('purchase');
    
      final String itemId;
    
      @override
      Map<String, dynamic> toJson() => _$PurchaseActionToJson(this);
    }
    ```
3. `TrackingReporter`: The main class for reporting events. It provides methods to report events. Current implementations include `FirebaseTrackingReporter` for Firebase Analytics and `LocalTrackingReporter` for local logging.
   ```dart
    eventReporter.sendTrackingEvent(Tracking(name: 'purchase_made', action: PurchaseAction('item_123')));
   ```
4. `TrackingArea`: Used to represent the screen or module in which the event occurred. `ScreenViewTracking` is used to set the current screen context for events.

## Usage
```yaml
tracking:
  path: layer/tracking
```