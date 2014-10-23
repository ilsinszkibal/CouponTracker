//
//  CTTemplateDataSource.h
//  CTServices
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CTMyTemplates,
    CTPopularTemplates
} CTTemplateType;

@class Model_CardTemplate;

@interface CTTemplateDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView* collectionView;
@property (nonatomic, assign) CTTemplateType templateType;

- (Model_CardTemplate*)templateForIndexPath:(NSIndexPath*)indexPath;

@end
