import 'dart:js' as js;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class MultipleScreensWeb {
  static void registerWith(Registrar registrar) {
    final instance = MultipleScreensWeb();

    final methodChannel = MethodChannel(
        'plugins.builttoroam.com/multiple_screens/methods',
        const StandardMethodCodec(),
        registrar.messenger);
    methodChannel.setMethodCallHandler(instance.handleMethodCall);

    final eventChannel = EventChannel(
        'plugins.builttoroam.com/multiple_screens/events',
        const StandardMethodCodec(),
        registrar.messenger);
    var eventArguments = eventChannel
        .receiveBroadcastStream()
        .map<bool>((dynamic result) => result);
    // TODO: Register event channel
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'isMultipleScreensDevice':
        return isMultipleScreensDevice();
      case 'isAppSpanned':
        return isAppSpanned();
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details:
                "The multiple_screens_web plugin for web doesn't implement "
                "the method '${call.method}'");
    }
  }

  bool isMultipleScreensDevice() {
    // TODO: Need to call window.getWindowSegments() from windowsegments-polyfill.js and return true if the function returns > 2
    js.context.callMethod('alert', ['isMultipleScreensDevice()']);
  }

  bool isAppSpanned() {
    if (isMultipleScreensDevice()) {
      // TODO: Implement isAppSpanned()
      js.context.callMethod('alert', ['isAppSapnned()']);
    }
  }
}
