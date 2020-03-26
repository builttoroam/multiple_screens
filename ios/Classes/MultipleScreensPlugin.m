#import "MultipleScreensPlugin.h"
#if __has_include(<multiple_screens/multiple_screens-Swift.h>)
#import <multiple_screens/multiple_screens-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "multiple_screens-Swift.h"
#endif

@implementation MultipleScreensPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftpleScreensPlugin registerWithRegistrar:registrar];
}
@end
