//
//  CTPrintTemplateViewController_Common.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrintTemplateViewController_Common.h"
#import "CTQRCodeManager.h"
#import "CTNetworkingManager.h"
#import "CTPrinterManager.h"
#import "Model.h"
#import <SDWebImage/SDWebImageManager.h>

@interface CTPrintTemplateViewController_Common ()

@end

@implementation CTPrintTemplateViewController_Common

- (void)print {
    [[CTNetworkingManager sharedManager] createPrintedCardFromTemplate:self.template completion:^(Model_PrintedCard* card, NSError* error){
        if (error) {
            //TODO: show popup
        } else {
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.template.image.url] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    UIImage* qrImage = [[CTQRCodeManager sharedManager] generateQRCodeFromString:card.code size:100];
                    UIImage* finalImage = [self placeQRCode:qrImage aboveImage:image];
                    
                    [[CTPrinterManager sharedManager] printImage:finalImage];
                }
            }];
        }
    }];
}

- (UIImage*)placeQRCode:(UIImage*)qrImage aboveImage:(UIImage*)inputImage {
    UIGraphicsBeginImageContextWithOptions(inputImage.size, YES, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    [qrImage drawInRect:CGRectMake(200, 20, 100, 100)];//FIXME: get QR code position
    
    UIGraphicsPopContext();

    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
