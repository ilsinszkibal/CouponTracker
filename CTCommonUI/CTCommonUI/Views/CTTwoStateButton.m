//
//  CTStateButton.m
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTTwoStateButton.h"

@interface CTTwoStateButton ()

@property (nonatomic, strong) NSMutableDictionary* titles;

@end

@implementation CTTwoStateButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentState = CTButtonStateInactive;
        [self addTarget:self action:@selector(didPress:) forControlEvents:UIControlEventTouchUpInside];
        self.changeTitleOnStateChange = YES;
        self.titles = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    return self;
}

- (void)didPress:(UIButton*)button {
    [self toggleState];
}

- (void)setCurrentState:(CTButtonState)currentState {
    _currentState = currentState;
    [self setTitle:[self titleForButtonState:self.currentState] forState:UIControlStateNormal];
}

- (void)toggleState {
    if (self.currentState == CTButtonStateInactive) {
        self.currentState = CTButtonStateActive;
    } else {
        self.currentState = CTButtonStateInactive;
    }
    [self setTitle:[self titleForButtonState:self.currentState] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title forButtonState:(CTButtonState)state {
    if (title) {
        self.titles[@(state)] = title;
    }
}

- (NSString*)titleForButtonState:(CTButtonState)state {
    return self.titles[@(state)];
}

@end
