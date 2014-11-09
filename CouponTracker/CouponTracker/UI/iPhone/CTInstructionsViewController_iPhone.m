//
//  CTInstructionsViewController_iPhone.m
//  CouponTracker
//
//  Created by Teveli László on 02/11/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTInstructionsViewController_iPhone.h"
#import <JazzHands/IFTTTJazzHands.h>

NSUInteger kPageCount = 5;

@interface CTInstructionsViewController_iPhone () <UIScrollViewDelegate>

@property (nonatomic, strong) IFTTTAnimator* animator;

@end

@implementation CTInstructionsViewController_iPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = kPageCount;
    [self.view addSubview:self.pageControl];
    
    UIImageView* cardView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-card"]];
    [cardView setContentMode:UIViewContentModeScaleAspectFill];
    cardView.alpha = 0;
    [self.scrollView addSubview:cardView];
    UIImageView* man1View = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-man"]];
    [man1View setContentMode:UIViewContentModeScaleAspectFill];
    man1View.alpha = 0;
    [self.scrollView addSubview:man1View];
    UIImageView* man2View = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-man"]];
    [man2View setContentMode:UIViewContentModeScaleAspectFill];
    man2View.alpha = 0;
    [self.scrollView addSubview:man2View];
    UIImageView* man2HappyView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-man2"]];
    [man2HappyView setContentMode:UIViewContentModeScaleAspectFill];
    man2HappyView.alpha = 0;
    [self.scrollView addSubview:man2HappyView];
    UIImageView* message = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-message"]];
    [message setContentMode:UIViewContentModeScaleAspectFill];
    message.alpha = 0;
    [self.scrollView addSubview:message];
    UIImageView* iPhone = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-iphone"]];
    [iPhone setContentMode:UIViewContentModeScaleAspectFill];
    iPhone.alpha = 0;
    [self.scrollView addSubview:iPhone];
    UIImageView* qrView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-qr"]];
    [qrView setContentMode:UIViewContentModeScaleAspectFill];
    qrView.alpha = 0;
    [self.scrollView addSubview:qrView];
    UIImageView* cloudView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"i-cloud"]];
    [cloudView setContentMode:UIViewContentModeScaleAspectFill];
    cloudView.alpha = 0;
    [self.scrollView addSubview:cloudView];
    
    self.animator = [[IFTTTAnimator alloc] init];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);

    IFTTTAnimation* man1MoveAnim = [IFTTTFrameAnimation animationWithView:man1View];
    [man1MoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:0 andFrame:CGRectMake(50, 400, 50, 100)]];
    [man1MoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:width andFrame:CGRectMake(width+50, 400, 50, 100)]];
    [man1MoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andFrame:CGRectMake(2*width+50, 400, 50, 100)]];
    [man1MoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andFrame:CGRectMake(3*width-50, 400, 50, 100)]];
    [self.animator addAnimation:man1MoveAnim];
    
    IFTTTAnimation* man1FadeAnim = [IFTTTAlphaAnimation animationWithView:man1View];
    [man1FadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:-width andAlpha:0]];
    [man1FadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:0 andAlpha:1]];
    [self.animator addAnimation:man1FadeAnim];
    
    IFTTTAnimation* messageMoveAnim = [IFTTTFrameAnimation animationWithView:message];
    [messageMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:0 andFrame:CGRectMake(70, 400, 0, 0)]];
    [messageMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:width andFrame:CGRectMake(width+60, 350, 100, 50)]];
    [messageMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andFrame:CGRectMake(2*width+80, 370, 60, 30)]];
    [messageMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andFrame:CGRectMake(3*width+120, 70, 80, 40)]];
    [self.animator addAnimation:messageMoveAnim];
    
    IFTTTAnimation* messageFadeAnim = [IFTTTAlphaAnimation animationWithView:message];
    [messageFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:0 andAlpha:0]];
    [messageFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:width andAlpha:1]];
    [self.animator addAnimation:messageFadeAnim];
    
    IFTTTAnimation* qrMoveAnim = [IFTTTFrameAnimation animationWithView:qrView];
    [qrMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:width andFrame:CGRectMake(width+70, 300, 50, 50)]];
    [qrMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andFrame:CGRectMake(2*width+70, 350, 100, 100)]];
    [self.animator addAnimation:qrMoveAnim];

    IFTTTAnimation* qrFadeAnim = [IFTTTAlphaAnimation animationWithView:qrView];
    [qrFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:width andAlpha:0]];
    [qrFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andAlpha:1]];
    [self.animator addAnimation:qrFadeAnim];

    IFTTTAnimation* cloudMoveAnim = [IFTTTFrameAnimation animationWithView:cloudView];
    [cloudMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andFrame:CGRectMake(2*width+50, -100, 200, 100)]];
    [cloudMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andFrame:CGRectMake(3*width+50, 50, 200, 100)]];
    [self.animator addAnimation:cloudMoveAnim];

    IFTTTAnimation* cloudFadeAnim = [IFTTTAlphaAnimation animationWithView:cloudView];
    [cloudFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andAlpha:0]];
    [cloudFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andAlpha:1]];
    [self.animator addAnimation:cloudFadeAnim];
    
    IFTTTAnimation* cardMoveAnim = [IFTTTFrameAnimation animationWithView:cardView];
    [cardMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andFrame:CGRectMake(2*width+70, 350, 100, 50)]];
    [cardMoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andFrame:CGRectMake(3*width+200, 350, 100, 50)]];
    [self.animator addAnimation:cardMoveAnim];
    
    IFTTTAnimation* cardFadeAnim = [IFTTTAlphaAnimation animationWithView:cardView];
    [cardFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andAlpha:0]];
    [cardFadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andAlpha:1]];
    [self.animator addAnimation:cardFadeAnim];
    
    IFTTTAnimation* man2MoveAnim = [IFTTTFrameAnimation animationWithView:man2View];
    [man2MoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andFrame:CGRectMake(3*width, 400, 50, 100)]];
    [man2MoveAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andFrame:CGRectMake(3*width+260, 400, 50, 100)]];
    [self.animator addAnimation:man2MoveAnim];
    
    IFTTTAnimation* man2FadeAnim = [IFTTTAlphaAnimation animationWithView:man2View];
    [man2FadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:2*width andAlpha:0]];
    [man2FadeAnim addKeyFrame:[IFTTTAnimationKeyFrame keyFrameWithTime:3*width andAlpha:1]];
    [self.animator addAnimation:man2FadeAnim];

    [self.animator animate:0];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*kPageCount, CGRectGetHeight(self.view.bounds));
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.animator animate:scrollView.contentOffset.x];
    
    self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.contentSize.width * kPageCount;
}

@end
