//
//  ViewController.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "ViewController.h"
#import "CTNetworkingManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CTNetworkingManager sharedManager] getCards:^(NSArray *cards, NSError *error) {
        if (error) {
            NSLog(@"GetCards error: %@", error);
        } else {
            NSLog(@"GetCards success");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
