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

@property (nonatomic, strong) UIImageView* dropDownImage;
@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer;

@property (nonatomic, weak) id<CTInteracting> delegate;

@end

@implementation CTInteractionView

#pragma mark - Init

- (id) initWithTitle:(NSString*) title withDelegate:(id<CTInteracting>) delegate;
{
    
    self = [super init];
    
    if ( self ) {
        
        _delegate = delegate;
        
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
    [self.delegate tapInteractionOnView:self];
}

@end
