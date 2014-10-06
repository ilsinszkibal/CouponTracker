//
//  CardDrawingOperationView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingOperationView.h"

#import "UIFactory.h"

#import "CouponDrawingData.h"
#import "CouponDrawingBaseLayer.h"

#import "CardDrawingOperationRectEditView.h"
#import "CardDrawingOperationTextEditView.h"
#import "CardDrawingOperationImageEditView.h"

@interface CardDrawingOperationView () {
    
    id<CouponCardDrawerManagerProtocol> _drawerListener;
    
    UILabel* _titleLabel;
    UIButton* _showCardButton;
    
    CardDrawingOperationAddView* _operationAddView;
    CardDrawingOperationRectEditView* _operationRectView;
    CardDrawingOperationTextEditView* _operationTextView;
    CardDrawingOperationImageEditView* _operationImageView;
    
    CouponDrawingData* _drawingData;
}

@end

@implementation CardDrawingOperationView

#pragma mark - View lifecycle

- (id) init
{
    self = [super init];
    
    if ( self )
    {
    
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    
        _showCardButton = [UIFactory defaultButtonWithTitle:@"Show card" target:self action:@selector(showCardAction:) ];
        [self addSubview:_showCardButton];
    
        _operationAddView = [[CardDrawingOperationAddView alloc] init];
        [_operationAddView setHidden:YES];
        [_operationAddView setAddDelegate:self];
        [self addSubview:_operationAddView];
    
        _operationRectView = [[CardDrawingOperationRectEditView alloc] init];
        [_operationRectView setHidden:YES];
        [_operationRectView setEditDelegate:self];
        [self addSubview:_operationRectView];
    
        _operationTextView = [[CardDrawingOperationTextEditView alloc] init];
        [_operationTextView setHidden:YES];
        [_operationTextView setEditDelegate:self];
        [self addSubview:_operationTextView];
    
        _operationImageView = [[CardDrawingOperationImageEditView alloc] init];
        [_operationImageView setHidden:YES];
        [_operationImageView setEditDelegate:self];
        [self addSubview:_operationImageView];
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat subViewYOffset = 50;
    
    [_showCardButton setFrame:CGRectMake(self.frame.size.width - 100, 0, 100, 45) ];
    [_titleLabel setFrame:CGRectMake(10, 0, self.frame.size.width - _showCardButton.frame.size.width, 45)];
    
    [_operationAddView setFrame:CGRectMake(0, subViewYOffset, self.frame.size.width, self.frame.size.height - subViewYOffset ) ];
    [_operationRectView setFrame:CGRectMake(0, subViewYOffset, self.frame.size.width, self.frame.size.height - subViewYOffset ) ];
    [_operationTextView setFrame:CGRectMake(0, subViewYOffset, self.frame.size.width, self.frame.size.height - subViewYOffset ) ];
    [_operationImageView setFrame:CGRectMake(0, subViewYOffset, self.frame.size.width, self.frame.size.height - subViewYOffset ) ];
}

#pragma mark - Action

- (void) showCardAction:(UIButton*) button
{
    [_drawerListener resetPresenting];
}

#pragma mark - CardDrawingOperationEditProtocol

- (void) commmitEdit
{
    [_drawerListener commitLayerEdit];
}

- (void) presentImagePicker:(UIImagePickerController*) imagePicker
{
    [_drawerListener presentImagePicker:imagePicker];
}

#pragma mark - CardDrawingOperationAddProtocol

- (void) addLayerType:(CouponDrawingLayerTypes) type
{
    [_drawerListener insertNewLayerWithType:type];
}

#pragma mark - Public

- (void) setDrawerListener:(id<CouponCardDrawerManagerProtocol>) drawerListener
{
    _drawerListener = drawerListener;
}

- (void) setDrawingData:(CouponDrawingData*) drawingData
{
    _drawingData = drawingData;
}

#pragma mark - Public

- (void) updateStateIfNeeded
{
    
    switch ( [_drawingData state] ) {
        default:
        case CouponDrawingStateUnkown:
            break;
        
        case CouponDrawingStatePresent:
            [self setStateForTitleText:@"Operations"];
            break;
            
        case CouponDrawingStateLayerCandidate:
            [self setStateForTitleText:@"Add new label"];
            break;
            
        case CouponDrawingStateEdit:
            [self setStateForTitleText:@"Edit label"];
            [self startEditing];
            break;
            
        case CouponDrawingStateCommitEdit:
            [self startEditing];
            break;
        
    }
    
}

#pragma mark - Private

- (void) setStateForTitleText:(NSString*) titleText
{
    [_titleLabel setText:titleText];
    [self setSubViewVisibility];
}

- (void) setSubViewVisibility
{
    [_operationAddView setHidden:!( [_drawingData state] == CouponDrawingStateLayerCandidate ) ];
    [_operationRectView setHidden:![self isEditingType:CouponDrawingLayerTypeRect] ];
    [_operationTextView setHidden:![self isEditingType:CouponDrawingLayerTypeText] ];
    [_operationImageView setHidden:![self isEditingType:CouponDrawingLayerTypeImage] ];
    
    [_showCardButton setHidden:( [_drawingData state] == CouponDrawingStatePresent ) ];
    
}

- (BOOL) isEditingType:(CouponDrawingLayerTypes) type
{
    return ( ( [_drawingData state] == CouponDrawingStateEdit || [_drawingData state] == CouponDrawingStateCommitEdit ) && [_drawingData layerAtIndex:[_drawingData layerIndex] withType:type] );
}

- (void) startEditing
{
    
    CouponDrawingBaseLayer* layer = [_drawingData layerAtIndex:[_drawingData layerIndex] ];
    
    if ( [layer layerType] == CouponDrawingLayerTypeRect )
    {
        [_operationRectView editRectLayer:(CouponDrawingRectLayer*)layer forIndex:[_drawingData layerIndex] ];
    }
    else if ( [layer layerType] == CouponDrawingLayerTypeText )
    {
        [_operationTextView editTextLayer:(CouponDrawingTextLayer*)layer forIndex:[_drawingData layerIndex] ];
    }
    else if ( [layer layerType] == CouponDrawingLayerTypeImage )
    {
        [_operationImageView editRectLayer:(CouponDrawingImageLayer*)layer forIndex:[_drawingData layerIndex] ];
    }
}

@end
