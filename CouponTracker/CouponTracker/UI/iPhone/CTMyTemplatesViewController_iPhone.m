//
//  CTMyTemplatesViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_iPhone.h"
#import "Model.h"
#import "CTPrintTemplateViewController_iPhone.h"

#import "CTNetworkingManager.h"

#import "CTMyTemplatesViewController_iPhone.h"
#import "CTNewTemplateViewController_iPhone.h"

#import <iCarousel/iCarousel.h>
#import "UIImageView+WebCache.h"

@interface CTMyTemplatesViewController_iPhone () <UICollectionViewDelegate, iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) NSArray* templates;
@property (nonatomic, strong) iCarousel* carousel;
@property (nonatomic, assign) NSUInteger selectedIndex;

@property (nonatomic, strong) UISegmentedControl* switcher;

- (void)switcherChanged:(UISegmentedControl*)switcher;
- (void)backButtonPressed:(UIButton*)backButton;

@end

@implementation CTMyTemplatesViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:) ];
    [self setUpTopRightButtonWithTitle:@"New template" withSel:@selector(newTemplatePressed:) ];
    
    _carousel = [[iCarousel alloc] init];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeLinear;
    [self.view addSubview:_carousel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.switcher)
    {
        self.switcher = [[UISegmentedControl alloc] initWithItems:@[@"My templates", @"Popular templates"]];
        [self.switcher addTarget:self action:@selector(switcherChanged:) forControlEvents:UIControlEventValueChanged];
        self.switcher.tintColor = [UIColor whiteColor];
        [self.view addSubview:self.switcher];
        self.switcher.selectedSegmentIndex = 0;
        [self switcherChanged:self.switcher];
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.switcher setFrame:CGRectMake(20, 60, 280, 25)];
    [self.carousel setFrame:CGRectMake(20, 100, 280, 400)];
}

- (void)switcherChanged:(UISegmentedControl*)switcher {
    
    self.templates = nil;
    [self.carousel reloadData];
    
    if ( switcher.selectedSegmentIndex == 0 )
    {
        [[CTNetworkingManager sharedManager] getMyTemplates:^(NSArray* templates, NSError* error){
            if (!error) {
                self.templates = templates.copy;
            }
            [self.carousel reloadData];
        }];
    }
    else
    {
        [[CTNetworkingManager sharedManager] getPopularTemplates:^(NSArray* templates, NSError* error){
            if (!error) {
                self.templates = templates.copy;
            }
            [self.carousel reloadData];
        }];
    }
    
}

#pragma mark - New template

- (void) newTemplatePressed:(UIButton*) pressed
{
    CTNewTemplateViewController_iPhone* newTemplate = [[CTNewTemplateViewController_iPhone alloc] init];
    [self showNewTemplate:newTemplate];
}

#pragma mark - iCarouselDataSource

- (NSUInteger) numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.templates count];
}

- (UIView*) carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    BorderContainerView* borderContainer = (BorderContainerView*)view;
    if (  borderContainer == nil )
    {
        borderContainer = [self createCellWithSize:CGSizeMake(200, 100) ];
    }
    
    Model_CardTemplate* templateCard = [self.templates objectAtIndex:index];
    Model_Image* image = [templateCard image];
    
    [(UIImageView*)borderContainer.contentView sd_setImageWithURL:[NSURL URLWithString:image.url] ];
    
    return borderContainer;
}

#pragma mark - ICarouselDelegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
    _selectedIndex = index;
    
    CTPassingViewNavigatingKey* key = [CTPassingViewNavigatingKey createNavigationWithKey:[self printNavigationKey] withParameters:@{ [self selectedElemIndexKey] : @(index) } ];
    
    CTPrintTemplateViewController_iPhone* printTemplate = [[CTPrintTemplateViewController_iPhone alloc] init];
    [self passingViewNavigateToViewController:printTemplate forKey:key];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PassingViewAnimation

- (UIView*) passingViewForKey:(CTPassingViewNavigatingKey*) key
{
    
    if ( [[key key] isEqualToString:[self printNavigationKey] ] )
    {
        NSNumber* selectedIndex = [key parameters][ [self selectedElemIndexKey] ];
        
        BorderContainerView* selected = (BorderContainerView*)[_carousel itemViewAtIndex:[selectedIndex integerValue] ];
        [selected setHidden:YES];
        
        UIImage* selectedImage = [(UIImageView*)selected.contentView image];
        
        BorderContainerView* cell = [self createCellWithSize:CGSizeMake(200, 100) ];
        [(UIImageView*)cell.contentView setImage:selectedImage];
        
        return cell;
    }
    
    return nil;
}

- (CGRect) passingViewRectForKey:(CTPassingViewNavigatingKey*) key
{
    
    if ( [[key key] isEqualToString:[self printNavigationKey] ] )
    {
        return CGRectMake( ( self.view.width - 230 ) / 2.0, ( self.view.height - 130 ) / 2.0, 230, 130);
    }
    
    return CGRectZero;
}

- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key
{
    if ( [[key key] isEqualToString:[self printNavigationKey] ] )
    {
        NSNumber* selectedIndex = [key parameters][ [self selectedElemIndexKey] ];
        BorderContainerView* selected = (BorderContainerView*)[_carousel itemViewAtIndex:[selectedIndex integerValue] ];
        
        [selected setHidden:NO];
    }
}

@end
