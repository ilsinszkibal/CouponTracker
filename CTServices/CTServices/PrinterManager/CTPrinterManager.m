//
//  CTPrinterManager.m
//  CTServices
//
//  Created by Teveli László on 24/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrinterManager.h"

#import "DeviceInfo.h"

@implementation CTPrinterManager

- (void)printImage:(UIImage*)image withButton:(UIButton*) button
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    NSData* data = UIImageJPEGRepresentation(image, 1);
    
    if(pic && [UIPrintInteractionController canPrintData:data] ) {
        
        pic.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @"CouponTracker coupon print";
        printInfo.duplex = UIPrintInfoDuplexNone;
        UIPrintFormatter* formatter = [[UIPrintFormatter alloc] init];
        formatter.maximumContentWidth = image.size.width;
        formatter.maximumContentHeight = image.size.height;
        pic.printInfo = printInfo;
        pic.showsPageRange = YES;
        pic.printingItem = data;
        pic.printFormatter = formatter;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"Printing failed due to error %@", error);
            } else {
                NSLog(@"Printing finished");
            }
        };
        
        if ( [DeviceInfo isiPhone] )
        {
            [pic presentAnimated:YES completionHandler:completionHandler];
        }
        else
        {
            [pic presentFromRect:CGRectZero inView:button animated:YES completionHandler:completionHandler];
        }
        
    }
}

@end
