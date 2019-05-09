//
//  GetCaptchaView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/4/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GetCaptchaViewBlock)(void);

@interface GetCaptchaView : UIView

@property (nonatomic, copy) GetCaptchaViewBlock getCaptchaViewBlock;

@end

NS_ASSUME_NONNULL_END
