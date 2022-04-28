//
//  XLAlertMessage.h
//  XLAlertMessage
//
//  Created by ilongge on 2021/3/12.
//  Copyright © 2021 admin. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface XLAlertMessage : UIView

/**
 在主window上的提示
 */
+ (void)showAlertMessage:(NSString *)alertMessage
         andButtomHeight:(CGFloat)buttomHeight;

/**
 加到当前window上的提示
 */
+ (void)showAlertMessage:(NSString *)alertMessage
         andButtomHeight:(CGFloat)buttomHeight
         andCustomWindow:(UIWindow *)window;
/**
 在主window上显示的提示（新增显示时间参数）
 */
+ (void)showAlertMessageWithDuration:(CGFloat)duration
                          andMessage:(NSString *)message
                     andBottomHeight:(CGFloat)bottomHeight;

@end
