//
//  CTNaviagationAnimatedTransitioning.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTNavigationAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, readonly) BOOL moveLeft;

- (id) initWithMoveLeft:(BOOL) moveLeft;

@end
