//
//  CTTemplateCell.m
//  CTServices
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTTemplateCell.h"
#import "Model.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CTTemplateCell ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation CTTemplateCell

- (void)prepareForReuse {
    self.titleLabel.text = @"";
    self.imageView.image = nil;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    layoutAttributes.bounds = CGRectMake(0, 0, 250, 150);
    return layoutAttributes;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        self.titleLabel.frame = CGRectMake(0, 0, 250, 40);
        self.imageView.frame = self.bounds;
    }
    return self;
}

- (void)configure {

}

- (void)setTemplate:(Model_CardTemplate *)template {
    self.titleLabel.text = template.text;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:template.image.url]];
}

@end
