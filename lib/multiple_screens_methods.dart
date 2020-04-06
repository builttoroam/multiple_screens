import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:multiple_screens/models/hinge.dart';

/// The entry point for accessing multiple screens methods
class MultipleScreensMethods {
  static const MethodChannel _methodChannel =
      const MethodChannel('plugins.builttoroam.com/multiple_screens/methods');
  static const EventChannel _eventChannel =
      const EventChannel('plugins.builttoroam.com/multiple_screens/events');

  /// Returns whether the device supports multi screen
  static Future<bool> get isMultipleScreensDevice async =>
      await _methodChannel.invokeMethod('isMultipleScreensDevice');

  /// Returns whether the app is spanned across both screens
  static Future<bool> get isAppSpanned async =>
      await _methodChannel.invokeMethod('isAppSpanned');

  /// Provides a stream for whether the app is spanned across both screens
  static Stream<bool> isAppSpannedStream() async* {
    yield* _eventChannel
        .receiveBroadcastStream()
        .map<bool>((dynamic result) => result);
  }

  static Future<Hinge> get getHinge async {
    var hingeJson = await _methodChannel.invokeMethod('getHinge');
    var hinge = Hinge.fromJson(json.decode(hingeJson));
    return hinge;
  }
}
