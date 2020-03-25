import 'dart:async';

import 'package:flutter/services.dart';

/// The entry point for accessing dual screen methods
class DualScreenMethods {
  static const MethodChannel _methodChannel =
      const MethodChannel('plugins.builttoroam.com/dual_screen/methods');
  static const EventChannel _eventChannel =
      const EventChannel('plugins.builttoroam.com/dual_screen/events');

  /// Returns whether the device supports dual screen
  static Future<bool> get isDualScreenDevice async =>
      await _methodChannel.invokeMethod('isDualScreenDevice');

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
