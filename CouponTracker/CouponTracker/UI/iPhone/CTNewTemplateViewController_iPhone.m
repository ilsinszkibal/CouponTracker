//
//  CTNewTemplateViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNewTemplateViewController_iPhone.h"

#import "CardDrawingLayerView.h"
#import "CardDrawingOperationView.h"
#import "CardDrawingPresentView.h"
#import "CouponCardDrawerManager.h"

@interface CTNewTemplateViewController_iPhone ()<CouponDrawerManagerImagePickerDelegate, CardDrawingCreating>

@property (nonatomic, strong) CardDrawingLayerView* layerView;
@property (nonatomic, strong) CardDrawingOperationView* operationView;
@property (nonatomic, strong) CardDrawingPresentView* presentView;
@property (nonatomic, strong) CouponCardDrawerManager* drawerManager;

@end

@implementation CTNewTemplateViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    [_presentView setFrame:CGRectMake(0, 20, self.view.width, self.view.height)];
    
    [_layerView setFrame:CGRectMake(0, _presentView.y, 80, 300)];
    [_operationView setFrame:CGRectMake(0, _presentView.y - 200, 600, 200)];
}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
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
