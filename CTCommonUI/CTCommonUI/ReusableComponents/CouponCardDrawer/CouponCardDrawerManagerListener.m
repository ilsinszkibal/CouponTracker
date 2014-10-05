//
//  CouponCardDrawerManagerListener.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponCardDrawerManagerListener.h"

@interface CouponCardDrawerManagerListener () {
    
    id<CouponCardDrawerManagerProtocol> __weak _drawerProtocol;
    
}

@end

@implementation CouponCardDrawerManagerListener

#pragma mark - Init

- (id) initWithDrawerManager:(id<CouponCardDrawerManagerProtocol>) drawerManager
{
    
    self = [super init];
    
    if ( self ) {
        _drawerProtocol = drawerManager;
    }
    
    return self;
}

#pragma mark - Protocol

- (void) layerCandidateAtIndex:(NSUInteger)newLayerIndex
{
    [_drawerProtocol layerCandidateAtIndex:newLayerIndex];
}

- (void) insertNewLayerWithType:(CouponDrawingLayerTypes) type
{
    [_drawerProtocol insertNewLayerWithType:type];
}

- (void) startEditingLayerAtIndex:(NSUInteger) index
{
    [_drawerProtocol startEditingLayerAtIndex:index];
}

- (void) commitLayerEdit
{
    [_drawerProtocol commitLayerEdit];
}

- (void) finishedLayerEdit
{
    [_drawerProtocol finishedLayerEdit];
}

- (void) resetPresenting
{
    [_drawerProtocol resetPresenting];
}

- (void) presentImagePicker:(UIImagePickerController*) imagePicker
{
    [_drawerProtocol presentImagePicker:imagePicker];
}

@end
