//
//  CTCardsViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTCardsViewController_iPhone.h"
#import "CTNetworkingManager.h"
#import <iCarousel/iCarousel.h>
#import "UIImageView+WebCache.h"
#import "BorderContainerView.h"
#import "CTPassingViewNavigatingKey.h"
#import "Model.h"
#import "PreferredSizingImageView.h"

@interface CTCardsViewController_iPhone () <UICollectionViewDelegate, iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) NSArray* cards;
@property (nonatomic, strong) iCarousel* carousel;
@property (nonatomic, assign) NSUInteger selectedIndex;

- (void)backButtonPressed:(UIButton*)backButton;

@end

@implementation CTCardsViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonPressed:) ];
    
    _carousel = [[iCarousel alloc] init];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeInvertedTimeMachine;
    [self.view addSubview:_carousel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[CTNetworkingManager sharedManager] getCards:^(NSArray *cards, NSError *error) {
        if (!error) {
            self.cards = cards.copy;
        }
        [self.carousel reloadData];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.carousel setFrame:CGRectMake(20, 100, 280, 400)];
}

#pragma mark - iCarouselDataSource

- (NSUInteger) numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.cards count];
}

- (UIView*) carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    PreferredSizingImageView* imageView = [[PreferredSizingImageView alloc] initWithFrame:view.bounds ];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    BorderContainerView* borderContainer = [[BorderContainerView alloc] initWithContentView:imageView];
    [borderContainer setFrame:CGRectMake(0, 0, 200, 100) ];
        
    Model_PrintedCard* card = [self.cards objectAtIndex:index];
    [imageView sd_setImageWithURL:[NSURL URLWithString:card.template.image.url] ];
    
    return borderContainer;
}

#pragma mark - ICarouselDelegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    _selectedIndex = index;
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
