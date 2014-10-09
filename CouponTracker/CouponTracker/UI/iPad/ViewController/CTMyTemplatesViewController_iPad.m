//
//  CTMyTemplatesViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_iPad.h"

#import "UIFactory.h"

#import "CTNewTemplateViewController_iPad.h"

#import "iCarousel.h"
#import "BorderContainerView.h"
#import "PreferredSizingImageView.h"

@interface CTMyTemplatesViewController_iPad () <iCarouselDataSource, iCarouselDelegate> {
    
    UIButton* _backButton;
    UIButton* _newTemplateButton;
    
    iCarousel* _carousel;
    
}

@end

@implementation CTMyTemplatesViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector(backButtonAction:) ];
    [self.view addSubview:_backButton];
 
    _newTemplateButton = [UIFactory defaultButtonWithTitle:@"New template" target:self action:@selector(newTemplateButtonAction:) ];
    [self.view addSubview:_newTemplateButton];
    
    _carousel = [[iCarousel alloc] init];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeRotary;
    [self.view addSubview:_carousel];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getMyCards:^(NSArray *cards, NSError *error) {
        NSLog(@"Got cards %@", cards);
    }];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_backButton setFrame:CGRectMake(0, 25, 120, 44)];
    [_newTemplateButton setFrame:CGRectMake(0, 75, 120, 44)];
    
    [_carousel setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100) ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void) newTemplateButtonAction:(UIButton*) button
{
    CTNewTemplateViewController_iPad* newTemplate = [[CTNewTemplateViewController_iPad alloc] init];
    [self showNewTemplate:newTemplate];
}

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    BorderContainerView* borderContainer = (BorderContainerView*)view;
    if (  borderContainer == nil )
    {
        
        PreferredSizingImageView* imageView = [[PreferredSizingImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 400) ];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg%d", index + 2] ] ];
        
        borderContainer = [[BorderContainerView alloc] initWithContentView:imageView];
        CGRect borderRect = CGRectZero;
        borderRect.size = [borderContainer preferredContainterViewSize];
        [borderContainer setFrame:borderRect ];
    }
    
    return borderContainer;
}

#pragma mark - ICarouselDelegate

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    
    switch ( option ) {
        default:
        case iCarouselOptionFadeRange:
            return value;
            break;
            
            
    }
    
    return 0;
}

#pragma mark - dealloc

- (void) dealloc
{
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

@end
