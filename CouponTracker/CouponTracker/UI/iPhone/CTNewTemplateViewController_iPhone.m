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
#import "CTColor.h"

#import "CardDrawingLayerView.h"
#import "CardDrawingOperationView.h"
#import "CardDrawingPresentView.h"
#import "CouponCardDrawerManager.h"

@interface CTNewTemplateViewController_iPhone ()<CouponDrawerManagerImagePickerDelegate, CardDrawingCreating, CTInteracting>

@property (nonatomic, strong) UIButton* backButton;

@property (nonatomic, strong) CTInteractionView* operationInteractionView;

@property (nonatomic, strong) CardDrawingLayerView* layerView;
@property (nonatomic, strong) CardDrawingOperationView* operationView;
@property (nonatomic, strong) CardDrawingPresentView* presentView;
@property (nonatomic, strong) CouponCardDrawerManager* drawerManager;

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
    
    if ( _presentView == nil )
    {
        _presentView = [[CardDrawingPresentView alloc] init];
        [self.view addSubview:_presentView];
    }
    
    if ( _layerView == nil )
    {
        _layerView = [[CardDrawingLayerView alloc] init];
        [_layerView setBackgroundColor:[CTColor viewControllerBackgroundColor] ];
        [_layerView setHidden:YES];
        [self.view addSubview:_layerView];
        
    }
    
    if ( _operationView == nil )
    {
        _operationView = [[CardDrawingOperationView alloc] init];
        [_operationView setDrawingCreating:self];
        [_operationView setBackgroundColor:[CTColor viewControllerBackgroundColor] ];
        [_operationView setHidden:YES];
        [self.view addSubview:_operationView];
    }
    
    if ( _operationInteractionView == nil )
    {
        _operationInteractionView = [[CTInteractionView alloc] initWithTitle:@"Operations" withDelegate:self];
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
    
    CGFloat heightSize = MIN(self.view.height - interactionHeight, self.view.width / 2.0 );
    [_presentView setFrame:CGRectMake(self.view.width - 2 * heightSize, self.view.height - heightSize, heightSize * 2, heightSize)];
    
    [_backButton setFrame:CGRectMake(0, 0, 100, interactionHeight) ];
    
    [_operationInteractionView setFrame:CGRectMake(self.view.width - 150 - 10, 0, 150, interactionHeight)];

    [_layerView setFrame:CGRectMake(0, _operationInteractionView.maxY, 90, self.view.height - _operationInteractionView.maxY) ];
    [_operationView setFrame:CGRectMake(_layerView.maxX + 4, _operationInteractionView.maxY, self.view.width - 94, self.view.height - _operationInteractionView.maxY) ];
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

#pragma mark - CTInteraction

- (void) tapInteractionOnView:(CTInteractionView *)view
{
    
    if ( [_operationView isHidden] == NO || [_layerView isHidden] == NO )
    {
        [self closeOptions];
    }
    else
    {
        [self openOptions];
    }
    
}

- (void) openOptions
{
    CGRect operationOriginalRect = _operationView.frame;
    CGRect operationPreAnimationRect = operationOriginalRect;
    operationPreAnimationRect.origin.y -= operationPreAnimationRect.size.height;
    
    CGRect layerOriginalRect = _layerView.frame;
    CGRect layerPreAnimationRect = layerOriginalRect;
    layerPreAnimationRect.origin.y -= layerPreAnimationRect.size.height;
    
    [_operationView setFrame:operationPreAnimationRect];
    [_operationView setAlpha:0.0f];
    [_operationView setHidden:NO];
    
    [_layerView setFrame:layerPreAnimationRect];
    [_layerView setAlpha:0.0f];
    [_layerView setHidden:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [_operationView setFrame:operationOriginalRect];
        [_operationView setAlpha:1.0f];
        
        [_layerView setFrame:layerOriginalRect];
        [_layerView setAlpha:1.0f];
        
    }];
    
}

- (void) closeOptions
{
    
    CGRect operationOriginalRect = _operationView.frame;
    CGRect operationPostAnimationRect = operationOriginalRect;
    operationPostAnimationRect.origin.y -= operationPostAnimationRect.size.height;
    
    CGRect layerOriginalRect = _layerView.frame;
    CGRect layerPostAnimationRect = layerOriginalRect;
    layerPostAnimationRect.origin.y -= layerPostAnimationRect.size.height;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [_operationView setFrame:operationPostAnimationRect];
        [_operationView setAlpha:0.0f];
        
        [_layerView setFrame:layerPostAnimationRect];
        [_layerView setAlpha:0.0f];
        
    } completion:^(BOOL finished) {
        
        [_operationView setFrame:operationOriginalRect];
        [_operationView setHidden:YES];
        
        [_layerView setFrame:layerOriginalRect];
        [_layerView setHidden:YES];
        
    }];
    
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
