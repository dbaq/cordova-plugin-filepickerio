#import "FilePickerIO.h"
#import <UIKit/UIKit.h>

@implementation FilePickerIO
@synthesize actionCallbackId;
@synthesize keyCallbackId;
@synthesize nameCallbackId;
FSConfig *config;

- (void)setKey:(CDVInvokedUrlCommand*)command {
     if (!config){
         config = [[FSConfig alloc] initWithApiKey:@""];
     }
     self.keyCallbackId = command.callbackId;
     [self.commandDelegate runInBackground:^{
         config.apiKey = [command.arguments objectAtIndex:0];
         CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
         [self.commandDelegate sendPluginResult:result callbackId:self.keyCallbackId];
     }];
}

- (void)setName:(CDVInvokedUrlCommand*)command {
     if (!config){
         config = [[FSConfig alloc] initWithApiKey:@""];
     }
     self.nameCallbackId = command.callbackId;
     [self.commandDelegate runInBackground:^{
         config.title = [command.arguments objectAtIndex:0];
         CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
         [self.commandDelegate sendPluginResult:result callbackId:self.nameCallbackId];
     }];
}

- (void)pick:(CDVInvokedUrlCommand*)command {
    self.actionCallbackId = command.callbackId;
    [self showPicker: command storeOptions:nil];
}

- (void)pickAndStore:(CDVInvokedUrlCommand*)command {
    self.actionCallbackId = command.callbackId;
    FSStoreOptions *storeOptions = [[FSStoreOptions alloc] init];
    storeOptions.location = FSStoreLocationS3;
    if ([[command.arguments objectAtIndex:5] isEqual: @"azure"]) {
        storeOptions.location = FSStoreLocationAzure;
    } else if ([[command.arguments objectAtIndex:5] isEqual: @"dropbox"]) {
        storeOptions.location = FSStoreLocationDropbox;
    } else if ([[command.arguments objectAtIndex:5] isEqual: @"rackspace"]) {
        storeOptions.location = FSStoreLocationRackspace;
    } else if ([[command.arguments objectAtIndex:5] isEqual: @"gcs"]) {
        storeOptions.location = FSStoreLocationGoogleCloud;
    }
    storeOptions.path = [command.arguments objectAtIndex:6];
    storeOptions.container = [command.arguments objectAtIndex:7];
    storeOptions.access = [command.arguments objectAtIndex:8];
    if ([command.arguments objectAtIndex:9] && [command.arguments objectAtIndex:10]) {
        NSDictionary *security = @{
            @"policy" : [command.arguments objectAtIndex:9],
            @"signature" : [command.arguments objectAtIndex:10]
        };
        storeOptions.security = security;
    }
    
    [self showPicker: command storeOptions:storeOptions];
  
}

- (void) showPicker:(CDVInvokedUrlCommand*)command storeOptions:(FSStoreOptions *)storeOptions{
    [self.commandDelegate runInBackground:^{
        // Set allowed mime types, all mime types by default
        config.mimeTypes = [self parseMimeTypes: [command.arguments objectAtIndex:0]];
        // Set services, all services by default
        NSArray *sources = [self parseSources: [command.arguments objectAtIndex:1]];
        if (sources && ![sources isEqual:[NSNull null]]) {
            config.sources = sources;
        }
        // Allowing multiple file selection
        NSString *multiple = [command.arguments objectAtIndex:2];
        if (multiple && ![multiple isEqual:[NSNull null]]) {
            config.selectMultiple = [multiple boolValue];
        }
        // Limiting the maximum number of files that can be uploaded at one time
        NSNumber *maxFiles = [command.arguments objectAtIndex:3];
        if (maxFiles && ![maxFiles isEqual:[NSNull null]]) {
            config.maxFiles = [maxFiles integerValue];
        }
        // Set store options
        if (storeOptions && ![storeOptions isEqual:[NSNull null]]) {
            config.storeOptions = storeOptions;
        }
        FSTheme *theme = [FSTheme filestackTheme];
        dispatch_async(dispatch_get_main_queue(), ^{
          FSPickerController *fsPickerController = [[FSPickerController alloc] initWithConfig:config theme:theme];
          fsPickerController.fsDelegate = self;
          [self.viewController presentViewController:fsPickerController animated:YES completion:nil];
        });
        return;
    }];
}

- (NSArray *)parseMimeTypes:(NSArray*)array {
    NSMutableArray *mimeTypes = [NSMutableArray new];
    if (!array || [array isEqual:[NSNull null]]) {
        [mimeTypes addObject:FSMimeTypeAll];
        return mimeTypes;
    }
    for(int i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex:i] isEqual: @"audio/*"]) {
            [mimeTypes addObject:FSMimeTypeAudioAll];
        } else if ([[array objectAtIndex:i] isEqual: @"video/*"]) {
            [mimeTypes addObject:FSMimeTypeVideoAll];
        } else if ([[array objectAtIndex:i] isEqual: @"video/quicktime"]) {
            [mimeTypes addObject:FSMimeTypeVideoQuickTime];
        } else if ([[array objectAtIndex:i] isEqual: @"image/*"]) {
            [mimeTypes addObject:FSMimeTypeImageAll];
        } else if ([[array objectAtIndex:i] isEqual: @"image/png"]) {
            [mimeTypes addObject:FSMimeTypeImagePNG];
        } else if ([[array objectAtIndex:i] isEqual: @"image/jpeg"]) {
            [mimeTypes addObject:FSMimeTypeImageJPEG];
        } else if ([[array objectAtIndex:i] isEqual: @"image/bmp"]) {
            [mimeTypes addObject:FSMimeTypeImageBMP];
        } else if ([[array objectAtIndex:i] isEqual: @"image/gif"]) {
            [mimeTypes addObject:FSMimeTypeImageGIF];
        } else if ([[array objectAtIndex:i] isEqual: @"image/svg+xml"]) {
            [mimeTypes addObject:FSMimeTypeImageSVG];
        } else if ([[array objectAtIndex:i] isEqual: @"image/tiff"]) {
            [mimeTypes addObject:FSMimeTypeImageTIFF];
        } else if ([[array objectAtIndex:i] isEqual: @"image/vnd.adobe.photoshop"]) {
            [mimeTypes addObject:FSMimeTypeImagePSD];
        } else if ([[array objectAtIndex:i] isEqual: @"application/*"]) {
            [mimeTypes addObject:FSMimeTypeApplicationAll];
        } else if ([[array objectAtIndex:i] isEqual: @"application/pdf"]) {
            [mimeTypes addObject:FSMimeTypeApplicationPDF];
        } else if ([[array objectAtIndex:i] isEqual: @"application/msword"]) {
            [mimeTypes addObject:FSMimeTypeApplicationDOC];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.openxmlformats-officedocument.wordprocessingml.document"]) {
            [mimeTypes addObject:FSMimeTypeApplicationDOCX];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.oasis.opendocument.text"]) {
            [mimeTypes addObject:FSMimeTypeApplicationODT];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.ms-excel"]) {
            [mimeTypes addObject:FSMimeTypeApplicationXLS];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]) {
            [mimeTypes addObject:FSMimeTypeApplicationXLSX];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.oasis.opendocument.spreadsheet"]) {
            [mimeTypes addObject:FSMimeTypeApplicationODS];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.ms-powerpoint"]) {
            [mimeTypes addObject:FSMimeTypeApplicationPPT];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.openxmlformats-officedocument.presentationml.presentation"]) {
            [mimeTypes addObject:FSMimeTypeApplicationPPTX];
        } else if ([[array objectAtIndex:i] isEqual: @"application/vnd.oasis.opendocument.presentation"]) {
            [mimeTypes addObject:FSMimeTypeApplicationODP];
        } else if ([[array objectAtIndex:i] isEqual: @"application/illustrator"]) {
            [mimeTypes addObject:FSMimeTypeApplicationAI];
        } else if ([[array objectAtIndex:i] isEqual: @"application/json"]) {
            [mimeTypes addObject:FSMimeTypeApplicationJSON];
        } else if ([[array objectAtIndex:i] isEqual: @"text/*"]) {
            [mimeTypes addObject:FSMimeTypeTextAll];
        } else if ([[array objectAtIndex:i] isEqual: @"text/html"]) {
           [mimeTypes addObject:FSMimeTypeTextHTML];
        } else if ([[array objectAtIndex:i] isEqual: @"text/plain; charset=UTF-8"]) {
           [mimeTypes addObject:FSMimeTypeTextPlain];
        }
    }
    return mimeTypes;
}
                   
- (NSArray *)parseSources:(NSArray*)array {
     if (!array || [array isEqual:[NSNull null]]) {
         return nil;
     }
     NSMutableArray *sources = [NSMutableArray new];
     for(int i = 0; i < [array count]; i++) {
         if ([[array objectAtIndex:i] isEqual: @"GALLERY"]) {
             [sources addObject:FSSourceCameraRoll];
         }
         else if ([[array objectAtIndex:i] isEqual: @"CAMERA"]) {
             [sources addObject:FSSourceCamera];
         }
         else if ([[array objectAtIndex:i] isEqual: @"FACEBOOK"]) {
             [sources addObject:FSSourceFacebook];
         }
         else if ([[array objectAtIndex:i] isEqual: @"CLOUDDRIVE"]) {
             [sources addObject:FSSourceCloudDrive];
         }
         else if ([[array objectAtIndex:i] isEqual: @"DROPBOX"]) {
             [sources addObject:FSSourceDropbox];
         }
         else if ([[array objectAtIndex:i] isEqual: @"BOX"]) {
             [sources addObject:FSSourceBox];
         }
         else if ([[array objectAtIndex:i] isEqual: @"GMAIL"]) {
             [sources addObject:FSSourceGmail];
         }
         else if ([[array objectAtIndex:i] isEqual: @"INSTAGRAM"]) {
             [sources addObject:FSSourceInstagram];
         }
         else if ([[array objectAtIndex:i] isEqual: @"FLICKR"]) {
             [sources addObject:FSSourceFlickr];
         }
         else if ([[array objectAtIndex:i] isEqual: @"PICASA"]) {
             [sources addObject:FSSourcePicasa];
         }
         else if ([[array objectAtIndex:i] isEqual: @"GITHUB"]) {
             [sources addObject:FSSourceGithub];
         }
         else if ([[array objectAtIndex:i] isEqual: @"GOOGLE_DRIVE"]) {
             [sources addObject:FSSourceGoogleDrive];
         }
         else if ([[array objectAtIndex:i] isEqual: @"EVERNOTE"]) {
             [sources addObject:FSSourceEvernote];
         }
         else if ([[array objectAtIndex:i] isEqual: @"SKYDRIVE"]) {
             [sources addObject:FSSourceSkydrive];
         }
     }
     return sources;
}
 

 #pragma mark - FSPickerDelegate Methods

- (void)fsPicker:(FSPickerController *)picker didFinishPickingMediaWithBlobs:(NSArray<FSBlob *> *)blobs {
    NSLog(@"FILES CHOSEN: %@", blobs);
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    if (blobs.count == 0) {
        NSLog(@"Nothing was picked.");
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"cancelled"] callbackId:self.actionCallbackId];
        return;
    }
    
    NSMutableArray* files = [[NSMutableArray alloc] init];
    for (FSBlob *info in blobs) {
        NSMutableDictionary* file = [NSMutableDictionary dictionaryWithCapacity:7];
        [file setObject: (!info.container || [info.container isEqual:[NSNull null]] ? [NSNull null]: info.container) forKey:@"container"];
        [file setObject: (!info.url || [info.url isEqual:[NSNull null]] ? [NSNull null]: info.url) forKey:@"url"];
        [file setObject: (!info.fileName || [info.fileName isEqual:[NSNull null]] ? [NSNull null]: info.fileName) forKey:@"filename"];
        [file setObject: (!info.key || [info.key isEqual:[NSNull null]] ? [NSNull null]: info.key) forKey:@"key"];
        [file setObject: (!info.mimeType || [info.mimeType isEqual:[NSNull null]] ? [NSNull null]: info.mimeType) forKey:@"mimetype"];
        [file setObject: [NSNull null] forKey:@"localPath"];
        [file setObject: [NSNumber numberWithInteger:info.size] forKey:@"size"];
        
        [files addObject:file];
    }
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:files] callbackId:self.actionCallbackId];
}

 - (void)fsPickerDidCancel:(FSPickerController *)picker {
     NSLog(@"FilePicker Cancelled");
     [self.viewController dismissViewControllerAnimated:YES completion:nil];
     [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"cancelled"] callbackId:self.actionCallbackId];
 }
@end