//
//  CTCardContentCell.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 11/12/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTCardContentCell.h"

#import "UIFactory.h"

#import "Model_CardContent.h"
#import "CTUser.h"

@interface CTCardContentCell () {
    
    UILabel* _senderUserName;
    UILabel* _senderUserMail;
    UITextView* _textView;
    UILabel* _receiverUserName;
    UILabel* _receiverUserMail;
    
}

@end

@implementation CTCardContentCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ( self ) {
        
        [self setBackgroundColor:[UIColor clearColor] ];
        [UIFactory setBordersAndCornerToButton:[self contentView] ];
        
        _senderUserName = [[UILabel alloc] init];
        [_senderUserName setTextColor:[UIColor whiteColor] ];
        [[self contentView] addSubview:_senderUserName];
        
        _senderUserMail = [[UILabel alloc] init];
        [_senderUserMail setTextColor:[UIColor whiteColor] ];
        [[self contentView] addSubview:_senderUserMail];
        
        _textView = [[UITextView alloc] init];
        [_textView setBackgroundColor:[UIColor clearColor] ];
        [_textView setTextAlignment:NSTextAlignmentCenter];
        [_textView setTextColor:[UIColor whiteColor] ];
        [[self contentView] addSubview:_textView];
        
        _receiverUserName = [[UILabel alloc] init];
        [_receiverUserName setTextColor:[UIColor whiteColor] ];
        [_receiverUserName setTextAlignment:NSTextAlignmentRight];
        [[self contentView] addSubview:_receiverUserName];
        
        _receiverUserMail = [[UILabel alloc] init];
        [_receiverUserMail setTextColor:[UIColor whiteColor] ];
        [_receiverUserMail setTextAlignment:NSTextAlignmentRight];
        [[self contentView] addSubview:_receiverUserMail];
        
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = 0;
    CGFloat margin = 10;
    
    if ( [_senderUserName isHidden] == NO )
    {
        [_senderUserName setFrame:CGRectMake(margin, height, self.contentView.width - 2 * margin, 30)];
        height += 30;
    }
    
    if ( [_senderUserMail isHidden] == NO )
    {
        [_senderUserMail setFrame:CGRectMake(margin, height, self.contentView.width - 2 * margin, 30) ];
        height += 30;
    }
    
    if ( [_textView isHidden] == NO )
    {
        [_textView setFrame:CGRectMake(margin, height, self.contentView.width - 2 * margin, 80)];
        height += 80;
    }
    
    if ( [_receiverUserName isHidden] == NO )
    {
        [_receiverUserName setFrame:CGRectMake(margin, height, self.contentView.width - 2 * margin, 30) ];
        height += 30;
    }
    
    if ( [_receiverUserMail isHidden] == NO )
    {
        [_receiverUserMail setFrame:CGRectMake(margin, height, self.contentView.width - 2 * margin, 30) ];
        height += 30;
    }
    
}

-(CGFloat) heightAfterUpdateContent:(Model_CardContent*) content;
{
    
    NSString* senderName = [[content senderUser] username];
    NSString* senderMail = [[content senderUser] email];
    NSString* text = [content text];
    NSString* receiverName = [[content receiverUser] username];
    NSString* receiverMail = [[content receiverUser] email];
    
    CGFloat height = 0;
    
    if ( senderName )
    {
        [_senderUserName setText:senderName];
        height += 30;
    }
    [_senderUserName setHidden:senderName == nil];
    
    if ( senderMail )
    {
        [_senderUserMail setText:senderMail];
        height += 30;
    }
    [_senderUserMail setHidden:senderMail == nil];
    
    if ( text )
    {
        [_textView setText:text];
        height += 80;
    }
    [_textView setHidden:text == nil];
    
    if ( receiverName )
    {
        [_receiverUserName setText:receiverName];
        height += 30;
    }
    [_receiverUserName setHidden:receiverName == nil];
    
    if ( receiverMail )
    {
        [_receiverUserMail setText:receiverMail];
        height += 30;
    }
    [_receiverUserMail setHidden:receiverMail == nil];
    
    return height;
}

@end
