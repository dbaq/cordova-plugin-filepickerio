//
// FSTheme.h
// FSPicker
//
// Created by Łukasz Cichecki on 24/02/16.
// Copyright (c) 2016 Filestack. All rights reserved.
//

@import UIKit;

@interface FSTheme : NSObject

/*!
 Navigation bar style that specifies its appearance (i.e., UIBarStyleDefault or UIBarStyleBlack)
 */
@property (nonatomic, assign) UIBarStyle navigationBarStyle;

/*!
 Background color to apply to the navigation bar.
 */
@property (nonatomic, strong) UIColor *navigationBarBackgroundColor;

/*!
 Text color to apply to the navigation bar title.
 */
@property (nonatomic, strong) UIColor *navigationBarTitleColor;

/*!
 Tint color to apply to the navigation items and bar button items.
 */
@property (nonatomic, strong) UIColor *navigationBarTintColor;

/*!
 Tint (background) color to apply to the table view headers and footers.
 */
@property (nonatomic, strong) UIColor *headerFooterViewTintColor;

/*!
 Text color to apply to the table view headers and footers.
 */
@property (nonatomic, strong) UIColor *headerFooterViewTextColor;

/*!
 Background color to apply to the table view.
 */
@property (nonatomic, strong) UIColor *tableViewBackgroundColor;

/*!
 Color to apply to the table view separators.
 */
@property (nonatomic, strong) UIColor *tableViewSeparatorColor;

/*!
 Background color to apply to the table view cells.
 */
@property (nonatomic, strong) UIColor *tableViewCellBackgroundColor;

/*!
 Text color to apply to the table view cell label.
 */
@property (nonatomic, strong) UIColor *tableViewCellTextColor;

/*!
 Tint color to apply to the table and collection view cells.
 */
@property (nonatomic, strong) UIColor *cellIconTintColor;

/*!
 TTint color to apply to the table view cells icon images.
 */
@property (nonatomic, strong) UIColor *tableViewCellIconTintColor;

/*!
 Background color to apply to the table view cell when selected.
 */
@property (nonatomic, strong) UIColor *tableViewCellSelectedBackgroundColor;

/*!
 Text color to apply to the table view cell when selected.
 */
@property (nonatomic, strong) UIColor *tableViewCellSelectedTextColor;

/*!
 Border color to apply to the table view cell imageView.
 */
@property (nonatomic, strong) UIColor *tableViewCellImageViewBorderColor;

/*!
 Background color to apply to the collection view.
 */
@property (nonatomic, strong) UIColor *collectionViewBackgroundColor;

/*!
 The background color to apply to the collection view cell.
 */
@property (nonatomic, strong) UIColor *collectionViewCellBackgroundColor;

/*!
 Border color to apply to the collection view cell. This will affect "File" and "Directory" cell types.
 */
@property (nonatomic, strong) UIColor *collectionViewCellBorderColor;

/*!
 Text color to apply to the collection view cell title.
 */
@property (nonatomic, strong) UIColor *collectionViewCellTitleTextColor;

/*!
 Text color to apply to the upload button.
 */
@property (nonatomic, strong) UIColor *uploadButtonTextColor;

/*!
 Background color to apply to the upload button.
 */
@property (nonatomic, strong) UIColor *uploadButtonBackgroundColor;

/*!
 Tint color to apply to the refresh control.
 */
@property (nonatomic, strong) UIColor *refreshControlTintColor;

/*!
 Background color to apply to the refresh control.
 */
@property (nonatomic, strong) UIColor *refreshControlBackgroundColor;

/*!
 Attributed title property of the refresh control.
 */
@property (nonatomic, strong) NSAttributedString *refreshControlAttributedTitle;

/*!
 Background color to apply to search bar in Web Search.
 */
@property (nonatomic, strong) UIColor *searchBarBackgroundColor;

/*!
 Tint color to apply to search bar in Web Images search.
 */
@property (nonatomic, strong) UIColor *searchBarTintColor;

/*!
 Color for all activity indicators in FSPicker.
 */
@property (nonatomic, strong) UIColor *activityIndicatorColor;

/*!
 Color for progress circle track in FSPicker.
 */
@property (nonatomic, strong) UIColor *progressCircleTrackColor;

/*!
 Color for progress circle progress in FSPicker.
 */
@property (nonatomic, strong) UIColor *progressCircleProgressColor;

- (void)applyToController:(UIResponder *)controller;
+ (void)applyDefaultToController:(UIResponder *)controller;

+ (FSTheme *)filestackTheme;

@end
