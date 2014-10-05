//
//  ViewController.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 27/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "ViewController.h"
#import "CTNetworkingManager.h"
#import "CTUserManager.h"
#import "CTUser.h"

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
    
    CTOauth2User* user = [[CTOauth2User alloc] init];
    user.name = @"Teveli László";
    user.email = @"tevelee@gmail.com";
    user.username = @"teve";
    user.password = @"password";
    [[CTUserManager sharedManager] loginUser:user completion:^(CTUser *user, NSError *error) {
        if (error) {
            NSLog(@"Login error: %@", error);
        } else {
            NSLog(@"Login success");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
