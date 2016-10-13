#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

#import <Filestack/Filestack.h>
#import <FSPicker/FSPicker.h>

@interface FilePickerIO : CDVPlugin <FSPickerDelegate>

@property(strong) NSString* callbackId;

- (void)setKey:(CDVInvokedUrlCommand*)command;

- (void)setName:(CDVInvokedUrlCommand*)command;

- (void)pick:(CDVInvokedUrlCommand*)command;

- (void)pickAndStore:(CDVInvokedUrlCommand*)command;

@end