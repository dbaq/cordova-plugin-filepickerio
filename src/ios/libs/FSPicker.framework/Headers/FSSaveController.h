//
//  FSSaveController.h
//  FSPicker
//
//  Created by Łukasz Cichecki on 13/05/16.
//  Copyright © 2016 Filestack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSProtocols.h"
@class FSTheme;
@class FSConfig;

@interface FSSaveController : UINavigationController

@property (nonatomic, copy) FSTheme *theme;
@property (nonatomic, copy) FSConfig *config;
@property (nonatomic, weak) id <FSSaveDelegate> fsDelegate;

- (instancetype)initWithConfig:(FSConfig *)config theme:(FSTheme *)theme;
- (instancetype)initWithConfig:(FSConfig *)config;

- (void)didCancel;

@end
