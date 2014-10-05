//
//  CardDrawingOperationImageEditView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 29/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingOperationImageEditView.h"

#import "CouponDrawingImageLayer.h"

@interface CardDrawingOperationImageEditView ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    
    CouponDrawingImageLayer* _editingLayer;
    NSUInteger _editingIndex;
    
    UIImageView* _imageView;
    
    UIButton* _chooseImageButton;
    UIButton* _scaleToWidth;
    UIButton* _scaleToHeight;
    
    UIImagePickerController* _imagePicker;
    
}

@end

@implementation CardDrawingOperationImageEditView

#pragma mark - Init

- (id) init
{
    
    self = [super init];
    
    if ( self ) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _chooseImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseImageButton setTitle:@"Select image" forState:UIControlStateNormal];
        [_chooseImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_chooseImageButton addTarget:self action:@selector(chooseImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_chooseImageButton];
        
        _scaleToWidth = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scaleToWidth setTitle:@"Scale to width" forState:UIControlStateNormal];
        [_scaleToWidth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_scaleToWidth addTarget:self action:@selector(scaleToWidthAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_scaleToWidth];
        
        _scaleToHeight = [UIButton buttonWithType:UIButtonTypeCustom];
        [_scaleToHeight setTitle:@"Scale to height" forState:UIControlStateNormal];
        [_scaleToHeight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_scaleToHeight addTarget:self action:@selector(scaleToHeightAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_scaleToHeight];
        
    }
    
    return self;
}

#pragma mark - layoutSubViews

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [_imageView setFrame:CGRectMake(10, 0, 150, 150) ];
    [_chooseImageButton setFrame:CGRectMake(160, 0, 200, 44) ];
    
    [_scaleToWidth setFrame:CGRectMake(160, 44, 200, 44) ];
    [_scaleToHeight setFrame:CGRectMake(160, 88, 200, 44) ];
    
}

#pragma mark - Private

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    _imagePicker = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage* image = info[ UIImagePickerControllerOriginalImage ];
    if ( image )
    {
        [_editingLayer setOriginalImage:image];
        [_editDelegate commmitEdit];
    }
    
    NSLog(@"Picker");
    [_imagePicker dismissViewControllerAnimated:YES completion:NULL];
    
    _imagePicker = nil;
}

- (void) scaleToWidthAction:(UIButton*) image
{
    CGRect rect = [_editingLayer layerFrame];
    CGSize imageSize = [_editingLayer originalImage].size;
    
    CGFloat scale = rect.size.width / imageSize.width;
    rect.size.height = imageSize.height * scale;
    
    _editingLayer.layerFrame = rect;
    [_editDelegate commmitEdit];
}

- (void) scaleToHeightAction:(UIButton*) image
{
    
    CGRect rect = [_editingLayer layerFrame];
    CGSize imageSize = [_editingLayer originalImage].size;
    
    CGFloat scale = rect.size.height / imageSize.height;
    rect.size.width = imageSize.width * scale;
    
    _editingLayer.layerFrame = rect;
    [_editDelegate commmitEdit];
}

- (void) chooseImageAction:(UIButton*) image
{
    NSLog(@"Select image");
    
    _imagePicker = [[UIImagePickerController alloc] init];
    [_imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    _imagePicker.delegate = self;
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:_imagePicker animated:YES completion:NULL];
    
}

- (void) setSelectedImage:(UIImage*) image
{
    [_imageView setImage:image];
}

#pragma mark - Public

- (void) editRectLayer:(CouponDrawingImageLayer*) rectLayer forIndex:(NSUInteger) index
{
    _editingLayer = rectLayer;
    _editingIndex = index;
    
    [self setSelectedImage:[_editingLayer originalImage] ];
    
}

@end
