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

@property (nonatomic, strong) CTInteractionView* layerInteractionView;
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
    
    if ( _layerInteractionView == nil )
    {
        _layerView = [[CardDrawingLayerView alloc] init];
        [_layerView setBackgroundColor:[CTColor viewControllerBackgroundColor] ];
        [_layerView setHidden:YES];
        [self.view addSubview:_layerView];
        
        _layerInteractionView = [[CTInteractionView alloc] initWithTitle:@"Layers" withDelegate:self];
        [self.view addSubview:_layerInteractionView];
    }
    
    if ( _operationView == nil )
    {
        _operationView = [[CardDrawingOperationView alloc] init];
        [_operationView setDrawingCreating:self];
        [_operationView setBackgroundColor:[CTColor viewControllerBackgroundColor] ];
        [_operationView setHidden:YES];
        [self.view addSubview:_operationView];
        
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
    CGFloat innerMargin = 16;
    
    CGFloat heightSize = MIN(self.view.height - interactionHeight, self.view.width / 2.0 );
    [_presentView setFrame:CGRectMake(self.view.width - 2 * heightSize, self.view.height - heightSize, heightSize * 2, heightSize)];
    
    [_backButton setFrame:CGRectMake(0, 0, 100, interactionHeight) ];
    
    //[_operationInteractionView setContentSize:CGSizeMake(self.view.width, 200) ];
    //[_operationInteractionView setFrame:CGRectMake(_backButton.maxX + innerMargin, 0, 150, interactionHeight)];
    //[_layerInteractionView setContentSize:CGSizeMake(80, 300) ];
    
    
    [_operationInteractionView setFrame:CGRectMake(_backButton.maxX + innerMargin, 0, 150, interactionHeight)];
    //[_operationInteractionView setContentOffset:CGPointMake(_operationInteractionView.x * -1.0, 0) ];
    [_layerInteractionView setFrame:CGRectMake(self.view.width - 120 - innerMargin, 0, 120, interactionHeight) ];
    
    [_operationView setFrame:CGRectMake(0, _operationInteractionView.maxY, self.view.width, 200) ];
    [_layerView setFrame:CGRectMake(_layerInteractionView.x, _layerInteractionView.maxY, self.view.width - _layerInteractionView.x, self.view.height - _layerInteractionView.maxY) ];
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
    
    UIView* targetView;
    UIView* otherView;
    
    if ( view == _operationInteractionView )
    {
        targetView = _operationView;
        otherView = _layerView;
    }
    else if ( view == _layerInteractionView )
    {
        targetView = _layerView;
        otherView = _operationView;
    }

    //Open or close view
    if ( [otherView isHidden] == NO )
    {
        [self closeView:otherView];
    }
    else if ( [targetView isHidden] == NO )
    {
        [self closeView:targetView];
    }
    else
    {
        [self openView:targetView];
    }
    
}

- (void) openView:(UIView*) view
{
    CGRect originalViewRect = view.frame;
    CGRect preOpenRect = originalViewRect;
    preOpenRect.origin.y -= preOpenRect.size.height;
    
    [view setFrame:preOpenRect];
    [view setAlpha:0.0f];
    [view setHidden:NO];
    
    [UIView animateWithDuration:0.3 animations:^{
        [view setFrame:originalViewRect];
        [view setAlpha:1.0f];
    }];
}

- (void) closeView:(UIView*) view
{
    
    CGRect originalViewRect = view.frame;
    CGRect postAnimationRect = originalViewRect;
    postAnimationRect.origin.y -= originalViewRect.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        [view setFrame:postAnimationRect];
        [view setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [view setHidden:YES];
        [view setFrame:originalViewRect];
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
