//
//  MBProgressHUD+GZQ.h
//  云售楼
//
//  Created by 谷治墙 on 2019/5/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

#define HudShowTime 1.5

@interface MBProgressHUD (GZQ)

#pragma mark 在指定的view上显示hud
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showWarning:(NSString *)Warning toView:(UIView *)view;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message view:(UIView *)view;
+ (MBProgressHUD *)showProgressBarToView:(UIView *)view;


#pragma mark 在window上显示hud
+ (void)showMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)Warning;
+ (void)showMessageWithImageName:(NSString *)imageName message:(NSString *)message;
+ (MBProgressHUD *)showActivityMessage:(NSString*)message;


#pragma mark 移除hud
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
