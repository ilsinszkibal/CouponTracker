//
//  CardDrawingOperationAddView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingOperationAddView.h"

@interface CardDrawingOperationAddView () {

    NSUInteger _addLayerIndex;
    UIButton* _addImageButton;
    UIButton* _addTextButton;
    UIButton* _addRectButton;
    
}


@end

@implementation CardDrawingOperationAddView

#pragma mark - View lifecycle

- (id) init
{
    self = [super init];
    
    if ( self ) {
     
        _addImageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addImageButton addTarget:self action:@selector(addImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addImageButton setTitle:@"Add image" forState:UIControlStateNormal];
        [self addSubview:_addImageButton];
        
        _addTextButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addTextButton addTarget:self action:@selector(addTextAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addTextButton setTitle:@"Add text" forState:UIControlStateNormal];
        [self addSubview:_addTextButton];
        
        _addRectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addRectButton addTarget:self action:@selector(addRectAction:) forControlEvents:UIControlEventTouchUpInside];
        [_addRectButton setTitle:@"Add rect" forState:UIControlStateNormal];
        [self addSubview:_addRectButton];
        
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftMargin = 140;
    
    [_addImageButton setFrame:CGRectMake(leftMargin, 0, 150, 45) ];
    [_addRectButton setFrame:CGRectMake(leftMargin, 45, 150, 45) ];
    [_addTextButton setFrame:CGRectMake(leftMargin, 90, 150, 45) ];
    
}

#pragma mark - Public

#pragma mark - Actions

- (void) addImageAction:(UIButton*) button
{
    [_addDelegate addLayerType:CouponDrawingLayerTypeImage];
}

- (void) addTextAction:(UIButton*) button
{
    [_addDelegate addLayerType:CouponDrawingLayerTypeText];
}

- (void) addRectAction:(UIButton*) button
{
    [_addDelegate addLayerType:CouponDrawingLayerTypeRect];
}


@end
