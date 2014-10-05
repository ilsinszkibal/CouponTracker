//
//  CTStateButton.h
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CTButtonStateInactive,
    CTButtonStateActive
} CTButtonState;

@interface CTTwoStateButton : UIButton

@property (nonatomic, assign) CTButtonState currentState;
@property (nonatomic, assign) BOOL changeTitleOnStateChange;

- (void)setTitle:(NSString *)title forButtonState:(CTButtonState)state;

@end
