#import "FilePickerIO.h"
#import <UIKit/UIKit.h>

@implementation FilePickerIO

- (void)setKey:(CDVInvokedUrlCommand*)command {
    NSString* callbackId = command.callbackId;
    [self.commandDelegate runInBackground:^{

       
      [FPConfig sharedInstance].APIKey = @"key";
        
        FPTheme *theme = [FPTheme new];
        
        CGFloat hue = 0.5616;
        
        theme.navigationBarStyle = UIBarStyleBlack;
        theme.navigationBarBackgroundColor = [UIColor colorWithHue:hue saturation:0.8 brightness:0.12 alpha:1.0];
        theme.navigationBarTintColor = [UIColor colorWithHue:hue saturation:0.1 brightness:0.98 alpha:1.0];
        theme.headerFooterViewTintColor = [UIColor colorWithHue:hue saturation:0.8 brightness:0.28 alpha:1.0];
        theme.headerFooterViewTextColor = [UIColor whiteColor];
        theme.tableViewBackgroundColor = [UIColor colorWithHue:hue saturation:0.8 brightness:0.49 alpha:1.0];
        theme.tableViewSeparatorColor = [UIColor colorWithHue:hue saturation:0.8 brightness:0.38 alpha:1.0];
        theme.tableViewCellBackgroundColor = [UIColor colorWithHue:hue saturation:0.8 brightness:0.49 alpha:1.0];
        theme.tableViewCellTextColor = [UIColor colorWithHue:hue saturation:0.1 brightness:1.0 alpha:1.0];
        theme.tableViewCellTintColor = [UIColor colorWithHue:hue saturation:0.3 brightness:0.7 alpha:1.0];
        theme.tableViewCellSelectedBackgroundColor = [UIColor colorWithHue:hue saturation:0.8 brightness:0.18 alpha:1.0];
        theme.tableViewCellSelectedTextColor = [UIColor whiteColor];
        
        theme.uploadButtonBackgroundColor = [UIColor blackColor];
        theme.uploadButtonHappyTextColor = [UIColor yellowColor];
        theme.uploadButtonAngryTextColor = [UIColor redColor];
  
        
        
        
        FPPickerController *fpController = [FPPickerController new];

        // Set the delegate
        fpController.fpdelegate = self;
        
        
        fpController.theme = theme;
        
        fpController.dataTypes = @[@"image/*"];

        fpController.sourceNames = @[
            FPSourceFilesystem,
            FPSourceBox,
            FPSourceCameraRoll,
            FPSourceDropbox,
            FPSourceFacebook,
            FPSourceGithub,
            FPSourceGmail,
            FPSourceImagesearch,
            FPSourceCamera,
            FPSourceGoogleDrive,
            FPSourceInstagram,
            FPSourceFlickr,
            FPSourcePicasa,
            FPSourceSkydrive,
            FPSourceEvernote,
            FPSourceCloudDrive
        ];

        // You can set some of the in built Camera properties as you would with UIImagePicker

        fpController.allowsEditing = YES;

        // Allowing multiple file selection

        fpController.selectMultiple = YES;

        // Limiting the maximum number of files that can be uploaded at one time

        fpController.maxFiles = 5;


        /* Control if we should upload or download the files for you.
         * Default is YES.
         * When a user selects a local file, we'll upload it and return a remote URL.
         * When a user selects a remote file, we'll download it and return the filedata to you.
         */

        // pickerController.shouldUpload = YES;
        // pickerController.shouldDownload = YES;

        [self.viewController presentViewController:fpController animated:YES completion:nil];
        return;
   
    }];
}




@end