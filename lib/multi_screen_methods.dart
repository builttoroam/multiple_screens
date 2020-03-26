import 'dart:async';

import 'package:flutter/services.dart';

/// The entry point for accessing multi screen methods
class MultiScreenMethods {
  static const MethodChannel _methodChannel =
      const MethodChannel('plugins.builttoroam.com/multi_screen/methods');
  static const EventChannel _eventChannel =
      const EventChannel('plugins.builttoroam.com/multi_screen/events');

  /// Returns whether the device supports multi screen
  static Future<bool> get isMultiScreenDevice async =>
      await _methodChannel.invokeMethod('isMultiScreenDevice');

  /// Returns whether the app is spanned across both screens
  static Future<bool> get isAppSpanned async =>
      await _methodChannel.invokeMethod('isAppSpanned');

  /// Provides a stream for whether the app is spanned across both screens
  static Stream<bool> isAppSpannedStream() async* {
    yield* _eventChannel
        .receiveBroadcastStream()
        .map<bool>((dynamic result) => result);
  }
}
