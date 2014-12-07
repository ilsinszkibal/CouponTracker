//
//  CardMapListerView.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 12/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardMapListerView.h"

#import "Model_PrintedCard.h"
#import "Model_CardTemplate.h"
#import "Model_Image.h"

#import "UIImageView+WebCache.h"

@interface CardMapListerView () {
    
    UIImageView* _imageView;
    UILabel* _numberOfPassesLabel;
    
}

@property (nonatomic, readonly) Model_PrintedCard* printedCard;

@end

@implementation CardMapListerView

#pragma mark - Init

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        _imageView = [[UIImageView alloc] init];
        [_imageView setHidden:YES];
        [self addSubview:_imageView];
        
        _numberOfPassesLabel = [[UILabel alloc] init];
        [_numberOfPassesLabel setTextColor:[UIColor whiteColor] ];
        [_numberOfPassesLabel setNumberOfLines:0];
//        [_numberOfPassesLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_numberOfPassesLabel];
        
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    CGFloat imageViewSize = self.maxY - 2 * margin;
    
    [_imageView setFrame:CGRectMake(margin, margin, imageViewSize, imageViewSize) ];
    
    [_numberOfPassesLabel setFrame:CGRectMake(_imageView.maxX + margin * 3, _imageView.y, self.maxX - _imageView.maxX - margin, imageViewSize) ];
    
}

#pragma mark - PreferredViewSizing protocoll

- (CGSize) preferredContentViewSize
{
    return self.frame.size;
}

#pragma mark - CardMapListerViewProtocol protocoll

- (void) presentPrintedCard:(Model_PrintedCard*) printedCard
{
    _printedCard = printedCard;
    
    NSString* urlString = _printedCard.template.image.url;
    NSURL* url = [NSURL URLWithString:urlString];
    
    [self hideContent];
  
    if ( urlString && url )
    {
        [_imageView sd_setImageWithURL:url];
        [_imageView setHidden:NO];
    }
    
    NSUInteger numberOfPassing = [[_printedCard contents] count];
    if ( 0 < numberOfPassing )
    {
        [_numberOfPassesLabel setText:[NSString stringWithFormat:@"This card has been passed %ld times!", (long)numberOfPassing ] ];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void) hideContent
{
    [_imageView setHidden:YES];
    
    [_numberOfPassesLabel setText:@""];
}

@end
