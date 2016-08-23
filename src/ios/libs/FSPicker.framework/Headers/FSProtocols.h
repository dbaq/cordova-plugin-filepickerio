//
//  FSProtocols.h
//  FSPicker
//
//  Created by Łukasz Cichecki on 22/04/16.
//  Copyright © 2016 Filestack. All rights reserved.
//

@class FSBlob;
@class FSPickerController;
@class FSSaveController;

@protocol FSPickerDelegate <NSObject>
@optional
- (void)fsPickerDidCancel:(FSPickerController *)picker;
- (void)fsPicker:(FSPickerController *)picker pickingDidError:(NSError *)error;
- (void)fsPicker:(FSPickerController *)picker pickedMediaWithBlob:(FSBlob *)blob;
- (void)fsPicker:(FSPickerController *)picker didFinishPickingMediaWithBlobs:(NSArray<FSBlob *> *)blobs;
@end

@protocol FSSaveDelegate <NSObject>
@optional
- (void)fsSaveControllerDidCancel:(FSSaveController *)saveController;
- (void)fsSaveController:(FSSaveController *)saveController savingDidError:(NSError *)error;
- (void)fsSaveController:(FSSaveController *)saveController didFinishSavingMediaWithBlob:(FSBlob *)blob;
@end