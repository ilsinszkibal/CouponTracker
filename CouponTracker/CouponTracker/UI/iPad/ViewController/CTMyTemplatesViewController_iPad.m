//
//  CTMyTemplatesViewController_iPad.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_iPad.h"

#import "UIImageView+WebCache.h"

#import "CTNewTemplateViewController_iPad.h"
#import "CTPrintTemplateViewController_iPad.h"

#import <iCarousel/iCarousel.h>
#import "PreferredSizingImageView.h"
#import "Model.h"

#import "ImagePreLoader.h"
#import "ImagePreLoadImageInfo.h"

#import "Keys.h"

@interface CTMyTemplatesViewController_iPad () <iCarouselDataSource, iCarouselDelegate, ImagePreLoading> {
    
    UILabel* _hintLabel;
    
    iCarousel* _carousel;
    NSUInteger _selectedIndex;
    
    NSArray* _myTemplates;
    NSArray* _templatePreLoadImageInfo;
    
    NSInteger _maxImageSize;
    NSString* _imagePreLoadingKey;
    
}

@end

@implementation CTMyTemplatesViewController_iPad

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector( loadTemplates ) name:[Keys needTemplateReload] object:nil];
        
    }
    
    return self;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpTopLeftButtonWithTitle:@"Back" withSel:@selector(backButtonAction:) ];
    
    [self setUpTopRightButtonWithTitle:@"New template" withSel:@selector(newTemplateButtonAction:) ];
    
    _maxImageSize = 400;
    
    _hintLabel = [[UILabel alloc] init];
    [_hintLabel setTextColor:[UIColor whiteColor] ];
    [_hintLabel setText:@"Tap on a template to print it!"];
    [_hintLabel setHidden:YES];
    [self.view addSubview:_hintLabel];
    
    _carousel = [[iCarousel alloc] init];
    _carousel.delegate = self;
    _carousel.dataSource = self;
    _carousel.type = iCarouselTypeRotary;
    [self.view addSubview:_carousel];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self hideMiddleTextLabel];
    [self startMiddleLoadingIndicator];
    [_hintLabel setHidden:YES];
    
    [self loadTemplates];
    
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat topMargin = 300;
    CGFloat bottomMargin = 200;
    
    [_carousel setFrame:CGRectMake(0, topMargin, self.view.frame.size.width, self.view.frame.size.height - topMargin - bottomMargin) ];
    
    [_hintLabel sizeToFit];
    [_hintLabel setFrame:CGRectMake(self.view.width / 2.0 - _hintLabel.width / 2.0, _carousel.y - _hintLabel.height, _hintLabel.width, _hintLabel.height) ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load templates

- (void) loadTemplates
{
    
    [self getMyTemplates:^(NSArray *templates, NSError *error) {
        _myTemplates = templates;
       
        [self preLoadImages];
        
    }];
    
}

#pragma mark - PreLoadingImage

- (void) preLoadImages
{
    
    if ( [_myTemplates count] == 0 )
    {
        [self stopMiddleLoadingIndicator];
        [self showMiddleTextLabel:@"You don't have any templates!"];
    }
    
    
    NSMutableArray* urlArray = [@[] mutableCopy];
    
    //Fill the urlArray
    for (Model_CardTemplate* template in _myTemplates) {
        Model_Image * image = [template image];
        NSString* urlString = [image url];
        NSURL* url;
        
        if ( urlString )
        {
            url = [NSURL URLWithString:urlString];
        }
        
        if ( url )
        {
            [urlArray addObject:url];
        }
        
    }
    
    NSDate* date = [NSDate date];
    _imagePreLoadingKey = [NSString stringWithFormat:@"%@", date];
    
    //Pre load images
    [[ImagePreLoader sharedInstance] preloadImages:urlArray imagePreLoading:self forKey:_imagePreLoadingKey];
}

- (void) imagesPreloadedForKey:(NSString*) key imageInfo:(NSArray *)imageInfo
{
    if ( [key isEqualToString:_imagePreLoadingKey] == NO )
    {
        return;
    }
    
    _imagePreLoadingKey = nil;
    
    _templatePreLoadImageInfo = imageInfo;
    
    [self stopMiddleLoadingIndicator];
    [self hideMiddleTextLabel];
    
    if ( 0 < [_myTemplates count] )
        [_hintLabel setHidden:NO];
    
    [_carousel reloadData];
}

- (void) imagesPreloadedFailedForKey:(NSString *)key
{
    
}

#pragma mark - Navigation

- (void) newTemplateButtonAction:(UIButton*) button
{
    CTNewTemplateViewController_iPad* newTemplate = [[CTNewTemplateViewController_iPad alloc] init];
    [self showNewTemplate:newTemplate defaultAnimation:NO];
}

- (void) backButtonAction:(UIButton*) backButton
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - iCarouselDataSource

- (NSUInteger) numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_myTemplates count];
}

- (UIView*) carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    BorderContainerView* borderContainer = (BorderContainerView*)view;
    if (  borderContainer == nil )
    {
        borderContainer = [self createCellWithSize:CGSizeMake(_maxImageSize, _maxImageSize) ];
    }
    
    Model_CardTemplate* templateCard = [_myTemplates objectAtIndex:index];
    Model_Image* image = [templateCard image];
    
    ImagePreLoadImageInfo* imageInfo;
    if ( index < [_templatePreLoadImageInfo count] )
    {
        imageInfo = _templatePreLoadImageInfo[ index ];
    }
    
    if ( [[image url] isEqualToString:[[imageInfo url] absoluteString] ] && [imageInfo imageInfoState] == ImageInfoStateMeasured )
    {
        CGSize imageSize = [imageInfo imageSize];
        CGFloat maxImageDimension = MAX(imageSize.width, imageSize.height);
        
        if ( _maxImageSize < maxImageDimension )
        {
            CGFloat scale = _maxImageSize / maxImageDimension;
            imageSize.width *= scale;
            imageSize.height *= scale;
        }
        
        [(PreferredSizingImageView*)borderContainer.contentView setFrame:CGRectIntegral( CGRectMake(0, 0, imageSize.width, imageSize.height) ) ];
        
        CGSize borderContainerSize = [borderContainer preferredContainterViewSize];
        [borderContainer setFrame:CGRectMake(0, 0, borderContainerSize.width, borderContainerSize.height) ];
    }
    
    [(UIImageView*)borderContainer.contentView sd_setImageWithURL:[NSURL URLWithString:image.url] ];
    
    return borderContainer;
}

#pragma mark - ICarouselDelegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
    _selectedIndex = index;
    
    CTPassingViewNavigatingKey* key = [CTPassingViewNavigatingKey createNavigationWithKey:[self printNavigationKey] withParameters:@{ [self selectedElemIndexKey] : @(index) } ];
    
    CTPrintTemplateViewController_iPad* printTemplate = [[CTPrintTemplateViewController_iPad alloc] init];
    printTemplate.template = _myTemplates[index];
    [self passingViewNavigateToViewController:printTemplate forKey:key];
}

#pragma mark - PassingViewAnimation

- (UIView*) passingViewForKey:(CTPassingViewNavigatingKey*) key
{
    
    if ( [[key key] isEqualToString:[self printNavigationKey] ] )
    {
        NSNumber* selectedIndex = [key parameters][ [self selectedElemIndexKey] ];
        
        BorderContainerView* selected = (BorderContainerView*)[_carousel itemViewAtIndex:[selectedIndex integerValue] ];
        [selected setHidden:YES];
        
        UIImage* selectedImage = [(UIImageView*)selected.contentView image];
        
        BorderContainerView* cell = [self createCellWithSize:CGSizeMake(250, 250) ];
        [(UIImageView*)cell.contentView setImage:selectedImage];
        
        return cell;
    }
    
    return nil;
}

- (CGRect) passingViewRectForKey:(CTPassingViewNavigatingKey*) key
{
    
    if ( [[key key] isEqualToString:[self printNavigationKey] ] )
    {
        NSNumber* selectedIndex = [key parameters][ [self selectedElemIndexKey] ];
        BorderContainerView* selected = (BorderContainerView*)[_carousel itemViewAtIndex:[selectedIndex integerValue] ];
        
        CGSize selectedSize = selected.frame.size;
        
        CGRect rect = CGRectMake(_carousel.width / 2.0 - selectedSize.width / 2.0, _carousel.height / 2.0 - selectedSize.height / 2.0, selectedSize.width, selectedSize.height);
        rect.origin.x += _carousel.x;
        rect.origin.y += _carousel.y;
        
        return rect;
    }
    
    return CGRectZero;
}

- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key
{
    if ( [[key key] isEqualToString:[self printNavigationKey] ] )
    {
        NSNumber* selectedIndex = [key parameters][ [self selectedElemIndexKey] ];
        BorderContainerView* selected = (BorderContainerView*)[_carousel itemViewAtIndex:[selectedIndex integerValue] ];
        
        [selected setHidden:NO];
    }
}

#pragma mark - dealloc

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

@end
