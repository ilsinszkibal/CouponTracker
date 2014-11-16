//
//  CTNewTemplateViewController_iPhone.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNewTemplateViewController_iPhone.h"

#import "DeviceInfo.h"

#import "CTInteractionView.h"

#import "CardDrawingLayerView.h"
#import "CardDrawingOperationView.h"
#import "CardDrawingPresentView.h"
#import "CouponCardDrawerManager.h"

@interface CTNewTemplateViewController_iPhone ()<CouponDrawerManagerImagePickerDelegate, CardDrawingCreating>

@property (nonatomic, strong) UIButton* backButton;

@property (nonatomic, strong) CTInteractionView* layerInteractionView;
@property (nonatomic, strong) CTInteractionView* operationInteractionView;

@property (nonatomic, strong) CardDrawingLayerView* layerView;
@property (nonatomic, strong) CardDrawingOperationView* operationView;
@property (nonatomic, strong) CardDrawingPresentView* presentView;
@property (nonatomic, strong) CouponCardDrawerManager* drawerManager;

@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecoginzer;

@end

@implementation CTNewTemplateViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ( _backButton == nil )
    {
        _backButton = [UIFactory defaultButtonWithTitle:@"Back" target:self action:@selector(backButtonAction:) ];
        [self.view addSubview:_backButton];
    }
    
    if ( _tapGestureRecoginzer == nil )
    {
        _tapGestureRecoginzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:) ];
        [self.view addGestureRecognizer:_tapGestureRecoginzer];
    }
    
    if ( _presentView == nil )
    {
        _presentView = [[CardDrawingPresentView alloc] init];
        [self.view addSubview:_presentView];
    }
    
    if ( _layerInteractionView == nil )
    {
        _layerView = [[CardDrawingLayerView alloc] init];
        
        _layerInteractionView = [CTInteractionView createWithContentView:_layerView withTitle:@"Layers"];
        [self.view addSubview:_layerInteractionView];
    }
    
    if ( _operationView == nil )
    {
        _operationView = [[CardDrawingOperationView alloc] init];
        [_operationView setDrawingCreating:self];
        
        _operationInteractionView = [CTInteractionView createWithContentView:_operationView withTitle:@"Operations"];
        [self.view addSubview:_operationInteractionView];
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
    
    if ( [DeviceInfo isSmallerThanPhone6PlusForm] )
    {
        [self defaultLayout];
    }
    else
    {
        [self phone6plusLayout];
    }
    
}

- (void) defaultLayout
{
    CGFloat interactionHeight = 34;
    CGFloat innerMargin = 16;
    
    CGFloat heightSize = MIN(self.view.height - interactionHeight, self.view.width / 2.0 );
    [_presentView setFrame:CGRectMake(self.view.width - 2 * heightSize, self.view.height - heightSize, heightSize * 2, heightSize)];
    
    [_backButton setFrame:CGRectMake(0, 0, 100, interactionHeight) ];
    
    [_operationInteractionView setContentSize:CGSizeMake(self.view.width, 200) ];
    [_operationInteractionView setFrame:CGRectMake(_backButton.maxX + innerMargin, 0, 150, interactionHeight)];
    [_operationInteractionView setContentOffset:CGPointMake(_operationInteractionView.x * -1.0, 0) ];
    [_layerInteractionView setContentSize:CGSizeMake(80, 300) ];
    [_layerInteractionView setFrame:CGRectMake(self.view.width - 120 - innerMargin, 0, 120, interactionHeight) ];
}

- (void) phone6plusLayout
{
    
}

- (NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

#pragma mark - Tap gesture

- (void) handleTap:(UITapGestureRecognizer*) tapGesture
{
    
    CGPoint touchAt = [tapGesture locationInView:self.view];
    
    if ( CGRectContainsPoint(_operationInteractionView.frame, touchAt) || CGRectContainsPoint(_layerInteractionView.frame, touchAt) )
    {
        return;
    }
    
    [_operationInteractionView closeContent];
    [_layerInteractionView closeContent];
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
