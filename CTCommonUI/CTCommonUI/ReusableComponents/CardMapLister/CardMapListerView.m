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
    
    UIActivityIndicatorView* _imageViewActivity;
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
        [_imageView setAlpha:0.0];
        [self addSubview:_imageView];
        
        _imageViewActivity = [[UIActivityIndicatorView alloc] init];
        [_imageViewActivity startAnimating];
        [self addSubview:_imageViewActivity];
        
        _numberOfPassesLabel = [[UILabel alloc] init];
        [_numberOfPassesLabel setTextColor:[UIColor whiteColor] ];
        [_numberOfPassesLabel setNumberOfLines:0];
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
    [_imageViewActivity setFrame:_imageView.frame];
    
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
    
    [self refreshContent];
    
}

- (void) refreshContent
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_imageView setAlpha:0.0];
        
        [_imageViewActivity startAnimating];
        [_imageViewActivity setAlpha:1.0];
        
        [_numberOfPassesLabel setAlpha:0.0];
        
    } completion:^(BOOL finished) {
        
        [_numberOfPassesLabel setAlpha:1.0];
        [_numberOfPassesLabel setText:@""];
        
        [self updateContent];
    }];
    
}

- (void) updateContent
{
    
    NSString* urlString = _printedCard.template.image.url;
    NSURL* url = [NSURL URLWithString:urlString];
    
    if ( urlString && url )
    {
        [_imageView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            if ( image )
            {
                [UIView animateWithDuration:0.5 animations:^{
                    
                    [_imageViewActivity setAlpha:0.0];
                    [_imageViewActivity stopAnimating];
                
                    [_imageView setAlpha:1.0];
                }];
                
            }
            
        }];
    }
    
    NSUInteger numberOfPassing = [[_printedCard contents] count];
    if ( 0 < numberOfPassing )
    {
        [_numberOfPassesLabel setText:[NSString stringWithFormat:@"This card has been passed %ld times!", (long)numberOfPassing ] ];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
