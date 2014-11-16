//
//  CTInteractionView.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 16/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTInteractionView.h"

#import "UIFactory.h"
#import "CTColor.h"

@interface CTInteractionView ()

@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, assign) CGSize contentViewSize;
@property (nonatomic, assign) CGPoint contentViewOffset;

@property (nonatomic, strong) UIImageView* dropDownImage;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer;

@end

@implementation CTInteractionView

#pragma mark - Create and init

+ (instancetype) createWithContentView:(UIView*) contentView withTitle:(NSString*) title
{
    
    if ( contentView == nil )
        return nil;
    
    CTInteractionView* interactionView = [[CTInteractionView alloc] initWithTitle:title withContentView:contentView];
    
    return interactionView;
}

- (id) initWithTitle:(NSString*) title withContentView:(UIView*) contentView
{
    
    self = [super init];
    
    if ( self ) {
        
        [self setClipsToBounds:NO];
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:self.tapGestureRecognizer];
        
        //Setup border
        [UIFactory setBordersAndCornerToButton:self];
        
        //DropDown
        self.dropDownImage = [[UIImageView alloc] initWithImage:[UIFactory imageWhiteNamed:@"Dropdown"] ];
        [self addSubview:self.dropDownImage];
        
        //TitleLabel
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = title;
        [self addSubview:self.titleLabel];
        
        [self.contentView removeFromSuperview];
        _contentView = contentView;
        [_contentView setBackgroundColor:[CTColor viewControllerBackgroundColor] ];
        [_contentView setHidden:YES];
        [self addSubview:_contentView];
    }
    
    return self;
}

#pragma mark - Layout

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageMargin = 4;
    CGFloat imageSize = self.height - 2 * imageMargin;
    
    [self.dropDownImage setFrame:CGRectMake(imageMargin, imageMargin, imageSize, imageSize) ];
    
    CGFloat titleLabelX = self.dropDownImage.maxX + imageMargin;
    [self.titleLabel setFrame:CGRectMake(titleLabelX, 0, self.width - titleLabelX, self.height) ];
}

#pragma mark - Handle tap

- (void) handleTap:(UITapGestureRecognizer*) tapGesture
{
    
    if ( [self isContentViewShown] )
    {
        [self closeContentView];
    }
    else
    {
        [self openContentView];
    }
    
}

- (void) closeContentView
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setAlpha:0.0f];
        [self.contentView setFrame:[self contentViewFrameForShow:NO] ];
    } completion:^(BOOL finished) {
        [self.contentView setHidden:YES];
    }];
    
}

- (void) openContentView
{
    
    [self.contentView setHidden:NO];
    [self.contentView setAlpha:0.0f];
    [self.contentView setFrame:[self contentViewFrameForShow:NO] ];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView setAlpha:1.0f];
        [self.contentView setFrame:[self contentViewFrameForShow:YES] ];
    }];
    
}

- (CGRect) contentViewFrameForShow:(BOOL) show
{
    CGRect frame = [self.contentView frame];
    
    frame.origin = self.contentViewOffset;
    frame.size = self.contentViewSize;
    
    if ( show == NO )
        frame.size.height = self.height;
    
    return frame;
}

#pragma mark - Public

- (void) setContentOffset:(CGPoint) offset
{
    self.contentViewOffset = offset;
}

- (void) setContentSize:(CGSize) size
{
    self.contentViewSize = size;
}

- (BOOL) isContentViewShown
{
    return self.contentView.width == self.contentViewSize.width && self.contentView.height == self.contentViewSize.height;
}

- (void) closeContent
{
    [self closeContentView];
}

@end
