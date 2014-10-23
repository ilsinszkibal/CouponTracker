//
//  CTTemplateCell.h
//  CTServices
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Model_CardTemplate;

@interface CTTemplateCell : UICollectionViewCell

@property (nonatomic, strong) Model_CardTemplate* template;

@end
