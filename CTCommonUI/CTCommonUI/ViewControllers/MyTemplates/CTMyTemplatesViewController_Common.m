//
//  CTMyTemplatesViewController_Common.m
//  CTCommonUI
//
//  Created by Balazs Ilsinszki on 05/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTMyTemplatesViewController_Common.h"

@interface CTMyTemplatesViewController_Common () {
    
    CTNewTemplateViewController_Common* _newTemplateViewController;
    
}

@end

@implementation CTMyTemplatesViewController_Common

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) showNewTemplate:(CTNewTemplateViewController_Common*) newTemplateViewController
{
    _newTemplateViewController = newTemplateViewController;
    [self navigateToViewController:_newTemplateViewController];
}

@end
