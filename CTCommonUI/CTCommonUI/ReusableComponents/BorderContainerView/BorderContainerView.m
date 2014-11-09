//
//  BorderContainerView.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 09/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "BorderContainerView.h"

@interface BorderContainerView () {
    
    CGFloat _containerMargin;
    
}

@end

@implementation BorderContainerView

#pragma mark - Init

- (id) initWithContentView:(UIView<PreferredViewSizing>*) contentView
{
    
    self = [super init];
    
    if ( self ) {
        _contentView = contentView;
        [_contentView setClipsToBounds:YES];
        [self addSubview:_contentView];
        
        _containerMargin = ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ) ? 15 : 30;
        
        //Setting up container
        [self setBackgroundColor:[UIColor clearColor] ];
        [UIFactory setBordersAndCornerToButton:self];
    }
    
    return self;
}

#pragma mark - Layouting

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentRect = self.bounds;
    contentRect.origin.x += _containerMargin;
    contentRect.origin.y += _containerMargin;
    contentRect.size.width -= 2 * _containerMargin;
    contentRect.size.height -= 2 * _containerMargin;
    
    [_contentView setFrame:CGRectIntegral( contentRect ) ];
}

#pragma mark - Public

- (CGFloat) containerMargin
{
    return _containerMargin;
}

- (CGSize) preferredContentViewSize
{
    return [_contentView preferredContentViewSize];
}

- (CGSize) preferredContainterViewSize
{
    CGSize preferredContentViewSize = [self preferredContentViewSize];
    CGFloat containerMargin = [self containerMargin];
    
    preferredContentViewSize.width += containerMargin;
    preferredContentViewSize.height += containerMargin;
    
    return preferredContentViewSize;
}

@end
