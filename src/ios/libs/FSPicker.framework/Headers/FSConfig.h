//
//  FSConfig.h
//  FSPicker
//
//  Created by Łukasz Cichecki on 23/02/16.
//  Copyright © 2016 Filestack. All rights reserved.
//

#import <Filestack/FSStoreOptions.h>
#import <Filestack/FSSecurity.h>
#import "FSMimeTypes.h"
@import UIKit;

// extern NSString *const FSSourceFilesystem;
extern NSString *const FSSourceBox;
extern NSString *const FSSourceCameraRoll;
extern NSString *const FSSourceDropbox;
extern NSString *const FSSourceFacebook;
extern NSString *const FSSourceGithub;
extern NSString *const FSSourceGmail;
extern NSString *const FSSourceImageSearch;
extern NSString *const FSSourceCamera;
extern NSString *const FSSourceGoogleDrive;
extern NSString *const FSSourceInstagram;
extern NSString *const FSSourceFlickr;
extern NSString *const FSSourcePicasa;
extern NSString *const FSSourceSkydrive;
extern NSString *const FSSourceEvernote;
extern NSString *const FSSourceCloudDrive;

@interface FSConfig : NSObject

@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<NSString *> *sources;

/// FSPickerController only.
@property (nonatomic, copy) NSArray<FSMimeType> *mimeTypes;
/// FSPickerController only.
@property (nonatomic, assign) NSInteger maxFiles;
/// FSPickerController only.
@property (nonatomic, assign) NSUInteger maxSize;
/// FSPickerController only.
@property (nonatomic, assign) BOOL selectMultiple;
/// FSPickerController only.
@property (nonatomic, assign) BOOL shouldDownload;
/// FSPickerController only.
@property (nonatomic, assign) BOOL shouldUpload;
/// FSPickerController only.
@property (nonatomic, assign) BOOL defaultToFrontCamera;
/// FSPickerController only.
@property (nonatomic, strong) FSStoreOptions *storeOptions;

/// FSSaveController only.
@property (nonatomic, strong) NSData *data;
/// FSSaveController only.
@property (nonatomic, strong) NSURL *localDataURL;
/// FSSaveController only.
@property (nonatomic, copy) FSMimeType dataMimeType;
/// FSSaveController only.
@property (nonatomic, copy) NSString *dataExtension;
/// FSSaveController only.
@property (nonatomic, copy) NSString *proposedFileName;

- (instancetype)initWithApiKey:(NSString *)apiKey storeOptions:(FSStoreOptions *)storeOptions;
- (instancetype)initWithApiKey:(NSString *)apiKey;

@end
