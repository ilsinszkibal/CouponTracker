//
//  CTCardContentCell.h
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 11/12/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Model_CardContent;

@interface CTCardContentCell : UITableViewCell

-(CGFloat) heightAfterUpdateContent:(Model_CardContent*) content;

@end
