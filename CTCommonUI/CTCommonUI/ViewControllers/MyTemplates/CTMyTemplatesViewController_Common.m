//
//  CTMyTemplatesViewController_Common.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_Common.h"

#import "CTNetworkingManager.h"

@interface CTMyTemplatesViewController_Common () {
    
    CTNewTemplateViewController_Common* _newTemplateViewController;
    CTPrintTemplateViewController_Common* _printTemplateViewController;
    
}

@end

@implementation CTMyTemplatesViewController_Common

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BorderContainerView*) createCellWithSize:(CGSize) size
{
    
    CGRect imageViewRect = CGRectZero;
    imageViewRect.size = size;
    
    PreferredSizingImageView* imageView = [[PreferredSizingImageView alloc] initWithFrame:imageViewRect ];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    BorderContainerView* borderContainer = [[BorderContainerView alloc] initWithContentView:imageView];
    CGRect borderRect = CGRectZero;
    borderRect.size = [borderContainer preferredContainterViewSize];
    [borderContainer setFrame:borderRect ];
    
    return borderContainer;
}

- (NSString*) selectedElemIndexKey
{
    return @"SelectedElemIndexKey";
}

- (NSString*) printNavigationKey
{
    return @"PrintNavigationKey";
}

- (void) showNewTemplate:(CTNewTemplateViewController_Common*) newTemplateViewController
{
    _newTemplateViewController = newTemplateViewController;
    [self navigateToViewController:_newTemplateViewController];
}

- (void) showPrintTemplate:(CTPrintTemplateViewController_Common*)  printTemplateViewController forKey:(CTPassingViewNavigatingKey*) key
{
    _printTemplateViewController = printTemplateViewController;
    [self passingViewNavigateToViewController:_printTemplateViewController forKey:key];
}

- (NSOperation*)uploadImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion
{
    return nil;
}

- (NSOperation*) getMyTemplates:(void(^)(NSArray* templates, NSError* error))completion
{
    return [[CTNetworkingManager sharedManager] getMyTemplates:completion];
}

@end
