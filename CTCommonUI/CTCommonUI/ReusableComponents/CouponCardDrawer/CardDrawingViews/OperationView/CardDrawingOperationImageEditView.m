//
//  CardDrawingOperationImageEditView.m
//  CouponCardDrawer
//
//  Created by Balazs Ilsinszki on 29/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CardDrawingOperationImageEditView.h"

#import "UIFactory.h"

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
        
        _chooseImageButton = [UIFactory defaultButtonWithTitle:@"Select image" target:self action:@selector( chooseImageAction: ) ];
        [self addSubview:_chooseImageButton];
        
        _scaleToWidth = [UIFactory defaultButtonWithTitle:@"Scale to width" target:self action:@selector( scaleToWidthAction: ) ];
        [self addSubview:_scaleToWidth];
        
        _scaleToHeight = [UIFactory defaultButtonWithTitle:@"Scale to height" target:self action:@selector( scaleToHeightAction: ) ];
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
    [_imagePicker dismissViewControllerAnimated:YES completion:NULL];
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
    
    _imagePicker = [[UIImagePickerController alloc] init];
    [_imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    _imagePicker.delegate = self;
 
    [_editDelegate presentImagePicker:_imagePicker];
    
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
