//
//  CTCardContentView.m
//  CTCommonUI
//
//  Created by Teveli László on 02/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTCardContentView.h"
#import "Model.h"

@interface CTCardContentView ()

@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIVisualEffectView* blur;

@end

@implementation CTCardContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        self.blur = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.blur.layer.cornerRadius = 5;
        [self addSubview:self.blur];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 20)];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.textColor = [UIColor darkGrayColor];
        self.textView.font = [UIFont boldSystemFontOfSize:15];
        self.textView.alpha = 0.8;
        [self addSubview:self.textView];
    }
    return self;
}

- (void)layoutSubviews {
    self.blur.frame = self.bounds;
    self.textView.frame = CGRectMake(10, 10, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 20);
}

- (void)setContent:(Model_CardContent *)content {
    _content = content;
    self.textView.text = content.text;
}

@end
