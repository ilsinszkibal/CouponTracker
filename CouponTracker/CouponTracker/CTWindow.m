//
//  CTWindow.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 06/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTWindow.h"

@interface CTWindow () {
    
    UIImageView* _backgroundImageView;
    CGSize _backgroundImageViewSize;
}

@end

@implementation CTWindow

- (id) initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        UIImage* image = [UIImage imageNamed:@"bg6"];
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:image ];
        _backgroundImageViewSize = _backgroundImageView.image.size;
        _backgroundImageViewSize.width *= 0.6;
        _backgroundImageViewSize.height *= 0.6;
        
        [self addSubview:_backgroundImageView];
        
    }
    
    return self;
}

#pragma mark - LayoutSubviews

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [_backgroundImageView setFrame:CGRectIntegral( CGRectMake(-400, 0, _backgroundImageViewSize.width, _backgroundImageViewSize.height) ) ];
    
}

#pragma mark - Public

@end
