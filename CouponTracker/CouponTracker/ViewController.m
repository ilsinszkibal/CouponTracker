//
//  ViewController.m
//  CouponTracker
//
//  Created by Balazs Ilsinszki on 24/09/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "ViewController.h"

#import "CCDataManager.h"
#import "CouponAnalytics.h"
#import "Model_Image.h"
#import "CCMapView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CCDataManager* manager;
    CouponAnalytics* analytics;
    Model_Image* image;
    CCMapView* mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
