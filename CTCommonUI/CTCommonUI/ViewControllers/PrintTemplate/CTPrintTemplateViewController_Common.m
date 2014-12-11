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
    [self print:nil];
}

- (void)print:(UIButton*) button
{
    [[CTNetworkingManager sharedManager] createPrintedCardFromTemplate:self.template completion:^(Model_PrintedCard* card, NSError* error){
        if (error) {
            //TODO: show popup
        } else {
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.template.image.url] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                if (image) {
                    UIImage* qrImage = [[CTQRCodeManager sharedManager] generateQRCodeFromString:[NSString stringWithFormat:@"http://coupontracker.org/code/%@", card.code] size:image.size.height/2.0];
                    UIImage* finalImage = [self placeQRCode:qrImage aboveImage:image];
                    
                    UIImage* resizedImage = [self resizeImage:finalImage toWidth:300];
                    UIImage* framedImage = [self frameImage:resizedImage withColor:[UIColor whiteColor] toSize:CGSizeMake(600, 800)];
                    
                    [[CTPrinterManager sharedManager] printImage:framedImage withButton:button];
                }
            }];
        }
    }];
}

- (UIImage*)frameImage:(UIImage*)image withColor:(UIColor*)color toSize:(CGSize)size
{
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGRect frameRect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(frameRect.size, YES, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextAddRect(context, frameRect);
    CGContextFillRect(context, frameRect);
    
    [image drawInRect:imageRect];
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage*)resizeImage:(UIImage*)image toWidth:(CGFloat)width
{
    CGFloat scale = image.size.width / width * 2;
    return [[UIImage alloc] initWithCGImage:image.CGImage scale:scale orientation:image.imageOrientation];
}

- (UIImage*)placeQRCode:(UIImage*)qrImage aboveImage:(UIImage*)inputImage {
    UIGraphicsBeginImageContextWithOptions(inputImage.size, YES, 0.0);
    
    [inputImage drawInRect:CGRectMake(0, 0, inputImage.size.width, inputImage.size.height)];
    CGRect qrRect = CGRectMake(inputImage.size.width - inputImage.size.height/1.5 - inputImage.size.width*5/100.0,
                               inputImage.size.height - inputImage.size.height/1.5 - inputImage.size.height*5/100.0,
                               inputImage.size.height/1.5,
                               inputImage.size.height/1.5);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, qrRect);
    CGContextFillRect(context, qrRect);
    
    [qrImage drawInRect:qrRect];
    
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
