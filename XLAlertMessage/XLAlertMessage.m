//
//  XLAlertMessage.m
//  XLAlertMessage
//
//  Created by ilongge on 2021/3/12.
//  Copyright © 2021 admin. All rights reserved.
//

#import "XLAlertMessage.h"

#import "XLAlertMessageHeader.h"

@implementation XLAlertMessage

- (id)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)showAlertMessage:(NSString *)alertMessage
         andButtomHeight:(CGFloat)buttomHeight {
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    
    [XLAlertMessage createAlertMessageWithDuration:1.5
                                        andMessage:alertMessage
                                   andBottomHeight:buttomHeight
                                         andWindow:window];
    
}

+ (void)showAlertMessage:(NSString *)alertMessage
         andButtomHeight:(CGFloat)buttomHeight
         andCustomWindow:(UIWindow*)window {
    
    [XLAlertMessage createAlertMessageWithDuration:1.5
                                        andMessage:alertMessage
                                   andBottomHeight:buttomHeight
                                         andWindow:window];
    
}

///在主window上显示的提示
+ (void)showAlertMessageWithDuration:(CGFloat)duration
                          andMessage:(NSString *)message
                     andBottomHeight:(CGFloat)bottomHeight {
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    
    [XLAlertMessage createAlertMessageWithDuration:duration
                                        andMessage:message
                                   andBottomHeight:bottomHeight
                                         andWindow:window];
    
}

///统一创建弹框视图
+ (void)createAlertMessageWithDuration:(CGFloat)duration
                            andMessage:(NSString *)message
                       andBottomHeight:(CGFloat)bottomHeight
                             andWindow:(UIWindow *)showWindow {
    
    XLAlertMessage *customMessageAlert = [[self alloc]init];
    customMessageAlert.backgroundColor = [UIColor blackColor];
    customMessageAlert.alpha = 0;
    customMessageAlert.layer.masksToBounds = YES;
    customMessageAlert.layer.cornerRadius = 5.0;
    customMessageAlert.userInteractionEnabled = NO;
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.alpha = 0;
    messageLabel.font = [UIFont fontWithName:XLFontName
                                        size:14.0];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.backgroundColor = [UIColor clearColor];
    
    messageLabel.text = message;
    
    CGFloat messageHeight = [XLAlertMessage getStringHeight:message andFont:[UIFont fontWithName:XLFontName size:14.0] andWidth:XLScreenWidth-20];
    CGFloat messageWidth = [XLAlertMessage getStringWidth:message andFont:[UIFont fontWithName:XLFontName size:14.0] andHeight:messageHeight];
    
    if (messageWidth > XLScreenWidth-20) {
        
        messageWidth = XLScreenWidth-20;
        
    }
    
    messageLabel.frame = CGRectMake(10,
                                    15,
                                    messageWidth,
                                    messageHeight);
    
    [customMessageAlert setFrame:CGRectMake(0,
                                            0,
                                            messageWidth+20,
                                            messageHeight+30)];
    customMessageAlert.center = showWindow.center;
    
    [customMessageAlert addSubview:messageLabel];
    
    [showWindow addSubview:customMessageAlert];
    
    __weak typeof(XLAlertMessage *) weakCustomAlert = customMessageAlert;
    __weak typeof(UILabel *) weakMessageLabel = messageLabel;
    
    [UIView animateWithDuration:0.5
                     animations:^{
        
        weakCustomAlert.alpha = 0.7;
        weakMessageLabel.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [weakCustomAlert performSelector:@selector(hideAlertMessage)
                              withObject:nil
                              afterDelay:duration];
    }];
}

///隐藏alertmessage
- (void)hideAlertMessage {
    
    __weak typeof (self) weakSelf = self;
    
    [UIView animateWithDuration:0.5
                     animations:^{
        weakSelf.alpha = 0;
    }
                     completion:^(BOOL finished) {
        
        if (finished) {
            
            [weakSelf removeFromSuperview];
        }
    }];
}



+ (CGFloat)getStringWidth:(NSString *)string andFont:(UIFont*)font andHeight:(CGFloat)height {
    
    CGSize size = [XLAlertMessage getStringSize:string andFont:font andSize:CGSizeMake(MAXFLOAT, height)];
    
    return size.width;
}

+ (CGFloat)getStringHeight:(NSString *)string andFont:(UIFont*)font andWidth:(CGFloat)width {
    
    CGSize size = [XLAlertMessage getStringSize:string andFont:font andSize:CGSizeMake(width, MAXFLOAT)];
    
    return size.height;
}

+ (CGSize)getStringSize:(NSString *)string andFont:(UIFont*)font andSize:(CGSize)size {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, string.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:size
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                         
                                                       context:nil];
    
    return stringRect.size;
}
@end
