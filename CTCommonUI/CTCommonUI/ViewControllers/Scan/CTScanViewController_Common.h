//
//  CT_ScanViewController_Common.h
//  CTCommonUI
//
//  Created by Teveli László on 23/10/14.
//  Copyright (c) 2014 Balazs Ilsinszki. All rights reserved.
//

#import "CTViewController.h"
#import "CTQRCodeManager.h"

@interface CTScanViewController_Common : CTViewController <CTCodeReaderDelegate>

@property (nonatomic, strong) UIView* previewView;
@property (nonatomic, strong) UIButton* startStopButton;
@property (nonatomic, strong) UILabel* statusLabel;
@property (nonatomic, strong) UILabel* instructionLabel;

- (void)startStopButtonPressed:(UIButton*)button;

@end
