# multi_screen

[![pub package](https://img.shields.io/pub/v/multi_screen.svg)](https://pub.dartlang.org/packages/multi_screen) [![Build Status](https://dev.azure.com/builttoroam/Flutter%20Plugins/_apis/build/status/Multi%20Screen)](https://dev.azure.com/builttoroam/Flutter%20Plugins/_build/latest?definitionId=109)

A Flutter plugin to determine whether the device supports multi screen and whether the app is currently spanned across both screen.

## Usage

```import 'package:multi_screen/multi_screen.dart';```

Determine whether the app is run on a multi screen device

```bool isMultiDevice = await MultiScreen.isMultiScreenDevice;```

Determine whether the app is currently spanned across both screens

```bool isAppSpanned = await MultiScreen.isAppSpanned;```

Subscribing to app spanned across both screen stream

```dart
MultiScreen.isAppSpannedStream().listen(
  (data) => setState(() => _isAppSpannedStream = data)
);
```

Using the MultiScreenScaffold widget

```dart
MultiScreenScaffold(
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
