//
//  CouponCardDrawerManager.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CouponCardDrawerManager.h"

#import "CardDrawing.h"
#import "CouponDrawingData.h"
#import "CouponCardDrawerManagerListener.h"

#import "CouponDrawingBaseLayer.h"

@interface CouponCardDrawerManager () {
    
    CardDrawing* _cardDrawing;
    CouponDrawingData* _drawingData;
 
    CardDrawingOperationView* _operationView;
    CardDrawingPresentView* _presentationView;
    CardDrawingLayerView* _layerView;
    
}

@end

@implementation CouponCardDrawerManager

#pragma mark - Init

- (id) initWithPresentView:(CardDrawingPresentView*) presentView withLayerView:(CardDrawingLayerView*) layerView withOperationView:(CardDrawingOperationView*) operationView
{
    
    self = [super init];
    
    if ( self ) {
        
        _cardDrawing = [[CardDrawing alloc] init];
        _drawingData = [[CouponDrawingData alloc] initWithMaxNbOfLayers:6];

        CGFloat borderWidth = 1.f;
        
        [self setUpPresentationView:presentView borderWidth:borderWidth];
        [self setUpLayerView:layerView borderWidth:borderWidth];
        [self setUpOperaiontView:operationView borderWidth:borderWidth];
     
        [_drawingData setState:CouponDrawingStatePresent];
        [self updateSubViewStates];
    }
    
    return self;
}

- (void) setUpPresentationView:(CardDrawingPresentView*) presentView borderWidth:(CGFloat) borderWidth
{
    _presentationView = presentView;
    [_presentationView.layer setBorderColor:[UIColor blackColor].CGColor ];
    [_presentationView.layer setBorderWidth:borderWidth];
    [_presentationView setDrawerListener:[self drawerListener] ];
    [_presentationView setDrawingData:_drawingData];
}

- (void) setUpLayerView:(CardDrawingLayerView*) layerView borderWidth:(CGFloat) borderWidth
{
    _layerView = layerView;
    [_layerView.layer setBorderColor:[UIColor blackColor].CGColor ];
    [_layerView.layer setBorderWidth:borderWidth];
    [_layerView setDrawerListener:[self drawerListener] ];
    [_layerView setDrawingData:_drawingData];
}

- (void) setUpOperaiontView:(CardDrawingOperationView*) operationView borderWidth:(CGFloat) borderWidth
{
    _operationView = operationView;
    [_operationView.layer setBorderColor:[UIColor blackColor].CGColor ];
    [_operationView.layer setBorderWidth:borderWidth];
    [_operationView setDrawerListener:[self drawerListener] ];
    [_operationView setDrawingData:_drawingData];
}

#pragma mark - Private

- (CouponCardDrawerManagerListener*) drawerListener
{
    return [[CouponCardDrawerManagerListener alloc] initWithDrawerManager:self];
}

- (void) updateSubViewStates
{
    //Redraw card and all layers if ther are invalid
    UIImage* cardImage = [_cardDrawing drawCard:_drawingData withSize:_presentationView.frame.size];
    [_drawingData setCardImage:cardImage];
    
    [_presentationView updateStateIfNeeded];
    [_operationView updateStateIfNeeded];
    [_layerView updateStateIfNeeded];
    
}

#pragma mark - Delegate

- (void) layerCandidateAtIndex:(NSUInteger) newLayerIndex
{
    [_drawingData setLayerIndex:newLayerIndex];
    [_drawingData setState:CouponDrawingStateLayerCandidate];
    [self updateSubViewStates];
}

- (void) insertNewLayerWithType:(CouponDrawingLayerTypes) type
{
    NSUInteger index = [_drawingData layerIndex];
    
    //Insert new layer
    CouponDrawingBaseLayer* layer = [CouponDrawingBaseLayer layerFactoryWithType:type withMaxLayerPositions:_presentationView.frame.size ];
    [_drawingData addLayer:layer AtIndex:index ];
    
    //Start editing the new layer
    [self startEditingLayerAtIndex:index];
    
}

- (void) startEditingLayerAtIndex:(NSUInteger) index
{
    //Set editing layer's index
    [_drawingData setLayerIndex:index];
    [_drawingData setState:CouponDrawingStateEdit];
    
    [self updateSubViewStates];
}

- (void) commitLayerEdit
{
    //Invalidate editted layer for redraw
    CouponDrawingBaseLayer* layer = [_drawingData layerAtIndex:[_drawingData layerIndex] ];
    [layer setIsInvalid:YES];
    
    [_drawingData setState:CouponDrawingStateCommitEdit];
    [self updateSubViewStates];
    [_drawingData setState:CouponDrawingStateEdit];
}

- (void) finishedLayerEdit
{
    [self resetPresenting];
}

- (void) resetPresenting
{
    [_drawingData setState:CouponDrawingStatePresent];
    [self updateSubViewStates];
}

#pragma mark - Public

@end
