/********* CordovaPluginIos.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface CordovaPluginIos : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation CordovaPluginIos

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    NSString* echo = [command.arguments objectAtIndex:0];
    if (echo != nil && [echo length] > 0) {
        // Show a toast-like alert
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:echo
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [self.viewController presentViewController:alert animated:YES completion:^{
            // Dismiss the alert after 2 seconds
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];

        // Send success result back to JavaScript
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } else {
        // Send error result back to JavaScript
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Invalid argument"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
