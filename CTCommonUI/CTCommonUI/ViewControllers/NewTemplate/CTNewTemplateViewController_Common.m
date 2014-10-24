//
//  CTNewTemplateViewController_Common.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTNewTemplateViewController_Common.h"

#import "CTNetworkingManager.h"

@interface CTNewTemplateViewController_Common ()

@end

@implementation CTNewTemplateViewController_Common

- (void) createTemplateWithName:(NSString*) name withText:(NSString*) text withImage:(UIImage*) image
{
    
    [[CTNetworkingManager sharedManager] createTemplateWithName:name text:text image:image completion:^(Model_CardTemplate *image, NSError *error) {
        NSLog(@"Template");
    }];
    
}

@end
