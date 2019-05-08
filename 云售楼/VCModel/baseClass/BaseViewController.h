//
//  BaseViewController.h
//  云售楼
//
//  Created by 谷治墙 on 2019/4/8.
//  Copyright © 2019 谷治墙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

//Nav背景
@property (nonatomic, strong)UIView *navBackgroundView;

@property (nonatomic, strong) UIImageView *navImg;

//Nav标题
@property (nonatomic, strong)UILabel *titleLabel;
//返回按钮
@property (nonatomic, strong)UIButton *leftButton;

@property (nonatomic, strong)UIButton *rightBtn;

@property (nonatomic, strong) UIView *line;

//返回按钮；
- (void)ActionMaskBtn:(UIButton *)btn;

//弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack;

- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithDefaultBlack:(void(^)(void))defaultBlack;

//没有点击效果的弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1;

/**
 *  检查输入的手机号正确与否
 */
- (BOOL)checkTel:(NSString *)str;

- (void)showContent:(NSString *)str;

- (BOOL)isEmpty:(NSString *)str;

//图片压缩至希望的大小
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

//拍照后对图片进行处理
- (UIImage *)fixOrientation:(UIImage *)aImage;
@end

NS_ASSUME_NONNULL_END
