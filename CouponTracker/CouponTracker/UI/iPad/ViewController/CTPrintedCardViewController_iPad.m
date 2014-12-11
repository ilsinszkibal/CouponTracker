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

#import "Model_PrintedCard.h"

#import "CTCardContentCell.h"

@interface CTPrintedCardViewController_iPad ()<UITableViewDelegate, UITableViewDataSource> {
    
    CardMapView* _cardMapView;
    BorderContainerView* _cardMapBorderContainer;
    
    UITableView* _tableView;
    CTCardContentCell* _contentCell;
    
    NSArray* _contentArray;
}

@end

@implementation CTPrintedCardViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contentArray = [[self.printedCard contents] allObjects];
    
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
    if ( _tableView == nil )
    {
        _contentCell = [[CTCardContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass( [CTCardContentCell class] ) ];
        
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:[CTCardContentCell class] forCellReuseIdentifier:NSStringFromClass( [CTCardContentCell class] ) ];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor clearColor] ];
        [_tableView setSeparatorColor:[UIColor clearColor] ];
        [self.view addSubview:_tableView];
    }
    
    [_tableView reloadData];
    
    [_cardMapView presentAnnotationsForPrintedCard:self.printedCard];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat yOffset = 100;
    
    CGSize cardMapBorderSize = [_cardMapBorderContainer preferredContainterViewSize];
    
    [_cardMapBorderContainer setFrame:CGRectMake(self.view.width - 10 - cardMapBorderSize.width, yOffset, cardMapBorderSize.width, cardMapBorderSize.height) ];
    
    [_tableView setFrame:CGRectMake(self.view.width / 4.0, _cardMapBorderContainer.maxY + 50, self.view.width / 2.0, self.view.height - _cardMapBorderContainer.maxY - 50 ) ];
}

#pragma mark - Delegates
#pragma mark TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contentArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Model_CardContent* content = [self contentForIndex:indexPath.row];
    CGFloat height = [_contentCell heightAfterUpdateContent:content];
    return height;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTCardContentCell* contentCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass( [CTCardContentCell class] ) ];
    
    if ( contentCell == nil )
    {
        contentCell = [[CTCardContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass( [CTCardContentCell class] ) ];
    }
    
    Model_CardContent* content = [self contentForIndex:indexPath.row];
    [contentCell heightAfterUpdateContent:content];    
    
    return contentCell;
}

-(Model_CardContent*) contentForIndex:(NSUInteger) index
{
    Model_CardContent* content = nil;
    
    if ( index < [[self.printedCard contents] count] )
        return _contentArray[ index ];
    
    return content;
}

#pragma mark - Action

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
