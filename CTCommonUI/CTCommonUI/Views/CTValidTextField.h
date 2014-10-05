//
//  CTValidTextField.h
//  CTCommonUI
//
//  Created by Teveli László on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTTextFieldDelegate <UITextFieldDelegate>

- (void)textFieldDidBecameValid:(UITextField*)textField;
- (void)textFieldDidBecameInvalid:(UITextField*)textField;

@end

@interface CTValidTextField : UITextField

@property (nonatomic, assign, getter = isValid) BOOL valid;
@property (nonatomic, assign) BOOL(^validationBlock)(NSString* text);

@property (nonatomic, assign) id<CTTextFieldDelegate> delegate;

@end
