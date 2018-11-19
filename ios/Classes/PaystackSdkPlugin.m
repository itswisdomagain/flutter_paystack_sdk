#import "PaystackSdkPlugin.h"
#import <paystack_sdk/paystack_sdk-Swift.h>

@implementation PaystackSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPaystackSdkPlugin registerWithRegistrar:registrar];
}
@end
