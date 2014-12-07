//
//  CTPrintedCardViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 07/12/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrintedCardViewController_iPad.h"

#import "CardMapView.h"
#import "BorderContainerView.h"

@interface CTPrintedCardViewController_iPad () {
    
    CardMapView* _cardMapView;
    BorderContainerView* _cardMapBorderContainer;
    
}

@end

@implementation CTPrintedCardViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector( backButtonAction: ) ];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ( _cardMapView == nil )
    {
        _cardMapView = [[CardMapView alloc] initWithFrame:CGRectMake(0, 0, 350, 350) ];
        _cardMapBorderContainer = [[BorderContainerView alloc] initWithContentView:_cardMapView];
        [self.view addSubview:_cardMapBorderContainer];
        
    }
    
    [_cardMapView presentAnnotationsForPrintedCard:self.printedCard];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat yOffset = 100;
    
    CGSize cardMapBorderSize = [_cardMapBorderContainer preferredContainterViewSize];
    
    [_cardMapBorderContainer setFrame:CGRectMake(self.view.width - 10 - cardMapBorderSize.width, yOffset, cardMapBorderSize.width, cardMapBorderSize.height) ];
}

#pragma mark - Action

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
