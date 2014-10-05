//
//  CouponCardDrawerManagerProtocol.h
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CouponDrawingLayerTypes.h"

@protocol CouponCardDrawerManagerProtocol <NSObject>

//New layer creating
- (void) layerCandidateAtIndex:(NSUInteger) newLayerIndex;
- (void) insertNewLayerWithType:(CouponDrawingLayerTypes) type;

//Editing process
- (void) startEditingLayerAtIndex:(NSUInteger) index;
- (void) commitLayerEdit;
- (void) finishedLayerEdit;

- (void) resetPresenting;

//Present imageViewController
- (void) presentImagePicker:(UIImagePickerController*) imagePicker;

@end
