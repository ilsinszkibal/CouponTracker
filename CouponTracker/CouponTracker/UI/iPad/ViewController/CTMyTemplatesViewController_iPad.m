//
//  CTMyTemplatesViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_iPad.h"

#import "UIFactory.h"

#import "UIImageView+WebCache.h"

#import "CTNewTemplateViewController_iPad.h"
#import "CTPrintTemplateViewController_iPad.h"

#import <iCarousel/iCarousel.h>
#import "BorderContainerView.h"
#import "PreferredSizingImageView.h"
#import "Model.h"

@interface CTMyTemplatesViewController_iPad () <iCarouselDataSource, iCarouselDelegate> {
    iCarousel* _carousel;
    NSUInteger _selectedIndex;
    
    NSArray* _myCards;
    
}

@end

@implementation CTMyTemplatesViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonAction:) ];
    
    [self setUpTopRightButtonWithTitle:@"New template" withSel:@selector(newTemplateButtonAction:) ];
    
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
        _myCards = cards;
        
        [_carousel reloadData];
    }];
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
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

- (NSUInteger) numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_myCards count];
}

- (UIView*) carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    BorderContainerView* borderContainer = (BorderContainerView*)view;
    if (  borderContainer == nil )
    {
        borderContainer = [self createCell];
    }
    
    Model_PrintedCard* printedCard = [_myCards objectAtIndex:index];
    Model_CardTemplate* templateCard = [printedCard template];
    Model_Image* image = [templateCard image];
    
    [(UIImageView*)borderContainer.contentView sd_setImageWithURL:[NSURL URLWithString:image.url] ];
    
    return borderContainer;
}

- (BorderContainerView*) createCell
{
    PreferredSizingImageView* imageView = [[PreferredSizingImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 400) ];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    BorderContainerView* borderContainer = [[BorderContainerView alloc] initWithContentView:imageView];
    CGRect borderRect = CGRectZero;
    borderRect.size = [borderContainer preferredContainterViewSize];
    [borderContainer setFrame:borderRect ];
    
    return borderContainer;
}

#pragma mark - ICarouselDelegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
    _selectedIndex = index;
    
    CTPassingViewNavigatingKey* key = [CTPassingViewNavigatingKey createNavigationWithKey:[CTMyTemplatesViewController_iPad printNavigationKey] withParameters:@{ [CTMyTemplatesViewController_iPad selectedElemIndexKey] : @(index) } ];
    
    CTPrintTemplateViewController_iPad* printTemplate = [[CTPrintTemplateViewController_iPad alloc] init];
    [self passingViewNavigateToViewController:printTemplate forKey:key];
}

#pragma mark - PassingViewAnimation

- (UIView*) passingViewForKey:(CTPassingViewNavigatingKey*) key
{
    
    if ( [[key key] isEqualToString:[CTMyTemplatesViewController_iPad printNavigationKey] ] )
    {
        NSNumber* selectedIndex = [key parameters][ [CTMyTemplatesViewController_iPad selectedElemIndexKey] ];
        
        BorderContainerView* selected = (BorderContainerView*)[_carousel itemViewAtIndex:[selectedIndex integerValue] ];
        [selected setHidden:YES];
        
        UIImage* selectedImage = [(UIImageView*)selected.contentView image];
        
        BorderContainerView* cell = [self createCell];
        [(UIImageView*)cell.contentView setImage:selectedImage];
        
        return cell;
    }
    
    return nil;
}

- (CGRect) passingViewRectForKey:(CTPassingViewNavigatingKey*) key
{
    
    if ( [[key key] isEqualToString:[CTMyTemplatesViewController_iPad printNavigationKey] ] )
    {
        CGFloat size = 430;
        CGRect actFrame = self.view.frame;
        return CGRectMake( ( actFrame.size.width - size ) / 2.0, ( actFrame.size.height - size ) / 2.0, size, size);
    }
    
    return CGRectZero;
}

- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key
{
    if ( [[key key] isEqualToString:[CTMyTemplatesViewController_iPad printNavigationKey] ] )
    {
        NSNumber* selectedIndex = [key parameters][ [CTMyTemplatesViewController_iPad selectedElemIndexKey] ];
        BorderContainerView* selected = (BorderContainerView*)[_carousel itemViewAtIndex:[selectedIndex integerValue] ];
        
        [selected setHidden:NO];
    }
}

+ (NSString*) selectedElemIndexKey
{
    return @"SelectedElemIndexKey";
}

+ (NSString*) printNavigationKey
{
    return @"PrintNavigationKey";
}

#pragma mark - dealloc

- (void) dealloc
{
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

@end
