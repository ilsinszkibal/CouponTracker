//
//  CTPrinterManager.m
//  CTServices
//
//  Created by Teveli László on 24/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPrinterManager.h"

@implementation CTPrinterManager

- (void)printImage:(UIImage*)image {
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    NSData* data = UIImageJPEGRepresentation(image, 1);
    
    if(pic && [UIPrintInteractionController canPrintData:data] ) {
        
        pic.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @"CouponTracker coupon print";
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        pic.printInfo = printInfo;
        pic.showsPageRange = YES;
        pic.printingItem = data;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"FAILED! due to error %@", error);
            }
        };
        
        [pic presentAnimated:YES completionHandler:completionHandler];
    }
}

@end
