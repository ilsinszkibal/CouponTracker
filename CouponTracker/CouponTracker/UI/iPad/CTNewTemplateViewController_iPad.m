//
//  CTNewTemplateViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNewTemplateViewController_iPad.h"

#import "UIFactory.h"

#import "CardDrawingLayerView.h"
#import "CardDrawingOperationView.h"
#import "CardDrawingPresentView.h"
#import "CouponCardDrawerManager.h"

@interface CTNewTemplateViewController_iPad ()<CouponDrawerManagerImagePickerDelegate> {
    
    UIButton* _backButton;
    
    CardDrawingLayerView* _layerView;
    CardDrawingOperationView* _operationView;
    CardDrawingPresentView* _presentView;
    CouponCardDrawerManager* _drawerManager;
}

@end

@implementation CTNewTemplateViewController_iPad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector( backButtonAction: ) ];
    [self.view addSubview:_backButton];
    
    _layerView = [[CardDrawingLayerView alloc] init];
    [self.view addSubview:_layerView];
    
    _operationView = [[CardDrawingOperationView alloc] init];
    [self.view addSubview:_operationView];
    
    _presentView = [[CardDrawingPresentView alloc] init];
    [self.view addSubview:_presentView];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ( _drawerManager == nil )
    {
        _drawerManager = [[CouponCardDrawerManager alloc] initWithPresentView:_presentView withLayerView:_layerView withOperationView:_operationView imagePickerDelegate:self];
    }
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [_backButton setFrame:CGRectMake(0, 25, 120, 44)];
    
    [_layerView setFrame:CGRectMake(0, 275, 80, 300)];
    [_operationView setFrame:CGRectMake(80, 75, 600, 200)];
    [_presentView setFrame:CGRectMake(80, 275, 600, 300)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - d

- (void) presentImagePicker:(UIImagePickerController*) imagePicker
{
    [self navigateToViewController:imagePicker];
}

@end
