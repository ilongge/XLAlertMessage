//
//  XLViewController.m
//  XLAlertMessage
//
//  Created by ilongge on 04/28/2022.
//  Copyright (c) 2022 ilongge. All rights reserved.
//

#import "XLViewController.h"
#import "XLAlertMessageHeader.h"
@interface XLViewController ()

@end

@implementation XLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ShowMsgWithDuration(@"aisdhfpasidhfpashdfpi", 5)
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
