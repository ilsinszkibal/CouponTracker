//
//  CTPassingViewNavigating.h
//  CTUtils
//
//  Created by Balazs Ilsinszki on 13/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CTPassingViewNavigatingKey.h"

@protocol CTPassingViewNavigating <NSObject>

//Called first
- (UIView*) passingViewForKey:(CTPassingViewNavigatingKey*) key;
//Called second
- (CGRect) passingViewRectForKey:(CTPassingViewNavigatingKey*) key;


- (void) receivingView:(UIView*) view forKey:(CTPassingViewNavigatingKey*) key;

@end
