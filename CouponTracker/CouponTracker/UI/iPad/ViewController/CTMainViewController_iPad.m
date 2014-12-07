//
//  CTMainViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMainViewController_iPad.h"

#import "CTMyTemplatesViewController_iPad.h"
#import "CTScanViewController_iPad.h"
#import "CTPrintedCardViewController_iPad.h"

#import "CardMapView.h"
#import "CardMapLister.h"
#import "CardMapListerView.h"

#import "CTNetworkingManager.h"

#import "Model_PrintedCard.h"
#import "Model_CardTemplate.h"
#import "Model_Image.h"

#import "ImagePreLoader.h"
#import "ImagePreLoadImageInfo.h"

#import "BorderContainerView.h"

@interface CTMainViewController_iPad ()<CardMapListing, ImagePreLoading> {
    
    NSArray* _popularCards;
    NSString* _preLoadingKey;
    NSArray* _popularCardImageInfo;
    
    CardMapLister* _cardMapLister;
    BorderContainerView* _cardMapBorderContainer;
    
    CardMapListerView* _cardMapListerView;
    BorderContainerView* _cardMapListerBorderContainer;
    
    CardMapView* _cardMapView;
    
}

@end

@implementation CTMainViewController_iPad

#pragma mark - View cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpTopRightButtonWithTitle:@"My templates" withSel:@selector(showMyTemplatesAction:) ];
    [self setUpTopLeftButtonWithTitle:@"Login" withSel:@selector( loginButtonAction: ) ];
    
    [self setUpBottomRightButtonWithTitle:@"Scan" withSel:@selector( scanButtonPressed: ) ];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ( _cardMapLister == nil )
    {
        _cardMapListerView = [[CardMapListerView alloc] initWithFrame:CGRectMake(0, 0, 350, 80) ];
        _cardMapListerBorderContainer = [[BorderContainerView alloc] initWithContentView:_cardMapListerView];
        [self.view addSubview:_cardMapListerBorderContainer];
        
        _cardMapView = [[CardMapView alloc] initWithFrame:CGRectMake(0, 0, 350, 350) ];
        _cardMapBorderContainer = [[BorderContainerView alloc] initWithContentView:_cardMapView];
        [self.view addSubview:_cardMapBorderContainer];
        
        _cardMapLister = [[CardMapLister alloc] initWithListing:self withCardMapView:_cardMapView withMapCardLister:_cardMapListerView];
    }
    
    [self loadPopularCards];
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat marginBetweenMapViews = 50;
    
    CGSize cardMapBorderSize = [_cardMapBorderContainer preferredContainterViewSize];
    CGSize cardMapListerBorderSize = [_cardMapListerBorderContainer preferredContainterViewSize];
    
    CGFloat yOffset = ( self.view.maxY - cardMapBorderSize.height - cardMapListerBorderSize.height - marginBetweenMapViews ) / 2.0;
    
    [_cardMapListerBorderContainer setFrame:CGRectMake(self.view.width / 2.0 - cardMapListerBorderSize.width / 2.0, yOffset, cardMapListerBorderSize.width, cardMapListerBorderSize.height) ];
    
    [_cardMapBorderContainer setFrame:CGRectMake(self.view.width / 2.0 - cardMapBorderSize.width / 2.0, _cardMapListerBorderContainer.maxY + marginBetweenMapViews, cardMapBorderSize.width, cardMapBorderSize.height) ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load cards

- (void) loadPopularCards
{
    [_cardMapBorderContainer setHidden:YES];
    [_cardMapListerBorderContainer setHidden:YES];
    [self startMiddleLoadingIndicator];
    
    [[CTNetworkingManager sharedManager] getPromotedCards:^(NSArray *cards, NSError *error) {
        _popularCards = cards;
        
        [self preLoadImages];
        
    }];
    
}

#pragma mark - Image preloading

- (void) preLoadImages
{
    
    NSMutableArray* urlCollection = [@[] mutableCopy];
    
    for (Model_PrintedCard* printedCard in _popularCards) {
        Model_CardTemplate* template = [printedCard template];
        Model_Image* image = [template image];
        
        NSString* urlString = [image url];
        
        NSURL* url;
        if ( urlString )
        {
            url = [NSURL URLWithString:urlString];
        }
        
        if ( url )
        {
            [urlCollection addObject:url];
        }
        
    }
    
    NSDate* date = [NSDate date];
    _preLoadingKey = [NSString stringWithFormat:@"%@", date];
    
    [[ImagePreLoader sharedInstance] preloadImages:urlCollection imagePreLoading:self forKey:_preLoadingKey];
    
}

- (void) imagesPreloadedForKey:(NSString*) key imageInfo:(NSArray*) imageInfo
{
    
    if ( [_preLoadingKey isEqualToString:key] == NO )
        return;
    
    _popularCardImageInfo = imageInfo;
    _preLoadingKey = nil;
    
    [_cardMapListerBorderContainer setHidden:NO];
    [_cardMapBorderContainer setHidden:NO];
    [self stopMiddleLoadingIndicator];
    
    [_cardMapLister startWithPrintedCards:_popularCards withPreLoadImageInfo:_popularCardImageInfo];
    
}

- (void) imagesPreloadedFailedForKey:(NSString *)key
{
    [self stopMiddleLoadingIndicator];
}

#pragma mark - CardMapListing

- (void) navigateToPrintedCard:(Model_PrintedCard*) printedCard
{
    CTPrintedCardViewController_iPad* printedCardVC = [[CTPrintedCardViewController_iPad alloc] init];
    [printedCardVC setPrintedCard:printedCard];
    
    [self showPrintedCard:printedCardVC];
}

#pragma mark - Public

- (void) showMyTemplatesAction:(UIButton*) button
{
    if ( [self isUserLoggedIn] == NO )
    {
        [self showLogin];
        return;
    }
    
    CTMyTemplatesViewController_iPad* myTemplates = [[CTMyTemplatesViewController_iPad alloc] init];
    [self showMyTemplates:myTemplates];
}

- (void) loginButtonAction:(UIButton*) button
{
    [self showLogin];
}

- (void) scanButtonPressed:(UIButton*) button
{
    CTScanViewController_iPad* scan = [[CTScanViewController_iPad alloc] init];
    [self navigateToViewController:scan];
}

@end
