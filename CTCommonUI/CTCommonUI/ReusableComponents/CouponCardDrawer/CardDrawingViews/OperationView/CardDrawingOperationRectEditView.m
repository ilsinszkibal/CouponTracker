//
//  CardDrawingOperationRectEditView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 20/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingOperationRectEditView.h"

#import "CouponDrawingRectLayer.h"

@interface CardDrawingOperationRectEditView () {
    
    CouponDrawingRectLayer* _editingLayer;
    NSUInteger _editingIndex;
    
    NSArray* _colorButtonCollection;
}

@end

@implementation CardDrawingOperationRectEditView

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        
        UIColor* borderColor = [UIColor blackColor];
        NSMutableArray* collection = [[NSMutableArray alloc] initWithCapacity:[CouponDrawingRectLayer maxNumberOfRectIndex] ];
        for (NSUInteger actButtonIndex = 0; actButtonIndex < [CouponDrawingRectLayer maxNumberOfRectIndex] ; actButtonIndex++) {
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[CouponDrawingRectLayer colorForRectIndex:actButtonIndex] ];
            [button setTag:actButtonIndex];
            [button.layer setBorderColor:borderColor.CGColor ];
            [button.layer setBorderWidth:1.f];
            [button addTarget:self action:@selector(colorChooserAction:) forControlEvents:UIControlEventTouchUpInside];
            [collection addObject:button];
            [self addSubview:button];
        }
        
        _colorButtonCollection = [NSArray arrayWithArray:collection];
        
        
        
    }
    
    return self;
}

#pragma mark - View lifeCycle

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftMargin = 140;
    CGFloat spaceBetween = 30;
    CGFloat buttonSize = 40;
    
    for (NSUInteger index = 0; index < [_colorButtonCollection count]; index++) {
        UIButton* button = [_colorButtonCollection objectAtIndex:index];
        
        [button setFrame:CGRectMake(leftMargin + index * ( spaceBetween + buttonSize ), 0, buttonSize, buttonSize)];
        
    }
    
}

- (void) setHidden:(BOOL)hidden
{
    [super setHidden:hidden];
    
    if ( hidden ) {
        _editingLayer = nil;
        _editingIndex = NSUIntegerMax;
    }
    
}

#pragma mark - Action

- (void) colorChooserAction:(UIButton*) button
{
    
    [self setSelectedColorIndex:[button tag] ];
    
    [_editingLayer setSelectedColorIndex:[button tag] ];
    
    [_editDelegate commmitEdit];
}

- (void) setSelectedColorIndex:(NSUInteger) colorIndex
{
    for (NSUInteger index = 0; index < [_colorButtonCollection count]; index++) {
        UIButton* button = [_colorButtonCollection objectAtIndex:index];
        
        if ( index == colorIndex )
        {
            [button.layer setBorderColor:[UIColor orangeColor].CGColor ];
        }
        else
        {
            [button.layer setBorderColor:[UIColor blackColor].CGColor ];
        }
        
    }
    
}

#pragma mark - Public

- (void) editRectLayer:(CouponDrawingRectLayer*) rectLayer forIndex:(NSUInteger) index
{
    _editingLayer = rectLayer;
    _editingIndex = index;
    
    [self setSelectedColorIndex:[_editingLayer selectedColorIndex] ];
}

@end
