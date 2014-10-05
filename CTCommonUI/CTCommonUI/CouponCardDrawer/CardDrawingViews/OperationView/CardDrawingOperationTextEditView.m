//
//  CardDrawingOperationTextEditView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingOperationTextEditView.h"

#import "CouponDrawingTextLayer.h"

@interface CardDrawingOperationTextEditView () <UITextFieldDelegate> {
    
    CouponDrawingTextLayer* _editingLayer;
    NSUInteger _editingIndex;
    
    UILabel* _textLabel;
    UITextField* _textField;
    
    NSArray* _colorButtonCollection;
    NSArray* _fontSizeButtonCollection;
}

@end

@implementation CardDrawingOperationTextEditView

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        
        UIColor* borderColor = [UIColor blackColor];
        
        //Text modification
        _textLabel = [[UILabel alloc] init];
        [_textLabel setText:@"Text: "];
        [self addSubview:_textLabel];
        
        _textField = [[UITextField alloc] init];
        [_textField setDelegate:self];
        _textField.returnKeyType = UIReturnKeyDone;
        [self addSubview:_textField];
        
        //color buttons
        NSMutableArray* collection = [[NSMutableArray alloc] initWithCapacity:[CouponDrawingTextLayer maxNumberOfColorIndex] ];
        for (NSUInteger actButtonIndex = 0; actButtonIndex < [CouponDrawingTextLayer maxNumberOfColorIndex] ; actButtonIndex++) {
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[CouponDrawingTextLayer colorForRectIndex:actButtonIndex] ];
            [button setTag:actButtonIndex];
            [button.layer setBorderColor:borderColor.CGColor ];
            [button.layer setBorderWidth:1.f];
            [button addTarget:self action:@selector(colorChooserAction:) forControlEvents:UIControlEventTouchUpInside];
            [collection addObject:button];
            [self addSubview:button];
        }
        _colorButtonCollection = [NSArray arrayWithArray:collection];
        
        //font size buttons
        collection = [[NSMutableArray alloc] initWithCapacity:[CouponDrawingTextLayer maxNumberOfFontIndex] ];
        for (NSUInteger actButtonIndex = 0; actButtonIndex < [CouponDrawingTextLayer maxNumberOfFontIndex]; actButtonIndex++ ) {
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            NSInteger fontSize = [CouponDrawingTextLayer fontSizeForIndex:actButtonIndex];
            NSString* fontSizeString = [NSString stringWithFormat:@"%ld", (long)fontSize ];
            [button setTitle:fontSizeString forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button setTag:actButtonIndex];
            [button.layer setBorderColor:borderColor.CGColor ];
            [button.layer setBorderWidth:1.f];
            [button addTarget:self action:@selector(fontSizeChooserAction:) forControlEvents:UIControlEventTouchUpInside];
            [collection addObject:button];
            [self addSubview:button];
        }
        _fontSizeButtonCollection = [NSArray arrayWithArray:collection];
        
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
    
    [_textLabel setFrame:CGRectMake(leftMargin, 0, 100, 50) ];
    [_textField setFrame:CGRectMake(leftMargin + _textLabel.frame.size.width, 0, 250, 50) ];
    
    
    for (NSUInteger index = 0; index < [_colorButtonCollection count]; index++) {
        UIButton* button = [_colorButtonCollection objectAtIndex:index];
        
        [button setFrame:CGRectMake(leftMargin + index * ( spaceBetween + buttonSize ), 55, buttonSize, buttonSize)];
        
    }
    
    for (NSUInteger index = 0; index < [_fontSizeButtonCollection count]; index++) {
        UIButton* button = [_fontSizeButtonCollection objectAtIndex:index];
        
        [button setFrame:CGRectMake(leftMargin + index * ( spaceBetween + buttonSize ), 55 + buttonSize + 10, buttonSize, buttonSize) ];
    }
    
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
 
    NSString* text = textField.text;
    
    if ( [text length] == 0 )
        text = @"Text";
    
    [_editingLayer setText:text];
    
    [_editDelegate commmitEdit];
}

#pragma mark - Action

- (void) fontSizeChooserAction:(UIButton*) button
{
    [self setSelectedFontSizeIndex:[button tag] ];
    
    [_editingLayer setFontSizeIndex:[button tag] ];
    
    [_editDelegate commmitEdit];
}

- (void) setSelectedFontSizeIndex:(NSUInteger) index
{
    
    for (NSUInteger actIndex = 0; actIndex < [_fontSizeButtonCollection count]; actIndex++) {
        UIButton* button = [_fontSizeButtonCollection objectAtIndex:actIndex];
        
        if ( index == [button tag] )
        {
            [button.layer setBorderColor:[UIColor orangeColor].CGColor ];
        }
        else
        {
            [button.layer setBorderColor:[UIColor blackColor].CGColor ];
        }
        
    }
    
}

- (void) colorChooserAction:(UIButton*) button
{
    
    [self setSelectedColorIndex:[button tag] ];
    
    [_editingLayer setFontColorIntex:[button tag] ];
    
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

- (void) editTextLayer:(CouponDrawingTextLayer*) rectLayer forIndex:(NSUInteger) index
{
    _editingLayer = rectLayer;
    _editingIndex = index;
 
    [_textField setText:_editingLayer.text];
    
    [self setSelectedColorIndex:[_editingLayer fontColorIntex] ];
    [self setSelectedFontSizeIndex:[_editingLayer fontSizeIndex] ];
}

@end
