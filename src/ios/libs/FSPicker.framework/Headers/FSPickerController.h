//
//  FSPickerController.h
//  FSPicker
//
//  Created by Łukasz Cichecki on 23/02/16.
//  Copyright © 2016 Filestack. All rights reserved.
//

@import UIKit;
#import "FSProtocols.h"
@class FSTheme;
@class FSConfig;

@interface FSPickerController : UINavigationController

@property (nonatomic, copy) FSTheme *theme;
@property (nonatomic, copy) FSConfig *config;
@property (nonatomic, weak) id <FSPickerDelegate> fsDelegate;

- (instancetype)initWithConfig:(FSConfig *)config theme:(FSTheme *)theme;
- (instancetype)initWithConfig:(FSConfig *)config;

- (void)didCancel;

@end