//
//  CaptchaView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/4/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaptchaView : UIView

@property (nonatomic, retain) NSArray *changeArray; //字符素材数组

@property (nonatomic, retain) NSMutableString *changeString;  //验证码的字符串

@end

NS_ASSUME_NONNULL_END
