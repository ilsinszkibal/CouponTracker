//
//  CTNewTemplateViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNewTemplateViewController_iPad.h"

#import "CardDrawingLayerView.h"
#import "CardDrawingOperationView.h"
#import "CardDrawingPresentView.h"
#import "CouponCardDrawerManager.h"

@interface CTNewTemplateViewController_iPad ()<CouponDrawerManagerImagePickerDelegate, CardDrawingCreating> {
    
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
    
    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonAction:) ];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ( _layerView == nil )
    {
        _layerView = [[CardDrawingLayerView alloc] init];
        [self.view addSubview:_layerView];
    }
    
    if ( _operationView == nil )
    {
        _operationView = [[CardDrawingOperationView alloc] init];
        [_operationView setDrawingCreating:self];
        [self.view addSubview:_operationView];
    }
    
    if ( _presentView == nil )
    {
        _presentView = [[CardDrawingPresentView alloc] init];
        [self.view addSubview:_presentView];
    }
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    if ( _drawerManager == nil )
    {
        _drawerManager = [[CouponCardDrawerManager alloc] initWithPresentView:_presentView withLayerView:_layerView withOperationView:_operationView imagePickerDelegate:self];
    }
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat yOffset = 150;
    
    [_presentView setFrame:CGRectMake(self.view.width / 2.0 - 600 / 2.0, self.view.height / 2.0 - 300 / 2.0 + yOffset, 600, 300)];
    
    [_layerView setFrame:CGRectMake(_presentView.x - 80, _presentView.y, 80, 300)];
    [_operationView setFrame:CGRectMake(_presentView.x, _presentView.y - 200, 600, 200)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CardDrawingCreating

- (void) createCardWithImage:(UIImage*) image
{
    [self createTemplateWithName:@"Name" withText:@"Text" withImage:image];
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
