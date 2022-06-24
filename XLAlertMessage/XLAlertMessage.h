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
+ (void)showAlertMessage:(NSString *)message
         andBottomHeight:(CGFloat)bottomHeight;

+ (void)showAlertMessage:(NSString *)message
         andBottomHeight:(CGFloat)bottomHeight
      andBackgroundColor:(UIColor *)backgrounColor
                 andFont:(UIFont *)font;

/**
 在主window上显示的提示
 */
+ (void)showAlertMessage:(NSString *)message
         andBottomHeight:(CGFloat)bottomHeight
             andDuration:(CGFloat)duration;

+ (void)showAlertMessage:(NSString *)message
         andBottomHeight:(CGFloat)bottomHeight
             andDuration:(CGFloat)duration
      andBackgroundColor:(UIColor *)backgrounColor
                 andFont:(UIFont *)font;

/**
 加到当前window上的提示
 */
+ (void)showAlertMessage:(NSString *)message
         andBottomHeight:(CGFloat)bottomHeight
         andCustomWindow:(UIWindow *)window;

+ (void)showAlertMessage:(NSString *)message
         andBottomHeight:(CGFloat)bottomHeight
         andCustomWindow:(UIWindow *)window
      andBackgroundColor:(UIColor *)backgrounColor
                 andFont:(UIFont *)font;

@end
