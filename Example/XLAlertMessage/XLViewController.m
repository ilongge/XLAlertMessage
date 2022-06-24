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
 
}

- (IBAction)showMessage:(id)sender {
//    XLAlertMsg(@"XLAlertMessage")
    [XLAlertMessage showAlertMessage:@"XLAlertMessage"
                     andBottomHeight:XLScreenHeight/3.0
                  andBackgroundColor:[UIColor redColor]
                             andFont:[UIFont systemFontOfSize:35]];
//    XLAlertFormat(@"XLAlertMessage, %d", 5)
//    XLAlertDuration(@"XLAlertMessage，显示5秒", 5)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
