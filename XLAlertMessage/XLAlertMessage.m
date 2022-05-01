//
//  XLAlertMessage.m
//  XLAlertMessage
//
//  Created by ilongge on 2021/3/12.
//  Copyright © 2021 admin. All rights reserved.
//

#import "XLAlertMessage.h"

#import "XLAlertMessageHeader.h"

@interface XLAlertMessage()
@property (nonatomic, strong) NSTimer *alertTimer;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, assign) NSInteger countDown;
@property (nonatomic, assign) NSInteger startCount;
@property (nonatomic, assign) NSInteger duration;
@end

@implementation XLAlertMessage

#pragma mark ***************** 初始化方法 / initialize function

static XLAlertMessage *_alertMessage = nil;
static dispatch_once_t _onceToken = 0;

+ (instancetype)sharedAlertMessage {
    if (_alertMessage == nil) {
        _alertMessage = [[super alloc] init];
        _alertMessage.backgroundColor = [UIColor blackColor];
        _alertMessage.alpha = 0;
        _alertMessage.layer.masksToBounds = YES;
        _alertMessage.layer.cornerRadius = 5.0;
        _alertMessage.userInteractionEnabled = NO;
    }
    return _alertMessage;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    dispatch_once(&_onceToken, ^{
        if (_alertMessage == nil) {
            _alertMessage = [super allocWithZone:zone];
        }
    });
    return _alertMessage;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return _alertMessage;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return _alertMessage;
}

+ (void)destory {
    if (_alertMessage.alertTimer) {
        [_alertMessage.alertTimer invalidate];
        _alertMessage.alertTimer = nil;
    }
    _alertMessage = nil;
    _onceToken = 0;
}

#pragma mark ***************** 公开方法 / public function

/**
 在主window上的提示
 */
+ (void)showAlertMessage:(NSString *)alertMessage
         andButtomHeight:(CGFloat)buttomHeight {
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    
    [XLAlertMessage createAlertMessageWithDuration:ShowMessageTime
                                        andMessage:alertMessage
                                   andBottomHeight:buttomHeight
                                         andWindow:window];
    
}

/**
 加到当前window上的提示
 */
+ (void)showAlertMessage:(NSString *)alertMessage
         andButtomHeight:(CGFloat)buttomHeight
         andCustomWindow:(UIWindow*)window {
    
    [XLAlertMessage createAlertMessageWithDuration:ShowMessageTime
                                        andMessage:alertMessage
                                   andBottomHeight:buttomHeight
                                         andWindow:window];
    
}

/**
 在主window上显示的提示（新增显示时间参数）
 */
+ (void)showAlertMessageWithDuration:(CGFloat)duration
                          andMessage:(NSString *)message
                     andBottomHeight:(CGFloat)bottomHeight {
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    
    [XLAlertMessage createAlertMessageWithDuration:duration
                                        andMessage:message
                                   andBottomHeight:bottomHeight
                                         andWindow:window];
    
}

#pragma mark  ***************** 私有方法 / private function

///统一创建弹框视图
+ (void)createAlertMessageWithDuration:(CGFloat)duration
                            andMessage:(NSString *)message
                       andBottomHeight:(CGFloat)bottomHeight
                             andWindow:(UIWindow *)showWindow {
    
    
    XLAlertMessage *customMessageAlert = [XLAlertMessage sharedAlertMessage];
    
    [customMessageAlert createAlertMessageWithDuration:duration andMessage:message andBottomHeight:bottomHeight andWindow:showWindow];
}

///统一创建弹框视图
- (void)createAlertMessageWithDuration:(CGFloat)duration
                            andMessage:(NSString *)message
                       andBottomHeight:(CGFloat)bottomHeight
                             andWindow:(UIWindow *)showWindow
{
    
    CGFloat messageHeight = [XLAlertMessage getStringHeight:message andFont:[UIFont fontWithName:XLFontName size:XLFontSize] andWidth:XLScreenWidth-20];
    CGFloat messageWidth = [XLAlertMessage getStringWidth:message andFont:[UIFont fontWithName:XLFontName size:XLFontSize] andHeight:messageHeight];
    
    if (messageWidth > XLScreenWidth-20) {
        messageWidth = XLScreenWidth-20;
    }

    self.countDown = 0;
    self.startCount = 0;
    self.duration = duration;
    [self showAlertMessage:message andWidth:messageWidth andHeight:messageHeight andWindow:showWindow];
    
    if (self.alertTimer == nil) {
        self.alertTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:self
                                                         selector:@selector(timeCountDown)
                                                         userInfo:nil
                                                          repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.alertTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)timeCountDown
{
    if (self.countDown == self.startCount + self.duration) {
        [self hideAlertMessage];
    }
 
    self.countDown ++;
}

/// 展示 alertmessage
- (void)showAlertMessage:(NSString *)message
                andWidth:(CGFloat)messageWidth
               andHeight:(CGFloat)messageHeight
               andWindow:(UIWindow *)showWindow {
    
    self.startCount = self.countDown;
    
    self.frame = CGRectMake(0,
                            0,
                            messageWidth+20,
                            messageHeight+20);
    
    self.center = showWindow.center;
    
    self.messageLabel.text = message;
    
    self.messageLabel.frame = CGRectMake(10,
                                         10,
                                         messageWidth,
                                         messageHeight);
    if (self.superview == nil) {
        [showWindow addSubview:self];
    }
    if (self.messageLabel.superview == nil) {
        [self addSubview:self.messageLabel];
        [UIView animateWithDuration:0.5
                         animations:^{
            
            self.alpha = 0.7;
            self.messageLabel.alpha = 1.0;
            
        }];
    }
}

/// 隐藏 alertmessage
- (void)hideAlertMessage {
    
    [UIView animateWithDuration:0.5
                     animations:^{
        self.alpha = 0;
    }
                     completion:^(BOOL finished) {
        
        if (finished) {
            [self removeFromSuperview];
            [XLAlertMessage destory];
        }
    }];
}

- (void)dealloc
{
    NSLog(@"XLAlertMessage dealloc");
}
#pragma mark ***************** 计算尺寸 / Calcul

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

- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.alpha = 0;
        _messageLabel.font = [UIFont fontWithName:XLFontName
                                             size:XLFontSize];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.backgroundColor = [UIColor clearColor];
    }
    return _messageLabel;
}
@end
