//
//  CTInteractionView.h
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 16/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTInteractionView : UIView

@property (nonatomic, readonly) UIView* contentView;

+ (instancetype) createWithContentView:(UIView*) contentView withTitle:(NSString*) title;

- (void) setContentOffset:(CGPoint) offset;
- (void) setContentSize:(CGSize) size;
- (BOOL) isContentViewShown;

- (void) closeContent;

@end
