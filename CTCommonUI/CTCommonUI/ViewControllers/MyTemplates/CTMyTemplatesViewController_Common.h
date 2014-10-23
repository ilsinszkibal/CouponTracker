//
//  CTMyTemplatesViewController_Common.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"

#import "CTNewTemplateViewController_Common.h"

@class Model_Image;

@interface CTMyTemplatesViewController_Common : CTViewController

- (void) showNewTemplate:(CTNewTemplateViewController_Common*) newTemplateViewController;

- (NSOperation*)uploadImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion;
- (NSOperation*) getMyCards:(void(^)(NSArray* cards, NSError* error))completion;

@end
