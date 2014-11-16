//
//  CTMyTemplatesViewController_Common.h
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTPassingViewNavigationViewController.h"

#import "CTNewTemplateViewController_Common.h"
#import "CTPrintTemplateViewController_Common.h"

#import "BorderContainerView.h"
#import "PreferredSizingImageView.h"

@class Model_Image;

@interface CTMyTemplatesViewController_Common : CTPassingViewNavigationViewController

- (BorderContainerView*) createCellWithSize:(CGSize) size;
- (NSString*) selectedElemIndexKey;
- (NSString*) printNavigationKey;

- (void) showNewTemplate:(CTNewTemplateViewController_Common*) newTemplateViewController defaultAnimation:(BOOL) isDefaultAnimation;
- (void) showPrintTemplate:(CTPrintTemplateViewController_Common*)  printTemplateViewController forKey:(CTPassingViewNavigatingKey*) key;

- (NSOperation*)uploadImage:(UIImage*)image completion:(void(^)(Model_Image* image, NSError* error))completion;
- (NSOperation*) getMyTemplates:(void(^)(NSArray* templates, NSError* error))completion;

@end
