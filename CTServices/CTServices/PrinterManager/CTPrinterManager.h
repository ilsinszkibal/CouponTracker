//
//  CTPrinterManager.h
//  CTServices
//
//  Created by Teveli László on 24/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTBaseManager.h"
#import <UIKit/UIKit.h>

@interface CTPrinterManager : CTBaseManager <UIPrintInteractionControllerDelegate>

- (void)printImage:(UIImage*)image;

@end
