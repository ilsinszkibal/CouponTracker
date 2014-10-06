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
}

@end

@implementation CTWindow

- (id) initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if ( self ) {
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg5"] ];
        [_backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        
        [self addSubview:_backgroundImageView];
        
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [_backgroundImageView setFrame:self.bounds];
}

@end
