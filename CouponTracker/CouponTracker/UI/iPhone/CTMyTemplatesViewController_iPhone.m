//
//  CTMyTemplatesViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_iPhone.h"
#import "Model.h"
#import "CTTemplateDataSource.h"
#import "UIFactory.h"

@interface CTMyTemplatesViewController_iPhone () <UICollectionViewDelegate>

@property (nonatomic, strong) UISegmentedControl* switcher;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UIButton* backButton;

@property (nonatomic, strong) CTTemplateDataSource* templatesDataSource;

- (void)switcherChanged:(UISegmentedControl*)switcher;
- (void)backButtonPressed:(UIButton*)backButton;

@end

@implementation CTMyTemplatesViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.templatesDataSource = [[CTTemplateDataSource alloc] init];
    
    self.backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector(backButtonPressed:)];
    [self.view addSubview:self.backButton];
    
    self.switcher = [[UISegmentedControl alloc] initWithItems:@[@"My templates", @"Popular templates"]];
    [self.switcher setSelectedSegmentIndex:CTMyTemplates];
    [self.switcher addTarget:self action:@selector(switcherChanged:) forControlEvents:UIControlEventValueChanged];
    self.switcher.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.switcher];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.collectionView.dataSource = self.templatesDataSource;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];
    
    self.templatesDataSource.collectionView = self.collectionView;
    self.templatesDataSource.templateType = CTMyTemplates;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.backButton setFrame:CGRectMake(10, 20, 60, 30)];
    [self.switcher setFrame:CGRectMake(20, 60, 280, 25)];
    [self.collectionView setFrame:CGRectMake(20, 100, 280, 400)];
}

- (void)switcherChanged:(UISegmentedControl*)switcher {
    if (switcher.selectedSegmentIndex == 0) {
        self.templatesDataSource.templateType = CTMyTemplates;
    } else {
        self.templatesDataSource.templateType = CTPopularTemplates;
    }
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    Model_CardTemplate* template = [self.templatesDataSource templateForIndexPath:indexPath];
}

- (void)backButtonPressed:(UIButton*)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
