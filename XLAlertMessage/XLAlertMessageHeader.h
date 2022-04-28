//
//  XLAlertMessageHeader.h
//  XLAlertMessage
//
//  Created by ilongge on 2021/3/12.
//  Copyright © 2021 admin. All rights reserved.
//

#ifndef XLAlertMessageHeader_h
#define XLAlertMessageHeader_h

#import "XLAlertMessage.h"

#define XLScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define XLScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define XLBoldFontName                    @"PingFang-SC-Medium"
#define XLFontName                        @"PingFang-SC-Regular"

/**
 加到keywindow上的提示
 */
#define ShowMsg(msg) \
{[XLAlertMessage showAlertMessage:[NSString stringWithFormat:@"%@", msg] andButtomHeight:XLScreenHeight/2];}

/**
 加到keywindow上可以设置显示时间的提示
 */
#define ShowMsgWithDuration(msg,duration) \
{[XLAlertMessage showAlertMessageWithDuration:duration andMessage:[NSString stringWithFormat:@"%@", msg] andBottomHeight:XLScreenHeight/2];}

#endif /* XLAlertMessageHeader_h */
