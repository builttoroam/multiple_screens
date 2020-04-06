# multiple_screens

[![pub package](https://img.shields.io/pub/v/multiple_screens.svg)](https://pub.dartlang.org/packages/multiple_screens) [![Build Status](https://dev.azure.com/builttoroam/Flutter%20Plugins/_apis/build/status/Multiple%20Screens)](https://dev.azure.com/builttoroam/Flutter%20Plugins/_build/latest?definitionId=109)

A Flutter plugin to determine whether the device supports multiple screens and whether the app is currently spanned across both screen.

## Usage

```import 'package:multiple_screens/multiple_screens.dart';```

Determine whether the app is run on a multiple screen device

```bool isMultipleDevice = await MultipleScreensMethods.isMultipleScreensDevice;```

Determine whether the app is currently spanned across both screens

```bool isAppSpanned = await MultipleScreensMethods.isAppSpanned;```

Subscribing to app spanned across both screen stream

```dart
MultipleScreensMethods.isAppSpannedStream().listen(
  (data) => setState(() => _isAppSpannedStream = data)
);
```

Using the MultipleScreensScaffold widget

```dart
MultipleScreensScaffold(
  //Must supply whether the app is spanned
  //This can be the result of the app spanned stream
  appSpanned
  //left and right must be specified without body
  //or body must be specified without left and right
  left
  right
  body
)
```

Get hinge details (angle and accuracy) on a multiple screen device

```Hinge hinge = await MultipleScreensMethods.getHinge;```

## Getting Started

See the example directory for a complete sample app

## Issues and feedback

Please file issues, bugs, or feature requests in our github issue tracker.
