# dual_screen

[![pub package](https://img.shields.io/pub/v/dual_screen.svg)](https://pub.dartlang.org/packages/dual_screen) [![Build Status](https://dev.azure.com/builttoroam/Flutter%20Plugins/_apis/build/status/Dual%20Screen)](https://dev.azure.com/builttoroam/Flutter%20Plugins/_build/latest?definitionId=108)

A Flutter plugin to determine whether the device supports dual screen and whether the app is currently spanned across both screen.

## Usage

```import 'package:dual_screen/dual_screen.dart';```

Determine whether the app is run on a dual screen device

```bool isDualDevice = await DualScreen.isDualScreenDevice;```

Determine whether the app is currently spanned across both screens

```bool isAppSpanned = await DualScreen.isAppSpanned;```

Subscribing to app spanned across both screen stream

```dart
DualScreen.isAppSpannedStream().listen(
  (data) => setState(() => _isAppSpannedStream = data)
);
```

Using the DualScreenScaffold widget

```dart
DualScreenScaffold(
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

## Getting Started

See the example directory for a complete sample app

## Issues and feedback

Please file issues, bugs, or feature requests in our github issue tracker.
