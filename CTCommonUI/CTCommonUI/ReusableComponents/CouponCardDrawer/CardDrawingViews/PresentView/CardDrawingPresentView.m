//
//  CardDrawingPresentView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingPresentView.h"

#import "CouponDrawingData.h"
#import "CardDrawingEditTextPresentView.h"

@interface CardDrawingPresentView () {
    
    CardDrawingEditBoxPresentView* _editBoxPresentView;
    CardDrawingEditTextPresentView* _editTextPresentView;
    
    CouponDrawingData* _drawingData;
    
    id<CouponCardDrawerManagerProtocol> _drawingListener;

    UIImageView* _imageView;
    
}

@end

@implementation CardDrawingPresentView

#pragma mark - View lifeCycle

- (id) init
{
    self = [super init];
    
    if ( self )
    {
        
        [self setBackgroundColor:[UIColor whiteColor] ];
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    
        _editBoxPresentView = [[CardDrawingEditBoxPresentView alloc] init];
        [_editBoxPresentView setEditProtocol:self];
        [_editBoxPresentView setHidden:YES];
        [self addSubview:_editBoxPresentView];
    
        _editTextPresentView = [[CardDrawingEditTextPresentView alloc] init];
        [_editTextPresentView setEditProtocol:self];
        [_editTextPresentView setHidden:YES];
        [self addSubview:_editTextPresentView];
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [_imageView setFrame:self.bounds];
    [_editBoxPresentView setFrame:self.bounds];
    [_editTextPresentView setFrame:self.bounds];
    
}

#pragma mark - CardDrawingEditPresentViewProtocol

- (void) layerPositionChanged
{
    [_drawingListener commitLayerEdit];
}

#pragma mark - Public setters

- (void) setDrawerListener:(id<CouponCardDrawerManagerProtocol>) drawerListener
{
    _drawingListener = drawerListener;
}

- (void) setDrawingData:(CouponDrawingData*) drawingData
{
    _drawingData = drawingData;
}

- (void) updateStateIfNeeded
{
    
    switch ( [_drawingData state] ) {
        default:
        case CouponDrawingStateUnkown:
            break;
            
        case CouponDrawingStateEdit:
            [self presentEditingSubView];
            break;
            
        case CouponDrawingStateCommitEdit:
            [self commitLayerEdit];
            break;
            
        case CouponDrawingStatePresent:
            [self presentCardSubView];
            break;
            
    }
    
}

#pragma mark - Private

- (void) presentCardSubView
{
    [_editBoxPresentView setHidden:YES];
    [_editBoxPresentView reset];
    
    [_editTextPresentView setHidden:YES];
    [_editTextPresentView reset];
    
    [_imageView setImage:[_drawingData cardImage] ];
    
}

- (void) presentEditingSubView
{
    CouponDrawingBaseLayer* layer = [_drawingData layerAtIndex:[_drawingData layerIndex] ];
    [_imageView setImage:[layer renderedImage] ];
    
    if ( [layer isBoxBaseLayer] )
    {
        [_editBoxPresentView setHidden:NO];
        [_editTextPresentView setHidden:YES];
        [_editBoxPresentView startEditingBoxLayer:(CouponDrawingBoxBaseLayer*)layer];
    }
    else if ( [layer layerType] == CouponDrawingLayerTypeText )
    {
        [_editBoxPresentView setHidden:YES];
        [_editTextPresentView setHidden:NO];
        [_editTextPresentView startEditingBoxLayer:(CouponDrawingTextLayer*)layer];
    }
    
}

- (void) commitLayerEdit
{
    CouponDrawingBaseLayer* layer = [_drawingData layerAtIndex:[_drawingData layerIndex] ];
    [_imageView setImage:[layer renderedImage] ];
    
    [_editBoxPresentView commitLayerEdit];
    [_editTextPresentView commitLayerEdit];
}

@end
