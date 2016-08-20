#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <FPPicker/FPPicker.h>

@interface FilePickerIO : CDVPlugin <MFMessageComposeViewControllerDelegate>

@property(strong) NSString* callbackID;

- (void)setKey:(CDVInvokedUrlCommand*)command;

@end